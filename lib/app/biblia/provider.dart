import 'package:coramdeo/app/biblia/data.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BibleProvider extends BaseProvider {
  BibleProvider() {
    _initialize();
  }

  Biblia dbHelper = Biblia();
  final FlutterTts flutterTts = FlutterTts();

  // TTS State
  bool _isSpeaking = false;
  double _speechRate = 1.0;
  List<dynamic> _voices = [];
  Map? _selectedVoice;
  bool _autoPlayNext = false;
  double _currentProgress = 0.0; // 0.0 to 1.0
  int _lastSpokenIndex = 0;
  int _tempLastSpokenIndex = 0;

  bool get isSpeaking => _isSpeaking;
  double get speechRate => _speechRate;
  List<dynamic> get voices => _voices;
  Map? get selectedVoice => _selectedVoice;
  bool get autoPlayNext => _autoPlayNext;
  double get currentProgress => _currentProgress;

  String _testament = AppConstants.defaultTestament;
  int _bookId = AppConstants.defaultBookId;
  String _book = AppConstants.defaultBook;
  List<String> _oldBooks = [];
  List<String> _newBooks = [];
  int _chapter = AppConstants.defaultChapter;
  final Map<String, List<int>> _bookChapters = {};
  List<String> _versesId = [];
  List<String> _verses = [];

  String get testament => _testament;
  int get bookId => _bookId;
  String get book => _book;
  List<String> get oldBooks => _oldBooks;
  List<String> get newBooks => _newBooks;
  int get chapter => _chapter;
  Map<String, List<int>> get bookChapters => _bookChapters;
  List<String> get versesId => _versesId;
  List<String> get verses => _verses;

  String _bibleVersion = AppConstants.defaultBibleVersion;

  String get bibleVersion => _bibleVersion;

  List<String> get availableVersions => ['NVI', 'ACF', 'KJV', 'RVR'];

  Future<void> _initialize() async {
    setLoading(true);

    await safePrefOperation((prefs) async {
      _testament = prefs.getString(AppConstants.bibleTestamentKey) ?? AppConstants.defaultTestament;
      _bookId = prefs.getInt(AppConstants.bibleBookIdKey) ?? AppConstants.defaultBookId;
      _book = prefs.getString(AppConstants.bibleBookKey) ?? AppConstants.defaultBook;
      _chapter = prefs.getInt(AppConstants.bibleChapterKey) ?? AppConstants.defaultChapter;
      _bibleVersion = prefs.getString(AppConstants.bibleVersionKey) ?? AppConstants.defaultBibleVersion;

      dbHelper.setVersion(_bibleVersion);

      _speechRate = prefs.getDouble(AppConstants.ttsRateKey) ?? 1.0;
      final savedVoice = prefs.getString('${AppConstants.ttsVoiceKey}_$_bibleVersion');
      if (savedVoice != null) {
        // We can't fully reconstruct the map here without the full list,
        // effectively we'll set it when we load voices.
        // Storing name is usually enough to find it back.
      }

      return true;
    }, errorContext: 'Loading Bible preferences');

    // Initialize TTS
    await safeAsync(() async {
      await flutterTts.setLanguage("pt-BR");
      // Configure Audio Session for background playback (mostly for iOS, Android needs service)
      await flutterTts.setIosAudioCategory(IosTextToSpeechAudioCategory.playback, [
        IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
      ]);
      await flutterTts.awaitSpeakCompletion(true); // Ensure await speak blocks until done

      await _updateTTSLanguage(_bibleVersion);

      flutterTts.setStartHandler(() {
        _isSpeaking = true;
        notifyListeners();
      });

      flutterTts.setProgressHandler((String text, int start, int end, String word) {
        // Estimate progress based on word count or character count could be complex.
        // Simple approach: We don't have total length easily from TTS engine usually.
        // Exception: setProgressHandler arguments on Android/iOS differ.
        // iOS: start, end of current word in utterance.
        // We know the full text we sent.
        // Let's store the text length when we speak.
      });

      flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
        _currentProgress = 0.0;
        notifyListeners();

        if (_autoPlayNext) {
          goToNextChapter().then((_) {
            speak();
          });
        }
      });

      flutterTts.setCancelHandler(() {
        _isSpeaking = false;
        _lastSpokenIndex = _tempLastSpokenIndex;
        notifyListeners();
      });

      flutterTts.setPauseHandler(() {
        _isSpeaking = false;
        _lastSpokenIndex = _tempLastSpokenIndex;
        notifyListeners();
      });

      flutterTts.setContinueHandler(() {
        _isSpeaking = true;
        notifyListeners();
      });

      return true;
    }, errorContext: 'Initializing TTS');
    await safeAsync(() async {
      _oldBooks = await dbHelper.getBooks("Old");
      _newBooks = await dbHelper.getBooks("New");

      // Load saved verses or fetch them if not cached
      final prefs = await BaseProvider.getPrefs();
      _versesId = prefs.getStringList(AppConstants.bibleVersesIdKey) ?? await dbHelper.getVersesId(_book, _chapter);
      _verses = prefs.getStringList(AppConstants.bibleVersesKey) ?? await dbHelper.getVerses(_book, _chapter);

      return true;
    }, errorContext: 'Loading Bible data');

    setLoading(false);
  }

  Future<void> setBibleVersion(String version) async {
    if (_bibleVersion == version) return;

    setLoading(true);
    await safeAsync(() async {
      _bibleVersion = version;
      dbHelper.setVersion(version);

      await _updateTTSLanguage(version);

      // Reload book lists for the new language
      _oldBooks = await dbHelper.getBooks("Old");
      _newBooks = await dbHelper.getBooks("New");

      // Update current book name based on ID (handles language change)
      try {
        _book = await dbHelper.getBookById(_bookId != 0 ? _bookId : 1);
      } catch (e) {
        _bookId = 1;
        _book = await dbHelper.getBookById(1);
      }

      // Clear chapters cache to force reload with new book names
      _bookChapters.clear();

      // Reload current chapter in new version
      _versesId = await dbHelper.getVersesId(_book, _chapter);
      _verses = await dbHelper.getVerses(_book, _chapter);

      await save();
      return true;
    }, errorContext: 'Changing Bible version to $version');
    setLoading(false);
  }

  // Renamed from 'load' to 'save' for clarity
  Future<void> save() async {
    await safePrefOperation((prefs) async {
      await prefs.setString(AppConstants.bibleTestamentKey, _testament);
      await prefs.setInt(AppConstants.bibleBookIdKey, _bookId);
      await prefs.setString(AppConstants.bibleBookKey, _book);
      await prefs.setInt(AppConstants.bibleChapterKey, _chapter);
      await prefs.setStringList(AppConstants.bibleVersesIdKey, _versesId);
      await prefs.setStringList(AppConstants.bibleVersesKey, _verses);
      await prefs.setString(AppConstants.bibleVersionKey, _bibleVersion);
      return true;
    }, errorContext: 'Saving Bible state');
  }

  Future<List<String>?> getBooksFromTestament({required String testament}) async {
    return safeAsync(() async {
      if (testament == "Old") {
        return await dbHelper.getBooks("Old");
      } else {
        return await dbHelper.getBooks("New");
      }
    }, errorContext: 'Getting books from testament $testament');
  }

  Future<void> updateBookChapters({required String book}) async {
    _lastSpokenIndex = 0;
    _currentProgress = 0.0;
    await safeAsync(() async {
      if (!_bookChapters.containsKey(book)) {
        _bookChapters[book] = await dbHelper.getChapters(book);
      }
      notifyListeners();
      return true;
    }, errorContext: 'Updating book chapters for $book');
  }

  Future<void> goToNextChapter() async {
    await safeAsync(() async {
      int lastChapter = await dbHelper.getLastChapterOfBook(_book);

      if (_chapter < lastChapter) {
        await updateValues(testament: _testament, book: _book, chapter: _chapter + 1);
      } else {
        String newBook = await dbHelper.getBookById(_bookId + 1);
        await updateValues(testament: _bookId + 1 > 39 ? "New" : "Old", book: newBook, chapter: 1);
      }
      return true;
    }, errorContext: 'Going to next chapter');
  }

  Future<void> goToPreviousChapter() async {
    await safeAsync(() async {
      if (_chapter > 1) {
        await updateValues(testament: _testament, book: _book, chapter: _chapter - 1);
      } else {
        String newBook = await dbHelper.getBookById(_bookId - 1);
        int lastChapter = await dbHelper.getLastChapterOfBook(newBook);
        await updateValues(testament: _bookId - 1 > 39 ? "New" : "Old", book: newBook, chapter: lastChapter);
      }
      return true;
    }, errorContext: 'Going to previous chapter');
  }

  Future<void> updateValues({required String testament, required String book, required int chapter}) async {
    setLoading(true);

    await safeAsync(() async {
      _testament = testament;
      _book = book;
      _bookId = await dbHelper.getBookId(book);
      _chapter = chapter;
      _versesId = await dbHelper.getVersesId(book, chapter);
      _verses = await dbHelper.getVerses(book, chapter);

      _currentProgress = 0.0;
      _lastSpokenIndex = 0;
      _tempLastSpokenIndex = 0;
      if (_isSpeaking) {
        await flutterTts.stop();
        _isSpeaking = false;
      }

      await save();
      return true;
    }, errorContext: 'Updating Bible values');

    setLoading(false);
  }

  Future<void> speak() async {
    if (_isSpeaking) {
      await flutterTts.stop();
      _isSpeaking = false;
      _lastSpokenIndex = _tempLastSpokenIndex;
      notifyListeners();
      return;
    }

    String fullText = "Capítulo $_chapter. ";
    for (String verse in _verses) {
      fullText += "$verse ";
    }

    int totalLength = fullText.length;

    String textToSpeak = fullText;
    if (_lastSpokenIndex > 0 && _lastSpokenIndex < totalLength) {
      textToSpeak = fullText.substring(_lastSpokenIndex);
    } else {
      _lastSpokenIndex = 0; // Reset if invalid
    }

    flutterTts.setProgressHandler((String text, int start, int end, String word) {
      int globalPos = _lastSpokenIndex + end;
      _tempLastSpokenIndex = globalPos;

      _currentProgress = globalPos / totalLength;
      if (_currentProgress > 1.0) _currentProgress = 1.0;
      notifyListeners();
    });

    await flutterTts.speak(textToSpeak);
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
    _isSpeaking = false;
    _lastSpokenIndex = 0; // Reset on full stop
    _currentProgress = 0.0;
    notifyListeners();
  }

  Future<void> setSpeechRate(double rate) async {
    _speechRate = rate;
    await flutterTts.setSpeechRate(rate * 0.5);
    safePrefOperation((prefs) async {
      await prefs.setDouble(AppConstants.ttsRateKey, rate);
      return true;
    });

    if (_isSpeaking) {
      await flutterTts.stop();
      _lastSpokenIndex = _tempLastSpokenIndex;

      String fullText = "Capítulo $_chapter. ";
      for (String verse in _verses) {
        fullText += "$verse ";
      }

      String textToSpeak = fullText;
      if (_lastSpokenIndex > 0 && _lastSpokenIndex < fullText.length) {
        textToSpeak = fullText.substring(_lastSpokenIndex);
      }

      await flutterTts.speak(textToSpeak);
      // _isSpeaking remains true, listeners notified by speak internal logic or progress
    }
    notifyListeners();
  }

  Future<void> setVoice(Map voice) async {
    _selectedVoice = voice;
    await flutterTts.setVoice(Map<String, String>.from(voice));
    safePrefOperation((prefs) async {
      await prefs.setString('${AppConstants.ttsVoiceKey}_$_bibleVersion', voice["name"]);
      return true;
    });
    notifyListeners();
  }

  Future<void> _updateTTSLanguage(String version) async {
    String lang = "pt-BR";
    if (version == 'KJV') {
      lang = "en-US";
    } else if (version == 'RVR') {
      lang = "es-ES";
    }

    await flutterTts.setLanguage(lang);
    await flutterTts.setSpeechRate(_speechRate * 0.5);

    // Load Voices
    try {
      List<dynamic> allVoices = await flutterTts.getVoices;
      // Filter for voices of the selected language
      String langCode = lang.split('-')[0];
      _voices = allVoices.where((voice) => voice["locale"].toString().contains(langCode)).toList();

      // Restore saved voice
      final prefs = await BaseProvider.getPrefs();
      final savedVoiceName = prefs.getString('${AppConstants.ttsVoiceKey}_$_bibleVersion');

      if (savedVoiceName != null) {
        try {
          final voice = _voices.firstWhere((v) => v["name"] == savedVoiceName);
          _selectedVoice = Map<String, String>.from(voice); // Ensure correct type
          await flutterTts.setVoice(Map<String, String>.from(_selectedVoice!));
        } catch (e) {
          // Saved voice not found (maybe system update changed it), fallback to default
          _selectedVoice = null;
        }
      } else {
        _selectedVoice = null;
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error loading voices: $e");
    }
  }

  Future<void> setAutoPlayNext(bool value) async {
    _autoPlayNext = value;
    notifyListeners();
  }
}

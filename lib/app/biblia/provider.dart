import 'package:flutter/material.dart';
import 'package:coramdeo/app/biblia/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:coramdeo/utils/audio_service.dart';

class BibleProvider extends BaseProvider {
  BibleProvider() {
    _initialize();
  }

  Biblia dbHelper = Biblia();
  final AudioService _audioService = AudioService();

  String _currentVersion = AppConstants.defaultBibleVersion;
  String _testament = AppConstants.defaultTestament;
  int _bookId = AppConstants.defaultBookId;
  String _book = AppConstants.defaultBook;
  List<String> _oldBooks = [];
  List<String> _newBooks = [];
  int _chapter = AppConstants.defaultChapter;
  final Map<String, List<int>> _bookChapters = {};
  List<String> _versesId = [];
  List<String> _verses = [];
  bool _audioEnabled = AppConstants.defaultAudioEnabled;
  bool _autoPlay = AppConstants.defaultAutoPlay;
  double _playbackSpeed = AppConstants.defaultPlaybackSpeed;

  // Getters
  String get currentVersion => _currentVersion;
  String get testament => _testament;
  int get bookId => _bookId;
  String get book => _book;
  List<String> get oldBooks => _oldBooks;
  List<String> get newBooks => _newBooks;
  int get chapter => _chapter;
  Map<String, List<int>> get bookChapters => _bookChapters;
  List<String> get versesId => _versesId;
  List<String> get verses => _verses;
  bool get audioEnabled => _audioEnabled;
  bool get autoPlay => _autoPlay;
  double get playbackSpeed => _playbackSpeed;
  AudioService get audioService => _audioService;
  
  BibleVersion get currentVersionInfo => 
    Biblia.availableVersions.firstWhere((v) => v.id == _currentVersion);
  
  List<BibleVersion> get availableVersions => Biblia.availableVersions;

  Future<void> _initialize() async {
    setLoading(true);
    
    await safePrefOperation((prefs) async {
      _currentVersion = prefs.getString(AppConstants.bibleVersionKey) ?? AppConstants.defaultBibleVersion;
      _testament = prefs.getString(AppConstants.bibleTestamentKey) ?? AppConstants.defaultTestament;
      _bookId = prefs.getInt(AppConstants.bibleBookIdKey) ?? AppConstants.defaultBookId;
      _book = prefs.getString(AppConstants.bibleBookKey) ?? AppConstants.defaultBook;
      _chapter = prefs.getInt(AppConstants.bibleChapterKey) ?? AppConstants.defaultChapter;
      _audioEnabled = prefs.getBool(AppConstants.bibleAudioEnabledKey) ?? AppConstants.defaultAudioEnabled;
      _autoPlay = prefs.getBool(AppConstants.bibleAutoPlayKey) ?? AppConstants.defaultAutoPlay;
      _playbackSpeed = prefs.getDouble(AppConstants.biblePlaybackSpeedKey) ?? AppConstants.defaultPlaybackSpeed;
      
      return true;
    }, errorContext: 'Loading Bible preferences');

    // Set the current version in the helper
    dbHelper.setVersion(_currentVersion);

    // Load books and verses data
    await safeAsync(() async {
      _oldBooks = await dbHelper.getBooks("Old", _currentVersion);
      _newBooks = await dbHelper.getBooks("New", _currentVersion);
      
      // Load saved verses or fetch them if not cached
      final prefs = await BaseProvider.getPrefs();
      _versesId = prefs.getStringList(AppConstants.bibleVersesIdKey) ?? await dbHelper.getVersesId(_book, _chapter, _currentVersion);
      _verses = prefs.getStringList(AppConstants.bibleVersesKey) ?? await dbHelper.getVerses(_book, _chapter, _currentVersion);
      
      return true;
    }, errorContext: 'Loading Bible data');
    
    setLoading(false);
  }

  // Renamed from 'load' to 'save' for clarity
  Future<void> save() async {
    await safePrefOperation((prefs) async {
      await prefs.setString(AppConstants.bibleVersionKey, _currentVersion);
      await prefs.setString(AppConstants.bibleTestamentKey, _testament);
      await prefs.setInt(AppConstants.bibleBookIdKey, _bookId);
      await prefs.setString(AppConstants.bibleBookKey, _book);
      await prefs.setInt(AppConstants.bibleChapterKey, _chapter);
      await prefs.setStringList(AppConstants.bibleVersesIdKey, _versesId);
      await prefs.setStringList(AppConstants.bibleVersesKey, _verses);
      await prefs.setBool(AppConstants.bibleAudioEnabledKey, _audioEnabled);
      await prefs.setBool(AppConstants.bibleAutoPlayKey, _autoPlay);
      await prefs.setDouble(AppConstants.biblePlaybackSpeedKey, _playbackSpeed);
      return true;
    }, errorContext: 'Saving Bible state');
  }

  Future<List<String>?> getBooksFromTestament({required String testament}) async {
    return safeAsync(() async {
      if (testament == "Old") {
        return await dbHelper.getBooks("Old", _currentVersion);
      } else {
        return await dbHelper.getBooks("New", _currentVersion);
      }
    }, errorContext: 'Getting books from testament $testament');
  }

  Future<void> updateBookChapters({required String book}) async {
    await safeAsync(() async {
      if (!_bookChapters.containsKey(book)) {
        _bookChapters[book] = await dbHelper.getChapters(book, _currentVersion);
      }
      notifyListeners();
      return true;
    }, errorContext: 'Updating book chapters for $book');
  }

  Future<void> goToNextChapter() async {
    await safeAsync(() async {
      int lastChapter = await dbHelper.getLastChapterOfBook(_book, _currentVersion);

      if (_chapter < lastChapter) {
        await updateValues(testament: _testament, book: _book, chapter: _chapter + 1);
      } else {
        String newBook = await dbHelper.getBookById(_bookId + 1, _currentVersion);
        if (newBook.isNotEmpty) {
          await updateValues(testament: _bookId + 1 > 39 ? "New" : "Old", book: newBook, chapter: 1);
        }
      }
      return true;
    }, errorContext: 'Going to next chapter');
  }

  Future<void> goToPreviousChapter() async {
    await safeAsync(() async {
      if (_chapter > 1) {
        await updateValues(testament: _testament, book: _book, chapter: _chapter - 1);
      } else if (_bookId > 1) {
        String newBook = await dbHelper.getBookById(_bookId - 1, _currentVersion);
        if (newBook.isNotEmpty) {
          int lastChapter = await dbHelper.getLastChapterOfBook(newBook, _currentVersion);
          await updateValues(testament: _bookId - 1 > 39 ? "New" : "Old", book: newBook, chapter: lastChapter);
        }
      }
      return true;
    }, errorContext: 'Going to previous chapter');
  }

  Future<void> updateValues({required String testament, required String book, required int chapter}) async {
    setLoading(true);
    
    await safeAsync(() async {
      _testament = testament;
      _book = book;
      _bookId = await dbHelper.getBookId(book, _currentVersion);
      _chapter = chapter;
      _versesId = await dbHelper.getVersesId(book, chapter, _currentVersion);
      _verses = await dbHelper.getVerses(book, chapter, _currentVersion);
      
      // Save the updated values
      await save();
      
      // Auto-play audio if enabled
      if (_audioEnabled && _autoPlay && currentVersionInfo.hasAudio) {
        await playChapterAudio();
      }
      
      return true;
    }, errorContext: 'Updating Bible values');
    
    setLoading(false);
  }

  Future<void> switchVersion(String versionId) async {
    if (_currentVersion == versionId) return;
    
    setLoading(true);
    
    await safeAsync(() async {
      _currentVersion = versionId;
      dbHelper.setVersion(versionId);
      
      // Reload books for the new version
      _oldBooks = await dbHelper.getBooks("Old", _currentVersion);
      _newBooks = await dbHelper.getBooks("New", _currentVersion);
      
      // Try to maintain the same book/chapter, or fallback to Genesis 1
      try {
        _versesId = await dbHelper.getVersesId(_book, _chapter, _currentVersion);
        _verses = await dbHelper.getVerses(_book, _chapter, _currentVersion);
        _bookId = await dbHelper.getBookId(_book, _currentVersion);
      } catch (e) {
        // Fallback to Genesis 1 if current book doesn't exist in new version
        _testament = "Old";
        _book = _oldBooks.isNotEmpty ? _oldBooks.first : "Genesis";
        _chapter = 1;
        _bookId = 1;
        _versesId = await dbHelper.getVersesId(_book, _chapter, _currentVersion);
        _verses = await dbHelper.getVerses(_book, _chapter, _currentVersion);
      }
      
      await save();
      return true;
    }, errorContext: 'Switching Bible version');
    
    setLoading(false);
  }

  Future<void> playChapterAudio() async {
    if (!currentVersionInfo.hasAudio) return;
    
    final audioUrl = await dbHelper.getChapterAudioUrl(_book, _chapter, _currentVersion);
    if (audioUrl.isNotEmpty) {
      await _audioService.playUrl(audioUrl);
    }
  }

  Future<void> pauseAudio() async {
    await _audioService.pause();
  }

  Future<void> resumeAudio() async {
    await _audioService.resume();
  }

  Future<void> stopAudio() async {
    await _audioService.stop();
  }

  void toggleAudioEnabled() {
    _audioEnabled = !_audioEnabled;
    save();
    notifyListeners();
  }

  void toggleAutoPlay() {
    _autoPlay = !_autoPlay;
    save();
    notifyListeners();
  }

  void setPlaybackSpeed(double speed) {
    _playbackSpeed = speed;
    _audioService.setSpeed(speed);
    save();
    notifyListeners();
  }
}

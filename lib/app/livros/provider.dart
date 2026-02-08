import 'package:coramdeo/app/livros/data.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class BookIndexProvider extends BaseProvider {
  final String bookName;

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  final List<int>? initialPoints;
  final String? initialTitle;

  BookIndexProvider({required this.bookName, this.initialPoints, this.initialTitle}) {
    _initialize();
  }

  List<int> _chapterIds = [];
  List<String> _chapterNames = [];
  int _fistChapterId = 0;
  int _currentChapterId = 0;
  String _currentChapterName = "";
  List<int> _contentIds = [];
  List<String> _content = [];
  List<String> _titles = [];
  String _aboutContent = "";
  Map<String, Map<String, List<int>>> _thematicIndex = {};

  List<int> get chapterIds => _chapterIds;
  List<String> get chapterNames => _chapterNames;
  int get fistChapterId => _fistChapterId;
  int get currentChapterId => _currentChapterId;
  String get currentChapterName => _currentChapterName;
  List<int> get contentIds => _contentIds;
  List<String> get content => _content;
  List<String> get titles => _titles;
  String get aboutContent => _aboutContent;
  Map<String, Map<String, List<int>>> get thematicIndex => _thematicIndex;
  String get imagePath => "assets/images/capas_livros/$bookName.jpg";

  Future<void> _initialize() async {
    if (_isDisposed) return;
    setLoading(true);

    await safeAsync(() async {
      Livros book = Livros(bookName: bookName);
      _chapterIds = await book.getChapterIds();
      _chapterNames = await book.getChapterNames();
      _fistChapterId = await book.getFirstChapter();
      _aboutContent = await book.getAboutContent();

      await _loadThematicIndex();

      return true;
    }, errorContext: 'Loading book structure');

    if (initialPoints != null) {
      await changeContentForThemeIndex(initialPoints!, initialTitle ?? "");
      // Skip the rest of initialization (loading default chapter)
      setLoading(false);
      return;
    }

    await safePrefOperation((prefs) async {
      Livros book = Livros(bookName: bookName);
      _currentChapterId = prefs.getInt('livros.$bookName.currentChapterId') ?? await book.getFirstChapter();
      _currentChapterName = prefs.getString('livros.$bookName.currentChapterName') ?? await book.getFirstChapterName();

      return true;
    }, errorContext: 'Loading book preferences');

    await safeAsync(() async {
      Livros book = Livros(bookName: bookName);
      _contentIds = await book.getContentIds(chapterId: _currentChapterId);
      var contentData = await book.getFullContentByIds(contentIds: _contentIds, chapterId: _currentChapterId);
      _content = contentData.map((e) => e['content'] as String).toList();
      _titles = contentData.map((e) => e['title'] as String? ?? "").toList();

      return true;
    }, errorContext: 'Loading book content');

    setLoading(false);
  }

  Future<void> _loadThematicIndex() async {
    try {
      final String response = await rootBundle.loadString('assets/data/thematic_indices.json');
      final Map<String, dynamic> data = json.decode(response);

      String jsonKey = bookName;
      if (bookName == 'amigos_de_deus') jsonKey = 'amigos_de_deus';
      if (bookName == 'e_cristo_que_passa') jsonKey = 'e_cristo_que_passa';
      if (bookName == 'caminho') jsonKey = 'caminho';
      if (bookName == 'sulco') jsonKey = 'sulco';
      if (bookName == 'forja') jsonKey = 'forja';

      if (data.containsKey(jsonKey)) {
        final Map<String, dynamic> bookData = data[jsonKey];
        _thematicIndex = bookData.map((key, value) {
          final subthemes = value as Map<String, dynamic>;
          return MapEntry(key, subthemes.map((subKey, subValue) => MapEntry(subKey, List<int>.from(subValue))));
        });
      } else {
        _thematicIndex = {};
      }
    } catch (e) {
      _thematicIndex = {};
    }
  }

  Future<void> changeChapter(int chapterId) async {
    setLoading(true);

    await safePrefOperation((prefs) async {
      await prefs.setInt('livros.$bookName.currentChapterId', chapterId + _fistChapterId);
      await prefs.setString('livros.$bookName.currentChapterName', _chapterNames[chapterId]);
      return true;
    }, errorContext: 'Saving chapter change');

    await safeAsync(() async {
      Livros book = Livros(bookName: bookName);
      _currentChapterId = chapterId + _fistChapterId;
      _currentChapterName = _chapterNames[chapterId];
      _contentIds = await book.getContentIds(chapterId: _currentChapterId);
      var contentData = await book.getFullContentByIds(contentIds: _contentIds, chapterId: _currentChapterId);
      _content = contentData.map((e) => e['content'] as String).toList();
      _titles = contentData.map((e) => e['title'] as String? ?? "").toList();
      return true;
    }, errorContext: 'Loading new chapter content');

    setLoading(false);
  }

  Future<void> changeContentForThemeIndex(List<int> contentIds, String itemName) async {
    setLoading(true);

    await safeAsync(() async {
      Livros book = Livros(bookName: bookName);
      _currentChapterName = itemName;
      _contentIds = contentIds;
      var contentData = await book.getFullContentByIds(contentIds: _contentIds);
      _content = contentData.map((e) => e['content'] as String).toList();
      _titles = contentData.map((e) => e['title'] as String? ?? "").toList();
      notifyListeners();
      return true;
    }, errorContext: 'Loading theme content');

    setLoading(false);
  }
}

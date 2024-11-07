import 'package:coramdeo/models/livros.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookIndexProvider extends ChangeNotifier {
  final String bookName;

  BookIndexProvider({required this.bookName}) {
    init();
  }

  List<int> _chapterIds = [];
  List<String> _chapterNames = [];
  int _fistChapterId = 0;
  int _currentChapterId = 0;
  String _currentChapterName = "";
  List<int> _contentIds = [];
  List<String> _content = [];

  bool _isLoading = false;

  List<int> get chapterIds => _chapterIds;
  List<String> get chapterNames => _chapterNames;
  int get fistChapterId => _fistChapterId;
  int get currentChapterId => _currentChapterId;
  String get currentChapterName => _currentChapterName;
  List<int> get contentIds => _contentIds;
  List<String> get content => _content;

  bool get isLoading => _isLoading;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Livros book = Livros(bookName: bookName);
    _chapterIds = await book.getChapterIds();
    _chapterNames = await book.getChapterNames();
    _fistChapterId = await book.getFirstChapter();
    _currentChapterId = prefs.getInt('livros.$bookName.currentChapterId') ?? await book.getFirstChapter();
    _currentChapterName = prefs.getString('livros.$bookName.currentChapterName') ?? await book.getFirstChapterName();
    _contentIds = await book.getContentIds(chapterId: _currentChapterId);
    _content = await book.getContentByIds(contentIds: _contentIds);
    _isLoading = false;
    notifyListeners();
  }

  changeChapter(int chapterId) async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Livros book = Livros(bookName: bookName);
    prefs.setInt('livros.$bookName.currentChapterId', chapterId + _fistChapterId);
    prefs.setString('livros.$bookName.currentChapterName', _chapterNames[chapterId]);
    _currentChapterId = chapterId + _fistChapterId;
    _currentChapterName = _chapterNames[chapterId];
    _contentIds = await book.getContentIds(chapterId: _currentChapterId);
    _content = await book.getContentByIds(contentIds: _contentIds);
    _isLoading = false;
    notifyListeners();
  }

  changeContentForThemeIndex(List<int> contentIds, String itemName) async {
    _isLoading = true;
    notifyListeners();
    Livros book = Livros(bookName: bookName);
    _currentChapterName = itemName;
    _contentIds = contentIds;
    _content = await book.getContentByIds(contentIds: _contentIds);
    _isLoading = false;
    notifyListeners();
  }
}

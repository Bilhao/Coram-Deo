import 'package:coramdeo/app/livros/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/utils/base_provider.dart';

class BookIndexProvider extends BaseProvider {
  final String bookName;

  BookIndexProvider({required this.bookName}) {
    _initialize();
  }

  List<int> _chapterIds = [];
  List<String> _chapterNames = [];
  int _fistChapterId = 0;
  int _currentChapterId = 0;
  String _currentChapterName = "";
  List<int> _contentIds = [];
  List<String> _content = [];

  List<int> get chapterIds => _chapterIds;
  List<String> get chapterNames => _chapterNames;
  int get fistChapterId => _fistChapterId;
  int get currentChapterId => _currentChapterId;
  String get currentChapterName => _currentChapterName;
  List<int> get contentIds => _contentIds;
  List<String> get content => _content;

  Future<void> _initialize() async {
    setLoading(true);
    
    await safeAsync(() async {
      Livros book = Livros(bookName: bookName);
      _chapterIds = await book.getChapterIds();
      _chapterNames = await book.getChapterNames();
      _fistChapterId = await book.getFirstChapter();
      
      return true;
    }, errorContext: 'Loading book structure');

    await safePrefOperation((prefs) async {
      Livros book = Livros(bookName: bookName);
      _currentChapterId = prefs.getInt('livros.$bookName.currentChapterId') ?? await book.getFirstChapter();
      _currentChapterName = prefs.getString('livros.$bookName.currentChapterName') ?? await book.getFirstChapterName();
      
      return true;
    }, errorContext: 'Loading book preferences');

    await safeAsync(() async {
      Livros book = Livros(bookName: bookName);
      _contentIds = await book.getContentIds(chapterId: _currentChapterId);
      _content = await book.getContentByIds(contentIds: _contentIds);
      
      return true;
    }, errorContext: 'Loading book content');
    
    setLoading(false);
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
      _content = await book.getContentByIds(contentIds: _contentIds);
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
      _content = await book.getContentByIds(contentIds: _contentIds);
      notifyListeners();
      return true;
    }, errorContext: 'Loading theme content');
    
    setLoading(false);
  }
}

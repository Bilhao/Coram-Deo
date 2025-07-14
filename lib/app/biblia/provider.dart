import 'package:flutter/material.dart';
import 'package:coramdeo/app/biblia/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';

class BibleProvider extends BaseProvider {
  BibleProvider() {
    _initialize();
  }

  Biblia dbHelper = Biblia();

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

  Future<void> _initialize() async {
    setLoading(true);
    
    await safePrefOperation((prefs) async {
      // Fixed: Changed "biblie" to "bible" for consistency
      _testament = prefs.getString(AppConstants.bibleTestamentKey) ?? AppConstants.defaultTestament;
      _bookId = prefs.getInt(AppConstants.bibleBookIdKey) ?? AppConstants.defaultBookId;
      _book = prefs.getString(AppConstants.bibleBookKey) ?? AppConstants.defaultBook;
      _chapter = prefs.getInt(AppConstants.bibleChapterKey) ?? AppConstants.defaultChapter;
      
      return true;
    }, errorContext: 'Loading Bible preferences');

    // Load books and verses data
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

  // Renamed from 'load' to 'save' for clarity
  Future<void> save() async {
    await safePrefOperation((prefs) async {
      // Fixed: Changed "biblie" to "bible" for consistency
      await prefs.setString(AppConstants.bibleTestamentKey, _testament);
      await prefs.setInt(AppConstants.bibleBookIdKey, _bookId);
      await prefs.setString(AppConstants.bibleBookKey, _book);
      await prefs.setInt(AppConstants.bibleChapterKey, _chapter);
      await prefs.setStringList(AppConstants.bibleVersesIdKey, _versesId);
      await prefs.setStringList(AppConstants.bibleVersesKey, _verses);
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
      
      // Save the updated values
      await save();
      return true;
    }, errorContext: 'Updating Bible values');
    
    setLoading(false);
  }
}

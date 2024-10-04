import 'package:flutter/material.dart';
import 'package:coramdeo/models/bible.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BibleProvider extends ChangeNotifier {
  BibleProvider() {
    init();
  }

  Biblia dbHelper = Biblia();

  String _testament = "Old";
  int _bookId = 1;
  String _book = "Gênesis";
  List<String> _oldBooks = [];
  List<String> _newBooks = [];
  int _chapter = 1;
  final Map<String, List<int>> _bookChapters = {};
  List<String> _versesId = [];
  List<String> _verses = [];
  bool _isLoading = false;

  String get testament => _testament;
  int get bookId => _bookId;
  String get book => _book;
  List<String> get oldBooks => _oldBooks;
  List<String> get newBooks => _newBooks;
  int get chapter => _chapter;
  Map<String, List<int>> get bookChapters => _bookChapters;
  List<String> get versesId => _versesId;
  List<String> get verses => _verses;
  bool get isLoading => _isLoading;

  init() async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    _testament = pref.getString("biblie.testament") ?? "Old";
    _bookId = pref.getInt("biblie.book_id") ?? 1;
    _book = pref.getString("biblie.book") ?? "Gênesis";
    _oldBooks = await dbHelper.getBooks("Old");
    _newBooks = await dbHelper.getBooks("New");
    _chapter = pref.getInt("biblie.chapter") ?? 1;
    _versesId = pref.getStringList("biblie.verses_id") ??
        await dbHelper.getVersesId(_book, _chapter);
    _verses = pref.getStringList("biblie.verses") ??
        await dbHelper.getVerses(_book, _chapter);
    _isLoading = false;
    notifyListeners();
  }

  load() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("biblie.testament", _testament);
    await pref.setInt("biblie.book_id", _bookId);
    await pref.setString("biblie.book", _book);
    await pref.setInt("biblie.chapter", _chapter);
    await pref.setStringList("biblie.verses_id", _versesId);
    await pref.setStringList("biblie.verses", _verses);
    notifyListeners();
  }

  getBooksFromTestament({required String testament}) async {
    if (testament == "Old") {
      return await dbHelper.getBooks("Old");
    } else {
      return await dbHelper.getBooks("New");
    }
  }

  updateBookChapters({required String book}) async {
    if (!bookChapters.containsKey(book)) {
      bookChapters[book] = await dbHelper.getChapters(book);
    }
    notifyListeners();
  }

  goToNextChapter() async {
    int lastChapter = await dbHelper.getLastChapterOfBook(_book);

    if (_chapter < lastChapter) {
      await updateValues(
          testament: _testament, book: book, chapter: chapter + 1);
    } else {
      String newBook = await dbHelper.getBookById(_bookId + 1);
      await updateValues(
          testament: _bookId + 1 > 39 ? "New" : "Old",
          book: newBook,
          chapter: 1);
    }
  }

  goToPreviousChapter() async {
    if (_chapter > 1) {
      await updateValues(
          testament: _testament, book: book, chapter: chapter - 1);
    } else {
      String newBook = await dbHelper.getBookById(_bookId - 1);
      int lastChapter = await dbHelper.getLastChapterOfBook(newBook);
      await updateValues(
          testament: _bookId - 1 > 39 ? "New" : "Old",
          book: newBook,
          chapter: lastChapter);
    }
  }

  updateValues(
      {required String testament,
      required String book,
      required int chapter}) async {
    _testament = testament;
    _book = book;
    _bookId = await dbHelper.getBookId(book);
    _chapter = chapter;
    _versesId = await dbHelper.getVersesId(book, chapter);
    _verses = await dbHelper.getVerses(book, chapter);
    load();
  }
}

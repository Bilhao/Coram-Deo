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
  int _chapter = 1;
  List<String> _versesId = [];
  List<String> _verses = [];
  double _fontsize = 17.0;
  bool _isLoading = false;

  String get testament => _testament;
  int get bookId => _bookId;
  String get book => _book;
  int get chapter => _chapter;
  List<String> get versesId => _versesId;
  List<String> get verses => _verses;
  double get fontsize => _fontsize;
  bool get isLoading => _isLoading;

  init() async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    _testament = pref.getString("biblie.testament") ?? "Old";
    _bookId = pref.getInt("biblie.book_id") ?? 1;
    _book = pref.getString("biblie.book") ?? "Gênesis";
    _chapter = pref.getInt("biblie.chapter") ?? 1;
    _versesId = pref.getStringList("biblie.verses_id") ?? await dbHelper.getVersesId(_book, _chapter);
    _verses = pref.getStringList("biblie.verses") ?? await dbHelper.getVerses(_book, _chapter);
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

  setTestament(String value) {
    _testament = value;
    notifyListeners();
  }

  setBookId(int value) {
    _bookId = value;
    notifyListeners();
  }

  setBook(String value) {
    _book = value;
    notifyListeners();
  }

  setChapter(int value) {
    _chapter = value;
    notifyListeners();
  }

  setVersesId(List<String> value) {
    _versesId = value;
    notifyListeners();
  }

  setVerses(List<String> value) {
    _verses = value;
    notifyListeners();
  }

  increaseFontSize() {
    _fontsize++;
    notifyListeners();
  }

  decreaseFontSize() {
    _fontsize--;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeProvider extends ChangeNotifier {

  FontSizeProvider() {
    loadFontSize();
  }

  double _fontSize = 16.0;

  double get fontSize => _fontSize;

  Future<void> loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    notifyListeners();
  }

  Future<void> saveFontSize(double fontSize) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', fontSize);
    _fontSize = fontSize;
    notifyListeners();
  }

  Future<void> increaseFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fontSize += 1.0;
    await prefs.setDouble('fontSize', _fontSize);
    notifyListeners();
  }

  Future<void> decreaseFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fontSize -= 1.0;
    await prefs.setDouble('fontSize', _fontSize);
    notifyListeners();
  }
}
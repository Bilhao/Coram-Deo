import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeProvider() {
    init();
  }

  String _currentTheme = "system";
  bool _dynamicColor = false;
  int _colorSeed = 0xFF004B8D;

  String get currentTheme => _currentTheme;
  bool get dynamicColor => _dynamicColor;
  int get colorSeed => _colorSeed;

  ThemeMode get themeMode {
    if (_currentTheme == "system") {
      return ThemeMode.system;
    } else if (_currentTheme == "light") {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentTheme = prefs.getString('theme.theme') ?? "system";
    _dynamicColor = prefs.getBool('theme.dynamiccolor') ?? false;
    _colorSeed = prefs.getInt('theme.colorseed') ?? 0xFF004B8D;
    notifyListeners();
  }

  Future<void> changeTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme.theme', theme);
    _currentTheme = theme;
    notifyListeners();
  }

  Future<void> toggleDynamicColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _dynamicColor = !_dynamicColor;
    await prefs.setBool('theme.dynamiccolor', _dynamicColor);
    notifyListeners();
  }

  Future<void> changeColorSeed(int colorSeed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _colorSeed = colorSeed;
    await prefs.setInt('theme.colorseed', _colorSeed);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  String _currentTheme;
  bool _dynamicColor;
  int _colorSeed;

  ThemeProvider({
    required String initialTheme,
    required bool initialDynamicColor,
    required int initialColorSeed,
  }) : _currentTheme = initialTheme,
       _dynamicColor = initialDynamicColor,
       _colorSeed = initialColorSeed;


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
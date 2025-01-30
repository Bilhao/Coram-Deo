import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';


class AppProvider extends ChangeNotifier {

  AppProvider() {
    load();
  }

  // Variaveis relativas ao tamanho da fonte
  double _fontSize = 16.0;

  // Variaveis relativas ao tema
  String _currentTheme = "system";
  bool _dynamicColor = false;
  int _colorSeed = 0xFF004B8D;

  // Variaveis relativas ao exame
  bool _blockExame = true;
  bool _useBiometric = true;
  bool _canAuthenticate = false;

  // Getters relativos ao tamanho da fonte
  double get fontSize => _fontSize;

  // Getters relativos ao tema
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

  // Getters relativos ao exame
  bool get blockExame => _blockExame;
  bool get useBiometric => _useBiometric;
  bool get canAuthenticate => _canAuthenticate;


  Future<bool> checkBiometric() async {
    LocalAuthentication auth = LocalAuthentication();
    bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics && await auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;

    _currentTheme = prefs.getString('theme.theme') ?? "system";
    _dynamicColor = prefs.getBool('theme.dynamiccolor') ?? false;
    _colorSeed = prefs.getInt('theme.colorseed') ?? 0xFF004B8D;

    _blockExame = prefs.getBool('exame.block') ?? true;
    _useBiometric = prefs.getBool('exame.biometric') ?? true;
    _canAuthenticate = await checkBiometric();

    notifyListeners();
  }

  // Metodos relativos ao tamanho da fonte
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

  // Metodos relativos ao tema
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

  // Metodos relativos ao exame
  Future<void> toggleBlockExame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _blockExame = !_blockExame;
    await prefs.setBool('exame.block', _blockExame);
    notifyListeners();
  }

  Future<void> toggleUseBiometric() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _useBiometric = !_useBiometric;
    await prefs.setBool('exame.biometric', _useBiometric);
    notifyListeners();
  }

}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import 'package:coramdeo/utils/base_provider.dart';

class AppProvider extends BaseProvider {

  AppProvider() {
    _initialize();
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
    return safeAsync<bool>(() async {
      LocalAuthentication auth = LocalAuthentication();
      bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics && await auth.isDeviceSupported();
      return canAuthenticate;
    }, errorContext: 'Checking biometric authentication') ?? false;
  }

  Future<void> _initialize() async {
    setLoading(true);
    
    await safePrefOperation((prefs) async {
      _fontSize = prefs.getDouble('fontSize') ?? 16.0;

      _currentTheme = prefs.getString('theme.theme') ?? "system";
      _dynamicColor = prefs.getBool('theme.dynamiccolor') ?? false;
      _colorSeed = prefs.getInt('theme.colorseed') ?? 0xFF004B8D;

      _blockExame = prefs.getBool('exame.block') ?? true;
      _useBiometric = prefs.getBool('exame.biometric') ?? true;
      
      return true;
    }, errorContext: 'Loading user preferences');

    _canAuthenticate = await checkBiometric();
    
    setLoading(false);
  }

  // Renamed from 'load' to avoid confusion with Flutter's load methods
  Future<void> reload() async {
    await _initialize();
  }

  // Methods related to font size
  Future<void> saveFontSize(double fontSize) async {
    await safePrefOperation((prefs) async {
      await prefs.setDouble('fontSize', fontSize);
      _fontSize = fontSize;
      notifyListeners();
      return true;
    }, errorContext: 'Saving font size');
  }

  Future<void> increaseFontSize() async {
    if (_fontSize < 30.0) { // Add reasonable upper limit
      await saveFontSize(_fontSize + 1.0);
    }
  }

  Future<void> decreaseFontSize() async {
    if (_fontSize > 12.0) { // Add reasonable lower limit
      await saveFontSize(_fontSize - 1.0);
    }
  }

  // Methods related to theme
  Future<void> changeTheme(String theme) async {
    await safePrefOperation((prefs) async {
      await prefs.setString('theme.theme', theme);
      _currentTheme = theme;
      notifyListeners();
      return true;
    }, errorContext: 'Changing theme');
  }

  Future<void> toggleDynamicColor() async {
    await safePrefOperation((prefs) async {
      _dynamicColor = !_dynamicColor;
      await prefs.setBool('theme.dynamiccolor', _dynamicColor);
      notifyListeners();
      return true;
    }, errorContext: 'Toggling dynamic color');
  }

  Future<void> changeColorSeed(int colorSeed) async {
    await safePrefOperation((prefs) async {
      _colorSeed = colorSeed;
      await prefs.setInt('theme.colorseed', _colorSeed);
      notifyListeners();
      return true;
    }, errorContext: 'Changing color seed');
  }

  // Methods related to examination of conscience
  Future<void> toggleBlockExame() async {
    await safePrefOperation((prefs) async {
      _blockExame = !_blockExame;
      await prefs.setBool('exame.block', _blockExame);
      notifyListeners();
      return true;
    }, errorContext: 'Toggling exam block');
  }

  Future<void> toggleUseBiometric() async {
    await safePrefOperation((prefs) async {
      _useBiometric = !_useBiometric;
      await prefs.setBool('exame.biometric', _useBiometric);
      notifyListeners();
      return true;
    }, errorContext: 'Toggling biometric usage');
  }

}
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';

class AppProvider extends BaseProvider {

  AppProvider() {
    _initialize();
  }

  // Variables related to font size
  double _fontSize = AppConstants.defaultFontSize;

  // Variables related to theme
  String _currentTheme = AppConstants.defaultTheme;
  bool _dynamicColor = AppConstants.defaultDynamicColor;
  int _colorSeed = AppConstants.defaultColorSeed;

  // Variables related to examination of conscience
  bool _blockExame = AppConstants.defaultBlockExame;
  bool _useBiometric = AppConstants.defaultUseBiometric;
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
    final result = await safeAsync<bool>(() async {
      LocalAuthentication auth = LocalAuthentication();
      bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics && await auth.isDeviceSupported();
      return canAuthenticate;
    }, errorContext: 'Checking biometric authentication');
    return result ?? false;
  }

  Future<void> _initialize() async {
    setLoading(true);
    
    await safePrefOperation((prefs) async {
      _fontSize = prefs.getDouble(AppConstants.fontSizeKey) ?? AppConstants.defaultFontSize;

      _currentTheme = prefs.getString(AppConstants.themeKey) ?? AppConstants.defaultTheme;
      _dynamicColor = prefs.getBool(AppConstants.dynamicColorKey) ?? AppConstants.defaultDynamicColor;
      _colorSeed = prefs.getInt(AppConstants.colorSeedKey) ?? AppConstants.defaultColorSeed;

      _blockExame = prefs.getBool(AppConstants.blockExameKey) ?? AppConstants.defaultBlockExame;
      _useBiometric = prefs.getBool(AppConstants.biometricKey) ?? AppConstants.defaultUseBiometric;
      
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
      await prefs.setDouble(AppConstants.fontSizeKey, fontSize);
      _fontSize = fontSize;
      notifyListeners();
      return true;
    }, errorContext: 'Saving font size');
  }

  Future<void> increaseFontSize() async {
    if (_fontSize < AppConstants.maxFontSize) {
      await saveFontSize(_fontSize + 1.0);
    }
  }

  Future<void> decreaseFontSize() async {
    if (_fontSize > AppConstants.minFontSize) {
      await saveFontSize(_fontSize - 1.0);
    }
  }

  // Methods related to theme
  Future<void> changeTheme(String theme) async {
    await safePrefOperation((prefs) async {
      await prefs.setString(AppConstants.themeKey, theme);
      _currentTheme = theme;
      notifyListeners();
      return true;
    }, errorContext: 'Changing theme');
  }

  Future<void> toggleDynamicColor() async {
    await safePrefOperation((prefs) async {
      _dynamicColor = !_dynamicColor;
      await prefs.setBool(AppConstants.dynamicColorKey, _dynamicColor);
      notifyListeners();
      return true;
    }, errorContext: 'Toggling dynamic color');
  }

  Future<void> changeColorSeed(int colorSeed) async {
    await safePrefOperation((prefs) async {
      _colorSeed = colorSeed;
      await prefs.setInt(AppConstants.colorSeedKey, _colorSeed);
      notifyListeners();
      return true;
    }, errorContext: 'Changing color seed');
  }

  // Methods related to examination of conscience
  Future<void> toggleBlockExame() async {
    await safePrefOperation((prefs) async {
      _blockExame = !_blockExame;
      await prefs.setBool(AppConstants.blockExameKey, _blockExame);
      notifyListeners();
      return true;
    }, errorContext: 'Toggling exam block');
  }

  Future<void> toggleUseBiometric() async {
    await safePrefOperation((prefs) async {
      _useBiometric = !_useBiometric;
      await prefs.setBool(AppConstants.biometricKey, _useBiometric);
      notifyListeners();
      return true;
    }, errorContext: 'Toggling biometric usage');
  }

}
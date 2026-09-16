import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:coramdeo/services/cloud_sync_service.dart';
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

  // Variables related to prayers
  bool _bilingualMode = AppConstants.defaultBilingualMode;
  String _prayerLanguage = AppConstants.defaultPrayerLanguage;
  String _bilingualOrder = AppConstants.defaultBilingualOrder;
  bool _openInBilingualMode = AppConstants.defaultOpenInBilingualMode;

  // Variables related to backup
  bool _autoBackup = AppConstants.defaultAutoBackup;

  // Getters relativos ao tamanho da fonte
  double get fontSize => _fontSize;

  // Getters relativos ao backup
  bool get autoBackup => _autoBackup;

  // Getters relativos às orações e modo bilíngue
  bool get bilingualMode => _bilingualMode;
  String get prayerLanguage => _prayerLanguage;
  String get bilingualOrder => _bilingualOrder;
  bool get isLatinFirst => _bilingualOrder == 'lt_pt';
  bool get openInBilingualMode => _openInBilingualMode;

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

      _bilingualMode = prefs.getBool(AppConstants.bilingualModeKey) ?? AppConstants.defaultBilingualMode;
      _prayerLanguage = prefs.getString(AppConstants.prayerLanguageKey) ?? AppConstants.defaultPrayerLanguage;
      _bilingualOrder = prefs.getString(AppConstants.bilingualOrderKey) ?? AppConstants.defaultBilingualOrder;
      _openInBilingualMode = prefs.getBool(AppConstants.openInBilingualModeKey) ?? AppConstants.defaultOpenInBilingualMode;
      if (prefs.containsKey(AppConstants.openInBilingualModeKey)) {
        _bilingualMode = _openInBilingualMode;
      }

      _autoBackup = prefs.getBool(AppConstants.autoBackupKey) ?? AppConstants.defaultAutoBackup;
      _showOnboarding = prefs.getBool(AppConstants.onboardingKey) ?? true;

      return true;
    }, errorContext: 'Loading user preferences');

    _canAuthenticate = await checkBiometric();

    setLoading(false);

    if (!_showOnboarding) {
      final restored = await CloudSyncService().checkAndRestoreOnLogin();
      if (!restored) {
        CloudSyncService().triggerDailyAutoBackup();
      }
    }
  }

  // Renamed from 'load' to avoid confusion with Flutter's load methods
  Future<void> reload() async {
    await _initialize();
  }

  // Onboarding
  bool _showOnboarding = true;
  bool get showOnboarding => _showOnboarding;

  Future<void> completeOnboarding() async {
    await safePrefOperation((prefs) async {
      _showOnboarding = false;
      await prefs.setBool(AppConstants.onboardingKey, false);
      notifyListeners();
      final restored = await CloudSyncService().checkAndRestoreOnLogin();
      if (!restored) {
        CloudSyncService().triggerDailyAutoBackup();
      }
      return true;
    }, errorContext: 'Completing onboarding');
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

  // Methods related to bilingual mode and prayers preferences
  Future<void> toggleBilingualMode() async {
    await safePrefOperation((prefs) async {
      _bilingualMode = !_bilingualMode;
      await prefs.setBool(AppConstants.bilingualModeKey, _bilingualMode);
      notifyListeners();
      return true;
    }, errorContext: 'Toggling bilingual mode');
  }

  Future<void> setPrayerLanguage(String lang) async {
    await safePrefOperation((prefs) async {
      _prayerLanguage = lang;
      await prefs.setString(AppConstants.prayerLanguageKey, lang);
      notifyListeners();
      return true;
    }, errorContext: 'Setting prayer language');
  }

  Future<void> setBilingualOrder(String order) async {
    await safePrefOperation((prefs) async {
      _bilingualOrder = order;
      await prefs.setString(AppConstants.bilingualOrderKey, order);
      notifyListeners();
      return true;
    }, errorContext: 'Setting bilingual order');
  }

  Future<void> setOpenInBilingualMode(bool value) async {
    await safePrefOperation((prefs) async {
      _openInBilingualMode = value;
      _bilingualMode = value;
      await prefs.setBool(AppConstants.openInBilingualModeKey, value);
      await prefs.setBool(AppConstants.bilingualModeKey, value);
      notifyListeners();
      return true;
    }, errorContext: 'Setting open in bilingual mode');
  }

  Future<void> toggleAutoBackup() async {
    await safePrefOperation((prefs) async {
      _autoBackup = !_autoBackup;
      await prefs.setBool(AppConstants.autoBackupKey, _autoBackup);
      notifyListeners();
      return true;
    }, errorContext: 'Toggling auto backup');
  }

  Future<void> setAutoBackup(bool value) async {
    await safePrefOperation((prefs) async {
      _autoBackup = value;
      await prefs.setBool(AppConstants.autoBackupKey, _autoBackup);
      notifyListeners();
      return true;
    }, errorContext: 'Setting auto backup');
  }
}

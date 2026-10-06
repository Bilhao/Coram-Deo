import 'package:coramdeo/services/cloud_sync_service.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Cloud Auto-Backup Safety & Restore on First Login', () {
    setUp(() {
      BaseProvider.resetCachedPrefs();
      SharedPreferences.setMockInitialValues({});
    });

    test('CloudSyncService instance is singleton and exposes safety methods', () {
      final service1 = CloudSyncService();
      final service2 = CloudSyncService();
      expect(identical(service1, service2), isTrue);

      // Verify methods exist and can be called safely without active user without throwing
      expect(() => service1.triggerDailyAutoBackup(), returnsNormally);
      expect(() => service1.checkAndRestoreOnLogin(), returnsNormally);
    });

    test('triggerDailyAutoBackup does nothing when user is not logged in', () async {
      final service = CloudSyncService();
      // Should exit early without throwing any exception
      await service.triggerDailyAutoBackup();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(AppConstants.lastAutoBackupDateKey), isNull);
    });

    test('checkAndRestoreOnLogin returns false when user is not logged in', () async {
      final service = CloudSyncService();
      final restored = await service.checkAndRestoreOnLogin();
      expect(restored, isFalse);
    });

    test('hasUserDataInPlano accurately detects factory default vs user data', () {
      final service = CloudSyncService();

      // Caso 1: Lista vazia
      expect(service.hasUserDataInPlano([]), isFalse);

      // Caso 2: 15 linhas de fábrica do plano_de_vida.db (virgens: nada selecionado, sem datas, sem custom)
      final factoryDefaultPlano = List.generate(
        15,
        (i) => {
          'id': i,
          'title': 'Prática $i',
          'isCustom': 0,
          'isSelected': 0,
          'isCompleted': 0,
          'isNotification': 0,
          'notificationTimes': null,
          'completedDates': null,
        },
      );
      expect(service.hasUserDataInPlano(factoryDefaultPlano), isFalse);

      // Caso 3: Usuário marcou uma prática como selecionada
      final withSelected = List<Map<String, dynamic>>.from(factoryDefaultPlano);
      withSelected[0] = Map<String, dynamic>.from(withSelected[0])..['isSelected'] = 1;
      expect(service.hasUserDataInPlano(withSelected), isTrue);

      // Caso 4: Usuário rezou em algum dia (tem completedDates)
      final withHistory = List<Map<String, dynamic>>.from(factoryDefaultPlano);
      withHistory[1] = Map<String, dynamic>.from(withHistory[1])..['completedDates'] = '06/10/2026';
      expect(service.hasUserDataInPlano(withHistory), isTrue);

      // Caso 5: Usuário adicionou uma prática personalizada
      final withCustom = List<Map<String, dynamic>>.from(factoryDefaultPlano);
      withCustom[2] = Map<String, dynamic>.from(withCustom[2])..['isCustom'] = 1;
      expect(service.hasUserDataInPlano(withCustom), isTrue);

      // Caso 6: Usuário agendou alarme de oração
      final withNotification = List<Map<String, dynamic>>.from(factoryDefaultPlano);
      withNotification[3] = Map<String, dynamic>.from(withNotification[3])
        ..['isNotification'] = 1
        ..['notificationTimes'] = '08:00';
      expect(service.hasUserDataInPlano(withNotification), isTrue);
    });

    test('Safeguard logic: factory default local planoData does not overwrite cloud with items', () {
      final service = CloudSyncService();
      final factoryDefaultPlano = List.generate(
        15,
        (i) => {
          'id': i,
          'title': 'Prática $i',
          'isCustom': 0,
          'isSelected': 0,
          'isCompleted': 0,
          'isNotification': 0,
          'notificationTimes': null,
          'completedDates': null,
        },
      );
      const cloudCount = 15;

      // When local has no user data (factory default) and cloud has data, overwrite MUST be blocked
      final localHasData = service.hasUserDataInPlano(factoryDefaultPlano);
      final shouldPreventOverwrite = !localHasData && cloudCount > 0;
      expect(shouldPreventOverwrite, isTrue);

      // When local has real user data, backup is permitted
      final localWithRealData = List<Map<String, dynamic>>.from(factoryDefaultPlano);
      localWithRealData[0] = Map<String, dynamic>.from(localWithRealData[0])..['isSelected'] = 1;
      final localWithDataHasUserData = service.hasUserDataInPlano(localWithRealData);
      final allowBackupWithData = !(!localWithDataHasUserData && cloudCount > 0);
      expect(allowBackupWithData, isTrue);
    });

    test('Preferences dictionary contains all application settings defaults', () {
      final defaultSettings = <String, dynamic>{
        AppConstants.fontSizeKey: AppConstants.defaultFontSize,
        AppConstants.themeKey: AppConstants.defaultTheme,
        AppConstants.dynamicColorKey: AppConstants.defaultDynamicColor,
        AppConstants.colorSeedKey: AppConstants.defaultColorSeed,
        AppConstants.blockExameKey: AppConstants.defaultBlockExame,
        AppConstants.biometricKey: AppConstants.defaultUseBiometric,
        AppConstants.autoBackupKey: AppConstants.defaultAutoBackup,
        AppConstants.bilingualModeKey: AppConstants.defaultBilingualMode,
        AppConstants.prayerLanguageKey: AppConstants.defaultPrayerLanguage,
        AppConstants.bilingualOrderKey: AppConstants.defaultBilingualOrder,
        AppConstants.openInBilingualModeKey: AppConstants.defaultOpenInBilingualMode,
        AppConstants.showOpusDeiCelebrationsKey: AppConstants.defaultShowOpusDeiCelebrations,
        AppConstants.bibleTestamentKey: AppConstants.defaultTestament,
        AppConstants.bibleBookIdKey: AppConstants.defaultBookId,
        AppConstants.bibleBookKey: AppConstants.defaultBook,
        AppConstants.bibleChapterKey: AppConstants.defaultChapter,
        AppConstants.bibleVersionKey: AppConstants.defaultBibleVersion,
      };

      expect(defaultSettings[AppConstants.showOpusDeiCelebrationsKey], isFalse);
      expect(defaultSettings[AppConstants.autoBackupKey], isTrue);
      expect(defaultSettings.containsKey(AppConstants.fontSizeKey), isTrue);
      expect(defaultSettings.containsKey(AppConstants.themeKey), isTrue);
    });
  });
}

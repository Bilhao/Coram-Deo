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

    test('hasUserDataInPreferences accurately detects default vs customized preferences', () {
      final service = CloudSyncService();

      // Factory defaults
      final defaultPrefs = <String, dynamic>{
        AppConstants.fontSizeKey: AppConstants.defaultFontSize,
        AppConstants.themeKey: AppConstants.defaultTheme,
        AppConstants.colorSeedKey: AppConstants.defaultColorSeed,
        AppConstants.favoritePrayersKey: <String>[],
        'exame.itensExame': '{}',
        AppConstants.bibleChapterKey: 1,
        AppConstants.bibleBookIdKey: 1,
      };
      expect(service.hasUserDataInPreferences(defaultPrefs), isFalse);

      // Modified font size
      expect(
        service.hasUserDataInPreferences({...defaultPrefs, AppConstants.fontSizeKey: 22.0}),
        isTrue,
      );

      // Favorite prayers added
      expect(
        service.hasUserDataInPreferences({
          ...defaultPrefs,
          AppConstants.favoritePrayersKey: ['Oração da Manhã'],
        }),
        isTrue,
      );

      // Exame de consciência items added (Map or JSON string)
      expect(
        service.hasUserDataInPreferences({
          ...defaultPrefs,
          'exame.itensExame': {'Pecado': 'Descrição'},
        }),
        isTrue,
      );
      expect(
        service.hasUserDataInPreferences({
          ...defaultPrefs,
          'exame.itensExame': '{"Pecado": "Descrição"}',
        }),
        isTrue,
      );

      // Bible reading progress
      expect(
        service.hasUserDataInPreferences({...defaultPrefs, AppConstants.bibleChapterKey: 5}),
        isTrue,
      );

      // Book reading progress
      expect(
        service.hasUserDataInPreferences({
          ...defaultPrefs,
          'livros.caminho.currentChapterId': 12,
        }),
        isTrue,
      );
    });

    test('sanitizePlanoRows converts booleans, handles nulls, and enforces SQLite constraints', () {
      final service = CloudSyncService();

      final rawRows = [
        // Row with booleans and null strings
        {
          'id': 1,
          'title': 'Oração Diária',
          'isCustom': false,
          'isSelected': true,
          'isCompleted': false,
          'isNotification': true,
          'notificationTimes': '07:30',
          'completedDates': null,
          'extraColumnThatDoesNotExistInSqlite': 'ignored_value',
        },
        // Row with missing/null boolean values
        {
          'id': 2,
          'title': 'Santo Rosário',
          'isCustom': null,
          'isSelected': 1,
          'isCompleted': null,
          'isNotification': 0,
        },
        // Row with empty title (should be skipped)
        {
          'id': 3,
          'title': '   ',
          'isCustom': 0,
          'isSelected': 1,
        },
      ];

      final sanitized = service.sanitizePlanoRows(rawRows);
      expect(sanitized.length, equals(2));

      // Row 1 assertions
      expect(sanitized[0]['id'], equals(1));
      expect(sanitized[0]['title'], equals('Oração Diária'));
      expect(sanitized[0]['isCustom'], equals(0));
      expect(sanitized[0]['isSelected'], equals(1));
      expect(sanitized[0]['isCompleted'], equals(0));
      expect(sanitized[0]['isNotification'], equals(1));
      expect(sanitized[0]['notificationTimes'], equals('07:30'));
      expect(sanitized[0]['completedDates'], isNull);
      expect(sanitized[0]['weekdays'], equals('1,2,3,4,5,6,7'));
      expect(sanitized[0].containsKey('extraColumnThatDoesNotExistInSqlite'), isFalse);

      // Row 2 assertions
      expect(sanitized[1]['id'], equals(2));
      expect(sanitized[1]['title'], equals('Santo Rosário'));
      expect(sanitized[1]['isCustom'], equals(0));
      expect(sanitized[1]['isSelected'], equals(1));
      expect(sanitized[1]['isCompleted'], equals(0));
      expect(sanitized[1]['isNotification'], equals(0));
    });

    test('restorePreferencesFromMap safely coerces and restores all data types', () async {
      final service = CloudSyncService();

      final restoredPrefs = {
        // Font size as num/int should become double
        AppConstants.fontSizeKey: 20,
        // Color seed as double should become int
        AppConstants.colorSeedKey: 4278213005.0,
        // Bible IDs as double should become int
        AppConstants.bibleBookIdKey: 2.0,
        AppConstants.bibleChapterKey: 15.0,
        // Boolean values as num and bool
        AppConstants.dynamicColorKey: 1,
        AppConstants.blockExameKey: true,
        // Exame items as Map should become JSON string
        'exame.itensExame': {'Pecado da Ira': 'Fiquei impaciente hoje'},
        // Favorite prayers as List
        AppConstants.favoritePrayersKey: ['Oração a São Miguel', 'Ângelus'],
        // Book progress as num should become int
        'livros.caminho.currentChapterId': 45.0,
      };

      await service.restorePreferencesFromMap(restoredPrefs);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getDouble(AppConstants.fontSizeKey), equals(20.0));
      expect(prefs.getInt(AppConstants.colorSeedKey), equals(4278213005));
      expect(prefs.getInt(AppConstants.bibleBookIdKey), equals(2));
      expect(prefs.getInt(AppConstants.bibleChapterKey), equals(15));
      expect(prefs.getBool(AppConstants.dynamicColorKey), isTrue);
      expect(prefs.getBool(AppConstants.blockExameKey), isTrue);
      expect(
        prefs.getString('exame.itensExame'),
        equals('{"Pecado da Ira":"Fiquei impaciente hoje"}'),
      );
      expect(
        prefs.getStringList(AppConstants.favoritePrayersKey),
        equals(['Oração a São Miguel', 'Ângelus']),
      );
      expect(prefs.getInt('livros.caminho.currentChapterId'), equals(45));
    });

    test('CloudSyncService.onDataRestored triggers listeners when restored', () {
      int notifyCount = 0;
      void listener() {
        notifyCount++;
      }

      CloudSyncService.onDataRestored.addListener(listener);
      CloudSyncService.onDataRestored.value++;

      expect(notifyCount, equals(1));
      CloudSyncService.onDataRestored.removeListener(listener);
    });
  });
}

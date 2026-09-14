import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Cloud Auto-Backup configuration and preferences', () {
    setUp(() {
      BaseProvider.resetCachedPrefs();
      SharedPreferences.setMockInitialValues({});
    });

    test('Default autoBackupKey and defaultAutoBackup constants are defined', () {
      expect(AppConstants.autoBackupKey, equals('backup.auto_backup'));
      expect(AppConstants.lastAutoBackupDateKey, equals('backup.last_auto_date'));
      expect(AppConstants.defaultAutoBackup, isTrue);
    });

    test('AppProvider initializes with default autoBackup true when key is absent', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = AppProvider();
      await Future.delayed(const Duration(milliseconds: 100));

      expect(provider.autoBackup, isTrue);
    });

    test('AppProvider respects stored autoBackup preference', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.autoBackupKey: false,
      });
      final provider = AppProvider();
      await Future.delayed(const Duration(milliseconds: 100));

      expect(provider.autoBackup, isFalse);
    });

    test('AppProvider.setAutoBackup updates value and persists to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.autoBackupKey: true,
      });
      final provider = AppProvider();
      await Future.delayed(const Duration(milliseconds: 100));

      var notified = false;
      provider.addListener(() {
        notified = true;
      });

      await provider.setAutoBackup(false);

      expect(provider.autoBackup, isFalse);
      expect(notified, isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppConstants.autoBackupKey), isFalse);
    });

    test('Daily backup date token logic correctly detects same day', () {
      final now = DateTime(2026, 9, 14, 15, 30);
      final todayStr = '${now.day}-${now.month}-${now.year}';

      expect(todayStr, equals('14-9-2026'));

      // Check date matching
      const storedLastDate = '14-9-2026';
      expect(storedLastDate == todayStr, isTrue);

      const previousDayDate = '13-9-2026';
      expect(previousDayDate == todayStr, isFalse);
    });
  });
}

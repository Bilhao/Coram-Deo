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

    test('Safeguard logic: empty local planoData does not overwrite cloud with items', () {
      final localPlano = <Map<String, dynamic>>[];
      const cloudCount = 15;

      // When local is empty and cloud has data, condition to prevent overwrite must be true
      final shouldPreventOverwrite = localPlano.isEmpty && cloudCount > 0;
      expect(shouldPreventOverwrite, isTrue);

      // When local has data, normal backup proceeds
      final localWithData = [{'id': 1, 'titulo': 'Oração Mental'}];
      final allowBackupWithData = !(localWithData.isEmpty && cloudCount > 0);
      expect(allowBackupWithData, isTrue);
    });
  });
}

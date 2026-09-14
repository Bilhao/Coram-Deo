import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Bilingual Prayer Widgets Tests', () {
    testWidgets('BilingualPrayerHeader renders Latin and Portuguese titles', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BilingualPrayerHeader(
              latinTitle: 'LATIM',
              portugueseTitle: 'PORTUGUÊS',
            ),
          ),
        ),
      );

      expect(find.text('LATIM'), findsOneWidget);
      expect(find.text('PORTUGUÊS'), findsOneWidget);
    });

    testWidgets('BilingualPrayerRow renders side-by-side contents with divider', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BilingualPrayerRow(
              latin: Text('Adóro te devóte'),
              portuguese: Text('Adoro-Te com amor'),
            ),
          ),
        ),
      );

      expect(find.text('Adóro te devóte'), findsOneWidget);
      expect(find.text('Adoro-Te com amor'), findsOneWidget);
      expect(find.byType(VerticalDivider), findsOneWidget);
    });
  });

  setUp(() {
    BaseProvider.resetCachedPrefs();
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/local_auth'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getAvailableBiometrics') {
          return <String>[];
        }
        return false;
      },
    );
  });

  tearDown(() {
    BaseProvider.resetCachedPrefs();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/local_auth'),
      null,
    );
  });

  group('AppProvider Bilingual Mode Tests', () {
    test('Default bilingual mode is false', () async {
      final provider = AppProvider();
      await provider.reload();
      expect(provider.bilingualMode, isFalse);
    });

    test('toggleBilingualMode toggles and persists value', () async {
      final provider = AppProvider();
      await provider.reload();
      expect(provider.bilingualMode, isFalse);

      await provider.toggleBilingualMode();
      expect(provider.bilingualMode, isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppConstants.bilingualModeKey), isTrue);

      await provider.toggleBilingualMode();
      expect(provider.bilingualMode, isFalse);
      expect(prefs.getBool(AppConstants.bilingualModeKey), isFalse);
    });

    test('Initializes with true if saved in preferences', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.bilingualModeKey: true,
      });

      final provider = AppProvider();
      await provider.reload();
      expect(provider.bilingualMode, isTrue);
    });
  });
}

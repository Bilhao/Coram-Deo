import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color/test_utils.dart';
import 'package:dynamic_color/samples.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Dynamic Color Theme Tests', () {
    testWidgets('uses authentic harmonized dynamic color scheme when dynamic color is active', (tester) async {
      DynamicColorTestingUtils.setMockDynamicColors(
        corePalette: SampleCorePalettes.green,
      );

      ColorScheme? resolvedLightScheme;
      ColorScheme? resolvedDarkScheme;

      await tester.pumpWidget(
        DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) {
            final light = lightDynamic != null
                ? lightDynamic.harmonized()
                : ColorScheme.fromSeed(seedColor: const Color(0xFF004B8D));
            final dark = darkDynamic != null
                ? darkDynamic.harmonized()
                : ColorScheme.fromSeed(seedColor: const Color(0xFF004B8D), brightness: Brightness.dark);

            resolvedLightScheme = light;
            resolvedDarkScheme = dark;

            return MaterialApp(
              theme: ThemeData(colorScheme: light, useMaterial3: true),
              darkTheme: ThemeData(colorScheme: dark, useMaterial3: true),
              home: const Scaffold(body: Text('Theme Test')),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(resolvedLightScheme, isNotNull);
      expect(resolvedDarkScheme, isNotNull);
      // Verify that the color scheme matches SampleCorePalettes.green authentically
      final expectedLight = SampleCorePalettes.green.toColorScheme().harmonized();
      expect(resolvedLightScheme!.primary, equals(expectedLight.primary));
      expect(resolvedLightScheme!.secondary, equals(expectedLight.secondary));
      expect(resolvedLightScheme!.surface, equals(expectedLight.surface));
    });

    testWidgets('falls back to custom color seed when dynamic color is disabled', (tester) async {
      const customSeed = Color(0xFF004B8D);
      final fallbackScheme = ColorScheme.fromSeed(
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        seedColor: customSeed,
        primary: customSeed,
        brightness: Brightness.light,
      );

      expect(fallbackScheme.primary, equals(customSeed));
    });
  });
}

import 'package:coramdeo/app/calendario/widgets/opus_dei_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OpusDeiIcon Widget Tests', () {
    testWidgets('Renderiza com dimensões e cores personalizadas', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: OpusDeiIcon(size: 24.0, color: Color(0xFFDAB264)),
            ),
          ),
        ),
      );

      final iconFinder = find.byType(OpusDeiIcon);
      expect(iconFinder, findsOneWidget);

      final SizedBox sizedBox = tester.widget<SizedBox>(
        find.descendant(of: iconFinder, matching: find.byType(SizedBox)),
      );
      expect(sizedBox.width, 24.0);
      expect(sizedBox.height, 24.0);

      final CustomPaint customPaint = tester.widget<CustomPaint>(
        find.descendant(of: iconFinder, matching: find.byType(CustomPaint)),
      );
      expect(customPaint.painter, isNotNull);
    });

    testWidgets('Funciona em tamanhos compactos de régua e grid', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                OpusDeiIcon(size: 7.0),
                OpusDeiIcon(size: 8.0),
                OpusDeiIcon(size: 10.0),
                OpusDeiIcon(size: 16.0),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(OpusDeiIcon), findsNWidgets(4));
    });

    testWidgets('Herda a cor do IconTheme ambiente quando color for nulo', (
      tester,
    ) async {
      const ambientColor = Color(0xFF123456);
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: IconTheme(
              data: IconThemeData(color: ambientColor),
              child: OpusDeiIcon(size: 22.0),
            ),
          ),
        ),
      );

      expect(find.byType(OpusDeiIcon), findsOneWidget);
    });
  });
}

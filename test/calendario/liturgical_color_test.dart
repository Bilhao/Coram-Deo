import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LiturgicalColor Representation & Styling Tests', () {
    testWidgets('Cor Branca só adiciona borda se o fundo for realmente branco', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: Brightness.light),
          home: Builder(
            builder: (context) {
              // Sem fundo branco: SEM borda
              final defaultDecor = LiturgicalColor.white.dotDecoration(context);
              expect(defaultDecor.color, const Color(0xFFFFFFFF));
              expect(defaultDecor.border, isNull);
              expect(defaultDecor.boxShadow, isNull);

              // Sobre fundo não-branco (ex: secondaryContainer azul pastel): SEM borda
              final blueDecor = LiturgicalColor.white.dotDecoration(
                context,
                backgroundColor: const Color(0xFFD3E4E8),
              );
              expect(blueDecor.border, isNull);

              // Sobre fundo realmente branco: COM borda para contraste
              final whiteDecor = LiturgicalColor.white.dotDecoration(
                context,
                backgroundColor: Colors.white,
              );
              expect(whiteDecor.color, const Color(0xFFFFFFFF));
              expect(whiteDecor.border, isNotNull);

              // Com flag explícita onWhiteBackground: COM borda
              final flagDecor = LiturgicalColor.white.dotDecoration(
                context,
                onWhiteBackground: true,
              );
              expect(flagDecor.border, isNotNull);

              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets(
      'Cor Branca no tema escuro sobre fundo escuro não adiciona borda',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(brightness: Brightness.dark),
            home: Builder(
              builder: (context) {
                final decor = LiturgicalColor.white.dotDecoration(
                  context,
                  backgroundColor: const Color(0xFF121212),
                );
                expect(decor.color, const Color(0xFFFFFFFF));
                expect(decor.shape, BoxShape.circle);
                expect(decor.border, isNull);

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );

    testWidgets('Outras cores litúrgicas preservam preenchimento sem borda', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: Brightness.light),
          home: Builder(
            builder: (context) {
              final greenDecor = LiturgicalColor.green.dotDecoration(
                context,
                backgroundColor: Colors.white,
              );
              expect(greenDecor.color, const Color(0xFF2E7D32));
              expect(greenDecor.border, isNull);

              final redDecor = LiturgicalColor.red.dotDecoration(
                context,
                backgroundColor: Colors.white,
              );
              expect(redDecor.color, const Color(0xFFC62828));
              expect(redDecor.border, isNull);

              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}

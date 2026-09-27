import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/santo_do_dia/page.dart';
import 'package:coramdeo/app/santo_do_dia/provider.dart';
import 'package:coramdeo/app/santo_do_dia/widgets/saint_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('SaintFullscreenViewer Widget Tests', () {
    testWidgets('Renderiza controles, título e fecha corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SaintFullscreenViewer(
            name: 'São Roberto Belarmino',
            subtitulo: 'Bispo e Doutor da Igreja',
            heroTag: 'hero_test_tag',
            assetPath: 'assets/images/santos/santo_09_17.webp',
          ),
        ),
      );

      // Verifica elementos da barra superior
      expect(find.text('São Roberto Belarmino'), findsOneWidget);
      expect(find.text('Bispo e Doutor da Igreja'), findsOneWidget);
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);
      expect(find.byIcon(Icons.download), findsOneWidget);

      // Toca na tela para alternar visibilidade dos controles
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Toca no botão fechar
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();
    });
  });

  group('SaintImageActionsSheet Tests', () {
    testWidgets('Exibe opções de tela cheia, compartilhar e salvar', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showSaintImageActionsSheet(
                      context,
                      name: 'São Roberto Belarmino',
                      subtitulo: 'Bispo e Doutor da Igreja',
                      heroTag: 'hero_test_tag',
                      assetPath: 'assets/images/santos/santo_09_17.webp',
                      localPath: null,
                      networkUrl: null,
                    );
                  },
                  child: const Text('Abrir Opções'),
                );
              },
            ),
          ),
        ),
      );

      // Abre o BottomSheet
      await tester.tap(find.text('Abrir Opções'));
      await tester.pumpAndSettle();

      // Verifica elementos do BottomSheet
      expect(find.text('São Roberto Belarmino'), findsOneWidget);
      expect(find.text('Bispo e Doutor da Igreja'), findsOneWidget);
      expect(find.text('Ver imagem ampliada'), findsOneWidget);
      expect(find.text('Compartilhar imagem'), findsOneWidget);
      expect(find.text('Salvar imagem'), findsOneWidget);
    });
  });

  group('SantoDoDiaPage Image Tap/LongPress Integration Tests', () {
    testWidgets(
      'Toque simples abre tela cheia e toque longo abre BottomSheet',
      (tester) async {
        final santoProvider = SantoDoDiaProvider();
        final appProvider = AppProvider();

        santoProvider.setSaintForTesting(
          name: 'São Roberto Belarmino',
          subtitulo: 'Bispo e Doutor da Igreja',
          portrait: 'assets/images/santos/santo_09_17.webp',
          text: ['Biografia resumida de São Roberto Belarmino.'],
          oracao: 'Ó Deus, que cumulastes São Roberto...',
          day: 17,
          month: 9,
        );

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<SantoDoDiaProvider>.value(
                value: santoProvider,
              ),
              ChangeNotifierProvider<AppProvider>.value(value: appProvider),
            ],
            child: MaterialApp(
              home: SantoDoDiaPage(initialDate: DateTime(2026, 9, 17)),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Localiza o InkWell que envolve o Hero da imagem
        final heroFinder = find.byType(Hero);
        expect(heroFinder, findsOneWidget);

        final imageInkWell = find.ancestor(
          of: heroFinder,
          matching: find.byType(InkWell),
        );
        expect(imageInkWell, findsOneWidget);

        // Realiza toque simples para abrir a imagem em tela cheia
        await tester.tap(imageInkWell);
        await tester.pumpAndSettle();

        expect(find.byType(SaintFullscreenViewer), findsOneWidget);

        // Fecha o visualizador
        await tester.tap(find.byIcon(Icons.close_rounded));
        await tester.pumpAndSettle();

        expect(find.byType(SaintFullscreenViewer), findsNothing);

        // Realiza toque longo na imagem
        await tester.longPress(imageInkWell);
        await tester.pumpAndSettle();

        // BottomSheet deve estar visível com todas as ações
        expect(find.text('Ver imagem ampliada'), findsOneWidget);
        expect(find.text('Compartilhar imagem'), findsOneWidget);
        expect(find.text('Salvar imagem'), findsOneWidget);
      },
    );
  });
}

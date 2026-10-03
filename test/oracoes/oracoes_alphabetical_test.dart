import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/oracoes/page.dart';
import 'package:coramdeo/app/search/provider.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/routes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    BaseProvider.resetCachedPrefs();
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    BaseProvider.resetCachedPrefs();
  });

  Widget buildTestApp(Widget child) {
    return ChangeNotifierProvider<AppProvider>(
      create: (_) => AppProvider(),
      child: MaterialApp(onGenerateRoute: Routes.onGenerateRoute, home: child),
    );
  }

  group('OracoesPage Alphabetical Order Tests', () {
    testWidgets('Displays all prayers in strict alphabetical order', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 6000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestApp(const OracoesPage()));
      await tester.pumpAndSettle();

      // Expand the "Todas" ExpansionTile
      await tester.tap(find.text('Todas'));
      await tester.pumpAndSettle();

      // Collect all prayer ListTile widgets under "Todas"
      final listTiles = tester.widgetList<ListTile>(find.byType(ListTile));
      final titles = listTiles
          .map((tile) => ((tile.title as Text).data ?? ''))
          .where((t) => t != 'Favoritas' && t != 'Todas')
          .toList();

      expect(titles.length, 18);

      // Verify that the list is strictly ordered alphabetically
      expect(titles.first, 'Adoração e Bênção com o Santíssimo');
      expect(titles[1], 'Adoro Te Devote');
      expect(titles[2], 'Angelus/Regina Cæli');
      expect(titles[3], 'Comentário do Evangelho do dia');
      expect(titles[4], 'Credo Atanasiano');
      expect(titles[5], 'Credo Niceno-Constantinopolitano');
      expect(titles[6], 'Estampa de São Josemaría');
      expect(titles[7], 'Exame de Consciência');
      expect(titles[8], 'Gratias tibi ago');
      expect(titles[9], 'Lembrai-Vos');
      expect(titles[10], 'Meditação Diária do Falar com Deus');
      expect(titles[11], 'Oferecimento de Obras');
      expect(titles[12], 'Preces');
      expect(titles[13], 'Responso');
      expect(titles[14], 'Salmo 2');
      expect(titles[15], 'Santo Rosário');
      expect(titles[16], 'Te Deum');
      expect(titles[17], 'Visita ao Santíssimo');
    });

    test('SearchProvider prayers map is in alphabetical order', () {
      final provider = SearchProvider();
      final titles = provider.prayers.values.toList();
      expect(titles.first, 'Adoração e Bênção com o Santíssimo');
      expect(titles[1], 'Adoro Te Devote');
      expect(titles.last, 'Visita ao Santíssimo');
    });
  });
}

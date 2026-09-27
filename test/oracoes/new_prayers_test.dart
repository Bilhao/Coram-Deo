import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/oracoes/adoracao_bencao_santissimo/page.dart';
import 'package:coramdeo/app/oracoes/page.dart';
import 'package:coramdeo/app/oracoes/responso/page.dart';
import 'package:coramdeo/app/santo_do_dia/provider.dart';
import 'package:coramdeo/app/search/provider.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/routes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  Widget buildTestApp(Widget child, {AppProvider? appProvider}) {
    return ChangeNotifierProvider<AppProvider>(
      create: (_) => appProvider ?? AppProvider(),
      child: MaterialApp(onGenerateRoute: Routes.onGenerateRoute, home: child),
    );
  }

  group('AdoracaoBencaoSantissimoPage Widget Tests', () {
    testWidgets('Renders all liturgical sections with standard book style', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        buildTestApp(const AdoracaoBencaoSantissimoPage()),
      );
      await tester.pumpAndSettle();

      // Check title in AppBar
      expect(find.text('Adoração e Bênção'), findsOneWidget);

      // Verify that NO Material Cards or CircleAvatars are used for decoration
      expect(find.byType(Card), findsNothing);
      expect(find.byType(CircleAvatar), findsNothing);

      // Check liturgical rubrics and score tiles
      expect(find.text('Pange Lingua'), findsOneWidget);
      expect(
        find.textContaining('Leitura da Sagrada Escritura'),
        findsOneWidget,
      );
      // Expand ExpansionTile for Visita ao Santíssimo if present
      final visitaTile = find.text('Visita ao Santíssimo');
      if (visitaTile.evaluate().isNotEmpty) {
        await tester.tap(visitaTile);
        await tester.pumpAndSettle();
      }

      expect(find.textContaining('Comunhão espiritual'), findsWidgets);
      expect(find.textContaining('Preces (Opcional)'), findsOneWidget);
      expect(find.text('Tantum Ergo'), findsOneWidget);
      expect(find.textContaining('Pão que desceu do Céu'), findsOneWidget);
      expect(
        find.textContaining(
          'Senhor Jesus Cristo, que neste admirável sacramento',
        ),
        findsOneWidget,
      );
      expect(find.text('Laudate Dominum'), findsOneWidget);
      expect(find.text('Salve Regina'), findsOneWidget);

      // Check Gospel and Preces action buttons
      expect(find.text('Abrir Evangelho do Dia'), findsOneWidget);
      expect(find.text('Rezar as Preces'), findsOneWidget);

      // Check Portuguese content by default
      expect(find.textContaining('Vamos todos louvar juntos'), findsOneWidget);
      expect(find.textContaining('Tão sublime Sacramento'), findsOneWidget);
      expect(
        find.textContaining('Bendito seja o seu Santo Nome'),
        findsOneWidget,
      );
    });

    testWidgets('Toggles bilingual mode and shows Latin and Portuguese', (
      tester,
    ) async {
      final appProvider = AppProvider();
      await tester.pumpWidget(
        buildTestApp(
          const AdoracaoBencaoSantissimoPage(),
          appProvider: appProvider,
        ),
      );
      await tester.pumpAndSettle();

      // App starts in bilingual mode by default
      expect(find.text('LATIM'), findsOneWidget);
      expect(find.text('PORTUGUÊS'), findsOneWidget);
      expect(find.textContaining('Pange, lingua, gloriósi'), findsOneWidget);
      expect(find.textContaining('Vamos todos louvar juntos'), findsOneWidget);

      // Tap bilingual toggle icon button to switch to single column
      final toSingleFinder = find.byTooltip('Modo coluna única');
      expect(toSingleFinder, findsOneWidget);
      await tester.tap(toSingleFinder);
      await tester.pumpAndSettle();

      expect(find.text('LATIM'), findsNothing);

      // Tap toggle again to return to bilingual
      final toBilingualFinder = find.byTooltip('Modo bilíngue lado a lado');
      expect(toBilingualFinder, findsOneWidget);
      await tester.tap(toBilingualFinder);
      await tester.pumpAndSettle();

      expect(find.text('LATIM'), findsOneWidget);
      expect(find.text('PORTUGUÊS'), findsOneWidget);
    });
  });

  group('ResponsoPage Widget Tests', () {
    testWidgets('Renders Responso with standard liturgical styling', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestApp(const ResponsoPage()));
      await tester.pumpAndSettle();

      // Check title
      expect(find.text('Responso'), findsOneWidget);

      // Verify that NO Material Cards or CircleAvatars are used
      expect(find.byType(Card), findsNothing);
      expect(find.byType(CircleAvatar), findsNothing);

      // Check Antiphon
      expect(
        find.textContaining('Eu sou a ressurreição e a vida'),
        findsWidgets,
      );

      // Check Invocations to Saints and Angels
      expect(
        find.textContaining('Santos de Deus, vinde em seu auxílio'),
        findsOneWidget,
      );
      expect(find.textContaining('Acolhei a sua alma'), findsWidgets);

      // Check Kyrie & Versicles
      expect(find.textContaining('Senhor, tende piedade de nós'), findsWidgets);
      expect(find.textContaining('Livrai, Senhor, a sua alma'), findsOneWidget);
      expect(find.textContaining('Descanse (descansem) em paz'), findsWidgets);
    });

    testWidgets('ResponsoPage supports bilingual toggle', (tester) async {
      final appProvider = AppProvider();
      await tester.pumpWidget(
        buildTestApp(const ResponsoPage(), appProvider: appProvider),
      );
      await tester.pumpAndSettle();

      // App starts in bilingual mode by default
      expect(find.text('LATIM'), findsOneWidget);
      expect(find.text('PORTUGUÊS'), findsOneWidget);
      expect(find.textContaining('Ego sum resurréctio et vita'), findsWidgets);
      expect(find.textContaining('Subveníte, Sancti Dei'), findsOneWidget);

      // Tap toggle to single column
      final toSingleFinder = find.byTooltip('Modo coluna única');
      expect(toSingleFinder, findsOneWidget);
      await tester.tap(toSingleFinder);
      await tester.pumpAndSettle();

      expect(find.text('LATIM'), findsNothing);

      // Tap toggle back to bilingual
      final toBilingualFinder = find.byTooltip('Modo bilíngue lado a lado');
      expect(toBilingualFinder, findsOneWidget);
      await tester.tap(toBilingualFinder);
      await tester.pumpAndSettle();

      expect(find.text('LATIM'), findsOneWidget);
      expect(find.text('PORTUGUÊS'), findsOneWidget);
    });
  });

  group('Routes and Catalog Integration Tests', () {
    test('Routes resolves both new prayer pages', () {
      final route1 = Routes.onGenerateRoute(
        const RouteSettings(name: '/adoracao-e-bencao-com-o-santissimo'),
      );
      expect(route1, isA<MaterialPageRoute>());
      final page1 = (route1 as MaterialPageRoute).builder;
      expect(page1, isNotNull);

      final route2 = Routes.onGenerateRoute(
        const RouteSettings(name: '/responso'),
      );
      expect(route2, isA<MaterialPageRoute>());
      final page2 = (route2 as MaterialPageRoute).builder;
      expect(page2, isNotNull);
    });

    testWidgets('OracoesPage lists both new prayers and allows scrolling', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestApp(const OracoesPage()));
      await tester.pumpAndSettle();

      // Expand the "Todas" ExpansionTile
      await tester.tap(find.text('Todas'));
      await tester.pumpAndSettle();

      // Drag up to reveal items at the bottom of the list
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -1000),
      );
      await tester.pumpAndSettle();

      expect(find.text('Adoração e Bênção com o Santíssimo'), findsOneWidget);
      expect(find.text('Responso'), findsOneWidget);
    });

    test('SearchProvider catalog contains both new prayers', () {
      final provider = SearchProvider();
      expect(
        provider.prayers['adoracao-e-bencao-com-o-santissimo'],
        'Adoração e Bênção com o Santíssimo',
      );
      expect(provider.prayers['responso'], 'Responso');
    });
  });

  group('SantoDoDia Remote GitHub Image Resolution Tests', () {
    test('Resolves GitHub raw URL for dates not bundled in assets', () {
      final url = SantoDoDiaProvider.resolvePortraitUrl(null, 15, 11);
      expect(url, '${SantoDoDiaProvider.githubImagesBaseUrl}/santo_11_15.webp');
    });

    test('Resolves asset path for dates bundled in assets', () {
      final url = SantoDoDiaProvider.resolvePortraitUrl(null, 1, 9);
      expect(url, 'assets/images/santos/santo_09_01.webp');
    });
  });
}

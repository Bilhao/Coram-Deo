import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/home_page.dart';
import 'package:coramdeo/app/santo_do_dia/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Santo do Dia - Reset to Today Tests', () {
    testWidgets(
      'Clicar no botão Santo do Dia na HomePage redefine a data para hoje após alteração',
      (tester) async {
        final santoProvider = SantoDoDiaProvider();
        final appProvider = AppProvider();

        // Simula que o usuário navegou para outra data na página do Santo do Dia
        await santoProvider.changeDate(15, 10);
        expect(santoProvider.day, 15);
        expect(santoProvider.month, 10);

        // Renderiza o botão HomePageButtons do Santo do Dia com o Provider
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<SantoDoDiaProvider>.value(
                value: santoProvider,
              ),
              ChangeNotifierProvider<AppProvider>.value(value: appProvider),
            ],
            child: MaterialApp(
              routes: {
                '/santo-do-dia': (context) =>
                    const Scaffold(body: Text('Página do Santo do Dia')),
              },
              home: Scaffold(
                body: HomePageButtons(
                  text: "Santo do Dia",
                  route: '/santo-do-dia',
                  onTap: () {
                    santoProvider.resetToToday();
                  },
                ),
              ),
            ),
          ),
        );

        // Localiza e clica no botão "Santo do Dia"
        final buttonFinder = find.widgetWithText(FilledButton, "Santo do Dia");
        expect(buttonFinder, findsOneWidget);

        await tester.tap(buttonFinder);
        await tester.pumpAndSettle();

        // Verifica se a data foi redefinida com sucesso para o dia de hoje
        final now = DateTime.now();
        expect(santoProvider.day, now.day);
        expect(santoProvider.month, now.month);
      },
    );

    testWidgets(
      'HomePageButtons reseta automaticamente para hoje mesmo sem onTap explícito',
      (tester) async {
        final santoProvider = SantoDoDiaProvider();
        final appProvider = AppProvider();

        // Altera a data
        await santoProvider.changeDate(25, 12);
        expect(santoProvider.day, 25);
        expect(santoProvider.month, 12);

        // Renderiza HomePageButtons sem passar onTap explícito
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<SantoDoDiaProvider>.value(
                value: santoProvider,
              ),
              ChangeNotifierProvider<AppProvider>.value(value: appProvider),
            ],
            child: MaterialApp(
              routes: {
                '/santo-do-dia': (context) =>
                    const Scaffold(body: Text('Página do Santo do Dia')),
              },
              home: const Scaffold(
                body: HomePageButtons(
                  text: "Santo do Dia",
                  route: '/santo-do-dia',
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text("Santo do Dia"));
        await tester.pumpAndSettle();

        final now = DateTime.now();
        expect(santoProvider.day, now.day);
        expect(santoProvider.month, now.month);
      },
    );

    test(
      'resetToToday() em SantoDoDiaProvider restaura os dados de hoje',
      () async {
        final provider = SantoDoDiaProvider();
        final now = DateTime.now();

        // Altera a data para outro dia
        final otherMonth = now.month == 12 ? 1 : now.month + 1;
        await provider.changeDate(1, otherMonth);
        expect(provider.day, 1);
        expect(provider.month, otherMonth);

        // Chama resetToToday()
        provider.resetToToday();
        expect(provider.day, now.day);
        expect(provider.month, now.month);
      },
    );
  });
}

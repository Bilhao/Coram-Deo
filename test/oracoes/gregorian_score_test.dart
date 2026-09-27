import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coramdeo/app/oracoes/adoracao_bencao_santissimo/widgets/gregorian_score.dart';

void main() {
  testWidgets('GregorianScoreTile renders with imageAsset', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GregorianScoreTile(
            title: 'Pauta: Laudate Dominum',
            mode: 'V.',
            imageAsset: 'assets/images/oracoes/partitura_laudate_dominum.png',
          ),
        ),
      ),
    );

    expect(find.text('Pauta: Laudate Dominum'), findsOneWidget);

    // Tap to expand
    await tester.tap(find.text('Pauta: Laudate Dominum'));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });
}

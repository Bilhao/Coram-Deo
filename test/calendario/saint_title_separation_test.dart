import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/services/computus_engine.dart';
import 'package:coramdeo/app/calendario/services/roman_sanctoral_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Separação de Título Temporal e Santo do Dia no Calendário', () {
    test(
      '16 de Setembro de 2026 preserva título temporal e santo limpo em saintOfTheDay',
      () {
        final day = ComputusEngine.getLiturgicalDay(DateTime(2026, 9, 16));

        // O título do dia deve ser o dia ferial da semana do Tempo Comum
        expect(day.title, contains('Quarta-feira'));
        expect(day.title, contains('Semana do Tempo Comum'));
        expect(day.title, isNot(contains('Santos Cornélio')));

        // O santo do dia deve ser conciso e limpo
        expect(day.saintOfTheDay, 'Santos Cornélio e Cipriano');
        expect(day.saintOfTheDay, isNot(contains('papa')));
        expect(day.saintOfTheDay, isNot(contains('bispo')));
        expect(day.saintOfTheDay, isNot(contains('mártires')));

        // hasSaintOfTheDay deve ser true e não haver duplicidade com o título
        expect(day.hasSaintOfTheDay, isTrue);
        expect(day.saintOfTheDay != day.title, isTrue);

        // A cor da memória deve ser vermelha (mártires)
        expect(day.color, LiturgicalColor.red);
        expect(day.rank, LiturgicalRank.memoriaObrigatoria);
      },
    );

    test('Nomes dos Santos em RomanSanctoralData são limpos e diretos', () {
      // 28 de Agosto: Santo Agostinho
      final agostinho = RomanSanctoralData.getSaint(8, 28);
      expect(agostinho, isNotNull);
      expect(agostinho!.name, 'Santo Agostinho');

      // 14 de Dezembro: São João da Cruz
      final joaoCruz = RomanSanctoralData.getSaint(12, 14);
      expect(joaoCruz, isNotNull);
      expect(joaoCruz!.name, 'São João da Cruz');

      // 1 de Outubro: Santa Teresinha do Menino Jesus
      final teresinha = RomanSanctoralData.getSaint(10, 1);
      expect(teresinha, isNotNull);
      expect(teresinha!.name, 'Santa Teresinha do Menino Jesus');

      // 4 de Outubro: São Francisco de Assis
      final francisco = RomanSanctoralData.getSaint(10, 4);
      expect(francisco, isNotNull);
      expect(francisco!.name, 'São Francisco de Assis');
    });

    test(
      'Festas e Solenidades preservam o card de santo do dia para acesso à biografia e oração',
      () {
        // 19 de Março: Solenidade de São José
        final saoJose = ComputusEngine.getLiturgicalDay(DateTime(2026, 3, 19));
        expect(saoJose.title, 'São José, Esposo da Virgem Maria');
        expect(saoJose.rank, LiturgicalRank.solenidade);
        expect(saoJose.hasSaintOfTheDay, isTrue);
        expect(saoJose.saintOfTheDay, 'São José, Esposo da Virgem Maria');

        // 25 de Dezembro: Natal do Senhor
        final natal = ComputusEngine.getLiturgicalDay(DateTime(2026, 12, 25));
        expect(natal.title, 'Natal de Nosso Senhor Jesus Cristo');
        expect(natal.rank, LiturgicalRank.solenidade);
        expect(natal.hasSaintOfTheDay, isTrue);
        expect(natal.saintOfTheDay, 'Natal de Nosso Senhor Jesus Cristo');

        // 14 de Setembro: Exaltação da Santa Cruz
        final santaCruz = ComputusEngine.getLiturgicalDay(
          DateTime(2026, 9, 14),
        );
        expect(santaCruz.title, 'Exaltação da Santa Cruz');
        expect(santaCruz.rank, LiturgicalRank.festa);
        expect(santaCruz.hasSaintOfTheDay, isTrue);
        expect(santaCruz.saintOfTheDay, 'Exaltação da Santa Cruz');

        // 21 de Setembro: São Mateus
        final saoMateus = ComputusEngine.getLiturgicalDay(
          DateTime(2026, 9, 21),
        );
        expect(saoMateus.title, 'São Mateus');
        expect(saoMateus.rank, LiturgicalRank.festa);
        expect(saoMateus.hasSaintOfTheDay, isTrue);
        expect(saoMateus.saintOfTheDay, 'São Mateus');
      },
    );
  });
}

import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/services/computus_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ComputusEngine - Cálculo Astronômico da Páscoa', () {
    test('Calcula corretamente o Domingo da Páscoa para diversos anos', () {
      // Datas canônicas oficiais da Páscoa Gregoriana
      expect(ComputusEngine.calculateEaster(2024), DateTime(2024, 3, 31));
      expect(ComputusEngine.calculateEaster(2025), DateTime(2025, 4, 20));
      expect(ComputusEngine.calculateEaster(2026), DateTime(2026, 4, 5));
      expect(ComputusEngine.calculateEaster(2027), DateTime(2027, 3, 28));
      expect(ComputusEngine.calculateEaster(2028), DateTime(2028, 4, 16));
      expect(ComputusEngine.calculateEaster(2029), DateTime(2029, 4, 1));
      expect(ComputusEngine.calculateEaster(2030), DateTime(2030, 4, 21));
      expect(ComputusEngine.calculateEaster(2033), DateTime(2033, 4, 17));
    });

    test('Identifica corretamente as festas móveis de 2026', () {
      // 2026: Páscoa em 05/04/2026
      // Quarta-feira de Cinzas: 18/02/2026
      final ashWed = ComputusEngine.getLiturgicalDay(DateTime(2026, 2, 18));
      expect(ashWed.title, 'Quarta-feira de Cinzas');
      expect(ashWed.season, LiturgicalSeason.quaresma);
      expect(ashWed.color, LiturgicalColor.purple);

      // Domingo de Ramos: 29/03/2026
      final palmSun = ComputusEngine.getLiturgicalDay(DateTime(2026, 3, 29));
      expect(palmSun.title, 'Domingo de Ramos e da Paixão do Senhor');
      expect(palmSun.color, LiturgicalColor.red);

      // Domingo Laetare (4º da Quaresma): 15/03/2026
      final laetare = ComputusEngine.getLiturgicalDay(DateTime(2026, 3, 15));
      expect(laetare.title, contains('Laetare'));
      expect(laetare.color, LiturgicalColor.rose);

      // Sexta-feira Santa: 03/04/2026
      final goodFri = ComputusEngine.getLiturgicalDay(DateTime(2026, 4, 3));
      expect(goodFri.season, LiturgicalSeason.triduoPascal);
      expect(goodFri.color, LiturgicalColor.red);

      // Páscoa: 05/04/2026
      final easter = ComputusEngine.getLiturgicalDay(DateTime(2026, 4, 5));
      expect(easter.season, LiturgicalSeason.tempoPascal);
      expect(easter.color, LiturgicalColor.white);

      // Pentecostes: 24/05/2026
      final pentecost = ComputusEngine.getLiturgicalDay(DateTime(2026, 5, 24));
      expect(pentecost.title, 'Domingo de Pentecostes');
      expect(pentecost.color, LiturgicalColor.red);

      // Santíssima Trindade: 31/05/2026
      final trinity = ComputusEngine.getLiturgicalDay(DateTime(2026, 5, 31));
      expect(trinity.title, 'Santíssima Trindade');
      expect(trinity.color, LiturgicalColor.white);

      // Corpus Christi: 04/06/2026
      final corpus = ComputusEngine.getLiturgicalDay(DateTime(2026, 6, 4));
      expect(corpus.title, contains('Corpus Christi'));
      expect(corpus.color, LiturgicalColor.white);

      // Cristo Rei: 22/11/2026
      final christKing = ComputusEngine.getLiturgicalDay(DateTime(2026, 11, 22));
      expect(christKing.title, 'Nosso Senhor Jesus Cristo, Rei do Universo');
      expect(christKing.color, LiturgicalColor.white);

      // 1º Domingo do Advento: 29/11/2026
      final advent1 = ComputusEngine.getLiturgicalDay(DateTime(2026, 11, 29));
      expect(advent1.season, LiturgicalSeason.advento);
      expect(advent1.color, LiturgicalColor.purple);

      // 3º Domingo do Advento (Gaudete): 13/12/2026
      final gaudete = ComputusEngine.getLiturgicalDay(DateTime(2026, 12, 13));
      expect(gaudete.title, contains('Gaudete'));
      expect(gaudete.color, LiturgicalColor.rose);
    });

    test('Calcula solenidades fixas da Igreja', () {
      // 25 de Março: Anunciação do Senhor
      final anunciacao = ComputusEngine.getLiturgicalDay(DateTime(2026, 3, 25));
      expect(anunciacao.title, 'Anunciação do Senhor');
      expect(anunciacao.color, LiturgicalColor.white);

      // 15 de Agosto: Assunção
      final assuncao = ComputusEngine.getLiturgicalDay(DateTime(2026, 8, 15));
      expect(assuncao.title, contains('Assunção'));
      expect(assuncao.color, LiturgicalColor.white);

      // 25 de Dezembro: Natal
      final natal = ComputusEngine.getLiturgicalDay(DateTime(2026, 12, 25));
      expect(natal.title, contains('Natal'));
      expect(natal.season, LiturgicalSeason.natal);
      expect(natal.color, LiturgicalColor.white);
    });
  });
}

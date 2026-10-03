import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/services/computus_engine.dart';
import 'package:coramdeo/app/calendario/services/opus_dei_calendar_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OpusDeiCalendarData - Validação das Classificações e Correções Oficiais', () {
    test('Valida as correções específicas de datas e graus da Prelazia', () {
      // 1. Conversão de São Paulo (25/01) -> Classe D
      final convPaulo = OpusDeiCalendarData.getCelebration(1, 25);
      expect(convPaulo, isNotNull);
      expect(convPaulo!.classRank, OpusDeiClass.classeD);
      expect(convPaulo.name, contains('Conversão de São Paulo'));

      // 2. Cátedra de São Pedro (22/02) -> Classe D
      final catedra = OpusDeiCalendarData.getCelebration(2, 22);
      expect(catedra, isNotNull);
      expect(catedra!.classRank, OpusDeiClass.classeD);
      expect(catedra.name, contains('Cátedra de São Pedro'));

      // 3. Aniv. Eleição do Papa (08/05) -> Classe B
      final eleicaoPapa = OpusDeiCalendarData.getCelebration(5, 8);
      expect(eleicaoPapa, isNotNull);
      expect(eleicaoPapa!.classRank, OpusDeiClass.classeB);

      // 4. Santo do Padre (30/05, São Fernando) -> Classe B
      final santoPadre = OpusDeiCalendarData.getCelebration(5, 30);
      expect(santoPadre, isNotNull);
      expect(santoPadre!.classRank, OpusDeiClass.classeB);
      expect(santoPadre.name, contains('São Fernando'));

      // 5. Aniv. Ordenação dos três primeiros sacerdotes (25/06/1944) -> Classe C
      final tresSacerdotes = OpusDeiCalendarData.getCelebration(6, 25);
      expect(tresSacerdotes, isNotNull);
      expect(tresSacerdotes!.classRank, OpusDeiClass.classeC);
      expect(tresSacerdotes.name, contains('Primeiros Sacerdotes'));

      // 6. São Pio X (21/08) -> Classe C
      final saoPioX = OpusDeiCalendarData.getCelebration(8, 21);
      expect(saoPioX, isNotNull);
      expect(saoPioX!.classRank, OpusDeiClass.classeC);
      expect(saoPioX.name, contains('São Pio X'));

      // 7. Nossa Senhora do Pilar (12/10) -> Classe D
      final pilar = OpusDeiCalendarData.getCelebration(10, 12);
      expect(pilar, isNotNull);
      expect(pilar!.classRank, OpusDeiClass.classeD);
      expect(pilar.name, contains('Pilar'));

      // 8. Aniversário do Padre (27/10, Mons. Fernando Ocáriz) -> Classe B
      final anivPadre = OpusDeiCalendarData.getCelebration(10, 27);
      expect(anivPadre, isNotNull);
      expect(anivPadre!.classRank, OpusDeiClass.classeB);
      expect(anivPadre.name, contains('Aniversário do Padre'));

      // 9. Todos os Santos (01/11) -> Classe B
      final todosSantos = OpusDeiCalendarData.getCelebration(11, 1);
      expect(todosSantos, isNotNull);
      expect(todosSantos!.classRank, OpusDeiClass.classeB);

      // 10. São Severino e Relíquias nos Oratórios (08/11) -> Classe B
      final severino = OpusDeiCalendarData.getCelebration(11, 8);
      expect(severino, isNotNull);
      expect(severino!.classRank, OpusDeiClass.classeB);
      expect(severino.name, contains('São Severino'));

      // 11. Nossa Senhora de Guadalupe (12/12) -> Classe D
      final guadalupe = OpusDeiCalendarData.getCelebration(12, 12);
      expect(guadalupe, isNotNull);
      expect(guadalupe!.classRank, OpusDeiClass.classeD);
      expect(guadalupe.name, contains('Guadalupe'));
    });

    test('Valida as grandes Solenidades de Classe A da Prelazia', () {
      // 14/02: Mulheres e SSSC
      final fev14 = OpusDeiCalendarData.getCelebration(2, 14);
      expect(fev14!.classRank, OpusDeiClass.classeA);

      // 19/03: São José
      final mar19 = OpusDeiCalendarData.getCelebration(3, 19);
      expect(mar19!.classRank, OpusDeiClass.classeA);

      // 26/06: São Josemaria
      final jun26 = OpusDeiCalendarData.getCelebration(6, 26);
      expect(jun26!.classRank, OpusDeiClass.classeA);

      // 02/10: Fundação da Obra
      final out02 = OpusDeiCalendarData.getCelebration(10, 2);
      expect(out02!.classRank, OpusDeiClass.classeA);

      // 06/10: Canonização de São Josemaria
      final out06 = OpusDeiCalendarData.getCelebration(10, 6);
      expect(out06!.classRank, OpusDeiClass.classeA);

      // 28/11: Ereção em Prelazia Pessoal (Ut Sit)
      final nov28 = OpusDeiCalendarData.getCelebration(11, 28);
      expect(nov28!.classRank, OpusDeiClass.classeA);
    });

    test('Identifica festas móveis com classificação do Opus Dei via ComputusEngine', () {
      // 2026: Páscoa em 05/04/2026
      // Pentecostes: 24/05/2026 -> Classe A
      final pentecostDay = ComputusEngine.getLiturgicalDay(DateTime(2026, 5, 24));
      expect(pentecostDay.opusDeiCelebration, isNotNull);
      expect(pentecostDay.opusDeiCelebration!.classRank, OpusDeiClass.classeA);

      // Sagrado Coração de Jesus: 12/06/2026 -> Classe A
      final sacredHeartDay = ComputusEngine.getLiturgicalDay(DateTime(2026, 6, 12));
      expect(sacredHeartDay.opusDeiCelebration, isNotNull);
      expect(sacredHeartDay.opusDeiCelebration!.classRank, OpusDeiClass.classeA);

      // Cristo Rei: 22/11/2026 -> Classe A
      final christKingDay = ComputusEngine.getLiturgicalDay(DateTime(2026, 11, 22));
      expect(christKingDay.opusDeiCelebration, isNotNull);
      expect(christKingDay.opusDeiCelebration!.classRank, OpusDeiClass.classeA);
    });
  });
}

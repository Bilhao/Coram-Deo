import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/services/computus_engine.dart';
import 'package:coramdeo/app/calendario/services/opus_dei_calendar_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OpusDeiCalendarData & Prelature Feasts', () {
    test('Contém todas as Solenidades de Classe A', () {
      final feb14 = OpusDeiCalendarData.getCelebration(2, 14);
      expect(feb14, isNotNull);
      expect(feb14!.classRank, OpusDeiClass.classeA);
      expect(feb14.name, contains('Mulheres'));

      final mar19 = OpusDeiCalendarData.getCelebration(3, 19);
      expect(mar19, isNotNull);
      expect(mar19!.classRank, OpusDeiClass.classeA);

      final may02 = OpusDeiCalendarData.getCelebration(5, 2);
      expect(may02, isNotNull);
      expect(may02!.classRank, OpusDeiClass.classeA);

      final jun26 = OpusDeiCalendarData.getCelebration(6, 26);
      expect(jun26, isNotNull);
      expect(jun26!.classRank, OpusDeiClass.classeA);
      expect(jun26.name, contains('São Josemaria Escrivá'));

      final oct02 = OpusDeiCalendarData.getCelebration(10, 2);
      expect(oct02, isNotNull);
      expect(oct02!.classRank, OpusDeiClass.classeA);
      expect(oct02.name, contains('Fundação do Opus Dei'));
    });

    test('Contém as Festas de Classe B', () {
      final alvaro = OpusDeiCalendarData.getCelebration(5, 12);
      expect(alvaro, isNotNull);
      expect(alvaro!.classRank, OpusDeiClass.classeB);
      expect(alvaro.name, contains('Álvaro del Portillo'));

      final guadalupe = OpusDeiCalendarData.getCelebration(5, 18);
      expect(guadalupe, isNotNull);
      expect(guadalupe!.classRank, OpusDeiClass.classeB);
      expect(guadalupe.name, contains('Guadalupe Ortiz'));

      final arcanjos = OpusDeiCalendarData.getCelebration(9, 29);
      expect(arcanjos, isNotNull);
      expect(arcanjos!.classRank, OpusDeiClass.classeB);
    });

    test('Contém as Memórias Históricas de Classe C', () {
      final utSit = OpusDeiCalendarData.getCelebration(11, 28);
      expect(utSit, isNotNull);
      expect(utSit!.classRank, OpusDeiClass.classeC);
      expect(utSit.name, contains('Prelazia Pessoal'));

      final canonizacao = OpusDeiCalendarData.getCelebration(10, 6);
      expect(canonizacao, isNotNull);
      expect(canonizacao!.classRank, OpusDeiClass.classeC);
      expect(canonizacao.name, contains('Canonização'));
    });

    test('Identifica os Sete Domingos de São José anteriores a 19 de Março', () {
      // Em 2026, 19 de março é uma quinta-feira.
      // Os 7 domingos anteriores são:
      // 15/03, 08/03, 01/03, 22/02, 15/02, 08/02, 01/02
      expect(OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 2, 1)), contains('1º Domingo de São José'));
      expect(OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 2, 8)), contains('2º Domingo de São José'));
      expect(OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 3, 15)), contains('7º Domingo de São José'));
      // Um dia que não é domingo não deve ter o aviso
      expect(OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 3, 14)), isNull);
    });

    test('Identifica os 9 dias da Novena da Imaculada Conceição', () {
      // 29 de novembro = Dia 1
      expect(OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 11, 29)), 'Novena da Imaculada Conceição (Dia 1)');
      // 30 de novembro = Dia 2
      expect(OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 11, 30)), 'Novena da Imaculada Conceição (Dia 2)');
      // 1 de dezembro = Dia 3
      expect(OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 12, 1)), 'Novena da Imaculada Conceição (Dia 3)');
      // 7 de dezembro = Dia 9
      expect(OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 12, 7)), 'Novena da Imaculada Conceição (Dia 9)');
      // 8 de dezembro = Festa (já não é novena)
      expect(OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 12, 8)), isNull);
    });

    test('Integração com ComputusEngine eleva o dia a Solenidade no dia de São Josemaria', () {
      final day = ComputusEngine.getLiturgicalDay(DateTime(2026, 6, 26));
      expect(day.hasOpusDeiCelebration, isTrue);
      expect(day.opusDeiCelebration!.classRank, OpusDeiClass.classeA);
      expect(day.rank, LiturgicalRank.solenidade);
      expect(day.color, LiturgicalColor.white);
    });
  });
}

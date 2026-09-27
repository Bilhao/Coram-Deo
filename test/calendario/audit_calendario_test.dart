import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/services/computus_engine.dart';
import 'package:coramdeo/app/calendario/services/roman_sanctoral_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Auditoria Completa do Calendário Litúrgico (2026)', () {
    test('Valida todos os 365 dias de 2026 dia a dia', () {
      final year = 2026;
      final startDate = DateTime(year, 1, 1);
      final endDate = DateTime(year, 12, 31);

      var cursor = startDate;
      int totalDays = 0;
      int sundays = 0;
      int solemnities = 0;
      int feasts = 0;
      int memorials = 0;
      int ferias = 0;
      final problems = <String>[];

      while (!cursor.isAfter(endDate)) {
        totalDays++;
        final day = ComputusEngine.getLiturgicalDay(cursor);

        // 1. Título nunca deve ser vazio
        expect(
          day.title.isNotEmpty,
          isTrue,
          reason: 'Dia sem título em ${cursor.toIso8601String()}',
        );

        // 2. Domingos devem ser sempre Solenidades
        if (day.isSunday) {
          sundays++;
          expect(
            day.rank,
            LiturgicalRank.solenidade,
            reason:
                'Domingo com rank inválido em ${cursor.toIso8601String()}: ${day.title}',
          );
        }

        switch (day.rank) {
          case LiturgicalRank.solenidade:
            solemnities++;
            break;
          case LiturgicalRank.festa:
            feasts++;
            break;
          case LiturgicalRank.memoriaObrigatoria:
          case LiturgicalRank.memoriaFacultativa:
            memorials++;
            break;
          case LiturgicalRank.feria:
            ferias++;
            break;
        }

        // 3. Validação canônica de cores por tempo
        if (day.season == LiturgicalSeason.quaresma) {
          // Na Quaresma: dias comuns devem ser roxos, exceto solenidades (São José/Anunciação: branco) e Laetare (rosa) e Ramos (vermelho)
          if (day.title.contains('Laetare')) {
            expect(day.color, LiturgicalColor.rose);
          } else if (day.title.contains('Ramos')) {
            expect(day.color, LiturgicalColor.red);
          } else if (day.title.contains('São José') ||
              day.title.contains('Anunciação')) {
            expect(day.color, LiturgicalColor.white);
          } else if (!day.hasSaintOfTheDay ||
              day.rank == LiturgicalRank.feria) {
            expect(day.color, LiturgicalColor.purple);
          }
        }

        if (day.season == LiturgicalSeason.tempoPascal) {
          // No Tempo Pascal: cor geral é branca, exceto Pentecostes e festas de mártires/apóstolos que são vermelhas
          if (day.title.contains('Pentecostes')) {
            expect(day.color, LiturgicalColor.red);
          } else if (day.rank == LiturgicalRank.feria || day.isSunday) {
            expect(day.color, LiturgicalColor.white);
          }
        }

        if (day.season == LiturgicalSeason.advento) {
          // No Advento: roxo, exceto Gaudete (rosa) e Imaculada Conceição (branco)
          if (day.title.contains('Gaudete')) {
            expect(day.color, LiturgicalColor.rose);
          } else if (day.title.contains('Imaculada Conceição')) {
            expect(day.color, LiturgicalColor.white);
          } else if (day.rank == LiturgicalRank.feria || day.isSunday) {
            expect(day.color, LiturgicalColor.purple);
          }
        }

        cursor = DateTime(cursor.year, cursor.month, cursor.day + 1);
      }

      expect(totalDays, 365);
      expect(sundays, 52);
      expect(solemnities, greaterThan(15));
      expect(feasts, greaterThan(15));
      expect(memorials, greaterThan(40));
      expect(ferias, greaterThan(100));
      expect(problems, isEmpty);
    });

    test('Valida transições exatas do Ano Litúrgico em 2026', () {
      // Epifania: 06/01
      final epifania = ComputusEngine.getLiturgicalDay(DateTime(2026, 1, 6));
      expect(epifania.rank, LiturgicalRank.solenidade);
      expect(epifania.color, LiturgicalColor.white);

      // Quarta-feira de Cinzas: 18/02/2026
      final cinzas = ComputusEngine.getLiturgicalDay(DateTime(2026, 2, 18));
      expect(cinzas.season, LiturgicalSeason.quaresma);
      expect(cinzas.color, LiturgicalColor.purple);
      expect(cinzas.title, 'Quarta-feira de Cinzas');

      // Domingo de Ramos: 29/03/2026
      final ramos = ComputusEngine.getLiturgicalDay(DateTime(2026, 3, 29));
      expect(ramos.season, LiturgicalSeason.quaresma);
      expect(ramos.color, LiturgicalColor.red);

      // Tríduo Pascal: 02/04 a 04/04/2026
      final quiSanta = ComputusEngine.getLiturgicalDay(DateTime(2026, 4, 2));
      expect(quiSanta.season, LiturgicalSeason.triduoPascal);
      expect(quiSanta.color, LiturgicalColor.white);

      final sexSanta = ComputusEngine.getLiturgicalDay(DateTime(2026, 4, 3));
      expect(sexSanta.season, LiturgicalSeason.triduoPascal);
      expect(sexSanta.color, LiturgicalColor.red);

      final sabSanto = ComputusEngine.getLiturgicalDay(DateTime(2026, 4, 4));
      expect(sabSanto.season, LiturgicalSeason.triduoPascal);
      expect(sabSanto.color, LiturgicalColor.purple);

      // Páscoa: 05/04/2026
      final pascoa = ComputusEngine.getLiturgicalDay(DateTime(2026, 4, 5));
      expect(pascoa.season, LiturgicalSeason.tempoPascal);
      expect(pascoa.color, LiturgicalColor.white);

      // Oitava da Páscoa: 06/04 a 12/04/2026 (todos os dias são Solenidade com cor branca)
      for (int d = 6; d <= 12; d++) {
        final diaOitava = ComputusEngine.getLiturgicalDay(DateTime(2026, 4, d));
        expect(
          diaOitava.color,
          LiturgicalColor.white,
          reason: 'Oitava da Páscoa dia $d deve ser branca',
        );
        expect(
          diaOitava.rank,
          LiturgicalRank.solenidade,
          reason: 'Oitava da Páscoa dia $d deve ser Solenidade',
        );
      }

      // 2º Domingo da Páscoa (Divina Misericórdia): 12/04/2026
      final misericordia = ComputusEngine.getLiturgicalDay(
        DateTime(2026, 4, 12),
      );
      expect(misericordia.title, contains('Divina Misericórdia'));

      // Pentecostes: 24/05/2026
      final pentecostes = ComputusEngine.getLiturgicalDay(
        DateTime(2026, 5, 24),
      );
      expect(pentecostes.season, LiturgicalSeason.tempoPascal);
      expect(pentecostes.color, LiturgicalColor.red);

      // Santíssima Trindade: 31/05/2026
      final trindade = ComputusEngine.getLiturgicalDay(DateTime(2026, 5, 31));
      expect(trindade.season, LiturgicalSeason.tempoComum);
      expect(trindade.title, 'Santíssima Trindade');
      expect(trindade.color, LiturgicalColor.white);

      // Corpus Christi: 04/06/2026
      final corpus = ComputusEngine.getLiturgicalDay(DateTime(2026, 6, 4));
      expect(corpus.title, contains('Corpus Christi'));
      expect(corpus.color, LiturgicalColor.white);
      expect(corpus.rank, LiturgicalRank.solenidade);

      // Sagrado Coração de Jesus: 12/06/2026 (sexta-feira após o 2º domingo após Pentecostes)
      final sagradoCoracao = ComputusEngine.getLiturgicalDay(
        DateTime(2026, 6, 12),
      );
      expect(sagradoCoracao.title, 'Sagrado Coração de Jesus');
      expect(sagradoCoracao.color, LiturgicalColor.white);
      expect(sagradoCoracao.rank, LiturgicalRank.solenidade);

      // Imaculado Coração de Maria: 13/06/2026 (sábado seguinte ao Sagrado Coração)
      final imaculadoCoracao = ComputusEngine.getLiturgicalDay(
        DateTime(2026, 6, 13),
      );
      expect(imaculadoCoracao.title, contains('Imaculado Coração'));
      expect(imaculadoCoracao.color, LiturgicalColor.white);

      // Cristo Rei: 22/11/2026
      final cristoRei = ComputusEngine.getLiturgicalDay(DateTime(2026, 11, 22));
      expect(cristoRei.title, contains('Rei do Universo'));
      expect(cristoRei.color, LiturgicalColor.white);
      expect(cristoRei.rank, LiturgicalRank.solenidade);

      // 1º Domingo do Advento: 29/11/2026
      final advento1 = ComputusEngine.getLiturgicalDay(DateTime(2026, 11, 29));
      expect(advento1.season, LiturgicalSeason.advento);
      expect(advento1.color, LiturgicalColor.purple);

      // 3º Domingo do Advento (Gaudete): 13/12/2026
      final gaudete = ComputusEngine.getLiturgicalDay(DateTime(2026, 12, 13));
      expect(gaudete.title, contains('Gaudete'));
      expect(gaudete.color, LiturgicalColor.rose);

      // Natal: 25/12/2026
      final natal = ComputusEngine.getLiturgicalDay(DateTime(2026, 12, 25));
      expect(natal.season, LiturgicalSeason.natal);
      expect(natal.color, LiturgicalColor.white);
      expect(natal.rank, LiturgicalRank.solenidade);
    });

    test('Valida todos os 366 dias do Santoral Romano', () {
      for (int m = 1; m <= 12; m++) {
        final daysInMonth = DateTime(2024, m + 1, 0).day; // Ano bissexto
        for (int d = 1; d <= daysInMonth; d++) {
          final saint = RomanSanctoralData.getSaint(m, d);
          expect(saint, isNotNull, reason: 'Falta santo para $m-$d');
          expect(saint!.name.isNotEmpty, isTrue);
        }
      }
    });

    test('Auditoria Multi-Anos (2024 a 2030) - zero regressões canônicas', () {
      for (int y = 2024; y <= 2030; y++) {
        final startDate = DateTime(y, 1, 1);
        final endDate = DateTime(y, 12, 31);
        var cursor = startDate;

        while (!cursor.isAfter(endDate)) {
          final day = ComputusEngine.getLiturgicalDay(cursor);

          expect(
            day.title.isNotEmpty,
            isTrue,
            reason: 'Título vazio em $y-${cursor.month}-${cursor.day}',
          );
          expect(
            day.title.startsWith('0º') || day.title.contains(' 0º'),
            isFalse,
            reason:
                'Contém 0º em $y-${cursor.month}-${cursor.day}: ${day.title}',
          );
          expect(
            day.title.contains('7ª Semana da Quaresma'),
            isFalse,
            reason:
                'Semana inválida da Quaresma em $y-${cursor.month}-${cursor.day}: ${day.title}',
          );

          if (day.isSunday) {
            expect(
              day.rank,
              LiturgicalRank.solenidade,
              reason:
                  'Domingo não é Solenidade em $y-${cursor.month}-${cursor.day}: ${day.title} (${day.rank})',
            );
          }

          cursor = DateTime(cursor.year, cursor.month, cursor.day + 1);
        }

        // Validação da Sagrada Família e Batismo do Senhor
        final holyFam = ComputusEngine.calculateHolyFamily(y);
        final holyFamDay = ComputusEngine.getLiturgicalDay(holyFam);
        expect(holyFamDay.title, 'Sagrada Família de Jesus, Maria e José');
        expect(holyFamDay.color, LiturgicalColor.white);

        final baptism = ComputusEngine.calculateBaptismOfLord(y);
        final baptismDay = ComputusEngine.getLiturgicalDay(baptism);
        expect(baptismDay.title, 'Batismo do Senhor');
        expect(baptismDay.color, LiturgicalColor.white);
      }
    });
  });
}

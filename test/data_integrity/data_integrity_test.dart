import 'package:flutter_test/flutter_test.dart';
import 'package:coramdeo/app/liturgia_diaria/data.dart';

void main() {
  group('Liturgia Diaria data integrity', () {
    test('Sanitizes attached verse numbers from raw API into clean liturgical proclamation text', () {
      final ld = LiturgiaDiaria();
      ld.data = {
        'data': '11/09/2026',
        'liturgia': 'Tempo Comum',
        'primeiraLeitura': {
          'titulo': 'Primeira Leitura (1Cor 9, 16-19. 22b-27)',
          'referencia': '1Cor 9, 16-19',
          'texto': '16pregar o Evangelho não é motivo de glória. 17Se eu exercesse...',
        },
        'salmo': {
          'referencia': 'Sl 83 (84)',
          'refrao': 'Quão amável, ó Senhor, é vossa casa!',
          'texto': '– Minha alma desmaia de saudades...',
        },
        'segundaLeitura': 'Não há segunda leitura hoje!',
        'evangelho': {
          'titulo': 'Evangelho (Lc 6, 39-42)',
          'referencia': 'Lc 6, 39-42',
          'texto': 'Naquele tempo, 39Jesus contou uma parábola: “Pode um cego guiar outro cego? 40Um discípulo não é maior...',
        },
      };

      // Readings should be clean continuous liturgical prose without attached digits
      expect(ld.getPrimeiraLeituraTexto(), equals('pregar o Evangelho não é motivo de glória. Se eu exercesse...'));
      expect(ld.getPrimeiraLeituraReferencia(), equals('1Cor 9, 16-19'));
      expect(ld.getSalmoTexto(), equals('– Minha alma desmaia de saudades...'));
      expect(ld.getEvangelhoTexto(), equals('Naquele tempo, Jesus contou uma parábola: “Pode um cego guiar outro cego? Um discípulo não é maior...'));
      expect(ld.getEvangelhoReferencia(), equals('Lc 6, 39-42'));
    });
  });

  group('Plano de Vida date token integrity', () {
    test('Tokenized date matching prevents false substring matches', () {
      // String containing 21/9/2026 and 11/9/2026
      const rawDates = '21/9/2026, 11/9/2026';
      final tokens = rawDates.split(',').map((e) => e.trim()).toList();

      // "1/9/2026" should NOT match even though it is a substring of "21/9/2026"
      expect(tokens.contains('1/9/2026'), isFalse);
      expect(tokens.contains('21/9/2026'), isTrue);
      expect(tokens.contains('11/9/2026'), isTrue);
      expect(tokens.contains('9/2026'), isFalse);
    });

    test('Inserting date into token list avoids duplicates', () {
      const rawDates = '10/9/2026, 11/9/2026';
      List<String> dateList = rawDates.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

      // Inserting an existing date does nothing
      if (!dateList.contains('11/9/2026')) {
        dateList.add('11/9/2026');
      }
      expect(dateList.length, 2);

      // Inserting a new date
      if (!dateList.contains('12/9/2026')) {
        dateList.add('12/9/2026');
      }
      expect(dateList.length, 3);
      expect(dateList.join(','), equals('10/9/2026,11/9/2026,12/9/2026'));
    });

    test('Deleting date removes only the exact date token', () {
      const rawDates = '1/9/2026, 21/9/2026, 31/9/2026';
      List<String> dateList = rawDates.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

      dateList.remove('1/9/2026');
      expect(dateList.contains('1/9/2026'), isFalse);
      expect(dateList.contains('21/9/2026'), isTrue);
      expect(dateList.contains('31/9/2026'), isTrue);
      expect(dateList.join(','), equals('21/9/2026,31/9/2026'));
    });
  });
}


import 'package:flutter_test/flutter_test.dart';
import 'package:coramdeo/app/liturgia_diaria/data.dart';

void main() {
  group('Liturgia Diaria data integrity', () {
    test('Preserves verse numbers and references in readings', () {
      final ld = LiturgiaDiaria();
      ld.data = {
        'data': '11/09/2026',
        'liturgia': 'Tempo Comum',
        'primeiraLeitura': {
          'titulo': 'Primeira Leitura (1Cor 9, 16-19. 22b-27)',
          'referencia': '1Cor 9, 16-19',
          'texto': '16 Se anuncio o evangelho, não tenho de que me gloriar...',
        },
        'salmo': {
          'referencia': 'Sl 83 (84)',
          'refrao': 'Quão amável, ó Senhor, é vossa casa!',
          'texto': '2 Minha alma desmaia de saudades...',
        },
        'segundaLeitura': 'Não há segunda leitura hoje!',
        'evangelho': {
          'titulo': 'Evangelho (Lc 6, 39-42)',
          'referencia': 'Lc 6, 39-42',
          'texto': '39 Jesus contou uma parábola: Pode um cego guiar outro cego?',
        },
      };

      expect(ld.getPrimeiraLeituraTexto(), contains('16 Se anuncio'));
      expect(ld.getPrimeiraLeituraReferencia(), equals('1Cor 9, 16-19'));
      expect(ld.getSalmoTexto(), contains('2 Minha alma'));
      expect(ld.getEvangelhoTexto(), contains('39 Jesus'));
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

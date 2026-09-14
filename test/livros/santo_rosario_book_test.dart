import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Santo Rosário book SQLite database integrity and cleanliness', () {
    const dbPath = 'assets/books/santo_rosario_livro.db';

    test('Database file exists and passes SQLite integrity check', () {
      final file = File(dbPath);
      expect(file.existsSync(), isTrue, reason: 'Database file must exist');

      final integrity = Process.runSync('sqlite3', [dbPath, 'PRAGMA integrity_check;']);
      expect(integrity.exitCode, equals(0));
      expect(integrity.stdout.toString().trim(), equals('ok'));
    });

    test('Chapters are properly formatted without literal quotes or extra padding', () {
      final result = Process.runSync('sqlite3', [
        dbPath,
        'SELECT DISTINCT chapter FROM book ORDER BY chapter_id;',
      ]);
      expect(result.exitCode, equals(0));

      final chapters = result.stdout
          .toString()
          .split('\n')
          .map((c) => c.trim())
          .where((c) => c.isNotEmpty)
          .toList();

      expect(chapters, equals([
        'Mistérios Gozosos',
        'Mistérios Dolorosos',
        'Mistérios Gloriosos',
        'Mistérios Luminosos',
        'Ladainha',
        'Conclusão',
      ]));

      for (final ch in chapters) {
        expect(ch.contains("'"), isFalse, reason: 'Chapter should not contain literal quotes');
        expect(ch, equals(ch.trim()));
      }
    });

    test('Content names exist for all mysteries and are not empty', () {
      final result = Process.runSync('sqlite3', [
        dbPath,
        'SELECT chapter_id, content_id, content_name FROM book ORDER BY chapter_id, content_id;',
      ]);
      expect(result.exitCode, equals(0));

      final rows = result.stdout
          .toString()
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .toList();

      // 5 gozosos + 5 dolorosos + 5 gloriosos + 5 luminosos + 1 ladainha + 1 conclusao = 22 rows
      expect(rows.length, equals(22));

      // Spot check important titles
      expect(rows[0], contains('A Anunciação'));
      expect(rows[1], contains('A Visitação de Nossa Senhora à sua prima Santa Isabel'));
      expect(rows[5], contains('A Oração de Jesus no horto'));
      expect(rows[10], contains('A Ressurreição do Senhor'));
      expect(rows[15], contains('O Batismo do Senhor'));
      expect(rows[20], contains('Ladainha'));
      expect(rows[21], contains('Conclusão'));
    });

    test('Content text is cleaned from typos, merged words, BOMs, and raw web citations', () {
      // 1. No BOM or zero-width spaces (\ufeff)
      final bomCheck = Process.runSync('sqlite3', [
        dbPath,
        "SELECT count(*) FROM book WHERE content LIKE '%\uFEFF%';",
      ]);
      expect(bomCheck.stdout.toString().trim(), equals('0'));

      // 2. No merged word typos
      final typoNumHossana = Process.runSync('sqlite3', [
        dbPath,
        "SELECT count(*) FROM book WHERE content LIKE '%numhossanaao%';",
      ]);
      expect(typoNumHossana.stdout.toString().trim(), equals('0'));

      final typoQuomodo = Process.runSync('sqlite3', [
        dbPath,
        "SELECT count(*) FROM book WHERE content LIKE '%Quomodofiet%';",
      ]);
      expect(typoQuomodo.stdout.toString().trim(), equals('0'));

      final typoComose = Process.runSync('sqlite3', [
        dbPath,
        "SELECT count(*) FROM book WHERE content LIKE '%Comose%';",
      ]);
      expect(typoComose.stdout.toString().trim(), equals('0'));

      // 3. No raw "Fontes:" web note in chapter 4
      final fontesCheck = Process.runSync('sqlite3', [
        dbPath,
        "SELECT count(*) FROM book WHERE chapter_id = 4 AND content LIKE '%Fontes:%';",
      ]);
      expect(fontesCheck.stdout.toString().trim(), equals('0'));

      // 4. Fixed line break in Ladainha
      final ladainhaCheck = Process.runSync('sqlite3', [
        dbPath,
        "SELECT count(*) FROM book WHERE content LIKE '%Sede\n\nda Sabedoria%';",
      ]);
      expect(ladainhaCheck.stdout.toString().trim(), equals('0'));
    });
  });
}

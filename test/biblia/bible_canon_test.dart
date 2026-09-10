import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('assets/biblia_ave_maria.db exists and has appropriate size', () {
    final dbFile = File('assets/biblia_ave_maria.db');
    expect(dbFile.existsSync(), isTrue);
    final sizeInMb = dbFile.lengthSync() / (1024 * 1024);
    expect(sizeInMb, greaterThan(5.0));
    expect(sizeInMb, lessThan(10.0));
  });

  test('assets/biblia_ave_maria.db contains Catholic Canon of 73 books', () {
    final result = Process.runSync('sqlite3', [
      'assets/biblia_ave_maria.db',
      'SELECT count(distinct book_id) FROM bible;',
    ]);
    expect(result.exitCode, 0);
    expect(result.stdout.toString().trim(), '73');
  });

  test('assets/biblia_ave_maria.db has 46 Old Testament and 27 New Testament books', () {
    final otResult = Process.runSync('sqlite3', [
      'assets/biblia_ave_maria.db',
      "SELECT count(distinct book_id) FROM bible WHERE testament = 'Old';",
    ]);
    expect(otResult.exitCode, 0);
    expect(otResult.stdout.toString().trim(), '46');

    final ntResult = Process.runSync('sqlite3', [
      'assets/biblia_ave_maria.db',
      "SELECT count(distinct book_id) FROM bible WHERE testament = 'New';",
    ]);
    expect(ntResult.exitCode, 0);
    expect(ntResult.stdout.toString().trim(), '27');
  });

  test('assets/biblia_ave_maria.db includes all 7 deuterocanonical books', () {
    final deuterocanonicals = [
      'Tobias',
      'Judite',
      'I Macabeus',
      'II Macabeus',
      'Sabedoria',
      'Eclesiástico',
      'Baruc',
    ];

    for (final book in deuterocanonicals) {
      final res = Process.runSync('sqlite3', [
        'assets/biblia_ave_maria.db',
        "SELECT count(*) FROM bible WHERE book = '$book';",
      ]);
      expect(res.exitCode, 0);
      final count = int.parse(res.stdout.toString().trim());
      expect(count, greaterThan(100), reason: '$book should have valid verse count');
    }
  });

  test('assets/biblia_ave_maria.db includes canonical additions in Daniel and Ester', () {
    // Daniel should have 14 chapters (deuterocanonical chapters 13 and 14)
    final danielRes = Process.runSync('sqlite3', [
      'assets/biblia_ave_maria.db',
      "SELECT max(chapter) FROM bible WHERE book = 'Daniel';",
    ]);
    expect(danielRes.exitCode, 0);
    expect(danielRes.stdout.toString().trim(), '14');

    // Ester should have 16 chapters (deuterocanonical Greek additions)
    final esterRes = Process.runSync('sqlite3', [
      'assets/biblia_ave_maria.db',
      "SELECT max(chapter) FROM bible WHERE book = 'Ester';",
    ]);
    expect(esterRes.exitCode, 0);
    expect(esterRes.stdout.toString().trim(), '16');
  });

  test('Text content has no printing artifacts (no soft-hyphens or asterisks)', () {
    final res = Process.runSync('sqlite3', [
      'assets/biblia_ave_maria.db',
      "SELECT count(*) FROM bible WHERE verse LIKE '%\xad%' OR verse LIKE '%*%';",
    ]);
    expect(res.exitCode, 0);
    expect(res.stdout.toString().trim(), '0');
  });

  test('Old Testament finishes at book 46 (Malaquias) and New Testament starts at 47 (São Mateus)', () {
    final book46 = Process.runSync('sqlite3', [
      'assets/biblia_ave_maria.db',
      "SELECT book, testament FROM bible WHERE book_id = 46 LIMIT 1;",
    ]);
    expect(book46.exitCode, 0);
    expect(book46.stdout.toString().trim(), 'Malaquias|Old');

    final book47 = Process.runSync('sqlite3', [
      'assets/biblia_ave_maria.db',
      "SELECT book, testament FROM bible WHERE book_id = 47 LIMIT 1;",
    ]);
    expect(book47.exitCode, 0);
    expect(book47.stdout.toString().trim(), 'São Mateus|New');

    final book73 = Process.runSync('sqlite3', [
      'assets/biblia_ave_maria.db',
      "SELECT book, testament FROM bible WHERE book_id = 73 LIMIT 1;",
    ]);
    expect(book73.exitCode, 0);
    expect(book73.stdout.toString().trim(), 'Apocalipse|New');
  });
}

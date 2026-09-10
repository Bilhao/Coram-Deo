import 'dart:io';
import 'package:coramdeo/app/biblia/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BibleVersion model tests', () {
    test('availableVersions contains 5 Catholic versions', () {
      expect(BibleVersion.availableVersions.length, equals(5));
    });

    test('defaultVersion is Ave Maria and is bundled', () {
      final def = BibleVersion.defaultVersion;
      expect(def.id, equals('ave_maria'));
      expect(def.name, equals('Bíblia Ave Maria'));
      expect(def.languageCode, equals('pt'));
      expect(def.isBundled, isTrue);
      expect(def.downloadUrl, isNull);
      expect(def.dbFileName, equals('biblia_ave_maria.db'));
    });

    test('all versions have valid attributes and descriptions', () {
      for (final version in BibleVersion.availableVersions) {
        expect(version.id.isNotEmpty, isTrue);
        expect(version.name.isNotEmpty, isTrue);
        expect(version.language.isNotEmpty, isTrue);
        expect(version.languageCode.isNotEmpty, isTrue);
        expect(version.description.isNotEmpty, isTrue);
        expect(version.dbFileName.endsWith('.db'), isTrue);
        expect(version.sizeDescription.isNotEmpty, isTrue);

        if (!version.isBundled) {
          expect(version.downloadUrl, isNotNull);
          expect(version.downloadUrl!.startsWith('https://github.com/Bilhao/Coram-Deo/releases/download/'), isTrue);
          expect(version.downloadUrl!.endsWith('.db.gz'), isTrue);
        }
      }
    });

    test('getById resolves by id, name, dbFileName, and falls back correctly', () {
      expect(BibleVersion.getById('ave_maria').id, equals('ave_maria'));
      expect(BibleVersion.getById('Bíblia Ave Maria').id, equals('ave_maria'));
      expect(BibleVersion.getById('biblia_ave_maria.db').id, equals('ave_maria'));

      expect(BibleVersion.getById('matos_soares').id, equals('matos_soares'));
      expect(BibleVersion.getById('vulgata').id, equals('vulgata'));
      expect(BibleVersion.getById('douay_rheims').id, equals('douay_rheims'));
      expect(BibleVersion.getById('torres_amat').id, equals('torres_amat'));

      // Unknown ID fallback
      expect(BibleVersion.getById('versao_inexistente').id, equals(BibleVersion.defaultVersion.id));
    });
  });

  group('Generated additional Catholic Bibles canonical integrity', () {
    final bibles = [
      {'name': 'Pe. Matos Soares', 'file': 'assets/downloads/biblia_matos_soares.db'},
      {'name': 'Vulgata Clementina', 'file': 'assets/downloads/biblia_vulgata.db'},
      {'name': 'Douay-Rheims', 'file': 'assets/downloads/biblia_douay_rheims.db'},
      {'name': 'Torres Amat / Platense', 'file': 'assets/downloads/biblia_torres_amat.db'},
    ];

    for (final bible in bibles) {
      final path = bible['file']!;
      final label = bible['name']!;

      test('$label ($path) has valid 73-book Catholic Canon and integrity ok', () {
        final file = File(path);
        if (!file.existsSync()) {
          return;
        }

        // Integrity check
        final integrity = Process.runSync('sqlite3', [path, 'PRAGMA integrity_check;']);
        expect(integrity.exitCode, 0);
        expect(integrity.stdout.toString().trim(), 'ok');

        // Exactly 73 books
        final bookCount = Process.runSync('sqlite3', [path, 'SELECT count(distinct book_id) FROM bible;']);
        expect(bookCount.exitCode, 0);
        expect(bookCount.stdout.toString().trim(), '73', reason: '$label must have 73 books');

        // 46 Old Testament books
        final otCount = Process.runSync('sqlite3', [path, "SELECT count(distinct book_id) FROM bible WHERE testament = 'Old';"]);
        expect(otCount.exitCode, 0);
        expect(otCount.stdout.toString().trim(), '46', reason: '$label must have 46 OT books');

        // 27 New Testament books
        final ntCount = Process.runSync('sqlite3', [path, "SELECT count(distinct book_id) FROM bible WHERE testament = 'New';"]);
        expect(ntCount.exitCode, 0);
        expect(ntCount.stdout.toString().trim(), '27', reason: '$label must have 27 NT books');

        // Book 46 is OT and Book 47 is NT
        final b46 = Process.runSync('sqlite3', [path, "SELECT testament FROM bible WHERE book_id = 46 LIMIT 1;"]);
        expect(b46.stdout.toString().trim(), 'Old');

        final b47 = Process.runSync('sqlite3', [path, "SELECT testament FROM bible WHERE book_id = 47 LIMIT 1;"]);
        expect(b47.stdout.toString().trim(), 'New');

        // Book 73 is NT
        final b73 = Process.runSync('sqlite3', [path, "SELECT testament FROM bible WHERE book_id = 73 LIMIT 1;"]);
        expect(b73.stdout.toString().trim(), 'New');
      });
    }
  });
}

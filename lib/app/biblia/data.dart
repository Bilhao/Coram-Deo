import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BibleVersion {
  final String id;
  final String name;
  final String language;
  final String languageCode;
  final String description;
  final String dbFileName;
  final String? downloadUrl;
  final bool isBundled;
  final String sizeDescription;

  const BibleVersion({
    required this.id,
    required this.name,
    required this.language,
    required this.languageCode,
    required this.description,
    required this.dbFileName,
    this.downloadUrl,
    this.isBundled = false,
    required this.sizeDescription,
  });

  static const List<BibleVersion> availableVersions = [
    BibleVersion(
      id: 'ave_maria',
      name: 'Bíblia Ave Maria',
      language: 'Português',
      languageCode: 'pt',
      description: 'Tradução devocional católica padrão',
      dbFileName: 'biblia_ave_maria.db',
      downloadUrl: null,
      isBundled: true,
      sizeDescription: '6.6 MB',
    ),
    BibleVersion(
      id: 'matos_soares',
      name: 'Pe. Manuel de Matos Soares',
      language: 'Português',
      languageCode: 'pt',
      description: 'Tradução tradicional a partir da Vulgata (1956)',
      dbFileName: 'biblia_matos_soares.db',
      downloadUrl:
          'https://github.com/Bilhao/Coram-Deo/releases/download/bible-assets-v1/biblia_matos_soares.db.gz',
      isBundled: false,
      sizeDescription: '2.2 MB',
    ),
    BibleVersion(
      id: 'vulgata',
      name: 'Vulgata Clementina',
      language: 'Latim',
      languageCode: 'la',
      description: 'Texto oficial da Igreja Católica em latim',
      dbFileName: 'biblia_vulgata.db',
      downloadUrl:
          'https://github.com/Bilhao/Coram-Deo/releases/download/bible-assets-v1/biblia_vulgata.db.gz',
      isBundled: false,
      sizeDescription: '2.1 MB',
    ),
    BibleVersion(
      id: 'douay_rheims',
      name: 'Douay-Rheims Bible',
      language: 'Inglês',
      languageCode: 'en',
      description: 'Tradução católica clássica em língua inglesa',
      dbFileName: 'biblia_douay_rheims.db',
      downloadUrl:
          'https://github.com/Bilhao/Coram-Deo/releases/download/bible-assets-v1/biblia_douay_rheims.db.gz',
      isBundled: false,
      sizeDescription: '2.1 MB',
    ),
    BibleVersion(
      id: 'torres_amat',
      name: 'Biblia Torres Amat / Platense',
      language: 'Espanhol',
      languageCode: 'es',
      description: 'Tradução católica clássica em língua espanhola',
      dbFileName: 'biblia_torres_amat.db',
      downloadUrl:
          'https://github.com/Bilhao/Coram-Deo/releases/download/bible-assets-v1/biblia_torres_amat.db.gz',
      isBundled: false,
      sizeDescription: '2.2 MB',
    ),
  ];

  static BibleVersion get defaultVersion => availableVersions.first;

  static BibleVersion getById(String id) {
    return availableVersions.firstWhere(
      (v) => v.id == id || v.name == id || v.dbFileName == id,
      orElse: () => defaultVersion,
    );
  }
}

class Biblia {
  static const String dbAveMaria = 'biblia_ave_maria.db';

  BibleVersion _currentVersion = BibleVersion.defaultVersion;

  BibleVersion get currentVersion => _currentVersion;

  void setVersion(String versionIdOrName) {
    _currentVersion = BibleVersion.getById(versionIdOrName);
  }

  String get currentVersionName => _currentVersion.name;

  Future<bool> isVersionInstalled(BibleVersion version) async {
    if (version.isBundled) return true;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, version.dbFileName);
    return await databaseExists(path);
  }

  Future<bool> deleteVersion(BibleVersion version) async {
    if (version.isBundled) return false;
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, version.dbFileName);
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        if (_currentVersion.id == version.id) {
          _currentVersion = BibleVersion.defaultVersion;
        }
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _currentVersion.dbFileName);

    final exist = await databaseExists(path);

    if (!exist) {
      if (_currentVersion.isBundled) {
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {}

        ByteData data = await rootBundle.load(
          join("assets", _currentVersion.dbFileName),
        );
        List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes,
          data.lengthInBytes,
        );

        await File(path).writeAsBytes(bytes, flush: true);

        // Limpeza de bases protestantes antigas de 66 livros para liberar armazenamento no dispositivo
        final legacyDatabases = [
          'biblia_nvi.db',
          'biblia_acf.db',
          'biblia_kjv.db',
          'biblia_rvr.db',
        ];
        for (final legacy in legacyDatabases) {
          try {
            final legacyFile = File(join(dbPath, legacy));
            if (await legacyFile.exists()) {
              await legacyFile.delete();
            }
          } catch (_) {}
        }
      } else {
        // Se a versão solicitada não estiver baixada no disco, reverte com segurança para a versão embutida
        _currentVersion = BibleVersion.defaultVersion;
        return await initDb();
      }
    }

    return await openDatabase(path);
  }

  Future<List<String>> getBooks(String testament) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT DISTINCT book FROM bible WHERE testament = ? ORDER BY book_id',
      [testament],
    );

    return List.generate(maps.length, (i) {
      return maps[i]['book'] as String;
    });
  }

  Future<List<int>> getChapters(String book) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT DISTINCT chapter FROM bible WHERE book = ? ORDER BY chapter',
      [book],
    );

    return List.generate(maps.length, (i) {
      return maps[i]['chapter'] as int;
    });
  }

  Future<List<String>> getVersesId(String book, int chapter) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT verse_id FROM bible WHERE book = ? AND chapter = ? ORDER BY verse_id',
      [book, chapter],
    );

    return List.generate(maps.length, (i) {
      return maps[i]['verse_id'].toString();
    });
  }

  Future<List<String>> getVerses(String book, int chapter) async {
    final db = await initDb();
    final maps = await db.rawQuery(
      'SELECT verse FROM bible WHERE book = ? AND chapter = ? ORDER BY verse_id',
      [book, chapter],
    );

    return List.generate(maps.length, (i) {
      return maps[i]['verse'] as String;
    });
  }

  Future<String> getBookById(int bookId) async {
    final db = await initDb();
    final maps = await db.rawQuery(
      'SELECT DISTINCT book FROM bible WHERE book_id = ? LIMIT 1',
      [bookId],
    );

    if (maps.isEmpty) {
      return 'Gênesis';
    }

    return maps[0]['book'] as String;
  }

  Future<int> getLastChapterOfBook(String book) async {
    final db = await initDb();
    final maps = await db.rawQuery(
      'SELECT MAX(chapter) as max_ch FROM bible WHERE book = ?',
      [book],
    );

    if (maps.isEmpty || maps[0]['max_ch'] == null) {
      return 1;
    }

    return maps[0]['max_ch'] as int;
  }

  Future<int> getBookId(String book) async {
    final db = await initDb();
    final maps = await db.rawQuery(
      'SELECT book_id FROM bible WHERE book = ? LIMIT 1',
      [book],
    );

    if (maps.isEmpty) {
      return 1;
    }

    return maps[0]['book_id'] as int;
  }
}

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Biblia {
  static const String dbAveMaria = 'biblia_ave_maria.db';

  String _currentVersion = dbAveMaria;

  void setVersion(String version) {
    // Atualmente mantemos a Bíblia Ave Maria como padrão católico com 73 livros
    _currentVersion = dbAveMaria;
  }

  String get currentVersionName => 'Ave Maria';

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _currentVersion);

    final exist = await databaseExists(path);

    if (!exist) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", _currentVersion));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

      // Limpeza de bases protestantes antigas de 66 livros para liberar armazenamento no dispositivo
      final legacyDatabases = ['biblia_nvi.db', 'biblia_acf.db', 'biblia_kjv.db', 'biblia_rvr.db'];
      for (final legacy in legacyDatabases) {
        try {
          final legacyFile = File(join(dbPath, legacy));
          if (await legacyFile.exists()) {
            await legacyFile.delete();
          }
        } catch (_) {}
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

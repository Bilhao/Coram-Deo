import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Biblia {
  static const String dbNvi = 'biblia_nvi.db';
  static const String dbAcf = 'biblia_acf.db';
  static const String dbKjv = 'biblia_kjv.db';
  static const String dbRvr = 'biblia_rvr.db';

  String _currentVersion = dbNvi;

  void setVersion(String version) {
    if (version == 'ACF') {
      _currentVersion = dbAcf;
    } else if (version == 'KJV') {
      _currentVersion = dbKjv;
    } else if (version == 'RVR') {
      _currentVersion = dbRvr;
    } else {
      _currentVersion = dbNvi;
    }
  }

  String get currentVersionName {
    if (_currentVersion == dbAcf) return 'ACF';
    if (_currentVersion == dbKjv) return 'KJV';
    if (_currentVersion == dbRvr) return 'RVR';
    return 'NVI';
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _currentVersion);

    final exist = await databaseExists(path);

    if (exist) {
      return await openDatabase(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", _currentVersion));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

      return await openDatabase(path);
    }
  }

  Future<List<String>> getBooks(String testament) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT book FROM bible WHERE testament = ?', [testament]);

    return List.generate(maps.length, (i) {
      return maps[i]['book'] as String;
    });
  }

  Future<List<int>> getChapters(String book) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter FROM bible WHERE book = ?', [book]);

    return List.generate(maps.length, (i) {
      return maps[i]['chapter'] as int;
    });
  }

  Future<List<String>> getVersesId(String book, int chapter) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT verse_id FROM bible WHERE book = ? AND chapter = ?', [book, chapter]);

    return List.generate(maps.length, (i) {
      return maps[i]['verse_id'].toString();
    });
  }

  Future<List<String>> getVerses(String book, int chapter) async {
    final db = await initDb();
    final maps = await db.rawQuery('SELECT verse FROM bible WHERE book = ? AND chapter = ?', [book, chapter]);

    return List.generate(maps.length, (i) {
      return maps[i]['verse'] as String;
    });
  }

  Future<String> getBookById(int bookId) async {
    final db = await initDb();
    final maps = await db.rawQuery('SELECT DISTINCT book FROM bible WHERE book_id = ?', [bookId]);

    return maps[0]['book'] as String;
  }

  Future<int> getLastChapterOfBook(String book) async {
    final db = await initDb();
    final maps = await db.rawQuery('SELECT MAX(chapter) FROM bible WHERE book = ?', [book]);

    return maps[0]['MAX(chapter)'] as int;
  }

  Future<int> getBookId(String book) async {
    final db = await initDb();
    final maps = await db.rawQuery('SELECT book_id FROM bible WHERE book = ?', [book]);

    return maps[0]['book_id'] as int;
  }
}

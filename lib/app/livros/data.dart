import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Livros {
  Livros({required this.bookName}) {
    initDb();
  }

  String bookName;

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'books/$bookName.db');

    final exist = await databaseExists(path);

    if (exist) {
      return await openDatabase(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "books/$bookName.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

      return await openDatabase(path);
    }
  }

  Future<int> getFirstChapter() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter_id FROM book');
    return maps[0]['chapter_id'];
  }

  Future<List<int>> getChapterIds() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter_id FROM book');
    return List.generate(maps.length, (i) {
      return maps[i]['chapter_id'];
    });
  }

  Future<String> getFirstChapterName() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter FROM book');
    return maps[0]['chapter'];
  }

  Future<List<String>> getChapterNames() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter FROM book');
    return List.generate(maps.length, (i) {
      return maps[i]['chapter'];
    });
  }

  Future<List<int>> getContentIds({required int chapterId}) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT content_id FROM book WHERE chapter_id = ?', [chapterId]);
    return List.generate(maps.length, (i) {
      return maps[i]['content_id'];
    });
  }

  Future<List<String>> getContentByIds({required List<int> contentIds}) async {
    final db = await initDb();
    List<String> contents = [];
    for (int id in contentIds) {
      final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT content FROM book WHERE content_id = ?', [id]);
      contents.add(maps[0]['content']);
    }
    return contents;
  }

  Future<List<Map<String, dynamic>>> getFullContentByIds({required List<int> contentIds, int? chapterId}) async {
    final db = await initDb();
    List<Map<String, dynamic>> results = [];

    // Check if title column exists
    var columns = await db.rawQuery("PRAGMA table_info(book)");
    bool hasTitle = columns.any((col) => col['name'] == 'title');

    for (int id in contentIds) {
      String query;
      List<dynamic> args = [id];

      if (chapterId != null) {
        if (hasTitle) {
          query = 'SELECT title, content FROM book WHERE content_id = ? AND chapter_id = ?';
        } else {
          query = 'SELECT content FROM book WHERE content_id = ? AND chapter_id = ?';
        }
        args.add(chapterId);
      } else {
        if (hasTitle) {
          query = 'SELECT title, content FROM book WHERE content_id = ?';
        } else {
          query = 'SELECT content FROM book WHERE content_id = ?';
        }
      }

      final List<Map<String, dynamic>> maps = await db.rawQuery(query, args);

      if (maps.isNotEmpty) {
        if (hasTitle) {
          results.add({'title': maps[0]['title'], 'content': maps[0]['content']});
        } else {
          results.add({'title': null, 'content': maps[0]['content']});
        }
      }
    }
    return results;
  }
}

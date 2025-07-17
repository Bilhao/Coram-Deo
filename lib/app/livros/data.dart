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
    
    // Check if content_id column exists
    final List<Map<String, dynamic>> schemaResult = await db.rawQuery("PRAGMA table_info(book)");
    final bool hasContentId = schemaResult.any((column) => column['name'] == 'content_id');
    
    if (hasContentId) {
      final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT content_id FROM book WHERE chapter_id = ?', [chapterId]);
      return List.generate(maps.length, (i) {
        return maps[i]['content_id'];
      });
    } else {
      // For databases without content_id (like via_sacra), return [0] as a single content item
      return [0];
    }
  }

  Future<List<String>> getContentByIds({required List<int> contentIds}) async {
    final db = await initDb();
    
    // Check if content_id column exists
    final List<Map<String, dynamic>> schemaResult = await db.rawQuery("PRAGMA table_info(book)");
    final bool hasContentId = schemaResult.any((column) => column['name'] == 'content_id');
    
    if (hasContentId) {
      List<String> contents = [];
      for (int id in contentIds) {
        final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT content FROM book WHERE content_id = ?', [id]);
        contents.add(maps[0]['content']);
      }
      return contents;
    } else {
      // For databases without content_id, this method shouldn't be used
      // Use getContentByChapterId instead
      throw UnsupportedError('getContentByIds not supported for databases without content_id. Use getContentByChapterId instead.');
    }
  }

  Future<List<String>> getContentByChapterId({required int chapterId}) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT content FROM book WHERE chapter_id = ?', [chapterId]);
    return maps.isNotEmpty ? [maps[0]['content']] : [''];
  }

  // Via Sacra specific methods for content without content_id
  Future<String> getChapterContent({required int chapterId}) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT content FROM book WHERE chapter_id = ?', [chapterId]);
    return maps.isNotEmpty ? maps[0]['content'] : '';
  }

  // Parse Via Sacra content to separate station description from meditation points
  Map<String, String> parseViaSacraContent(String content) {
    // Split content by numbered meditation points (preceded by 5 newlines and starting with "1.")
    final RegExp regExp = RegExp(r'\n\n\n\n\n1\.');
    final match = regExp.firstMatch(content);
    
    if (match == null) {
      // No meditation points found, return full content as station
      return {
        'station': content.trim(),
        'meditation': ''
      };
    }

    final stationContent = content.substring(0, match.start).trim();
    final meditationContent = content.substring(match.start + 5).trim(); // +5 to skip the newlines

    return {
      'station': stationContent,
      'meditation': meditationContent
    };
  }
}

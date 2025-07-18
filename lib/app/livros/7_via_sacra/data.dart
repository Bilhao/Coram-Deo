import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ViaSacraData {
  ViaSacraData() {
    initDb();
  }

  final String bookName = "via_sacra_livro";

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
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter_id FROM book ORDER BY chapter_id');
    return maps[0]['chapter_id'];
  }

  Future<List<int>> getChapterIds() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter_id FROM book ORDER BY chapter_id');
    return List.generate(maps.length, (i) {
      return maps[i]['chapter_id'];
    });
  }

  Future<String> getFirstChapterName() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter FROM book ORDER BY chapter_id');
    return maps[0]['chapter'];
  }

  Future<List<String>> getChapterNames() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter FROM book ORDER BY chapter_id');
    return List.generate(maps.length, (i) {
      return maps[i]['chapter'];
    });
  }

  // Get station content (content_id = 0)
  Future<String> getStationContent({required int chapterId}) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT content FROM book WHERE chapter_id = ? AND content_id = 0', 
      [chapterId]
    );
    return maps.isNotEmpty ? maps[0]['content'] : '';
  }

  // Get meditation content (content_id > 0, ordered by point)
  Future<List<String>> getMeditationContent({required int chapterId}) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT content FROM book WHERE chapter_id = ? AND content_id > 0 ORDER BY point', 
      [chapterId]
    );
    return List.generate(maps.length, (i) => maps[i]['content']);
  }

  // Get meditation point names (ordered by point)
  Future<List<String>> getMeditationNames({required int chapterId}) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT content_name FROM book WHERE chapter_id = ? AND content_id > 0 ORDER BY point', 
      [chapterId]
    );
    return List.generate(maps.length, (i) => maps[i]['content_name']);
  }

  // Get about content (introduction text)
  Future<String> getAboutContent() async {
    return '''A Via Sacra é uma devoção muito popular que consiste em meditar sobre a Paixão e Morte de Nosso Senhor Jesus Cristo, seguindo-O espiritualmente no caminho que percorreu desde o Pretório de Pilatos até o Calvário.

Esta Via Sacra foi escrita por São Josemaria Escrivá, fundador do Opus Dei, e nos convida a acompanhar Jesus em seu caminho de sofrimento, descobrindo nele o amor infinito de Deus pela humanidade.

Cada estação nos oferece uma reflexão sobre um momento específico da Paixão, seguida de pontos de meditação que nos ajudam a aplicar esses mistérios à nossa vida espiritual.

"Não há amor verdadeiro sem sacrifício; e não há sacrifício sem amor." - São Josemaria Escrivá

Rezemos esta Via Sacra com devoção, deixando que o amor de Cristo transforme nossos corações e nos inspire a segui-Lo mais de perto.''';
  }
}
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Bible {
  Future initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'bible_data.db');

    final exist = await databaseExists(path);

    if (exist) {
      return await openDatabase(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "biblia_data.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
      
      return await openDatabase(path);
    }
  }

  Future<List<String>> getversionNames() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.query('bible');
    return List.generate(maps.length, (i) {
      return maps[i]['versionName'];
    });
  }

  Future<String> getxmlLink(String versionName) async {
    final db = await initDb();
    final maps = await db.rawQuery('SELECT xmlLink FROM bible WHERE versionName = ?', [versionName]);
    return maps[0]['xmlLink'];
  }
}

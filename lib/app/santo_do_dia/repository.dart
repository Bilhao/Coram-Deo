import 'dart:io';
import 'package:coramdeo/app/santo_do_dia/model.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class SantoDoDiaRepository {
  static Database? _db;
  static const int _currentDbVersion = 13;

  Future<Database> get database async {
    if (_db != null && _db!.isOpen) {
      return _db!;
    }
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'santos.db');

    final exists = await databaseExists(path);
    final prefs = await SharedPreferences.getInstance();
    final savedVersion = prefs.getInt('santos.db_version') ?? 0;

    if (!exists || savedVersion < _currentDbVersion) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join('assets', 'santos.db'));
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      await File(path).writeAsBytes(bytes, flush: true);
      await prefs.setInt('santos.db_version', _currentDbVersion);
    }

    return await openDatabase(path);
  }

  /// Retorna o santo do dia para uma data específica (dia e mês).
  Future<SantoModel?> getSanto(int day, int month) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'santos',
        where: 'mes = ? AND dia = ?',
        whereArgs: [month, day],
        limit: 1,
      );

      if (maps.isNotEmpty) {
        return SantoModel.fromMap(maps.first);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Pesquisa santos por nome, subtítulo ou biografia.
  Future<List<SantoModel>> search(String query) async {
    try {
      final db = await database;
      final clean = '%${query.trim()}%';
      final List<Map<String, dynamic>> maps = await db.query(
        'santos',
        where: 'nome LIKE ? OR subtitulo LIKE ? OR biografia LIKE ?',
        whereArgs: [clean, clean, clean],
        limit: 30,
      );

      return maps.map((m) => SantoModel.fromMap(m)).toList();
    } catch (_) {
      return [];
    }
  }

  /// Retorna o total de santos cadastrados no banco.
  Future<int> count() async {
    try {
      final db = await database;
      final result = await db.rawQuery('SELECT COUNT(*) as count FROM santos');
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (_) {
      return 0;
    }
  }
}

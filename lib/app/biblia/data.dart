import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Bible version configuration
class BibleVersion {
  final String id;
  final String name;
  final String language;
  final String dbAssetPath;
  final bool hasAudio;

  const BibleVersion({
    required this.id,
    required this.name,
    required this.language,
    required this.dbAssetPath,
    this.hasAudio = false,
  });
}

class Biblia {
  static const List<BibleVersion> availableVersions = [
    BibleVersion(
      id: 'nvi_pt',
      name: 'Nova Versão Internacional',
      language: 'Português',
      dbAssetPath: 'assets/biblia_nvi.db',
      hasAudio: true,
    ),
    BibleVersion(
      id: 'kjv_en',
      name: 'King James Version',
      language: 'English',
      dbAssetPath: 'assets/bible_kjv.db',
      hasAudio: true,
    ),
    BibleVersion(
      id: 'rvr_es',
      name: 'Reina-Valera 1960',
      language: 'Español',
      dbAssetPath: 'assets/biblia_rvr.db',
      hasAudio: true,
    ),
    BibleVersion(
      id: 'lsg_fr',
      name: 'Louis Segond 1910',
      language: 'Français',
      dbAssetPath: 'assets/bible_lsg.db',
      hasAudio: false,
    ),
    BibleVersion(
      id: 'elb_de',
      name: 'Elberfelder Bibel',
      language: 'Deutsch',
      dbAssetPath: 'assets/bible_elb.db',
      hasAudio: false,
    ),
    BibleVersion(
      id: 'nvi_it',
      name: 'Nuova Riveduta 2006',
      language: 'Italiano',
      dbAssetPath: 'assets/bible_nvi_it.db',
      hasAudio: false,
    ),
  ];

  String _currentVersionId = 'nvi_pt';

  String get currentVersionId => _currentVersionId;
  
  BibleVersion get currentVersion => 
    availableVersions.firstWhere((v) => v.id == _currentVersionId);

  void setVersion(String versionId) {
    if (availableVersions.any((v) => v.id == versionId)) {
      _currentVersionId = versionId;
    }
  }

  Future<Database> initDb([String? versionId]) async {
    final version = versionId != null 
      ? availableVersions.firstWhere((v) => v.id == versionId, orElse: () => currentVersion)
      : currentVersion;
    
    final dbPath = await getDatabasesPath();
    final dbName = version.dbAssetPath.split('/').last;
    final path = join(dbPath, dbName);

    final exist = await databaseExists(path);

    if (exist) {
      return await openDatabase(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      try {
        ByteData data = await rootBundle.load(version.dbAssetPath);
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(path).writeAsBytes(bytes, flush: true);
      } catch (e) {
        // If the specific version DB doesn't exist, fall back to the default (NVI)
        if (version.id != 'nvi_pt') {
          ByteData data = await rootBundle.load('assets/biblia_nvi.db');
          List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
          await File(path).writeAsBytes(bytes, flush: true);
        } else {
          rethrow;
        }
      }

      return await openDatabase(path);
    }
  }

  Future<List<String>> getBooks(String testament, [String? versionId]) async {
    final db = await initDb(versionId);
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT book FROM bible WHERE testament = ? ORDER BY book_id', [testament]);

    return List.generate(maps.length, (i) {
      return maps[i]['book'] as String;
    });
  }

  Future<List<int>> getChapters(String book, [String? versionId]) async {
    final db = await initDb(versionId);
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter FROM bible WHERE book = ? ORDER BY chapter', [book]);

    return List.generate(maps.length, (i) {
      return maps[i]['chapter'] as int;
    });
  }

  Future<List<String>> getVersesId(String book, int chapter, [String? versionId]) async {
    final db = await initDb(versionId);
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT verse_id FROM bible WHERE book = ? AND chapter = ? ORDER BY verse_id', [book, chapter]);

    return List.generate(maps.length, (i) {
      return maps[i]['verse_id'].toString();
    });
  }

  Future<List<String>> getVerses(String book, int chapter, [String? versionId]) async {
    final db = await initDb(versionId);
    final maps = await db.rawQuery('SELECT verse FROM bible WHERE book = ? AND chapter = ? ORDER BY verse_id', [book, chapter]);

    return List.generate(maps.length, (i) {
      return maps[i]['verse'] as String;
    });
  }

  Future<String> getBookById(int bookId, [String? versionId]) async {
    final db = await initDb(versionId);
    final maps = await db.rawQuery('SELECT DISTINCT book FROM bible WHERE book_id = ?', [bookId]);

    return maps.isNotEmpty ? maps[0]['book'] as String : '';
  }

  Future<int> getLastChapterOfBook(String book, [String? versionId]) async {
    final db = await initDb(versionId);
    final maps = await db.rawQuery('SELECT MAX(chapter) FROM bible WHERE book = ?', [book]);

    return maps[0]['MAX(chapter)'] as int;
  }

  Future<int> getBookId(String book, [String? versionId]) async {
    final db = await initDb(versionId);
    final maps = await db.rawQuery('SELECT book_id FROM bible WHERE book = ? LIMIT 1', [book]);

    return maps.isNotEmpty ? maps[0]['book_id'] as int : 1;
  }

  Future<String> getVerseAudioUrl(String book, int chapter, int verse, [String? versionId]) async {
    final version = versionId != null 
      ? availableVersions.firstWhere((v) => v.id == versionId, orElse: () => currentVersion)
      : currentVersion;
    
    if (!version.hasAudio) return '';
    
    // This would integrate with beblia.com API or similar
    // For now, return a placeholder URL structure
    final bookId = await getBookId(book, versionId);
    return 'https://beblia.com/audio/${version.language.toLowerCase()}/$bookId/$chapter/$verse.mp3';
  }

  Future<String> getChapterAudioUrl(String book, int chapter, [String? versionId]) async {
    final version = versionId != null 
      ? availableVersions.firstWhere((v) => v.id == versionId, orElse: () => currentVersion)
      : currentVersion;
    
    if (!version.hasAudio) return '';
    
    final bookId = await getBookId(book, versionId);
    return 'https://beblia.com/audio/${version.language.toLowerCase()}/$bookId/$chapter.mp3';
  }
}

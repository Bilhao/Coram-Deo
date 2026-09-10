import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BibleDownloadService {
  static final BibleDownloadService _instance = BibleDownloadService._internal();
  factory BibleDownloadService() => _instance;
  BibleDownloadService._internal();

  final http.Client _client = http.Client();

  Future<bool> downloadAndExtract({
    required String downloadUrl,
    required String targetDbName,
    required void Function(double progress) onProgress,
  }) async {
    final dbDir = await getDatabasesPath();
    final tempGzPath = join(dbDir, '$targetDbName.tmp.gz');
    final finalDbPath = join(dbDir, targetDbName);

    try {
      final request = http.Request('GET', Uri.parse(downloadUrl));
      final response = await _client.send(request);

      if (response.statusCode != 200) {
        debugPrint('Erro ao baixar base bíblica: HTTP ${response.statusCode}');
        return false;
      }

      final contentLength = response.contentLength ?? 0;
      int downloadedBytes = 0;

      final tempFile = File(tempGzPath);
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      final sink = tempFile.openWrite();

      await for (final chunk in response.stream) {
        sink.add(chunk);
        downloadedBytes += chunk.length;
        if (contentLength > 0) {
          onProgress(downloadedBytes / contentLength);
        }
      }

      await sink.flush();
      await sink.close();

      onProgress(1.0);

      // Descompressão Gzip direta para o arquivo SQLite no disco
      final gzBytes = await tempFile.readAsBytes();
      final decompressedBytes = gzip.decode(gzBytes);

      final dbFile = File(finalDbPath);
      await dbFile.writeAsBytes(decompressedBytes, flush: true);

      // Remove arquivo temporário compactado
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      return true;
    } catch (e) {
      debugPrint('Erro durante download e extração da Bíblia: $e');
      try {
        final tempFile = File(tempGzPath);
        if (await tempFile.exists()) await tempFile.delete();
        final dbFile = File(finalDbPath);
        if (await dbFile.exists()) await dbFile.delete();
      } catch (_) {}
      return false;
    }
  }

  Future<bool> deleteDatabase(String dbName) async {
    try {
      final dbDir = await getDatabasesPath();
      final dbFile = File(join(dbDir, dbName));
      if (await dbFile.exists()) {
        await dbFile.delete();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Erro ao deletar base bíblica $dbName: $e');
      return false;
    }
  }

  Future<bool> isDatabaseInstalled(String dbName) async {
    final dbDir = await getDatabasesPath();
    final dbFile = File(join(dbDir, dbName));
    return await dbFile.exists();
  }
}

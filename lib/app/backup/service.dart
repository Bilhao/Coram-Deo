import 'dart:convert';
import 'dart:io';
import 'package:coramdeo/app/plano_de_vida/data.dart';
import 'package:coramdeo/app/plano_de_vida/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:coramdeo/utils/notification.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackupService {
  final PlanoDeVida planoDeVidaDb = PlanoDeVida();

  Future<String> exportBackup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allPrefs = <String, dynamic>{};
      for (var key in prefs.getKeys()) {
        final value = prefs.get(key);
        if (value is String || value is int || value is bool || value is double || value is List<String>) {
          allPrefs[key] = value;
        }
      }

      List<Map<String, dynamic>> planoData = [];
      try {
        final db = await planoDeVidaDb.initDb();
        planoData = await db.query('data');
      } catch (e) {
        // Continue with empty list if DB fails, to at least save prefs
      }

      final backupData = {'version': 1, 'timestamp': DateTime.now().toIso8601String(), 'preferences': allPrefs, 'plano_de_vida': planoData};

      String jsonString;
      try {
        jsonString = jsonEncode(backupData);
      } catch (e) {
        throw Exception("Falha ao codificar dados para JSON: $e");
      }

      final directory = Platform.isAndroid ? Directory('/storage/emulated/0/Download') : await getDownloadsDirectory() ?? await getApplicationDocumentsDirectory();

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final dateStr = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final filePath = '${directory.path}/coramdeo_backup_$dateStr.json';
      final file = File(filePath);
      await file.writeAsString(jsonString);

      return filePath;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> importBackup() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);

      if (result != null) {
        File file = File(result.files.single.path!);
        String content = await file.readAsString();
        Map<String, dynamic> data = jsonDecode(content);

        // Restore Preferences
        final prefs = await SharedPreferences.getInstance();
        if (data.containsKey('preferences')) {
          Map<String, dynamic> restoredPrefs = data['preferences'];
          for (var key in restoredPrefs.keys) {
            final value = restoredPrefs[key];
            if (value is String) {
              await prefs.setString(key, value);
            } else if (value is int) {
              await prefs.setInt(key, value);
            } else if (value is bool) {
              await prefs.setBool(key, value);
            } else if (value is double) {
              await prefs.setDouble(key, value);
            } else if (value is List) {
              await prefs.setStringList(key, List<String>.from(value));
            }
          }
        }

        // Restore Plano de Vida
        if (data.containsKey('plano_de_vida')) {
          // Ensure schema handles all columns
          await planoDeVidaDb.ensureWeekdaysColumn();

          final db = await planoDeVidaDb.initDb();

          await db.transaction((txn) async {
            // Delete existing data to avoid conflicts
            await txn.delete('data');

            List<dynamic> rows = data['plano_de_vida'];
            for (var row in rows) {
              await txn.insert('data', row);
            }
          });

          final provider = PlanoDeVidaProvider();
          // Ensure notification permissions are granted before rescheduling
          await Notifier.verifyNotificationPermission();
          await provider.rescheduleAllNotifications();
        }
        return true;
      }
      return false; // User cancelled
    } catch (e) {
      rethrow;
    }
  }
}

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PlanoDeVida {
  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'plano_de_vida.db');

    final exist = await databaseExists(path);

    if (exist) {
      return await openDatabase(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "plano_de_vida.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

      return await openDatabase(path);
    }
  }

  Future<int> getId(String title) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT id FROM data WHERE title = ?', [title]);
    return maps[0]['id'];
  }

  Future<bool> getIsCustom(String title) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT isCustom FROM data WHERE title = ?', [title]);

    if (maps[0]['isCustom'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getIsSelected(String title) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT isSelected FROM data WHERE title = ?', [title]);

    if (maps[0]['isSelected'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getIsCompleted(String title) async {
    final db = await initDb();
    String today = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT completedDates FROM data WHERE title = ?', [title]);
    if ((maps[0]['completedDates'] ?? "").contains(today)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getIsNotification(String title) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT isNotification FROM data WHERE title = ?', [title]);

    if (maps[0]['isNotification'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> getTitleAndNotificationTimes() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT title, notificationTimes FROM data');
    Map<String, dynamic> resultMap = {};
    for (Map<String, dynamic> map in maps) {
      resultMap.addAll({map["title"]: map["notificationTimes"]});
    }
    return resultMap;
  }

  Future<Map<String, dynamic>> getTitleAndCompletedDates() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT title, completedDates FROM data');
    Map<String, dynamic> resultMap = {};
    for (Map<String, dynamic> map in maps) {
      resultMap.addAll({map["title"]: map["completedDates"]});
    }
    return resultMap;
  }

  Future<Map<String, dynamic>> getTitleAndWeekdays() async {
    final db = await initDb();
    // Add weekdays column if it doesn't exist
    await db.execute('ALTER TABLE data ADD COLUMN weekdays TEXT DEFAULT "1,2,3,4,5,6,7"').catchError((e) {
      // Column already exists, ignore error
    });
    
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT title, weekdays FROM data');
    Map<String, dynamic> resultMap = {};
    for (Map<String, dynamic> map in maps) {
      resultMap.addAll({map["title"]: map["weekdays"] ?? "1,2,3,4,5,6,7"});
    }
    return resultMap;
  }

  Future<List<String>> getAllTitles() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT title FROM data ORDER BY id');
    return List.generate(maps.length, (i) {
      return maps[i]['title'];
    });
  }

  Future<List<String>> getTitleisCustom() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT title FROM data WHERE isCustom = 1');
    return List.generate(maps.length, (i) {
      return maps[i]['title'];
    });
  }

  Future<List<String>> getTitleisSelected() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT title FROM data WHERE isSelected = 1');
    return List.generate(maps.length, (i) {
      return maps[i]['title'];
    });
  }

  Future<List<String>> getTitleisCompleted(String date) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT title FROM data WHERE completedDates LIKE ?', ["%$date%"]);
    return List.generate(maps.length, (i) {
      return maps[i]['title'];
    });
  }

  Future<List<String>> getTitleisNotification() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT title FROM data WHERE isNotification = 1');
    return List.generate(maps.length, (i) {
      return maps[i]['title'];
    });
  }

  toggleisSelected(String title) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT isSelected FROM data WHERE title = ?', [title]);
    if (maps[0]['isSelected'] == 1) {
      await db.rawUpdate('UPDATE data SET isSelected = ? WHERE title = ?', [0, title]);
    } else {
      await db.rawUpdate('UPDATE data SET isSelected = ? WHERE title = ?', [1, title]);
    }
  }

  activateisNotification(String title) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT isNotification FROM data WHERE title = ?', [title]);
    if (maps[0]['isNotification'] == 0) {
      await db.rawUpdate('UPDATE data SET isNotification = ? WHERE title = ?', [1, title]);
    }
  }

  deactivateisNotification(String title) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT isNotification FROM data WHERE title = ?', [title]);
    if (maps[0]['isNotification'] == 1) {
      await db.rawUpdate('UPDATE data SET isNotification = ? WHERE title = ?', [0, title]);
    }
  }

  insertNotificationTime(String title, String time) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT notificationTimes FROM data WHERE title = ?', [title]);
    if (maps[0]['notificationTimes'] == null) {
      await db.rawUpdate('UPDATE data SET notificationTimes = ? WHERE title = ?', [time, title]);
    } else {
      await db.rawUpdate('UPDATE data SET notificationTimes = ? WHERE title = ?', [maps[0]['notificationTimes'] + ",$time", title]);
    }
  }

  deleteNotificationTime(String title, String time) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT notificationTimes FROM data WHERE title = ?', [title]);
    if (maps[0]['notificationTimes'].split(",").length == 1) {
      await db.rawUpdate('UPDATE data SET notificationTimes = ? WHERE title = ?', [null, title]);
    } else {
      List<String> timeList = maps[0]['notificationTimes'].split(',');
      timeList.remove(time);
      await db.rawUpdate('UPDATE data SET notificationTimes = ? WHERE title = ?', [timeList.join(","), title]);
    }
  }

  insertCompletedDate(String title, String date) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT completedDates FROM data WHERE title = ?', [title]);
    if (maps[0]['completedDates'] == null) {
      await db.rawUpdate('UPDATE data SET completedDates = ? WHERE title = ?', [date, title]);
    } else {
      await db.rawUpdate('UPDATE data SET completedDates = ? WHERE title = ?', [maps[0]['completedDates'] + ",$date", title]);
    }
  }

  deleteCompletedDate(String title, String date) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT completedDates FROM data WHERE title = ?', [title]);
    if (maps[0]['completedDates'].split(",").length == 1) {
      await db.rawUpdate('UPDATE data SET completedDates = ? WHERE title = ?', [null, title]);
    } else {
      List<String> dateList = maps[0]['completedDates'].split(',');
      dateList.remove(date);
      await db.rawUpdate('UPDATE data SET completedDates = ? WHERE title = ?', [dateList.join(","), title]);
    }
  }

  insertNewItem(String title, int isCustom, int isSelected, int isCompleted, int isNotification) async {
    final db = await initDb();
    // Ensure weekdays column exists
    await db.execute('ALTER TABLE data ADD COLUMN weekdays TEXT DEFAULT "1,2,3,4,5,6,7"').catchError((e) {
      // Column already exists, ignore error
    });
    await db.rawInsert("INSERT INTO data(title, isCustom, isSelected, isCompleted, isNotification, weekdays) VALUES(?, ?, ?, ?, ?, ?)", 
        [title, isCustom, isSelected, isCompleted, isNotification, "1,2,3,4,5,6,7"]);
  }

  deleteItem(String title) async {
    final db = await initDb();
    await db.rawDelete('DELETE FROM data WHERE title = ?', [title]);
  }

  updateWeekdays(String title, String weekdays) async {
    final db = await initDb();
    // Ensure weekdays column exists
    await db.execute('ALTER TABLE data ADD COLUMN weekdays TEXT DEFAULT "1,2,3,4,5,6,7"').catchError((e) {
      // Column already exists, ignore error
    });
    await db.rawUpdate('UPDATE data SET weekdays = ? WHERE title = ?', [weekdays, title]);
  }

  Future<String> getWeekdays(String title) async {
    final db = await initDb();
    // Ensure weekdays column exists
    await db.execute('ALTER TABLE data ADD COLUMN weekdays TEXT DEFAULT "1,2,3,4,5,6,7"').catchError((e) {
      // Column already exists, ignore error
    });
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT weekdays FROM data WHERE title = ?', [title]);
    return maps.isNotEmpty ? (maps[0]['weekdays'] ?? "1,2,3,4,5,6,7") : "1,2,3,4,5,6,7";
  }

  // Generate unique notification ID for a specific time within a title
  // Uses the time string itself to ensure ID stability regardless of array order
  int generateNotificationId(int itemId, String time) {
    // Convert time string to numeric representation (remove colons and non-digits)
    String timeOnly = time.replaceAll(RegExp(r'[^0-9]'), '');
    return int.parse("${itemId + 1}$timeOnly");
  }

  // Get notification ID for a specific title and time
  Future<int> getNotificationIdForTime(String title, String time) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT id, notificationTimes FROM data WHERE title = ?', [title]);
    
    if (maps.isEmpty || maps[0]['notificationTimes'] == null) {
      return -1;
    }
    
    int itemId = maps[0]['id'];
    List<String> times = maps[0]['notificationTimes'].split(',');
    
    // Check if the time exists in the list
    if (!times.contains(time)) {
      return -1;
    }
    
    return generateNotificationId(itemId, time);
  }

  // Get all notification IDs for a title
  Future<List<int>> getAllNotificationIdsForTitle(String title) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT id, notificationTimes FROM data WHERE title = ?', [title]);
    
    if (maps.isEmpty || maps[0]['notificationTimes'] == null) {
      return [];
    }
    
    int itemId = maps[0]['id'];
    List<String> times = maps[0]['notificationTimes'].split(',');
    List<int> notificationIds = [];
    
    for (String time in times) {
      notificationIds.add(generateNotificationId(itemId, time));
    }
    
    return notificationIds;
  }

  getTitleAndNotificationId() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT id, title, notificationTimes FROM data');
    Map<String, int> resultMap = {};
    for (Map<String, dynamic> map in maps) {
      int notiLength = 0;
      if (map["notificationTimes"] != null) {
        notiLength = map["notificationTimes"].split(',').length;
      } else {}
      int notiId = int.parse("${map["id"] + 1}$notiLength");
      resultMap.addAll({map["title"]: notiId});
    }
    return resultMap;
  }
}

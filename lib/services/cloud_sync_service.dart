import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coramdeo/app/plano_de_vida/data.dart';
import 'package:coramdeo/app/plano_de_vida/provider.dart';
import 'package:coramdeo/services/auth_service.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:coramdeo/utils/notification.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class CloudSyncService {
  static final CloudSyncService _instance = CloudSyncService._internal();
  factory CloudSyncService() => _instance;
  CloudSyncService._internal();

  /// Notificador global disparado sempre que uma restauração de dados é concluída com sucesso.
  static final ValueNotifier<int> onDataRestored = ValueNotifier<int>(0);

  final AuthService _authService = AuthService();
  final PlanoDeVida _planoDeVidaDb = PlanoDeVida();
  FirebaseFirestore? _firestore;

  FirebaseFirestore get _db {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }

  DocumentReference<Map<String, dynamic>>? _getBackupDocRef() {
    final user = _authService.currentUser;
    if (user == null) return null;
    return _db.collection('users').doc(user.uid).collection('backup').doc('data');
  }

  /// Informações sobre o último backup na nuvem
  Future<Map<String, dynamic>?> getLastBackupInfo() async {
    try {
      final docRef = _getBackupDocRef();
      if (docRef == null) return null;

      final snapshot = await docRef.get();
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }

      final data = snapshot.data()!;
      final planoList = (data['plano_de_vida'] as List?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList() ??
          [];
      final prefsMap = data['preferences'] is Map
          ? Map<String, dynamic>.from(data['preferences'] as Map)
          : null;
      final planoHasUserData = hasUserDataInPlano(planoList);
      final prefsHasUserData = hasUserDataInPreferences(prefsMap);

      return {
        'timestamp': data['timestamp'],
        'planoCount': planoList.length,
        'hasUserData': planoHasUserData || prefsHasUserData,
        'version': data['version'] ?? 1,
      };
    } catch (e) {
      debugPrint('Erro ao buscar info de backup na nuvem: $e');
      return null;
    }
  }

  /// Verifica se uma lista de registros do Plano de Vida contém dados reais de uso
  /// (práticas selecionadas, histórico de conclusões, orações customizadas ou lembretes).
  /// Caso contrário, trata-se apenas do modelo padrão de fábrica inicial.
  bool hasUserDataInPlano(List<Map<String, dynamic>> rows) {
    if (rows.isEmpty) return false;
    for (var row in rows) {
      final isCustom = row['isCustom'];
      if (isCustom == 1 || isCustom == true) return true;

      final isSelected = row['isSelected'];
      if (isSelected == 1 || isSelected == true) return true;

      final completedDates = row['completedDates']?.toString().trim();
      if (completedDates != null && completedDates.isNotEmpty) return true;

      final notificationTimes = row['notificationTimes']?.toString().trim();
      if (notificationTimes != null && notificationTimes.isNotEmpty) return true;

      final isNotification = row['isNotification'];
      if (isNotification == 1 || isNotification == true) return true;
    }
    return false;
  }

  /// Verifica se um mapa de preferências contém dados reais customizados pelo usuário.
  bool hasUserDataInPreferences(Map<String, dynamic>? prefs) {
    if (prefs == null || prefs.isEmpty) return false;

    // Orações favoritas
    final favs = prefs[AppConstants.favoritePrayersKey];
    if (favs is List && favs.isNotEmpty) return true;

    // Exame de consciência
    final exame = prefs['exame.itensExame'];
    if (exame is Map && exame.isNotEmpty) return true;
    if (exame is String && exame.trim().isNotEmpty && exame != '{}') return true;

    // Fonte alterada
    final fontSize = prefs[AppConstants.fontSizeKey];
    if (fontSize is num && fontSize.toDouble() != AppConstants.defaultFontSize) return true;

    // Tema ou cor alterados
    final theme = prefs[AppConstants.themeKey];
    if (theme is String && theme != AppConstants.defaultTheme) return true;
    final colorSeed = prefs[AppConstants.colorSeedKey];
    if (colorSeed is num && colorSeed.toInt() != AppConstants.defaultColorSeed) return true;

    // Progresso bíblico
    final chapter = prefs[AppConstants.bibleChapterKey];
    final bookId = prefs[AppConstants.bibleBookIdKey];
    if (chapter is num && chapter.toInt() > 1) return true;
    if (bookId is num && bookId.toInt() > 1) return true;

    // Progresso em livros espirituais
    for (final key in prefs.keys) {
      if (key.startsWith('livros.') && key.endsWith('.currentChapterId')) {
        final ch = prefs[key];
        if (ch is num && ch.toInt() > 0) return true;
      }
    }

    return false;
  }

  /// Verifica se as preferências locais no SharedPreferences contêm dados reais de uso do usuário.
  Future<bool> hasLocalPreferencesUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final favs = prefs.getStringList(AppConstants.favoritePrayersKey);
      if (favs != null && favs.isNotEmpty) return true;

      final exame = prefs.getString('exame.itensExame');
      if (exame != null && exame.trim().isNotEmpty && exame != '{}') return true;

      final fontSize = prefs.getDouble(AppConstants.fontSizeKey);
      if (fontSize != null && fontSize != AppConstants.defaultFontSize) return true;

      final theme = prefs.getString(AppConstants.themeKey);
      if (theme != null && theme != AppConstants.defaultTheme) return true;
      final colorSeed = prefs.getInt(AppConstants.colorSeedKey);
      if (colorSeed != null && colorSeed != AppConstants.defaultColorSeed) return true;

      final chapter = prefs.getInt(AppConstants.bibleChapterKey);
      final bookId = prefs.getInt(AppConstants.bibleBookIdKey);
      if ((chapter != null && chapter > 1) || (bookId != null && bookId > 1)) return true;

      for (final key in prefs.getKeys()) {
        if (key.startsWith('livros.') && key.endsWith('.currentChapterId')) {
          final ch = prefs.getInt(key);
          if (ch != null && ch > 0) return true;
        }
      }
    } catch (e) {
      debugPrint('CloudSyncService: Erro ao verificar preferências locais: $e');
    }
    return false;
  }

  /// Verifica se o banco local do Plano de Vida possui dados ativos do usuário.
  Future<bool> hasLocalPlanoUserData() async {
    try {
      final db = await _planoDeVidaDb.initDb();
      final rows = await db.query('data');
      return hasUserDataInPlano(rows);
    } catch (e) {
      debugPrint('CloudSyncService: Erro ao verificar dados locais do plano: $e');
      return false;
    }
  }

  /// Verifica se o dispositivo possui dados ativos do usuário (no Plano de Vida ou em Preferências).
  Future<bool> hasLocalUserData() async {
    try {
      final planoHasData = await hasLocalPlanoUserData();
      if (planoHasData) return true;

      final prefsHasData = await hasLocalPreferencesUserData();
      if (prefsHasData) return true;

      return false;
    } catch (e) {
      debugPrint('CloudSyncService: Erro ao verificar dados locais: $e');
      return false;
    }
  }

  /// Verifica se a nuvem possui dados de backup e a base local está virgem (sem uso).
  /// Em caso afirmativo, restaura automaticamente para evitar perda de dados no login.
  Future<bool> checkAndRestoreOnLogin() async {
    try {
      final user = _authService.currentUser;
      if (user == null) return false;

      final cloudInfo = await getLastBackupInfo();
      if (cloudInfo == null) return false;

      final cloudCount = (cloudInfo['planoCount'] as int?) ?? 0;
      final cloudHasUserData = (cloudInfo['hasUserData'] as bool?) ?? false;
      if (cloudCount <= 0 && !cloudHasUserData) return false;

      // Verificar se o dispositivo local possui dados reais de uso do usuário
      final localHasData = await hasLocalUserData();

      if (!localHasData) {
        debugPrint(
            'CloudSyncService: Base local virgem e nuvem possui backup ($cloudCount itens, temDados=$cloudHasUserData). '
            'Restaurando automaticamente dados da nuvem...');
        final success = await restoreBackup();
        return success;
      }
    } catch (e) {
      debugPrint('CloudSyncService: Erro ao verificar e restaurar no login: $e');
    }
    return false;
  }

  /// Executa o backup automático diário de forma silenciosa em segundo plano
  Future<void> triggerDailyAutoBackup() async {
    try {
      final user = _authService.currentUser;
      if (user == null) return;

      final prefs = await SharedPreferences.getInstance();
      final isAutoBackupEnabled =
          prefs.getBool(AppConstants.autoBackupKey) ?? AppConstants.defaultAutoBackup;
      if (!isAutoBackupEnabled) return;

      final now = DateTime.now();
      final todayStr = '${now.day}-${now.month}-${now.year}';
      final lastBackupDate = prefs.getString(AppConstants.lastAutoBackupDateKey);

      if (lastBackupDate == todayStr) {
        return; // Já executou o backup automático hoje
      }

      // Trava de segurança: verificar se os dados locais estão vazios mas a nuvem possui backup
      final localHasData = await hasLocalUserData();
      final cloudInfo = await getLastBackupInfo();
      final cloudCount = (cloudInfo?['planoCount'] as int?) ?? 0;
      final cloudHasUserData = (cloudInfo?['hasUserData'] as bool?) ?? false;

      if (!localHasData && (cloudHasUserData || cloudCount > 0)) {
        debugPrint(
            'CloudSyncService: Base local sem dados e nuvem possui backup. '
            'Restaurando em vez de sobrescrever...');
        await restoreBackup();
        await prefs.setString(AppConstants.lastAutoBackupDateKey, todayStr);
        return;
      }

      // Se a base local não possui dados de usuário e a nuvem também não tem nada, não faz upload de template
      if (!localHasData && cloudInfo == null) {
        return;
      }

      await uploadBackup();
      await prefs.setString(AppConstants.lastAutoBackupDateKey, todayStr);
      debugPrint('CloudSyncService: Backup automático diário concluído com sucesso.');
    } catch (e) {
      debugPrint('CloudSyncService: Falha silenciosa no backup automático: $e');
    }
  }

  /// Faz upload de todos os dados locais para a nuvem Firestore
  Future<void> uploadBackup({bool force = false}) async {
    final user = _authService.currentUser;
    if (user == null) {
      throw Exception('Você precisa estar autenticado para realizar o backup na nuvem.');
    }

    final docRef = _getBackupDocRef();
    if (docRef == null) {
      throw Exception('Não foi possível obter a referência de backup.');
    }

    // 1. Coleta SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final allPrefs = <String, dynamic>{};

    // Garante que todas as preferências/configurações do aplicativo estejam presentes com seus valores padrão
    final defaultSettings = <String, dynamic>{
      AppConstants.fontSizeKey: AppConstants.defaultFontSize,
      AppConstants.themeKey: AppConstants.defaultTheme,
      AppConstants.dynamicColorKey: AppConstants.defaultDynamicColor,
      AppConstants.colorSeedKey: AppConstants.defaultColorSeed,
      AppConstants.blockExameKey: AppConstants.defaultBlockExame,
      AppConstants.biometricKey: AppConstants.defaultUseBiometric,
      AppConstants.autoBackupKey: AppConstants.defaultAutoBackup,
      AppConstants.bilingualModeKey: AppConstants.defaultBilingualMode,
      AppConstants.prayerLanguageKey: AppConstants.defaultPrayerLanguage,
      AppConstants.bilingualOrderKey: AppConstants.defaultBilingualOrder,
      AppConstants.openInBilingualModeKey: AppConstants.defaultOpenInBilingualMode,
      AppConstants.showOpusDeiCelebrationsKey: AppConstants.defaultShowOpusDeiCelebrations,
      AppConstants.bibleTestamentKey: AppConstants.defaultTestament,
      AppConstants.bibleBookIdKey: AppConstants.defaultBookId,
      AppConstants.bibleBookKey: AppConstants.defaultBook,
      AppConstants.bibleChapterKey: AppConstants.defaultChapter,
      AppConstants.bibleVersionKey: AppConstants.defaultBibleVersion,
    };
    allPrefs.addAll(defaultSettings);

    for (var key in prefs.getKeys()) {
      // Ignora chaves transitórias ou caches diários de rede
      if (key.startsWith('liturgiaDiaria') ||
          key.startsWith('comentarioDoEvangelho') ||
          key.startsWith('falarComDeus') ||
          key.startsWith('santoDoDia') ||
          key.endsWith('.db_version') ||
          key == AppConstants.lastAutoBackupDateKey) {
        continue;
      }

      final value = prefs.get(key);
      if (value is String || value is int || value is bool || value is double) {
        allPrefs[key] = value;
      } else if (value is List) {
        allPrefs[key] = value.map((e) => e.toString()).toList();
      }
    }

    // 2. Coleta dados do Plano de Vida do SQLite
    List<Map<String, dynamic>> planoData = [];
    try {
      final db = await _planoDeVidaDb.initDb();
      planoData = await db.query('data');
    } catch (e) {
      debugPrint('Erro ao ler plano_de_vida.db: $e');
    }

    // Trava de segurança absoluta: NUNCA sobrescrever backup na nuvem com dados locais virgens/vazios
    if (!force) {
      final localHasData = await hasLocalUserData();
      if (!localHasData) {
        final cloudInfo = await getLastBackupInfo();
        if (cloudInfo != null) {
          final cloudCount = (cloudInfo['planoCount'] as int?) ?? 0;
          final cloudHasUserData = (cloudInfo['hasUserData'] as bool?) ?? false;
          if (cloudHasUserData || cloudCount > 0) {
            debugPrint(
                'CloudSyncService: TRAVA DE SEGURANÇA ATIVADA! '
                'Abortando upload de dados locais padrão para evitar sobrescrever o backup existente na nuvem.');
            return;
          }
        }
      }
    }

    // 3. Monta o pacote de dados
    final backupPayload = {
      'version': 1,
      'timestamp': DateTime.now().toIso8601String(),
      'updatedAt': FieldValue.serverTimestamp(),
      'preferences': allPrefs,
      'plano_de_vida': planoData,
      'userEmail': user.email,
    };

    // 4. Salva no Firestore
    await docRef.set(backupPayload, SetOptions(merge: false));
  }

  /// Sanitiza registros do Plano de Vida garantindo colunas válidas e tipos SQLite estritos.
  List<Map<String, dynamic>> sanitizePlanoRows(List<dynamic> rows) {
    final sanitizedList = <Map<String, dynamic>>[];
    for (var row in rows) {
      if (row is! Map) continue;
      final title = row['title']?.toString().trim() ?? '';
      if (title.isEmpty) continue;

      final sanitized = <String, dynamic>{
        'title': title,
        'isCustom': (row['isCustom'] == 1 || row['isCustom'] == true) ? 1 : 0,
        'isSelected': (row['isSelected'] == 1 || row['isSelected'] == true) ? 1 : 0,
        'isCompleted': (row['isCompleted'] == 1 || row['isCompleted'] == true) ? 1 : 0,
        'isNotification': (row['isNotification'] == 1 || row['isNotification'] == true) ? 1 : 0,
        'notificationTimes': row['notificationTimes']?.toString(),
        'completedDates': row['completedDates']?.toString(),
        'weekdays': row['weekdays']?.toString() ?? '1,2,3,4,5,6,7',
      };
      if (row['id'] != null && row['id'] is num) {
        sanitized['id'] = (row['id'] as num).toInt();
      }
      sanitizedList.add(sanitized);
    }
    return sanitizedList;
  }

  /// Restaura com coerção estrita de tipos para SharedPreferences.
  Future<void> restorePreferencesFromMap(Map<String, dynamic> restoredPrefs) async {
    final prefs = await SharedPreferences.getInstance();
    for (var key in restoredPrefs.keys) {
      final value = restoredPrefs[key];
      if (value == null) continue;

      if (key == AppConstants.fontSizeKey ||
          (key.toLowerCase().contains('fontsize') && value is num)) {
        await prefs.setDouble(key, (value as num).toDouble());
      } else if (key == AppConstants.colorSeedKey ||
          key == AppConstants.bibleBookIdKey ||
          key == AppConstants.bibleChapterKey ||
          key.endsWith('currentChapterId') ||
          (key.endsWith('Id') && value is num) ||
          (key.endsWith('id') && value is num)) {
        await prefs.setInt(key, (value as num).toInt());
      } else if (key == AppConstants.dynamicColorKey ||
          key == AppConstants.blockExameKey ||
          key == AppConstants.biometricKey ||
          key == AppConstants.autoBackupKey ||
          key == AppConstants.bilingualModeKey ||
          key == AppConstants.openInBilingualModeKey ||
          key == AppConstants.showOpusDeiCelebrationsKey ||
          key == AppConstants.onboardingKey) {
        if (value is bool) {
          await prefs.setBool(key, value);
        } else if (value is num) {
          await prefs.setBool(key, value != 0);
        } else if (value is String) {
          await prefs.setBool(key, value.toLowerCase() == 'true');
        }
      } else if (key == 'exame.itensExame') {
        if (value is String) {
          await prefs.setString(key, value);
        } else if (value is Map) {
          await prefs.setString(key, json.encode(value));
        }
      } else if (value is List) {
        await prefs.setStringList(
          key,
          List<String>.from(value.map((e) => e.toString())),
        );
      } else if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      } else if (value is String) {
        await prefs.setString(key, value);
      } else if (value is Map) {
        await prefs.setString(key, json.encode(value));
      }
    }
  }

  /// Restaura os dados da nuvem para o armazenamento local
  Future<bool> restoreBackup() async {
    final user = _authService.currentUser;
    if (user == null) {
      throw Exception('Você precisa estar autenticado para restaurar o backup da nuvem.');
    }

    final docRef = _getBackupDocRef();
    if (docRef == null) {
      throw Exception('Não foi possível obter a referência de backup.');
    }

    final snapshot = await docRef.get();
    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception('Nenhum backup encontrado na nuvem para esta conta.');
    }

    final data = snapshot.data()!;

    // 1. Restaura SharedPreferences
    if (data.containsKey('preferences')) {
      final restoredPrefs = Map<String, dynamic>.from(data['preferences'] as Map);
      await restorePreferencesFromMap(restoredPrefs);
    }

    // 2. Restaura dados do Plano de Vida no SQLite
    if (data.containsKey('plano_de_vida')) {
      await _planoDeVidaDb.ensureWeekdaysColumn();
      final db = await _planoDeVidaDb.initDb();

      final sanitizedRows = sanitizePlanoRows(data['plano_de_vida'] as List);
      await db.transaction((txn) async {
        await txn.delete('data');
        for (var row in sanitizedRows) {
          await txn.insert(
            'data',
            row,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });

      // 3. Reagenda notificações
      try {
        await Notifier.verifyNotificationPermission();
        final provider = PlanoDeVidaProvider();
        await provider.rescheduleAllNotifications();
      } catch (e) {
        debugPrint('Erro ao reagendar notificações pós-restauração: $e');
      }
    }

    // 4. Notifica todos os provedores em tempo real
    onDataRestored.value++;

    return true;
  }
}


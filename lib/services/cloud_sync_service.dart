import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coramdeo/app/plano_de_vida/data.dart';
import 'package:coramdeo/app/plano_de_vida/provider.dart';
import 'package:coramdeo/services/auth_service.dart';
import 'package:coramdeo/utils/notification.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CloudSyncService {
  static final CloudSyncService _instance = CloudSyncService._internal();
  factory CloudSyncService() => _instance;
  CloudSyncService._internal();

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
      return {
        'timestamp': data['timestamp'],
        'planoCount': (data['plano_de_vida'] as List?)?.length ?? 0,
        'version': data['version'] ?? 1,
      };
    } catch (e) {
      debugPrint('Erro ao buscar info de backup na nuvem: $e');
      return null;
    }
  }

  /// Faz upload de todos os dados locais para a nuvem Firestore
  Future<void> uploadBackup() async {
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
    for (var key in prefs.getKeys()) {
      // Ignora chave de onboarding se desejado, ou salva tudo
      final value = prefs.get(key);
      if (value is String || value is int || value is bool || value is double || value is List<String>) {
        allPrefs[key] = value;
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
    final prefs = await SharedPreferences.getInstance();
    if (data.containsKey('preferences')) {
      final restoredPrefs = Map<String, dynamic>.from(data['preferences'] as Map);
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

    // 2. Restaura dados do Plano de Vida no SQLite
    if (data.containsKey('plano_de_vida')) {
      await _planoDeVidaDb.ensureWeekdaysColumn();
      final db = await _planoDeVidaDb.initDb();

      await db.transaction((txn) async {
        await txn.delete('data');
        List<dynamic> rows = data['plano_de_vida'];
        for (var row in rows) {
          await txn.insert('data', Map<String, dynamic>.from(row as Map));
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

    return true;
  }
}


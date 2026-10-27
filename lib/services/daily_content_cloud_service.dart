import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Serviço de consumo do Pipeline de Conteúdo Diário na Nuvem (v1.0.12).
/// Busca o JSON pré-processado (Liturgia Diária, Comentário do Evangelho e Falar com Deus)
/// a partir do endpoint estático na nuvem ou coleção `daily_content` no Firestore,
/// compartilhando a resposta em memória para carregamento instantâneo (~1s).
class DailyContentCloudService {
  DailyContentCloudService._();
  static final DailyContentCloudService instance = DailyContentCloudService._();

  static const String _firebaseHostingBaseUrl =
      'https://coramdeo-app.web.app/api';
  static const String _githubContentBaseUrl =
      'https://raw.githubusercontent.com/Bilhao/Coram-Deo/daily-content/api';

  final Map<String, Map<String, dynamic>> _memoryCache = {};
  final Map<String, Future<Map<String, dynamic>?>> _inFlightRequests = {};

  String _formatDateIso(int day, int month, int year) {
    final m = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    return '$year-$m-$d';
  }

  /// Obtém o payload completo do dia (`liturgia`, `comentario_evangelho`, `falar_com_deus`).
  Future<Map<String, dynamic>?> fetchDailyPayload({
    required int day,
    required int month,
    required int year,
  }) async {
    final isoDate = _formatDateIso(day, month, year);
    if (_memoryCache.containsKey(isoDate)) {
      return _memoryCache[isoDate];
    }

    if (_inFlightRequests.containsKey(isoDate)) {
      return await _inFlightRequests[isoDate];
    }

    final future = _fetchInternal(day: day, month: month, year: year, isoDate: isoDate);
    _inFlightRequests[isoDate] = future;
    try {
      final result = await future;
      if (result != null && result.isNotEmpty) {
        _memoryCache[isoDate] = result;
      }
      return result;
    } finally {
      _inFlightRequests.remove(isoDate);
    }
  }

  Future<Map<String, dynamic>?> _fetchInternal({
    required int day,
    required int month,
    required int year,
    required String isoDate,
  }) async {
    final now = DateTime.now();
    final isToday =
        day == now.day && month == now.month && year == now.year;

    // 1. Tenta carregar do JSON estático pré-processado (Firebase Hosting / GitHub CDN)
    final urls = <String>[
      '$_githubContentBaseUrl/$isoDate.json',
      if (isToday) '$_githubContentBaseUrl/hoje.json',
      '$_firebaseHostingBaseUrl/$isoDate.json',
      if (isToday) '$_firebaseHostingBaseUrl/hoje.json',
    ];

    for (final url in urls) {
      try {
        final response = await http
            .get(Uri.parse(url))
            .timeout(const Duration(milliseconds: 2200));
        if (response.statusCode == 200 && response.body.isNotEmpty) {
          final decoded = jsonDecode(utf8.decode(response.bodyBytes));
          if (decoded is Map<String, dynamic>) {
            final payloadDate = decoded['isoDate'] as String?;
            if (payloadDate == null || payloadDate == isoDate) {
              return decoded;
            }
          }
        }
      } catch (_) {
        // Continua silenciosamente para o próximo espelho ou fallback
      }
    }

    // 2. Tenta carregar do Cloud Firestore (coleção pública `daily_content`)
    try {
      final doc = await FirebaseFirestore.instance
          .collection('daily_content')
          .doc(isoDate)
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(const Duration(milliseconds: 2200));
      if (doc.exists && doc.data() != null) {
        return doc.data()!;
      }
    } catch (e) {
      debugPrint('DailyContentCloudService Firestore fallback: $e');
    }

    return null;
  }

  Future<Map<String, dynamic>?> fetchLiturgia({
    required int day,
    required int month,
    required int year,
  }) async {
    final payload =
        await fetchDailyPayload(day: day, month: month, year: year);
    final liturgia = payload?['liturgia'];
    if (liturgia is Map<String, dynamic> &&
        (liturgia['liturgia']?.toString().isNotEmpty ?? false)) {
      return liturgia;
    }
    return null;
  }

  Future<Map<String, dynamic>?> fetchComentarioEvangelho({
    required int day,
    required int month,
    required int year,
  }) async {
    final payload =
        await fetchDailyPayload(day: day, month: month, year: year);
    final comentario = payload?['comentario_evangelho'];
    if (comentario is Map<String, dynamic> &&
        (comentario['evangelho']?.toString().isNotEmpty ?? false)) {
      return comentario;
    }
    return null;
  }

  Future<Map<String, dynamic>?> fetchFalarComDeus({
    required int day,
    required int month,
    required int year,
  }) async {
    final payload =
        await fetchDailyPayload(day: day, month: month, year: year);
    final fcd = payload?['falar_com_deus'];
    if (fcd is Map<String, dynamic> &&
        (fcd['title'] is List && (fcd['title'] as List).isNotEmpty)) {
      return fcd;
    }
    return null;
  }
}

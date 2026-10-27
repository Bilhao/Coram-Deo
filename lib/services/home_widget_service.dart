import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/services/computus_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Serviço de sincronização com os Widgets de Tela Inicial do Android (v1.1.1):
/// 1. Widget do Santo e Tempo Litúrgico do Dia
/// 2. Widget Interativo do Plano de Vida
class HomeWidgetService {
  HomeWidgetService._();
  static final HomeWidgetService instance = HomeWidgetService._();

  static const MethodChannel _channel = MethodChannel(
    'com.bilhao.coramdeo/home_widgets',
  );

  /// Atualiza os metadados do Santo do Dia e Tempo Litúrgico e dispara refresh do AppWidget.
  Future<void> syncSaintAndLiturgyWidget({
    required String saintName,
    required String saintSubtitle,
    required String localImagePath,
  }) async {
    if (kIsWeb) return;
    try {
      final now = DateTime.now();
      final litDay = ComputusEngine.getLiturgicalDay(now);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('widget_saint_name', saintName);
      await prefs.setString('widget_saint_subtitle', saintSubtitle);
      await prefs.setString('widget_saint_image_path', localImagePath);
      await prefs.setString(
        'widget_liturgical_season',
        litDay.season.displayName,
      );
      await prefs.setString(
        'widget_liturgical_color_name',
        litDay.color.displayName,
      );
      await prefs.setInt(
        'widget_liturgical_color_hex',
        litDay.color.colorValue.toARGB32(),
      );
      await _channel.invokeMethod('updateHomeWidgets');
    } catch (e) {
      debugPrint('HomeWidgetService.syncSaintAndLiturgyWidget: $e');
    }
  }

  /// Dispara atualização imediata do AppWidget do Plano de Vida no Android.
  Future<void> refreshPlanoDeVidaWidget() async {
    if (kIsWeb) return;
    try {
      await _channel.invokeMethod('updateHomeWidgets');
    } catch (e) {
      debugPrint('HomeWidgetService.refreshPlanoDeVidaWidget: $e');
    }
  }
}

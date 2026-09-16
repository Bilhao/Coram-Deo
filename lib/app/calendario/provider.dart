import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/services/computus_engine.dart';
import 'package:coramdeo/utils/base_provider.dart';

class CalendarioLiturgicoProvider extends BaseProvider {
  CalendarioLiturgicoProvider() {
    _initPreferences();
  }

  DateTime _selectedDate = DateTime.now();
  String _viewMode = 'diaria'; // 'diaria', 'semanal', 'mensal'
  final Map<String, LiturgicalDay> _dayCache = {};

  DateTime get selectedDate => _selectedDate;
  String get viewMode => _viewMode;

  LiturgicalDay get todayDay => getDay(DateTime.now());
  LiturgicalDay get currentSelectedDay => getDay(_selectedDate);

  Future<void> _initPreferences() async {
    await safePrefOperation((prefs) async {
      final savedMode = prefs.getString('calendario_view_mode');
      if (savedMode != null && ['diaria', 'semanal', 'mensal'].contains(savedMode)) {
        _viewMode = savedMode;
        notifyListeners();
      }
      return true;
    }, errorContext: 'Loading calendar view mode');
  }

  /// Seleciona uma nova data no calendário.
  void selectDate(DateTime date) {
    _selectedDate = DateTime(date.year, date.month, date.day);
    notifyListeners();
  }

  /// Retorna a data para o dia de hoje.
  void resetToToday() {
    _selectedDate = DateTime.now();
    notifyListeners();
  }

  /// Altera o modo de visualização ('diaria', 'semanal', 'mensal') e persiste a escolha.
  Future<void> setViewMode(String mode) async {
    if (_viewMode == mode) return;
    _viewMode = mode;
    notifyListeners();

    await safePrefOperation((prefs) async {
      await prefs.setString('calendario_view_mode', mode);
      return true;
    }, errorContext: 'Saving calendar view mode');
  }

  /// Obtém o dia litúrgico canônico para uma data específica.
  LiturgicalDay getDay(DateTime date) {
    final key = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    if (!_dayCache.containsKey(key)) {
      _dayCache[key] = ComputusEngine.getLiturgicalDay(date);
    }
    return _dayCache[key]!;
  }

  /// Retorna os 7 dias da semana litúrgica (Domingo a Sábado).
  List<LiturgicalDay> getWeek(DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    // No calendário litúrgico católico, a semana se inicia no Domingo
    final daysSinceSunday = dateOnly.weekday % 7; // Domingo = 7 % 7 = 0
    final firstDayOfWeek = dateOnly.subtract(Duration(days: daysSinceSunday));

    final week = <LiturgicalDay>[];
    for (int i = 0; i < 7; i++) {
      final current = firstDayOfWeek.add(Duration(days: i));
      week.add(getDay(current));
    }
    return week;
  }

  /// Retorna todos os dias do mês de uma determinada data.
  List<LiturgicalDay> getMonth(DateTime date) {
    final year = date.year;
    final month = date.month;
    final daysInMonth = DateTime(year, month + 1, 0).day;

    final days = <LiturgicalDay>[];
    for (int d = 1; d <= daysInMonth; d++) {
      days.add(getDay(DateTime(year, month, d)));
    }
    return days;
  }
}


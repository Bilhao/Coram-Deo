import 'package:coramdeo/app/plano_de_vida/data.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/notification.dart';

class PlanoDeVidaProvider extends BaseProvider {
  PlanoDeVida pdvDb = PlanoDeVida();

  List<String> _titles = [];
  List<String> _titlesIsCustom = [];
  List<String> _titlesIsSelected = [];
  List<String> _titlesIsCompleted = [];
  List<String> _titlesIsCompletedToday = [];
  List<String> _titlesIsNotification = [];
  Map<String, dynamic> _notificationTimes = {};
  Map<String, dynamic> _completedDates = {};
  Map<String, dynamic> _weekdays = {};
  Map<String, int> _notificationId = {};
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _day = DateTime.now().day;
  String _date = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

  List<String> get titles => _titles;
  List<String> get titlesIsCustom => _titlesIsCustom;
  List<String> get titlesIsSelected => _titlesIsSelected;
  List<String> get titlesIsCompleted => _titlesIsCompleted;
  List<String> get titlesIsCompletedToday => _titlesIsCompletedToday;
  List<String> get titlesIsNotification => _titlesIsNotification;
  Map<String, dynamic> get notificationTimes => _notificationTimes;
  Map<String, dynamic> get completedDates => _completedDates;
  Map<String, dynamic> get weekdays => _weekdays;
  Map<String, int> get notificationId => _notificationId;
  int get year => _year;
  int get month => _month;
  int get day => _day;
  String get date => _date;

  PlanoDeVidaProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    setLoading(true);

    await safeAsync(() async {
      _titles = await pdvDb.getAllTitles();
      _titlesIsCustom = await pdvDb.getTitleisCustom();
      _titlesIsSelected = await pdvDb.getTitleisSelected();
      _titlesIsCompleted = await pdvDb.getTitleisCompleted("$_day/$_month/$_year");
      _titlesIsCompletedToday = await pdvDb.getTitleisCompleted(date);
      _titlesIsNotification = await pdvDb.getTitleisNotification();
      _notificationTimes = await pdvDb.getTitleAndNotificationTimes();
      _completedDates = await pdvDb.getTitleAndCompletedDates();
      _weekdays = await pdvDb.getTitleAndWeekdays();
      _notificationId = await pdvDb.getTitleAndNotificationId();

      return true;
    }, errorContext: 'Loading life plan data');

    _updateDateTime();
    setLoading(false);
  }

  void _updateDateTime() {
    _year = DateTime.now().year;
    _month = DateTime.now().month;
    _day = DateTime.now().day;
    _date = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    notifyListeners();
  }

  Future<void> update() async {
    setLoading(true);

    await safeAsync(() async {
      _titles = await pdvDb.getAllTitles();
      _titlesIsCustom = await pdvDb.getTitleisCustom();
      _titlesIsSelected = await pdvDb.getTitleisSelected();
      _titlesIsCompleted = await pdvDb.getTitleisCompleted("$_day/$_month/$_year");
      _titlesIsCompletedToday = await pdvDb.getTitleisCompleted(date);
      _titlesIsNotification = await pdvDb.getTitleisNotification();
      _notificationTimes = await pdvDb.getTitleAndNotificationTimes();
      _completedDates = await pdvDb.getTitleAndCompletedDates();
      _weekdays = await pdvDb.getTitleAndWeekdays();
      _notificationId = await pdvDb.getTitleAndNotificationId();
      notifyListeners();
      return true;
    }, errorContext: 'Updating life plan data');

    setLoading(false);
  }

  Future<void> changeDate(int year, int month, int day) async {
    _year = year;
    _month = month;
    _day = day;
    await update();
    notifyListeners();
  }

  Future<void> addItem(String title, int isCustom, int isSelected, int isCompleted, int isNotification) async {
    if (title.trim().isEmpty) return;

    await safeAsync(() async {
      await pdvDb.insertNewItem(title, isCustom, isSelected, isCompleted, isNotification);
      await update();
      return true;
    }, errorContext: 'Adding life plan item');
  }

  Future<void> removeItem(String title) async {
    await safeAsync(() async {
      // Cancel all notifications for this title before deleting
      List<int> notificationIds = await getAllNotificationIdsForTitle(title);
      for (int id in notificationIds) {
        await Notifier.stopNotification(id);
      }

      await pdvDb.deleteItem(title);
      await update();
      return true;
    }, errorContext: 'Removing life plan item');
  }

  Future<void> toggleItemSelection(String title) async {
    await safeAsync(() async {
      await pdvDb.toggleisSelected(title);
      await update();
      return true;
    }, errorContext: 'Toggling item selection');
  }

  Future<void> toggleItemCompletion(String title) async {
    await safeAsync(() async {
      if (!await pdvDb.getIsCompleted(title)) {
        await insertCompletedDate(title, _date);
      } else {
        if (_completedDates[title]?.contains(_date) == true) {
          await deleteCompletedDate(title, _date);
        }
      }
      await update();
      return true;
    }, errorContext: 'Toggling item completion');
  }

  Future<void> activateItemNotification(String title) async {
    await safeAsync(() async {
      await pdvDb.activateisNotification(title);
      await update();
      return true;
    }, errorContext: 'Activating item notification');
  }

  Future<void> deactivateItemNotification(String title) async {
    await safeAsync(() async {
      await pdvDb.deactivateisNotification(title);
      await update();
      return true;
    }, errorContext: 'Deactivating item notification');
  }

  Future<void> insertNotificationTime(String title, String notificationTime) async {
    await safeAsync(() async {
      if (!(_notificationTimes[title] ?? "").split(",").contains(notificationTime)) {
        await pdvDb.insertNotificationTime(title, notificationTime);
        await update();
      }
      return true;
    }, errorContext: 'Inserting notification time');
  }

  Future<void> deleteNotificationTime(String title, String notificationTime) async {
    await safeAsync(() async {
      await pdvDb.deleteNotificationTime(title, notificationTime);
      await update();
      return true;
    }, errorContext: 'Deleting notification time');
  }

  // Get notification ID for specific time
  Future<int> getNotificationIdForTime(String title, String time) async {
    return await pdvDb.getNotificationIdForTime(title, time);
  }

  // Get all notification IDs for a title (used when deleting all notifications for an item)
  Future<List<int>> getAllNotificationIdsForTitle(String title) async {
    return await pdvDb.getAllNotificationIdsForTitle(title);
  }

  Future<void> insertCompletedDate(String title, String completedDate) async {
    await safeAsync(() async {
      if (!(_completedDates[title] ?? "").split(",").contains(completedDate)) {
        await pdvDb.insertCompletedDate(title, completedDate);
        await update();
      }
      return true;
    }, errorContext: 'Inserting completed date');
  }

  Future<void> deleteCompletedDate(String title, String completedDate) async {
    await safeAsync(() async {
      await pdvDb.deleteCompletedDate(title, completedDate);
      await update();
      return true;
    }, errorContext: 'Deleting completed date');
  }

  Future<void> updateItemWeekdays(String title, List<bool> weekdaySelection) async {
    await safeAsync(() async {
      // Convert boolean list to string representation (1-based indexing for weekdays)
      List<String> selectedDays = [];
      for (int i = 0; i < weekdaySelection.length; i++) {
        if (weekdaySelection[i]) {
          selectedDays.add((i + 1).toString()); // 1=Monday, 2=Tuesday, etc.
        }
      }
      // If no days selected, default to all days
      String weekdaysString = selectedDays.isEmpty ? "1,2,3,4,5,6,7" : selectedDays.join(',');
      await pdvDb.updateWeekdays(title, weekdaysString);
      await update();
      notifyListeners();
      return true;
    }, errorContext: 'Updating item weekdays');
  }

  List<bool> getItemWeekdays(String title) {
    String weekdaysString = _weekdays[title] ?? "1,2,3,4,5,6,7";
    if (weekdaysString.isEmpty) weekdaysString = "1,2,3,4,5,6,7";

    List<String> selectedDays = weekdaysString.split(',').where((s) => s.isNotEmpty).toList();
    List<bool> weekdaySelection = List.filled(7, false);

    for (String day in selectedDays) {
      int? dayIndex = int.tryParse(day.trim());
      if (dayIndex != null && dayIndex >= 1 && dayIndex <= 7) {
        // Map: 1=Monday (0), ..., 7=Sunday (6)
        weekdaySelection[dayIndex == 7 ? 6 : dayIndex - 1] = true;
      }
    }
    return weekdaySelection;
  }

  List<String> getTodaysItems() {
    int currentWeekday = DateTime.now().weekday; // 1=Monday, 7=Sunday
    int weekdayIndex = currentWeekday == 7 ? 6 : currentWeekday - 1;
    List<String> todaysItems = [];

    for (String title in _titlesIsSelected) {
      List<bool> weekdaySelection = getItemWeekdays(title);
      if (weekdaySelection[weekdayIndex]) {
        todaysItems.add(title);
      }
    }
    return todaysItems;
  }

  // New methods for progress tracking

  /// Get completion percentage for a specific item in the current week
  double getItemCompletionPercentageWeek(String title) {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday; // 1=Monday, 7=Sunday
    DateTime weekStart = now.subtract(Duration(days: currentWeekday - 1));
    int completedDays = 0;
    int totalDays = 0;
    List<bool> weekdaySelection = getItemWeekdays(title);
    String completedDatesString = _completedDates[title] ?? "";
    Set<String> completedDates = completedDatesString.split(',').toSet();
    for (int i = 0; i < 7; i++) {
      DateTime checkDate = weekStart.add(Duration(days: i));
      int weekdayIdx = checkDate.weekday - 1;
      if (weekdaySelection[weekdayIdx]) {
        totalDays++;
        String dateString = "${checkDate.day}/${checkDate.month}/${checkDate.year}";
        if (completedDates.contains(dateString)) completedDays++;
      }
    }
    return totalDays > 0 ? (completedDays / totalDays) * 100 : 0.0;
  }

  /// Get completion percentage for a specific item in the current month
  double getItemCompletionPercentageMonth(String title) {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int completedDays = 0;
    int totalDays = 0;
    List<bool> weekdaySelection = getItemWeekdays(title);
    int daysInMonth = DateTime(year, month + 1, 0).day;
    String completedDatesString = _completedDates[title] ?? "";
    Set<String> completedDates = completedDatesString.split(',').toSet();
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime checkDate = DateTime(year, month, i);
      int weekdayIdx = checkDate.weekday - 1;
      if (weekdaySelection[weekdayIdx]) {
        totalDays++;
        String dateString = "${checkDate.day}/${checkDate.month}/${checkDate.year}";
        if (completedDates.contains(dateString)) completedDays++;
      }
    }
    return totalDays > 0 ? (completedDays / totalDays) * 100 : 0.0;
  }

  /// Get completion percentage for a specific item in the current year
  double getItemCompletionPercentageYear(String title) {
    DateTime now = DateTime.now();
    int year = now.year;
    int completedDays = 0;
    int totalDays = 0;
    List<bool> weekdaySelection = getItemWeekdays(title);
    String completedDatesString = _completedDates[title] ?? "";
    Set<String> completedDates = completedDatesString.split(',').toSet();
    for (int m = 1; m <= 12; m++) {
      int daysInMonth = DateTime(year, m + 1, 0).day;
      for (int d = 1; d <= daysInMonth; d++) {
        DateTime checkDate = DateTime(year, m, d);
        int weekdayIdx = checkDate.weekday - 1;
        if (weekdaySelection[weekdayIdx]) {
          totalDays++;
          String dateString = "${checkDate.day}/${checkDate.month}/${checkDate.year}";
          if (completedDates.contains(dateString)) completedDays++;
        }
      }
    }
    return totalDays > 0 ? (completedDays / totalDays) * 100 : 0.0;
  }

  /// Get current streak for an item (consecutive days completed)
  int getItemCurrentStreak(String title) {
    int streak = 0;
    DateTime now = DateTime.now();

    // Check backwards from today
    for (int i = 0; i < 365; i++) {
      // Max 365 days to prevent infinite loop
      DateTime checkDate = now.subtract(Duration(days: i));
      String dateString = "${checkDate.day}/${checkDate.month}/${checkDate.year}";

      if ((_completedDates[title] ?? "").contains(dateString)) {
        streak++;
      } else {
        break; // Streak broken
      }
    }

    return streak;
  }

  /// Get total completed days for an item
  int getItemTotalCompletedDays(String title) {
    String completedDatesString = _completedDates[title] ?? "";
    if (completedDatesString.isEmpty) return 0;

    return completedDatesString.split(',').where((date) => date.isNotEmpty).length;
  }

  /// Get completion data for the last 30 days for charts
  Map<String, double> getItemLast30DaysData(String title) {
    Map<String, double> data = {};
    DateTime now = DateTime.now();

    for (int i = 29; i >= 0; i--) {
      DateTime checkDate = now.subtract(Duration(days: i));
      String dateString = "${checkDate.day}/${checkDate.month}";
      String fullDateString = "${checkDate.day}/${checkDate.month}/${checkDate.year}";

      bool completed = (_completedDates[title] ?? "").contains(fullDateString);
      data[dateString] = completed ? 1.0 : 0.0;
    }

    return data;
  }

  /// Get weekly completion summary for the current month (primeira, segunda, terceira, quarta semana)
  List<Map<String, dynamic>> getMonthlyWeekCompletionSummary(String title) {
    List<Map<String, dynamic>> weeks = [];
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int daysInMonth = DateTime(year, month + 1, 0).day;
    List<bool> weekdaySelection = getItemWeekdays(title);

    String completedDatesString = _completedDates[title] ?? "";
    Set<String> completedDates = completedDatesString.split(',').toSet();

    int weekCount = ((daysInMonth - 1) ~/ 7) + 1; // número de semanas (4 ou 5)
    for (int w = 0; w < weekCount; w++) {
      int startDay = w * 7 + 1;
      int endDay = ((w + 1) * 7);
      if (endDay > daysInMonth) endDay = daysInMonth;
      int totalPossibleDays = 0;
      Set<String> weekDates = {};
      for (int d = startDay; d <= endDay; d++) {
        DateTime checkDate = DateTime(year, month, d);
        int weekdayIdx = checkDate.weekday - 1;
        if (weekdaySelection[weekdayIdx]) {
          totalPossibleDays++;
          String dateString = "${checkDate.day}/${checkDate.month}/${checkDate.year}";
          weekDates.add(dateString);
        }
      }
      int completedDays = weekDates.intersection(completedDates).length;
      String weekLabel = "${w + 1}º semana do mês";
      weeks.add({
        'week': weekLabel,
        'completed': completedDays,
        'total': totalPossibleDays,
        'percentage': totalPossibleDays > 0 ? (completedDays / totalPossibleDays) * 100 : 0.0,
      });
    }
    return weeks;
  }

  /// Get monthly completion summary for the last 3 months
  List<Map<String, dynamic>> getLast3MonthsCompletionSummary(String title) {
    List<Map<String, dynamic>> months = [];
    DateTime now = DateTime.now();
    List<bool> weekdaySelection = getItemWeekdays(title);
    String completedDatesString = _completedDates[title] ?? "";
    Set<String> completedDates = completedDatesString.split(',').toSet();
    for (int m = 0; m < 3; m++) {
      DateTime monthDate = DateTime(now.year, now.month - m, 1);
      int year = monthDate.year;
      int month = monthDate.month;
      int daysInMonth = DateTime(year, month + 1, 0).day;
      int totalPossibleDays = 0;
      Set<String> monthDates = {};
      for (int d = 1; d <= daysInMonth; d++) {
        DateTime checkDate = DateTime(year, month, d);
        int weekdayIdx = checkDate.weekday - 1;
        if (weekdaySelection[weekdayIdx]) {
          totalPossibleDays++;
          String dateString = "${checkDate.day}/${checkDate.month}/${checkDate.year}";
          monthDates.add(dateString);
        }
      }
      int completedDays = monthDates.intersection(completedDates).length;
      String monthLabel = m == 0
          ? "Este mês"
          : m == 1
              ? "Mês passado"
              : "Há 2 meses";
      months.add({
        'month': monthLabel,
        'completed': completedDays,
        'total': totalPossibleDays,
        'percentage': totalPossibleDays > 0 ? (completedDays / totalPossibleDays) * 100 : 0.0,
      });
    }
    return months;
  }

  /// Get yearly completion summary for the last 2 years
  List<Map<String, dynamic>> getLast2YearsCompletionSummary(String title) {
    List<Map<String, dynamic>> years = [];
    DateTime now = DateTime.now();
    List<bool> weekdaySelection = getItemWeekdays(title);
    String completedDatesString = _completedDates[title] ?? "";
    Set<String> completedDates = completedDatesString.split(',').toSet();
    for (int y = 0; y < 2; y++) {
      int year = now.year - y;
      int totalPossibleDays = 0;
      Set<String> yearDates = {};
      for (int m = 1; m <= 12; m++) {
        int daysInMonth = DateTime(year, m + 1, 0).day;
        for (int d = 1; d <= daysInMonth; d++) {
          DateTime checkDate = DateTime(year, m, d);
          int weekdayIdx = checkDate.weekday - 1;
          if (weekdaySelection[weekdayIdx]) {
            totalPossibleDays++;
            String dateString = "${checkDate.day}/${checkDate.month}/${checkDate.year}";
            yearDates.add(dateString);
          }
        }
      }
      int completedDays = yearDates.intersection(completedDates).length;
      String yearLabel = y == 0 ? "Este ano" : "Ano passado";
      years.add({
        'year': yearLabel,
        'completed': completedDays,
        'total': totalPossibleDays,
        'percentage': totalPossibleDays > 0 ? (completedDays / totalPossibleDays) * 100 : 0.0,
      });
    }
    return years;
  }
}

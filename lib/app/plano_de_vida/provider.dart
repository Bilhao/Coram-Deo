import 'package:flutter/material.dart';
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
        weekdaySelection[dayIndex - 1] = true; // Convert to 0-based indexing
      }
    }
    return weekdaySelection;
  }

  List<String> getTodaysItems() {
    int currentWeekday = DateTime.now().weekday; // 1=Monday, 7=Sunday
    List<String> todaysItems = [];
    
    for (String title in _titlesIsSelected) {
      String weekdaysString = _weekdays[title] ?? "1,2,3,4,5,6,7";
      if (weekdaysString.isEmpty) weekdaysString = "1,2,3,4,5,6,7";
      
      List<String> selectedDays = weekdaysString.split(',').where((s) => s.isNotEmpty).toList();
      if (selectedDays.contains(currentWeekday.toString())) {
        todaysItems.add(title);
      }
    }
    return todaysItems;
  }

  // New methods for progress tracking
  
  /// Get completion percentage for a specific item over the last N days
  double getItemCompletionPercentage(String title, int days) {
    int completedDays = 0;
    DateTime now = DateTime.now();
    
    for (int i = 0; i < days; i++) {
      DateTime checkDate = now.subtract(Duration(days: i));
      String dateString = "${checkDate.day}/${checkDate.month}/${checkDate.year}";
      
      if ((_completedDates[title] ?? "").contains(dateString)) {
        completedDays++;
      }
    }
    
    return days > 0 ? (completedDays / days) * 100 : 0.0;
  }

  /// Get current streak for an item (consecutive days completed)
  int getItemCurrentStreak(String title) {
    int streak = 0;
    DateTime now = DateTime.now();
    
    // Check backwards from today
    for (int i = 0; i < 365; i++) { // Max 365 days to prevent infinite loop
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

  /// Get weekly completion summary (last 4 weeks)
  List<Map<String, dynamic>> getWeeklyCompletionSummary(String title) {
    List<Map<String, dynamic>> weeks = [];
    DateTime now = DateTime.now();
    
    for (int week = 0; week < 4; week++) {
      // Calculate the start of each week (Monday)
      // week = 0 is current week, week = 1 is last week, etc.
      DateTime weekStart = now.subtract(Duration(days: (week * 7) + (now.weekday - 1)));
      int completedDays = 0;
      int totalPossibleDays = 0;
      
      // Get the item's weekday selection
      List<bool> weekdaySelection = getItemWeekdays(title);
      
      for (int day = 0; day < 7; day++) {
        DateTime checkDate = weekStart.add(Duration(days: day));
        
        // Only count days that are selected for this item
        if (weekdaySelection[day]) {
          totalPossibleDays++;
          String dateString = "${checkDate.day}/${checkDate.month}/${checkDate.year}";
          
          if ((_completedDates[title] ?? "").contains(dateString)) {
            completedDays++;
          }
        }
      }
      
      // If no days are selected for this week, set total to 1 to avoid division by zero
      if (totalPossibleDays == 0) totalPossibleDays = 1;
      
      weeks.add({
        'week': week == 0 ? 'Esta semana' : 'Há ${week} semana${week > 1 ? 's' : ''}',
        'completed': completedDays,
        'total': totalPossibleDays,
        'percentage': (completedDays / totalPossibleDays) * 100,
      });
    }
    
    return weeks; // Keep chronological order (current week first)
  }
}

import 'package:flutter/material.dart';
import 'package:coramdeo/models/plano_de_vida.dart';

class PlanoDeVidaProvider with ChangeNotifier {
  PlanoDeVida pdvDb = PlanoDeVida();

  List<String> _titles = [];
  List<String> _titlesIsCustom = [];
  List<String> _titlesIsSelected = [];
  List<String> _titlesIsCompleted = [];
  List<String> _titlesIsCompletedToday = [];
  List<String> _titlesIsNotification = [];
  Map<String, dynamic> _notificationTimes = {};
  Map<String, dynamic> _completedDates = {};
  Map<String, int> _notificationId = {};
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _day = DateTime.now().day;
  String _date =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

  List<String> get titles => _titles;
  List<String> get titlesIsCustom => _titlesIsCustom;
  List<String> get titlesIsSelected => _titlesIsSelected;
  List<String> get titlesIsCompleted => _titlesIsCompleted;
  List<String> get titlesIsCompletedToday => _titlesIsCompletedToday;
  List<String> get titlesIsNotification => _titlesIsNotification;
  Map<String, dynamic> get notificationTimes => _notificationTimes;
  Map<String, dynamic> get completedDates => _completedDates;
  Map<String, int> get notificationId => _notificationId;
  int get year => _year;
  int get month => _month;
  int get day => _day;
  String get date => _date;

  PlanoDeVidaProvider() {
    init();
  }

  init() async {
    _titles = await pdvDb.getAllTitles();
    _titlesIsCustom = await pdvDb.getTitleisCustom();
    _titlesIsSelected = await pdvDb.getTitleisSelected();
    _titlesIsCompleted =
        await pdvDb.getTitleisCompleted("$_day/$_month/$_year");
    _titlesIsCompletedToday = await pdvDb.getTitleisCompleted(date);
    _titlesIsNotification = await pdvDb.getTitleisNotification();
    _notificationTimes = await pdvDb.getTitleAndNotificationTimes();
    _completedDates = await pdvDb.getTitleAndCompletedDates();
    _notificationId = await pdvDb.getTitleAndNotificationId();
    _year = DateTime.now().year;
    _month = DateTime.now().month;
    _day = DateTime.now().day;
    _date =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    notifyListeners();
  }

  update() async {
    _titles = await pdvDb.getAllTitles();
    _titlesIsCustom = await pdvDb.getTitleisCustom();
    _titlesIsSelected = await pdvDb.getTitleisSelected();
    _titlesIsCompleted =
        await pdvDb.getTitleisCompleted("$_day/$_month/$_year");
    _titlesIsCompletedToday = await pdvDb.getTitleisCompleted(date);
    _titlesIsNotification = await pdvDb.getTitleisNotification();
    _notificationTimes = await pdvDb.getTitleAndNotificationTimes();
    _completedDates = await pdvDb.getTitleAndCompletedDates();
    _notificationId = await pdvDb.getTitleAndNotificationId();
    notifyListeners();
  }

  changeDate(int year, int month, int day) {
    _year = year;
    _month = month;
    _day = day;
    update();
    notifyListeners();
  }

  addItem(String title, int isCustom, int isSelected, int isCompleted,
      int isNotification) async {
    await pdvDb.insertNewItem(
        title, isCustom, isSelected, isCompleted, isNotification);
    update();
  }

  removeItem(String title) async {
    await pdvDb.deleteItem(title);
    update();
  }

  toggleItemSelection(String title) async {
    await pdvDb.toggleisSelected(title);
    update();
  }

  toggleItemCompletion(String title) async {
    if (!await pdvDb.getIsCompleted(title)) {
      insertCompletedDate(title, _date);
    } else {
      if (_completedDates[title].contains(_date)) {
        deleteCompletedDate(title, _date);
      }
    }
    update();
  }

  activateItemNotification(String title) async {
    await pdvDb.activateisNotification(title);
    update();
  }

  deactivateItemNotification(String title) async {
    await pdvDb.deactivateisNotification(title);
    update();
  }

  insertNotificationTime(String title, String notificationTime) async {
    if (!(_notificationTimes[title] ?? "")
        .split(",")
        .contains(notificationTime)) {
      await pdvDb.insertNotificationTime(title, notificationTime);
      update();
    }
  }

  deleteNoticationTime(String title, String notificationTime) async {
    await pdvDb.deleteNoticationTime(title, notificationTime);
    update();
  }

  insertCompletedDate(String title, String completedDate) async {
    if (!(_completedDates[title] ?? "").split(",").contains(completedDate)) {
      await pdvDb.insertCompletedDate(title, completedDate);
      update();
    }
  }

  deleteCompletedDate(String title, String completedDate) async {
    await pdvDb.deleteCompletedDate(title, completedDate);
    update();
  }
}

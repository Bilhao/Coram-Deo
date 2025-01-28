import 'package:flutter/material.dart';
import 'package:coramdeo/app/santo_do_dia/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SantoDoDiaProvider extends ChangeNotifier {
  SantoDoDiaProvider() {
    init();
  }

  SantoDoDia data = SantoDoDia();

  int _day = DateTime.now().day;
  int _month = DateTime.now().month;
  String _portrait = "";
  String _name = "";
  List<String> _text = [];
  List<String> _boldText = [];
  List<String> _italicText = [];
  bool _isLoading = false;
  bool _error = false;

  int get day => _day;
  int get month => _month;
  String get portrait => _portrait;
  String get name => _name;
  List<String> get text => _text;
  List<String> get boldText => _boldText;
  List<String> get italicText => _italicText;
  bool get isLoading => _isLoading;
  bool get error => _error;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final storedDay = prefs.getInt('santoDoDiaDay');
    final storedMonth = prefs.getInt('santoDoDiaMonth');
    if (storedDay == _day && storedMonth == _month) {
      _portrait = prefs.getString('santoDoDiaPortrait') ?? '';
      _name = prefs.getString('santoDoDiaName') ?? '';
      _text = prefs.getStringList('santoDoDiaText') ?? [];
      _boldText = prefs.getStringList('santoDoDiaBoldText') ?? [];
      _italicText = prefs.getStringList('santoDoDiaItalicText') ?? [];
      _isLoading = false;
      notifyListeners();
    } else {
      await data.initSDD(day: _day, month: _month);
      if (data.data == null) {
        _error = true;
        notifyListeners();
      } else {
        _portrait = data.getPortrait();
        _name = data.getName();
        _text = data.getText();
        _boldText = data.getBoldText();
        _italicText = data.getItalicText();
        prefs.setInt('santoDoDiaDay', _day);
        prefs.setInt('santoDoDiaMonth', _month);
        prefs.setString('santoDoDiaPortrait', _portrait);
        prefs.setString('santoDoDiaName', _name);
        prefs.setStringList('santoDoDiaText', _text);
        prefs.setStringList('santoDoDiaBoldText', _boldText);
        prefs.setStringList('santoDoDiaItalicText', _italicText);
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  void changeDate(int day, int month) {
    _day = day;
    _month = month;
    init();
    notifyListeners();
  }
}
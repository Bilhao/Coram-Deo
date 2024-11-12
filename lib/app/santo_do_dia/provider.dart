import 'package:flutter/material.dart';
import 'package:coramdeo/app/santo_do_dia/data.dart';

class SantoDoDiaProvider extends ChangeNotifier {
  SantoDoDiaProvider() {
    init();
  }

  SantoDoDia data = SantoDoDia();

  double _fontsize = 16.0;
  int _day = DateTime.now().day;
  int _month = DateTime.now().month;
  String _portrait = "";
  String _name = "";
  List<String> _text = [];
  List<String> _boldText = [];
  List<String> _italicText = [];
  bool _isLoading = false;
  bool _error = false;

  double get fontsize => _fontsize;
  int get day => _day;
  int get month => _month;
  String get portrait => _portrait;
  String get name => _name;
  List<String> get text => _text;
  List<String> get boldText => _boldText;
  List<String> get italicText => _italicText;
  bool get isLoading => _isLoading;
  bool get error => _error;

  init() async {
    _isLoading = true;
    notifyListeners();
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
      _isLoading = false;
      notifyListeners();
    }
  }

  changeDate(int day, int month) {
    _day = day;
    _month = month;
    init();
    notifyListeners();
  }

  increaseFontSize() {
    _fontsize++;
    notifyListeners();
  }

  decreaseFontSize() {
    _fontsize--;
    notifyListeners();
  }
}

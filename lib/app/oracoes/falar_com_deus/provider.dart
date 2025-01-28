import 'package:flutter/material.dart';
import 'package:coramdeo/app/oracoes/falar_com_deus/data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FalarComDeusProvider extends ChangeNotifier {
  FalarComDeusProvider() {
    init();
  }

  FalarComDeus data = FalarComDeus();

  final String _date = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
  List<String> _day = [];
  List<String> _title = [];
  List<String> _subtitle = [];
  List<String> _note = [];
  List<String> _content = [];
  List<String> _reference = [];
  bool _isLoading = false;
  bool _error = false;

  String get date => _date;
  List<String> get day => _day;
  List<String> get title => _title;
  List<String> get subtitle => _subtitle;
  List<String> get note => _note;
  List<String> get content => _content;
  List<String> get reference => _reference;
  bool get isLoading => _isLoading;
  bool get error => _error;

  init() async {
    _isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final storedDate = prefs.getString('falarComDeusDate');
    if (storedDate == _date) {
      _day = prefs.getStringList('falarComDeusDay') ?? [];
      _title = prefs.getStringList('falarComDeusTitle') ?? [];
      _subtitle = prefs.getStringList('falarComDeusSubtitle') ?? [];
      _note = prefs.getStringList('falarComDeusNote') ?? [];
      _content = prefs.getStringList('falarComDeusContent') ?? [];
      _reference = prefs.getStringList('falarComDeusReference') ?? [];
      _isLoading = false;
      notifyListeners();
    } else {
      await data.initFCD();
      if (data.data == null) {
        _error = true;
        notifyListeners();
      } else {
        prefs.setString('falarComDeusDate', _date);
        _day = data.getDay();
        prefs.setStringList('falarComDeusDay', _day);
        _title = data.getTitle();
        prefs.setStringList('falarComDeusTitle', _title);
        _subtitle = data.getSubtitle();
        prefs.setStringList('falarComDeusSubtitle', _subtitle);
        _note = data.getNote();
        prefs.setStringList('falarComDeusNote', _note);
        _content = data.getContent();
        prefs.setStringList('falarComDeusContent', _content);
        _reference = data.getReference();
        prefs.setStringList('falarComDeusReference', _reference);
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}

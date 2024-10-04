import 'package:flutter/material.dart';
import 'package:coramdeo/models/falar_com_deus.dart';

class FalarComDeusProvider extends ChangeNotifier {
  FalarComDeusProvider() {
    init();
  }

  FalarComDeus data = FalarComDeus();

  List<String> _day = [];
  List<String> _title = [];
  List<String> _subtitle = [];
  List<String> _note = [];
  List<String> _content = [];
  List<String> _reference = [];
  double _fontsize = 17.0;
  bool _isLoading = false;
  bool _error = false;

  List<String> get day => _day;
  List<String> get title => _title;
  List<String> get subtitle => _subtitle;
  List<String> get note => _note;
  List<String> get content => _content;
  List<String> get reference => _reference;
  double get fontsize => _fontsize;
  bool get isLoading => _isLoading;
  bool get error => _error;

  init() async {
    _isLoading = true;
    notifyListeners();
    await data.initFCD();
    if (data.data == null) {
      _error = true;
      notifyListeners();
    } else {
      _day = data.getDay();
      _title = data.getTitle();
      _subtitle = data.getSubtitle();
      _note = data.getNote();
      _content = data.getContent();
      _reference = data.getReference();
      _isLoading = false;
      notifyListeners();
    }
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

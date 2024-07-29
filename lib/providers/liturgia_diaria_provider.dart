import 'package:flutter/material.dart';
import 'package:coramdeo/models/liturgia_diaria.dart';

class LiturgiaDiariaProvider extends ChangeNotifier {
  LiturgiaDiariaProvider() {
    init();
  }

  LiturgiaDiaria data = LiturgiaDiaria();

  double _fontsize = 17.0;
  int _month = DateTime.now().month;
  int _day = DateTime.now().day;
  String _date = "";
  String _liturgia = "";
  String _primeiraLeituraTitulo = "";
  String _primeiraLeituraReferencia = "";
  String _primeiraLeituraTexto = "";
  String _salmoReferencia = "";
  String _salmoRefrao = "";
  String _salmoTexto = "";
  String _segundaLeituraTitulo = "";
  String _segundaLeituraReferencia = "";
  String _segundaLeituraTexto = "";
  String _evangelhoTitulo = "";
  String _evangelhoReferencia = "";
  String _evangelhoTexto = "";
  bool _isLoading = false;
  bool _error = false;

  double get fontsize => _fontsize;
  int get month => _month;
  int get day => _day;
  String get date => _date;
  String get liturgia => _liturgia;
  String get primeiraLeituraTitulo => _primeiraLeituraTitulo;
  String get primeiraLeituraReferencia => _primeiraLeituraReferencia;
  String get primeiraLeituraText => _primeiraLeituraTexto;
  String get salmoReferencia => _salmoReferencia;
  String get salmoRefrao => _salmoRefrao;
  String get salmoText => _salmoTexto;
  String get segundaLeituraTitulo => _segundaLeituraTitulo;
  String get segundaLeituraReferencia => _segundaLeituraReferencia;
  String get segundaLeituraText => _segundaLeituraTexto;
  String get evangelhoTitle => _evangelhoTitulo;
  String get evangelhoReferencia => _evangelhoReferencia;
  String get evangelhoText => _evangelhoTexto;
  bool get isLoading => _isLoading;
  bool get error => _error;

  init() async {
    _isLoading = true;
    notifyListeners();
    await data.initLD(day: _day, month: _month);
    if (data.data == null) {
      _error = true;
      notifyListeners();
    } else {
      _date = data.getDate();
      _liturgia = data.getLiturgia();
      _primeiraLeituraReferencia = data.getPrimeiraLeituraReferencia();
      _primeiraLeituraTitulo = data.getPrimeiraLeituraTitulo();
      _primeiraLeituraTexto = data.getPrimeiraLeituraTexto();
      _salmoReferencia = data.getSalmoReferencia();
      _salmoRefrao = data.getSalmoRefrao();
      _salmoTexto = data.getSalmoTexto();
      _segundaLeituraReferencia = data.getSegundaLeituraReferencia();
      _segundaLeituraTitulo = data.getSegundaLeituraTitulo();
      _segundaLeituraTexto = data.getSegundaLeituraTexto();
      _evangelhoReferencia = data.getEvangelhoReferencia();
      _evangelhoTitulo = data.getEvangelhoTitulo();
      _evangelhoTexto = data.getEvangelhoTexto();
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
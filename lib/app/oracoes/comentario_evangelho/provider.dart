import 'package:flutter/material.dart';
import 'package:coramdeo/app/oracoes/comentario_evangelho/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComentarioDoEvangelhoProvider extends ChangeNotifier {
  ComentarioDoEvangelhoProvider() {
    init();
  }

  ComentarioDoEvangelho data = ComentarioDoEvangelho();

  final String _date = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
  String _evangelho = "";
  String _comentario = "";
  List<String> _evangelhoText = [];
  List<String> _comentarioText = [];
  bool _error = false;
  bool _isLoading = false;

  String get date => _date;
  String get evangelho => _evangelho;
  String get comentarios => _comentario;
  List<String> get evangelhoText => _evangelhoText;
  List<String> get comentariosText => _comentarioText;
  bool get error => _error;
  bool get isLoading => _isLoading;

  init() async {
    _isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final storedDate = prefs.getString('comentarioDoEvangelhoDate');
    if (storedDate == _date) {
      _evangelho = prefs.getString('comentarioDoEvangelhoEvangelho') ?? '';
      _comentario = prefs.getString('comentarioDoEvangelhoComentario') ?? '';
      _evangelhoText = prefs.getStringList('comentarioDoEvangelhoEvangelhoText') ?? [];
      _comentarioText = prefs.getStringList('comentarioDoEvangelhoComentarioText') ?? [];
      _error = false;
      _isLoading = false;
      notifyListeners();
    } else {
      prefs.setString('comentarioDoEvangelhoDate', _date);
      await data.initCDE();
      if (data.data == null) {
        _error = true;
        notifyListeners();
      } else {
        _evangelho = data.getEvangelho();
        prefs.setString('comentarioDoEvangelhoEvangelho', _evangelho);
        _comentario = data.getComentario();
        prefs.setString('comentarioDoEvangelhoComentario', _comentario);
        _evangelhoText = data.getEvangelhoText();
        prefs.setStringList('comentarioDoEvangelhoEvangelhoText', _evangelhoText);
        _comentarioText = data.getCommentsText();
        prefs.setStringList('comentarioDoEvangelhoComentarioText', _comentarioText);
        _error = false;
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}

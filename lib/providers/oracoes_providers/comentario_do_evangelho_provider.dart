import 'package:flutter/material.dart';
import 'package:coramdeo/models/comentario_do_evangelho.dart';

class ComentarioDoEvangelhoProvider extends ChangeNotifier {
  ComentarioDoEvangelhoProvider() {
    init();
  }

  ComentarioDoEvangelho data = ComentarioDoEvangelho();

  String _evangelho = "";
  String _comentario = "";
  List<String> _evangelhoText = [];
  List<String> _comentarioText = [];
  double _fontSize = 17.0;
  bool _error = false;
  bool _isLoading = false;

  String get evangelho => _evangelho;
  String get comentarios => _comentario;
  List<String> get evangelhoText => _evangelhoText;
  List<String> get comentariosText => _comentarioText;
  double get fontSize => _fontSize;
  bool get error => _error;
  bool get isLoading => _isLoading;

  init() async {
    _isLoading = true;
    notifyListeners();
    await data.initCDE();
    if (data.data == null) {
      _error = true;
      notifyListeners();
    } else {
      _evangelho = data.getEvangelho();
      _comentario = data.getComentario();
      _evangelhoText = data.getEvangelhoText();
      _comentarioText = data.getCommentsText();
      _fontSize = 17.0;
      _error = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  increaseFontSize() {
    _fontSize++;
    notifyListeners();
  }

  decreaseFontSize() {
    _fontSize--;
    notifyListeners();
  }
}

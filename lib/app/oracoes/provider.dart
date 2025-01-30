import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OracoesProvider extends ChangeNotifier {
  OracoesProvider() {
    init();
  }

  List<String> _favoritas = [];

  List<String> get favoritas => _favoritas;

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoritas = prefs.getStringList('oracoes.favoritas') ?? [];
    notifyListeners();
  }

  Future<void> toggleFavorita(String oracao) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_favoritas.contains(oracao)) {
      _favoritas.remove(oracao);
    } else {
      _favoritas.add(oracao);
    }
    await prefs.setStringList('oracoes.favoritas', _favoritas);
    notifyListeners();
  }
}
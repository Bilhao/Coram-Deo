import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/utils/base_provider.dart';

class OracoesProvider extends BaseProvider {
  OracoesProvider() {
    _initialize();
  }

  List<String> _favoritas = [];

  List<String> get favoritas => _favoritas;

  Future<void> _initialize() async {
    await safePrefOperation((prefs) async {
      _favoritas = prefs.getStringList('oracoes.favoritas') ?? [];
      notifyListeners();
      return true;
    }, errorContext: 'Loading favorite prayers');
  }

  Future<void> toggleFavorita(String oracao) async {
    await safePrefOperation((prefs) async {
      if (_favoritas.contains(oracao)) {
        _favoritas.remove(oracao);
      } else {
        _favoritas.add(oracao);
      }
      await prefs.setStringList('oracoes.favoritas', _favoritas);
      notifyListeners();
      return true;
    }, errorContext: 'Toggling favorite prayer');
  }
}
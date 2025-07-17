import 'dart:convert';
import 'package:coramdeo/utils/base_provider.dart';

class ExameDeConscienciaProvider extends BaseProvider {

  ExameDeConscienciaProvider() {
    _initialize();
  }

  Map<String, dynamic> _itensExame = {};

  Map<String, dynamic> get itensExame => _itensExame;

  Future<void> _initialize() async {
    await safePrefOperation((prefs) async {
      String itemExameString = prefs.getString("exame.itensExame") ?? "{}";
      try {
        _itensExame = json.decode(itemExameString) as Map<String, dynamic>;
      } catch (e) {
        // If JSON is invalid, start with empty map
        _itensExame = {};
      }
      notifyListeners();
      return true;
    }, errorContext: 'Loading examination items');
  }

  Future<void> addItem(String title, String description) async {
    if (title.trim().isEmpty) return;
    
    await safePrefOperation((prefs) async {
      _itensExame[title] = description;
      await prefs.setString("exame.itensExame", json.encode(_itensExame));
      notifyListeners();
      return true;
    }, errorContext: 'Adding examination item');
  }

  Future<void> removeItem(String title) async {
    await safePrefOperation((prefs) async {
      _itensExame.remove(title);
      await prefs.setString("exame.itensExame", json.encode(_itensExame));
      notifyListeners();
      return true;
    }, errorContext: 'Removing examination item');
  }

  Future<void> clearItems() async {
    await safePrefOperation((prefs) async {
      _itensExame.clear();
      await prefs.setString("exame.itensExame", json.encode(_itensExame));
      notifyListeners();
      return true;
    }, errorContext: 'Clearing examination items');
  }
}
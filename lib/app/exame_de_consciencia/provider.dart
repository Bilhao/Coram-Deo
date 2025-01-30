import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ExameDeConscienciaProvider extends ChangeNotifier {

  ExameDeConscienciaProvider() {
    init();
  }

  Map<String, dynamic> _itensExame = {};

  Map<String, dynamic> get itensExame => _itensExame;


  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String itemExameString = prefs.getString("exame.itensExame") ?? "";
    _itensExame = json.decode(itemExameString);
    notifyListeners();
  }

  addItem(String title, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _itensExame[title] = description;
    await prefs.setString("exame.itensExame", json.encode(_itensExame));
    notifyListeners();
  }

  removeItem(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _itensExame.remove(title);
    await prefs.setString("exame.itensExame", json.encode(_itensExame));
    notifyListeners();
  }

  clearItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _itensExame.clear();
    await prefs.setString("exame.itensExame", json.encode(_itensExame));
    notifyListeners();
  }


}
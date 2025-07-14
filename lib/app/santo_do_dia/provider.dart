import 'package:flutter/material.dart';
import 'package:coramdeo/app/santo_do_dia/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/utils/base_provider.dart';

class SantoDoDiaProvider extends BaseProvider {
  SantoDoDiaProvider() {
    _initialize();
  }

  SantoDoDia data = SantoDoDia();

  int _day = DateTime.now().day;
  int _month = DateTime.now().month;
  String _portrait = "";
  String _name = "";
  List<String> _text = [];
  List<String> _boldText = [];
  List<String> _italicText = [];

  int get day => _day;
  int get month => _month;
  String get portrait => _portrait;
  String get name => _name;
  List<String> get text => _text;
  List<String> get boldText => _boldText;
  List<String> get italicText => _italicText;

  Future<void> _initialize() async {
    setLoading(true);
    
    await safePrefOperation((prefs) async {
      final storedDay = prefs.getInt('santoDoDiaDay');
      final storedMonth = prefs.getInt('santoDoDiaMonth');
      
      if (storedDay == _day && storedMonth == _month) {
        // Load cached data
        _portrait = prefs.getString('santoDoDiaPortrait') ?? '';
        _name = prefs.getString('santoDoDiaName') ?? '';
        _text = prefs.getStringList('santoDoDiaText') ?? [];
        _boldText = prefs.getStringList('santoDoDiaBoldText') ?? [];
        _italicText = prefs.getStringList('santoDoDiaItalicText') ?? [];
        return true;
      } else {
        // Load fresh data
        return false;
      }
    }, errorContext: 'Loading cached saint data');

    // Check if we need to fetch fresh data (no cached data or error occurred)
    if (error != null || _name.isEmpty) {
      clearError(); // Clear any previous cache loading error
      await _fetchFreshData();
    }
    
    setLoading(false);
  }

  Future<void> _fetchFreshData() async {
    await safeAsync(() async {
      await data.initSDD(day: _day, month: _month);
      if (data.data == null) {
        setError('Erro ao carregar santo do dia');
        return false;
      } else {
        _portrait = data.getPortrait();
        _name = data.getName();
        _text = data.getText();
        _boldText = data.getBoldText();
        _italicText = data.getItalicText();
        
        // Cache the data
        await _cacheData();
        return true;
      }
    }, errorContext: 'Fetching saint of the day data');
  }

  Future<void> _cacheData() async {
    await safePrefOperation((prefs) async {
      await prefs.setInt('santoDoDiaDay', _day);
      await prefs.setInt('santoDoDiaMonth', _month);
      await prefs.setString('santoDoDiaPortrait', _portrait);
      await prefs.setString('santoDoDiaName', _name);
      await prefs.setStringList('santoDoDiaText', _text);
      await prefs.setStringList('santoDoDiaBoldText', _boldText);
      await prefs.setStringList('santoDoDiaItalicText', _italicText);
      return true;
    }, errorContext: 'Caching saint data');
  }

  Future<void> changeDate(int day, int month) async {
    setLoading(true);
    _day = day;
    _month = month;
    
    // Force fresh data fetch for the new date
    await _fetchFreshData();
    
    setLoading(false);
    notifyListeners();
  }
}
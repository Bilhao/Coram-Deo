import 'package:flutter/material.dart';
import 'package:coramdeo/app/oracoes/falar_com_deus/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/utils/base_provider.dart';

class FalarComDeusProvider extends BaseProvider {
  FalarComDeusProvider() {
    _initialize();
  }

  FalarComDeus data = FalarComDeus();

  final String _date = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
  List<String> _day = [];
  List<String> _title = [];
  List<String> _subtitle = [];
  List<String> _note = [];
  List<String> _content = [];
  List<String> _reference = [];

  String get date => _date;
  List<String> get day => _day;
  List<String> get title => _title;
  List<String> get subtitle => _subtitle;
  List<String> get note => _note;
  List<String> get content => _content;
  List<String> get reference => _reference;

  Future<void> _initialize() async {
    setLoading(true);
    
    await safePrefOperation((prefs) async {
      final storedDate = prefs.getString('falarComDeusDate');
      if (storedDate == _date) {
        _day = prefs.getStringList('falarComDeusDay') ?? [];
        _title = prefs.getStringList('falarComDeusTitle') ?? [];
        _subtitle = prefs.getStringList('falarComDeusSubtitle') ?? [];
        _note = prefs.getStringList('falarComDeusNote') ?? [];
        _content = prefs.getStringList('falarComDeusContent') ?? [];
        _reference = prefs.getStringList('falarComDeusReference') ?? [];
        return true;
      } else {
        return false;
      }
    }, errorContext: 'Loading cached FalarComDeus data');

    // Check if we need to fetch fresh data
    if (error != null || _title.isEmpty) {
      clearError();
      await _fetchFreshData();
    }
    
    setLoading(false);
  }

  Future<void> _fetchFreshData() async {
    await safeAsync(() async {
      await data.initFCD();
      if (data.data == null) {
        setError('Erro ao carregar Falar com Deus');
        return false;
      } else {
        _day = data.getDay();
        _title = data.getTitle();
        _subtitle = data.getSubtitle();
        _note = data.getNote();
        _content = data.getContent();
        _reference = data.getReference();
        
        // Cache the data
        await _cacheData();
        return true;
      }
    }, errorContext: 'Fetching FalarComDeus data');
  }

  Future<void> _cacheData() async {
    await safePrefOperation((prefs) async {
      await prefs.setString('falarComDeusDate', _date);
      await prefs.setStringList('falarComDeusDay', _day);
      await prefs.setStringList('falarComDeusTitle', _title);
      await prefs.setStringList('falarComDeusSubtitle', _subtitle);
      await prefs.setStringList('falarComDeusNote', _note);
      await prefs.setStringList('falarComDeusContent', _content);
      await prefs.setStringList('falarComDeusReference', _reference);
      return true;
    }, errorContext: 'Caching FalarComDeus data');
  }
}

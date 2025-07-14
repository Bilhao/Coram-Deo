import 'package:flutter/material.dart';
import 'package:coramdeo/app/oracoes/comentario_evangelho/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/utils/base_provider.dart';

class ComentarioDoEvangelhoProvider extends BaseProvider {
  ComentarioDoEvangelhoProvider() {
    _initialize();
  }

  ComentarioDoEvangelho data = ComentarioDoEvangelho();

  final String _date = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
  String _evangelho = "";
  String _comentario = "";
  List<String> _evangelhoText = [];
  List<String> _comentarioText = [];

  String get date => _date;
  String get evangelho => _evangelho;
  String get comentarios => _comentario;
  List<String> get evangelhoText => _evangelhoText;
  List<String> get comentariosText => _comentarioText;

  Future<void> _initialize() async {
    setLoading(true);
    
    await safePrefOperation((prefs) async {
      final storedDate = prefs.getString('comentarioDoEvangelhoDate');
      if (storedDate == _date) {
        _evangelho = prefs.getString('comentarioDoEvangelhoEvangelho') ?? '';
        _comentario = prefs.getString('comentarioDoEvangelhoComentario') ?? '';
        _evangelhoText = prefs.getStringList('comentarioDoEvangelhoEvangelhoText') ?? [];
        _comentarioText = prefs.getStringList('comentarioDoEvangelhoComentarioText') ?? [];
        return true;
      } else {
        return false;
      }
    }, errorContext: 'Loading cached gospel commentary data');

    // Check if we need to fetch fresh data
    if (error != null || _evangelho.isEmpty) {
      clearError();
      await _fetchFreshData();
    }
    
    setLoading(false);
  }

  Future<void> _fetchFreshData() async {
    await safeAsync(() async {
      await data.initCE();
      if (data.data == null) {
        setError('Erro ao carregar comentário do evangelho');
        return false;
      } else {
        _evangelho = data.getEvangelho();
        _comentario = data.getComentario();
        _evangelhoText = data.getEvangelhoText();
        _comentarioText = data.getComentarioText();
        
        // Cache the data
        await _cacheData();
        return true;
      }
    }, errorContext: 'Fetching gospel commentary data');
  }

  Future<void> _cacheData() async {
    await safePrefOperation((prefs) async {
      await prefs.setString('comentarioDoEvangelhoDate', _date);
      await prefs.setString('comentarioDoEvangelhoEvangelho', _evangelho);
      await prefs.setString('comentarioDoEvangelhoComentario', _comentario);
      await prefs.setStringList('comentarioDoEvangelhoEvangelhoText', _evangelhoText);
      await prefs.setStringList('comentarioDoEvangelhoComentarioText', _comentarioText);
      return true;
    }, errorContext: 'Caching gospel commentary data');
  }
}

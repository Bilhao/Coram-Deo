import 'dart:io';
import 'package:coramdeo/app/santo_do_dia/data.dart';
import 'package:coramdeo/app/santo_do_dia/model.dart';
import 'package:coramdeo/app/santo_do_dia/repository.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class SantoDoDiaProvider extends BaseProvider {
  SantoDoDiaProvider() {
    _initialize();
  }

  final SantoDoDia data = SantoDoDia();
  final SantoDoDiaRepository _repository = SantoDoDiaRepository();

  int _day = DateTime.now().day;
  int _month = DateTime.now().month;
  String _portrait = "";
  String _localImagePath = "";
  String _name = "";
  String _subtitulo = "";
  String _oracao = "";
  SantoModel? _currentSaint;
  List<String> _text = [];
  List<String> _boldText = [];
  List<String> _italicText = [];

  // Dedicated properties for today's saint (used by HomePage SantoDoDiaCard and resetToToday)
  String _todayName = "";
  String _todaySubtitulo = "";
  String _todayPortrait = "";
  String _todayLocalImagePath = "";
  SantoModel? _todaySaint;
  List<String> _todayText = [];
  String _todayOracao = "";
  List<String> _todayBoldText = [];
  List<String> _todayItalicText = [];

  int get day => _day;
  int get month => _month;
  String get portrait => _portrait;
  String get localImagePath => _localImagePath;
  String get name => _name;
  String get subtitulo => _subtitulo;
  String get oracao => _oracao;
  SantoModel? get currentSaint => _currentSaint;
  List<String> get text => _text;
  List<String> get boldText => _boldText;
  List<String> get italicText => _italicText;
  bool get hasOracao => _oracao.isNotEmpty;
  bool get hasSubtitulo => _subtitulo.isNotEmpty;

  // Getters for today's saint (guarantees HomePage card always shows today)
  String get todayName => _todayName.isNotEmpty ? _todayName : _name;
  String get todaySubtitulo =>
      _todaySubtitulo.isNotEmpty ? _todaySubtitulo : _subtitulo;
  String get todayPortrait =>
      _todayPortrait.isNotEmpty ? _todayPortrait : _portrait;
  String get todayLocalImagePath =>
      _todayLocalImagePath.isNotEmpty ? _todayLocalImagePath : _localImagePath;
  bool get hasTodaySubtitulo => todaySubtitulo.isNotEmpty;

  /// Retorna o título litúrgico dinâmico da celebração ("Santo do Dia", "Festa do Dia", "Solenidade do Dia", "Comemoração do Dia").
  String get displayHeaderTitle => computeHeaderTitle(_name, _subtitulo);

  /// Retorna o título litúrgico dinâmico para a celebração de hoje.
  String get todayDisplayHeaderTitle =>
      computeHeaderTitle(todayName, todaySubtitulo);

  static String computeHeaderTitle(String name, [String subtitulo = '']) {
    final nm = name.trim().toLowerCase();
    final full = '$nm ${subtitulo.toLowerCase()}'.trim();

    if (full.contains('fiéis defuntos')) {
      return 'Solenidade do Dia';
    }

    // Solenidades universais, do Senhor ou da Virgem Maria
    if (nm.contains('santa maria, mãe de deus') ||
        nm.contains('epifania do senhor') ||
        nm.contains('anunciação do senhor') ||
        nm.contains('assunção de nossa senhora') ||
        nm.contains('aparecida') ||
        nm.contains('todos os santos') ||
        nm.contains('imaculada conceição') ||
        nm.contains('natal de nosso senhor jesus cristo') ||
        nm.contains('natividade de são joão batista')) {
      return 'Solenidade do Dia';
    }

    // Festas do Senhor, da Cruz, de Maria ou da Igreja
    if (nm.contains('apresentação do senhor') ||
        nm.contains('cátedra de são pedro') ||
        nm.contains('visitação de nossa senhora') ||
        nm.contains('transfiguração do senhor') ||
        nm.contains('natividade de nossa senhora') ||
        nm.contains('exaltação da santa cruz') ||
        nm.contains('dedicação da basílica') ||
        nm.contains('nossa senhora de guadalupe') ||
        nm.contains('santíssimo nome de maria') ||
        nm == 'nossa senhora das dores') {
      return 'Festa do Dia';
    }

    // Fallback caso venha com subtitulo / rank explícito
    if (full.contains('solenidade')) {
      if (full.contains('senhor') ||
          full.contains('natal') ||
          full.contains('anunciação') ||
          full.contains('todos os santos') ||
          full.contains('aparecida') ||
          full.contains('epifania') ||
          full.contains('imaculada conceição') ||
          full.contains('assunção') ||
          full.contains('mãe de deus') ||
          full.contains('encarnação') ||
          full.contains('precursor do senhor')) {
        return 'Solenidade do Dia';
      }
    }
    if (full.contains('festa')) {
      if (full.contains('senhor') ||
          full.contains('cruz') ||
          full.contains('transfiguração') ||
          full.contains('cátedra') ||
          full.contains('basílica') ||
          full.contains('apresentação') ||
          full.contains('visitação') ||
          full.contains('exaltação') ||
          full.contains('guadalupe') ||
          full.contains('natividade de nossa senhora') ||
          full.contains('dores') ||
          full.contains('nome de maria')) {
        return 'Festa do Dia';
      }
    }
    return 'Santo do Dia';
  }

  static IconData computeHeaderIcon(String name, [String subtitulo = '']) {
    final title = computeHeaderTitle(name, subtitulo);
    switch (title) {
      case 'Solenidade do Dia':
        return Icons.auto_awesome_rounded;
      case 'Festa do Dia':
        return Icons.church_rounded;
      case 'Comemoração do Dia':
        return Icons.brightness_medium_rounded;
      default:
        return Icons.person_rounded;
    }
  }

  IconData get displayHeaderIcon => computeHeaderIcon(_name, _subtitulo);
  IconData get todayDisplayHeaderIcon =>
      computeHeaderIcon(todayName, todaySubtitulo);

  // Asset image helpers
  bool get hasAssetImage => _portrait.startsWith('assets/');
  String get assetImagePath => _portrait.startsWith('assets/') ? _portrait : '';
  bool get hasTodayAssetImage => todayPortrait.startsWith('assets/');
  String get todayAssetImagePath =>
      todayPortrait.startsWith('assets/') ? todayPortrait : '';

  bool _isToday(int day, int month) {
    final now = DateTime.now();
    return day == now.day && month == now.month;
  }

  void _syncTodayFields() {
    _todayName = _name;
    _todaySubtitulo = _subtitulo;
    _todayPortrait = _portrait;
    _todayLocalImagePath = _localImagePath;
    _todaySaint = _currentSaint;
    _todayText = List.from(_text);
    _todayOracao = _oracao;
    _todayBoldText = List.from(_boldText);
    _todayItalicText = List.from(_italicText);
  }

  static const int _currentCacheVersion = 2;
  static const String _cacheVersionKey = 'santo_image_cache_version_v2';

  static const String githubImagesBaseUrl =
      'https://raw.githubusercontent.com/Bilhao/Coram-Deo/main/assets/images/santos';

  /// Resolve o caminho ou URL da imagem do Santo:
  /// 1. Se for uma URL externa ou customizada (http:// ou https://) e NÃO for do antigo A12, retorna a URL;
  /// 2. Caso contrário, retorna a URL raw do GitHub para download sob demanda e cache permanente em disco.
  static String resolvePortraitUrl(String? dbUrl, int day, int month) {
    if (dbUrl != null &&
        dbUrl.isNotEmpty &&
        (dbUrl.startsWith('http://') || dbUrl.startsWith('https://')) &&
        !dbUrl.contains('a12.com')) {
      return dbUrl;
    }
    return '$githubImagesBaseUrl/santo_${month.toString().padLeft(2, '0')}_${day.toString().padLeft(2, '0')}.webp';
  }

  String _resolvePortrait(String? dbUrl, int day, int month) {
    return resolvePortraitUrl(dbUrl, day, month);
  }

  /// Limpa arquivos residuais em .jpg e chaves de SharedPreferences do antigo sistema de scraping do A12.
  Future<void> _cleanLegacyCache() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final saintsDir = Directory('${dir.path}/santos');

      await safePrefOperation((prefs) async {
        final currentVersion = prefs.getInt(_cacheVersionKey) ?? 0;
        final cachedPortrait = prefs.getString('santoDoDiaPortrait') ?? '';
        final cachedLocalPath =
            prefs.getString('santoDoDiaLocalImagePath') ?? '';

        final hasA12Reference = cachedPortrait.contains('a12.com') ||
            cachedLocalPath.toLowerCase().endsWith('.jpg');

        if (currentVersion < _currentCacheVersion || hasA12Reference) {
          // Remove todos os arquivos legados .jpg da época do scraping do A12
          if (await saintsDir.exists()) {
            final entities = await saintsDir.list().toList();
            for (final entity in entities) {
              if (entity is File) {
                final lower = entity.path.toLowerCase();
                if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) {
                  try {
                    await entity.delete();
                  } catch (_) {}
                }
              }
            }
          }

          // Invalida chaves antigas que apontavam para o A12 ou arquivos .jpg
          if (cachedPortrait.contains('a12.com')) {
            await prefs.remove('santoDoDiaPortrait');
          }
          if (cachedLocalPath.toLowerCase().endsWith('.jpg')) {
            await prefs.remove('santoDoDiaLocalImagePath');
          }

          await prefs.setInt(_cacheVersionKey, _currentCacheVersion);
        }
        return true;
      });
    } catch (_) {
      // Falhas no cleanup de cache não devem travar a inicialização
    }
  }

  Future<void> _initialize() async {
    setLoading(true);

    // 0. Remove cache legado e arquivos .jpg do antigo scraper A12
    await _cleanLegacyCache();

    // 1. Tenta carregar do banco de dados local SQLite (prioridade offline autoritativa)
    final localSaint = await _repository.getSanto(_day, _month);
    if (localSaint != null) {
      _currentSaint = localSaint;
      _name = localSaint.nome;
      _subtitulo = localSaint.subtitulo ?? '';
      _text = localSaint.paragraphs;
      _oracao = localSaint.oracao ?? '';
      _portrait = _resolvePortrait(localSaint.imagemUrl, _day, _month);
      _boldText = [];
      _italicText = [];
      if (_localImagePath.toLowerCase().endsWith('.jpg')) {
        _localImagePath = '';
      }
      if (_todayLocalImagePath.toLowerCase().endsWith('.jpg')) {
        _todayLocalImagePath = '';
      }
      if (_isToday(_day, _month)) {
        _syncTodayFields();
      }
      await _cacheData();
      setLoading(false);
      return;
    }

    // 2. Se não houver na base curada, busca cache SharedPreferences
    await safePrefOperation((prefs) async {
      final storedDay = prefs.getInt('santoDoDiaDay');
      final storedMonth = prefs.getInt('santoDoDiaMonth');

      if (storedDay == _day && storedMonth == _month) {
        // Load cached data
        final cachedPortrait = prefs.getString('santoDoDiaPortrait') ?? '';
        if (cachedPortrait.contains('a12.com') || cachedPortrait.isEmpty) {
          _portrait = _resolvePortrait(null, _day, _month);
        } else {
          _portrait = cachedPortrait;
        }

        final cachedLocalPath =
            prefs.getString('santoDoDiaLocalImagePath') ?? '';
        if (cachedLocalPath.toLowerCase().endsWith('.jpg') ||
            !File(cachedLocalPath).existsSync()) {
          _localImagePath = '';
        } else {
          _localImagePath = cachedLocalPath;
        }

        _name = prefs.getString('santoDoDiaName') ?? '';
        _subtitulo = prefs.getString('santoDoDiaSubtitulo') ?? '';
        _oracao = prefs.getString('santoDoDiaOracao') ?? '';
        _text = prefs.getStringList('santoDoDiaText') ?? [];
        _boldText = prefs.getStringList('santoDoDiaBoldText') ?? [];
        _italicText = prefs.getStringList('santoDoDiaItalicText') ?? [];

        if (_isToday(_day, _month)) {
          _syncTodayFields();
        }

        // If local image is missing but URL exists, cache in background
        if (_localImagePath.isEmpty && _portrait.isNotEmpty) {
          _cacheImageLocally(_portrait, day: _day, month: _month).then((path) {
            if (path.isNotEmpty) {
              _localImagePath = path;
              if (_isToday(_day, _month)) {
                _todayLocalImagePath = path;
              }
              prefs.setString('santoDoDiaLocalImagePath', _localImagePath);
              notifyListeners();
            }
          });
        }

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
      // 1. Tenta carregar do banco de dados local SQLite (100% offline)
      final localSaint = await _repository.getSanto(_day, _month);
      if (localSaint != null) {
        _currentSaint = localSaint;
        _name = localSaint.nome;
        _subtitulo = localSaint.subtitulo ?? '';
        _text = localSaint.paragraphs;
        _oracao = localSaint.oracao ?? '';
        _portrait = _resolvePortrait(localSaint.imagemUrl, _day, _month);
        _boldText = [];
        _italicText = [];
        if (_isToday(_day, _month)) {
          _syncTodayFields();
        }

        await _cacheData();
        return true;
      }

      // 2. Fallback temporário para webscraping se ainda não houver entrada no banco
      _currentSaint = null;
      await data.initSDD(day: _day, month: _month);
      if (data.data == null) {
        setError('Erro ao carregar santo do dia');
        return false;
      } else {
        _portrait = data.getPortrait();
        _name = data.getName();
        _subtitulo = '';
        _oracao = '';
        _text = data.getText();
        _boldText = data.getBoldText();
        _italicText = data.getItalicText();

        // Cache the data and image
        await _cacheData();
        return true;
      }
    }, errorContext: 'Fetching saint of the day data');
  }

  Future<String> _cacheImageLocally(String portraitUrl,
      {int? day, int? month}) async {
    if (portraitUrl.isEmpty || portraitUrl.startsWith('assets/')) return '';
    try {
      final dir = await getApplicationDocumentsDirectory();
      final saintsDir = Directory('${dir.path}/santos');
      if (!await saintsDir.exists()) {
        await saintsDir.create(recursive: true);
      }

      final d = day ?? _day;
      final m = month ?? _month;
      final dayStr = d.toString().padLeft(2, '0');
      final monthStr = m.toString().padLeft(2, '0');

      // 1. Remove qualquer arquivo legado em .jpg se ainda existir
      final legacyJpg1 = File('${saintsDir.path}/santo_${d}_$m.jpg');
      if (await legacyJpg1.exists()) {
        try {
          await legacyJpg1.delete();
        } catch (_) {}
      }
      final legacyJpg2 =
          File('${saintsDir.path}/santo_${monthStr}_$dayStr.jpg');
      if (await legacyJpg2.exists()) {
        try {
          await legacyJpg2.delete();
        } catch (_) {}
      }

      // 2. Arquivo oficial em WebP com padLeft de 2 dígitos
      final webpFile = File('${saintsDir.path}/santo_${monthStr}_$dayStr.webp');
      if (await webpFile.exists() && (await webpFile.length()) > 1024) {
        return webpFile.path;
      }

      // 3. Se a URL apontar para o antigo A12, usa GitHub
      final resolvedUrl = portraitUrl.contains('a12.com')
          ? resolvePortraitUrl(null, d, m)
          : portraitUrl;

      final response = await http.get(
        Uri.parse(resolvedUrl),
        headers: {'User-Agent': 'CoramDeo/1.0.5 (Android)'},
      );
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        await webpFile.writeAsBytes(response.bodyBytes);
        return webpFile.path;
      }
    } catch (_) {
      // Ignore download failures, fallback to network URL
    }
    return '';
  }

  Future<void> _cacheData() async {
    if (_portrait.isNotEmpty && !_portrait.startsWith('assets/')) {
      _localImagePath =
          await _cacheImageLocally(_portrait, day: _day, month: _month);
    } else {
      _localImagePath = '';
    }

    if (_isToday(_day, _month)) {
      _todayLocalImagePath = _localImagePath;
      _todayPortrait = _portrait;
      notifyListeners();
    }

    await safePrefOperation((prefs) async {
      await prefs.setInt('santoDoDiaDay', _day);
      await prefs.setInt('santoDoDiaMonth', _month);
      await prefs.setString('santoDoDiaPortrait', _portrait);
      await prefs.setString('santoDoDiaLocalImagePath', _localImagePath);
      await prefs.setString('santoDoDiaName', _name);
      await prefs.setString('santoDoDiaSubtitulo', _subtitulo);
      await prefs.setString('santoDoDiaOracao', _oracao);
      await prefs.setStringList('santoDoDiaText', _text);
      await prefs.setStringList('santoDoDiaBoldText', _boldText);
      await prefs.setStringList('santoDoDiaItalicText', _italicText);
      return true;
    }, errorContext: 'Caching saint data');
  }

  void resetToToday() {
    final now = DateTime.now();
    if (_day != now.day || _month != now.month) {
      if (_todayName.isNotEmpty) {
        _day = now.day;
        _month = now.month;
        _currentSaint = _todaySaint;
        _name = _todayName;
        _subtitulo = _todaySubtitulo;
        _portrait = _todayPortrait;
        _localImagePath = _todayLocalImagePath;
        _text = List.from(_todayText);
        _oracao = _todayOracao;
        _boldText = List.from(_todayBoldText);
        _italicText = List.from(_todayItalicText);
        clearError();
        setLoading(false);
        notifyListeners();
      } else {
        changeDate(now.day, now.month);
      }
    }
  }

  Future<void> changeDate(int day, int month) async {
    setLoading(true);
    _day = day;
    _month = month;
    _localImagePath = "";

    // Force fresh data fetch for the new date
    await _fetchFreshData();

    setLoading(false);
    notifyListeners();
  }

  @visibleForTesting
  void setSaintForTesting({
    required String name,
    required String subtitulo,
    required String portrait,
    required List<String> text,
    String oracao = '',
    int day = 1,
    int month = 1,
  }) {
    _name = name;
    _subtitulo = subtitulo;
    _portrait = portrait;
    _text = text;
    _oracao = oracao;
    _day = day;
    _month = month;
    clearError();
    setLoading(false);
    notifyListeners();
  }
}

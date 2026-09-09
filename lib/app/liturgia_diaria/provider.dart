import 'package:coramdeo/app/liturgia_diaria/data.dart';
import 'package:coramdeo/utils/base_provider.dart';

class LiturgiaDiariaProvider extends BaseProvider {
  LiturgiaDiariaProvider() {
    _initialize();
  }

  LiturgiaDiaria data = LiturgiaDiaria();

  int _month = DateTime.now().month;
  int _day = DateTime.now().day;
  String _date = "";
  String _liturgia = "";
  String _primeiraLeituraTitulo = "";
  String _primeiraLeituraReferencia = "";
  String _primeiraLeituraTexto = "";
  String _salmoReferencia = "";
  String _salmoRefrao = "";
  String _salmoTexto = "";
  String _segundaLeituraTitulo = "";
  String _segundaLeituraReferencia = "";
  String _segundaLeituraTexto = "";
  String _evangelhoTitulo = "";
  String _evangelhoReferencia = "";
  String _evangelhoTexto = "";

  int get month => _month;
  int get day => _day;
  String get date => _date;
  String get liturgia => _liturgia;
  String get primeiraLeituraTitulo => _primeiraLeituraTitulo;
  String get primeiraLeituraReferencia => _primeiraLeituraReferencia;
  String get primeiraLeituraText => _primeiraLeituraTexto;
  String get salmoReferencia => _salmoReferencia;
  String get salmoRefrao => _salmoRefrao;
  String get salmoText => _salmoTexto;
  String get segundaLeituraTitulo => _segundaLeituraTitulo;
  String get segundaLeituraReferencia => _segundaLeituraReferencia;
  String get segundaLeituraText => _segundaLeituraTexto;
  String get evangelhoTitle => _evangelhoTitulo;
  String get evangelhoReferencia => _evangelhoReferencia;
  String get evangelhoText => _evangelhoTexto;

  Future<void> _initialize() async {
    setLoading(true);

    final todayKey = "$_day-$_month-${DateTime.now().year}";

    await safePrefOperation((prefs) async {
      final storedDate = prefs.getString('liturgiaDiariaDate');
      if (storedDate == todayKey) {
        _date = prefs.getString('liturgiaDiaria_date') ?? '';
        _liturgia = prefs.getString('liturgiaDiaria_liturgia') ?? '';
        _primeiraLeituraReferencia = prefs.getString('liturgiaDiaria_primeiraLeituraReferencia') ?? '';
        _primeiraLeituraTitulo = prefs.getString('liturgiaDiaria_primeiraLeituraTitulo') ?? '';
        _primeiraLeituraTexto = prefs.getString('liturgiaDiaria_primeiraLeituraTexto') ?? '';
        _salmoReferencia = prefs.getString('liturgiaDiaria_salmoReferencia') ?? '';
        _salmoRefrao = prefs.getString('liturgiaDiaria_salmoRefrao') ?? '';
        _salmoTexto = prefs.getString('liturgiaDiaria_salmoTexto') ?? '';
        _segundaLeituraReferencia = prefs.getString('liturgiaDiaria_segundaLeituraReferencia') ?? '';
        _segundaLeituraTitulo = prefs.getString('liturgiaDiaria_segundaLeituraTitulo') ?? '';
        _segundaLeituraTexto = prefs.getString('liturgiaDiaria_segundaLeituraTexto') ?? '';
        _evangelhoReferencia = prefs.getString('liturgiaDiaria_evangelhoReferencia') ?? '';
        _evangelhoTitulo = prefs.getString('liturgiaDiaria_evangelhoTitulo') ?? '';
        _evangelhoTexto = prefs.getString('liturgiaDiaria_evangelhoTexto') ?? '';
        return true;
      }
      return false;
    }, errorContext: 'Loading cached daily liturgy');

    if (error != null || _liturgia.isEmpty) {
      clearError();
      await _fetchFreshData();
    }

    setLoading(false);
  }

  Future<void> _fetchFreshData() async {
    await safeAsync(() async {
      await data.initLD(day: _day, month: _month);
      if (data.data == null) {
        setError('Erro ao carregar liturgia diária');
        return false;
      } else {
        _date = data.getDate();
        _liturgia = data.getLiturgia();
        _primeiraLeituraReferencia = data.getPrimeiraLeituraReferencia();
        _primeiraLeituraTitulo = data.getPrimeiraLeituraTitulo();
        _primeiraLeituraTexto = data.getPrimeiraLeituraTexto();
        _salmoReferencia = data.getSalmoReferencia();
        _salmoRefrao = data.getSalmoRefrao();
        _salmoTexto = data.getSalmoTexto();
        _segundaLeituraReferencia = data.getSegundaLeituraReferencia();
        _segundaLeituraTitulo = data.getSegundaLeituraTitulo();
        _segundaLeituraTexto = data.getSegundaLeituraTexto();
        _evangelhoReferencia = data.getEvangelhoReferencia();
        _evangelhoTitulo = data.getEvangelhoTitulo();
        _evangelhoTexto = data.getEvangelhoTexto();

        await _cacheData();
        return true;
      }
    }, errorContext: 'Fetching daily liturgy');
  }

  Future<void> _cacheData() async {
    await safePrefOperation((prefs) async {
      final todayKey = "$_day-$_month-${DateTime.now().year}";
      await prefs.setString('liturgiaDiariaDate', todayKey);
      await prefs.setString('liturgiaDiaria_date', _date);
      await prefs.setString('liturgiaDiaria_liturgia', _liturgia);
      await prefs.setString('liturgiaDiaria_primeiraLeituraReferencia', _primeiraLeituraReferencia);
      await prefs.setString('liturgiaDiaria_primeiraLeituraTitulo', _primeiraLeituraTitulo);
      await prefs.setString('liturgiaDiaria_primeiraLeituraTexto', _primeiraLeituraTexto);
      await prefs.setString('liturgiaDiaria_salmoReferencia', _salmoReferencia);
      await prefs.setString('liturgiaDiaria_salmoRefrao', _salmoRefrao);
      await prefs.setString('liturgiaDiaria_salmoTexto', _salmoTexto);
      await prefs.setString('liturgiaDiaria_segundaLeituraReferencia', _segundaLeituraReferencia);
      await prefs.setString('liturgiaDiaria_segundaLeituraTitulo', _segundaLeituraTitulo);
      await prefs.setString('liturgiaDiaria_segundaLeituraTexto', _segundaLeituraTexto);
      await prefs.setString('liturgiaDiaria_evangelhoReferencia', _evangelhoReferencia);
      await prefs.setString('liturgiaDiaria_evangelhoTitulo', _evangelhoTitulo);
      await prefs.setString('liturgiaDiaria_evangelhoTexto', _evangelhoTexto);
      return true;
    }, errorContext: 'Caching daily liturgy');
  }

  Future<void> changeDate(int day, int month) async {
    setLoading(true);
    _day = day;
    _month = month;
    await _fetchFreshData();
    setLoading(false);
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coramdeo/app/liturgia_diaria/provider.dart';
import 'package:coramdeo/utils/base_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final now = DateTime.now();
  final todayKey = "${now.day}-${now.month}-${now.year}";

  final Map<String, Object> defaultTodayValues = {
    'liturgiaDiariaDate': todayKey,
    'liturgiaDiaria_date': '${now.day}/${now.month}/${now.year}',
    'liturgiaDiaria_liturgia': 'Tempo Comum Hoje',
    'liturgiaDiaria_primeiraLeituraReferencia': '1Cor 1, 1-9',
    'liturgiaDiaria_primeiraLeituraTitulo': 'Primeira Leitura',
    'liturgiaDiaria_primeiraLeituraTexto': 'Paulo, chamado a ser apóstolo...',
    'liturgiaDiaria_salmoReferencia': 'Sl 144',
    'liturgiaDiaria_salmoRefrao': 'Bendirei o vosso nome para sempre!',
    'liturgiaDiaria_salmoTexto': 'O Senhor é amor e piedade...',
    'liturgiaDiaria_segundaLeituraReferencia': '',
    'liturgiaDiaria_segundaLeituraTitulo': '',
    'liturgiaDiaria_segundaLeituraTexto': '',
    'liturgiaDiaria_evangelhoReferencia': 'Mt 5, 1-12',
    'liturgiaDiaria_evangelhoTitulo': 'Evangelho',
    'liturgiaDiaria_evangelhoTexto': 'Vendo Jesus as multidões...',
  };

  group('LiturgiaDiariaProvider Multi-Day Caching & Offline-First', () {
    setUp(() {
      BaseProvider.resetCachedPrefs();
      SharedPreferences.setMockInitialValues({});
    });

    test('Loads today liturgy from legacy cache on cold start', () async {
      BaseProvider.resetCachedPrefs();
      SharedPreferences.setMockInitialValues({
        ...defaultTodayValues,
        'liturgiaDiaria_liturgia': '24ª Semana do Tempo Comum',
        'liturgiaDiaria_primeiraLeituraReferencia': '1Cor 12, 31-13, 13',
        'liturgiaDiaria_salmoRefrao': 'Feliz o povo que o Senhor escolheu!',
        'liturgiaDiaria_evangelhoReferencia': 'Lc 7, 31-35',
      });

      final provider = LiturgiaDiariaProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      expect(provider.liturgia, equals('24ª Semana do Tempo Comum'));
      expect(provider.primeiraLeituraReferencia, equals('1Cor 12, 31-13, 13'));
      expect(provider.salmoRefrao, equals('Feliz o povo que o Senhor escolheu!'));
      expect(provider.evangelhoReferencia, equals('Lc 7, 31-35'));
      expect(provider.todayLiturgia, equals('24ª Semana do Tempo Comum'));
      expect(provider.todayEvangelhoReferencia, equals('Lc 7, 31-35'));
    });

    test('Loads multi-day cached liturgy from JSON key without network call', () async {
      final christmasKey = "liturgia_cache_25_12_2026";
      final christmasPayload = {
        'date': '25/12/2026',
        'liturgia': 'Natividade de Nosso Senhor Jesus Cristo',
        'primeiraLeituraReferencia': 'Is 52, 7-10',
        'primeiraLeituraTitulo': 'Primeira Leitura',
        'primeiraLeituraTexto': 'Como são belos sobre as montanhas...',
        'salmoReferencia': 'Sl 97',
        'salmoRefrao': 'Os confins de toda a terra viram a salvação do Senhor.',
        'salmoTexto': 'Cantai ao Senhor um cântico novo...',
        'segundaLeituraReferencia': 'Hb 1, 1-6',
        'segundaLeituraTitulo': 'Segunda Leitura',
        'segundaLeituraTexto': 'Muitas vezes e de muitos modos...',
        'evangelhoReferencia': 'Jo 1, 1-18',
        'evangelhoTitulo': 'Evangelho',
        'evangelhoTexto': 'No princípio era o Verbo...',
      };

      BaseProvider.resetCachedPrefs();
      SharedPreferences.setMockInitialValues({
        ...defaultTodayValues,
        christmasKey: jsonEncode(christmasPayload),
      });

      final provider = LiturgiaDiariaProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      // Change date to 25/12/2026 (cache hit)
      await provider.changeDate(25, 12, year: 2026);

      expect(provider.day, equals(25));
      expect(provider.month, equals(12));
      expect(provider.year, equals(2026));
      expect(provider.liturgia, equals('Natividade de Nosso Senhor Jesus Cristo'));
      expect(provider.primeiraLeituraReferencia, equals('Is 52, 7-10'));
      expect(provider.segundaLeituraReferencia, equals('Hb 1, 1-6'));
      expect(provider.evangelhoReferencia, equals('Jo 1, 1-18'));
      expect(provider.error, isNull);
    });

    test('Preserves today readings in today* getters when changing date', () async {
      final christmasKey = "liturgia_cache_25_12_2026";
      final christmasPayload = {
        'date': '25/12/2026',
        'liturgia': 'Natal do Senhor',
        'primeiraLeituraReferencia': 'Is 52, 7-10',
        'primeiraLeituraTitulo': 'Primeira Leitura',
        'primeiraLeituraTexto': 'Como são belos...',
        'salmoReferencia': 'Sl 97',
        'salmoRefrao': 'Os confins...',
        'salmoTexto': 'Cantai...',
        'segundaLeituraReferencia': '',
        'segundaLeituraTitulo': '',
        'segundaLeituraTexto': '',
        'evangelhoReferencia': 'Jo 1, 1-18',
        'evangelhoTitulo': 'Evangelho',
        'evangelhoTexto': 'No princípio...',
      };

      BaseProvider.resetCachedPrefs();
      SharedPreferences.setMockInitialValues({
        ...defaultTodayValues,
        'liturgiaDiaria_liturgia': 'Tempo Comum Hoje',
        'liturgiaDiaria_primeiraLeituraReferencia': '1Cor 1, 1-9',
        'liturgiaDiaria_evangelhoReferencia': 'Mt 5, 1-12',
        christmasKey: jsonEncode(christmasPayload),
      });

      final provider = LiturgiaDiariaProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      expect(provider.todayLiturgia, equals('Tempo Comum Hoje'));
      expect(provider.todayPrimeiraLeituraReferencia, equals('1Cor 1, 1-9'));

      // Navigate to another day (e.g., from CalendarioPage)
      await provider.changeDate(25, 12, year: 2026);

      // Active readings are now Christmas
      expect(provider.liturgia, equals('Natal do Senhor'));
      expect(provider.primeiraLeituraReferencia, equals('Is 52, 7-10'));

      // BUT today* getters for HomePage LiturgiaCard remain intact!
      expect(provider.todayLiturgia, equals('Tempo Comum Hoje'));
      expect(provider.todayPrimeiraLeituraReferencia, equals('1Cor 1, 1-9'));
      expect(provider.todayEvangelhoReferencia, equals('Mt 5, 1-12'));
    });
  });
}

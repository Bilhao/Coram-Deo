import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/services/computus_engine.dart';
import 'package:coramdeo/app/calendario/services/opus_dei_calendar_data.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('OpusDeiCalendarData & Prelature Feasts', () {
    test('Contém todas as Solenidades de Classe A', () {
      final mar19 = OpusDeiCalendarData.getCelebration(3, 19);
      expect(mar19, isNotNull);
      expect(mar19!.classRank, OpusDeiClass.classeA);

      final jun26 = OpusDeiCalendarData.getCelebration(6, 26);
      expect(jun26, isNotNull);
      expect(jun26!.classRank, OpusDeiClass.classeA);
      expect(jun26.name, contains('São Josemaria Escrivá'));

      final jun29 = OpusDeiCalendarData.getCelebration(6, 29);
      expect(jun29, isNotNull);
      expect(jun29!.classRank, OpusDeiClass.classeA);

      final oct02 = OpusDeiCalendarData.getCelebration(10, 2);
      expect(oct02, isNotNull);
      expect(oct02!.classRank, OpusDeiClass.classeA);
      expect(oct02.name, contains('Fundação do Opus Dei'));
    });

    test('Contém as Festas de Classe B', () {
      final feb14 = OpusDeiCalendarData.getCelebration(2, 14);
      expect(feb14, isNotNull);
      expect(feb14!.classRank, OpusDeiClass.classeB);
      expect(feb14.name, contains('Belo Amor'));

      final may02 = OpusDeiCalendarData.getCelebration(5, 2);
      expect(may02, isNotNull);
      expect(may02!.classRank, OpusDeiClass.classeB);

      final arcanjos = OpusDeiCalendarData.getCelebration(9, 29);
      expect(arcanjos, isNotNull);
      expect(arcanjos!.classRank, OpusDeiClass.classeB);

      final reliquias = OpusDeiCalendarData.getCelebration(11, 8);
      expect(reliquias, isNotNull);
      expect(reliquias!.classRank, OpusDeiClass.classeB);

      final joao = OpusDeiCalendarData.getCelebration(12, 27);
      expect(joao, isNotNull);
      expect(joao!.classRank, OpusDeiClass.classeB);
    });

    test('Contém as Memórias Litúrgicas de Classe C', () {
      final alvaro = OpusDeiCalendarData.getCelebration(5, 12);
      expect(alvaro, isNotNull);
      expect(alvaro!.classRank, OpusDeiClass.classeC);
      expect(alvaro.name, contains('Álvaro del Portillo'));

      final guadalupe = OpusDeiCalendarData.getCelebration(5, 18);
      expect(guadalupe, isNotNull);
      expect(guadalupe!.classRank, OpusDeiClass.classeC);
      expect(guadalupe.name, contains('Guadalupe Ortiz'));

      final rafael = OpusDeiCalendarData.getCelebration(10, 24);
      expect(rafael, isNotNull);
      expect(rafael!.classRank, OpusDeiClass.classeC);
      expect(rafael.name, contains('São Rafael'));
    });

    test('Contém os Aniversários Históricos de Classe D', () {
      final utSit = OpusDeiCalendarData.getCelebration(11, 28);
      expect(utSit, isNotNull);
      expect(utSit!.classRank, OpusDeiClass.classeD);
      expect(utSit.name, contains('Prelazia Pessoal'));

      final canonizacao = OpusDeiCalendarData.getCelebration(10, 6);
      expect(canonizacao, isNotNull);
      expect(canonizacao!.classRank, OpusDeiClass.classeD);
      expect(canonizacao.name, contains('Canonização'));

      final javier = OpusDeiCalendarData.getCelebration(12, 12);
      expect(javier, isNotNull);
      expect(javier!.classRank, OpusDeiClass.classeD);
      expect(javier.name, contains('Javier Echevarría'));
    });

    test(
      'Identifica os Sete Domingos de São José anteriores a 19 de Março',
      () {
        // Em 2026, 19 de março é uma quinta-feira.
        // Os 7 domingos anteriores são:
        // 15/03, 08/03, 01/03, 22/02, 15/02, 08/02, 01/02
        expect(
          OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 2, 1)),
          contains('1º Domingo de São José'),
        );
        expect(
          OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 2, 8)),
          contains('2º Domingo de São José'),
        );
        expect(
          OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 3, 15)),
          contains('7º Domingo de São José'),
        );
        // Um dia que não é domingo não deve ter o aviso
        expect(
          OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 3, 14)),
          isNull,
        );
      },
    );

    test('Identifica os 9 dias da Novena da Imaculada Conceição', () {
      // 29 de novembro = Dia 1
      expect(
        OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 11, 29)),
        'Novena da Imaculada Conceição (Dia 1)',
      );
      // 30 de novembro = Dia 2
      expect(
        OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 11, 30)),
        'Novena da Imaculada Conceição (Dia 2)',
      );
      // 1 de dezembro = Dia 3
      expect(
        OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 12, 1)),
        'Novena da Imaculada Conceição (Dia 3)',
      );
      // 7 de dezembro = Dia 9
      expect(
        OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 12, 7)),
        'Novena da Imaculada Conceição (Dia 9)',
      );
      // 8 de dezembro = Festa (já não é novena)
      expect(
        OpusDeiCalendarData.getNovenaNotice(DateTime(2026, 12, 8)),
        isNull,
      );
    });

    test(
      'ComputusEngine preserva a liturgia geral e adiciona Opus Dei como extra',
      () {
        final day = ComputusEngine.getLiturgicalDay(DateTime(2026, 6, 26));
        expect(day.hasOpusDeiCelebration, isTrue);
        expect(day.opusDeiCelebration!.classRank, OpusDeiClass.classeA);
        expect(day.opusDeiCelebration!.classRank.letter, 'A');
        // No calendário geral, 26/06/2026 é sexta-feira da 12ª Semana do Tempo Comum (feria / verde)
        expect(day.rank, LiturgicalRank.feria);
        expect(day.color, LiturgicalColor.green);
      },
    );

    test('Nomenclatura das classes segue o padrão A, B, C, D', () {
      expect(OpusDeiClass.classeA.letter, 'A');
      expect(OpusDeiClass.classeB.letter, 'B');
      expect(OpusDeiClass.classeC.letter, 'C');
      expect(OpusDeiClass.classeD.letter, 'D');
    });

    test(
      'Dia 14 de setembro (Exaltação da Santa Cruz) é festa universal e não do Opus Dei',
      () {
        final celebration = OpusDeiCalendarData.getCelebration(9, 14);
        expect(celebration, isNull);

        final day = ComputusEngine.getLiturgicalDay(DateTime(2026, 9, 14));
        expect(day.hasOpusDeiCelebration, isFalse);
        expect(day.rank, LiturgicalRank.festa);
        expect(day.color, LiturgicalColor.red);
        expect(day.title, contains('Exaltação da Santa Cruz'));
      },
    );
  });

  group('AppProvider Opus Dei Celebrations Setting', () {
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      BaseProvider.resetCachedPrefs();
      SharedPreferences.setMockInitialValues({});
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/local_auth'),
            (MethodCall methodCall) async {
              if (methodCall.method == 'getAvailableBiometrics') {
                return <String>[];
              }
              return false;
            },
          );
    });

    tearDown(() {
      BaseProvider.resetCachedPrefs();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/local_auth'),
            null,
          );
    });

    test('Padrão de showOpusDeiCelebrations é true', () async {
      final provider = AppProvider();
      await provider.reload();
      expect(provider.showOpusDeiCelebrations, isTrue);
    });

    test('toggleOpusDeiCelebrations alterna e persiste o valor', () async {
      final provider = AppProvider();
      await provider.reload();
      expect(provider.showOpusDeiCelebrations, isTrue);

      await provider.toggleOpusDeiCelebrations();
      expect(provider.showOpusDeiCelebrations, isFalse);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppConstants.showOpusDeiCelebrationsKey), isFalse);

      await provider.toggleOpusDeiCelebrations();
      expect(provider.showOpusDeiCelebrations, isTrue);
      expect(prefs.getBool(AppConstants.showOpusDeiCelebrationsKey), isTrue);
    });

    test(
      'setShowOpusDeiCelebrations define e persiste o valor especificado',
      () async {
        final provider = AppProvider();
        await provider.reload();

        await provider.setShowOpusDeiCelebrations(false);
        expect(provider.showOpusDeiCelebrations, isFalse);

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getBool(AppConstants.showOpusDeiCelebrationsKey), isFalse);
      },
    );

    test(
      'Carrega valor false quando salvo previamente nas preferências',
      () async {
        SharedPreferences.setMockInitialValues({
          AppConstants.showOpusDeiCelebrationsKey: false,
        });

        final provider = AppProvider();
        await provider.reload();
        expect(provider.showOpusDeiCelebrations, isFalse);
      },
    );
  });
}

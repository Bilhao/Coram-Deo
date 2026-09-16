import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/services/opus_dei_calendar_data.dart';
import 'package:coramdeo/app/calendario/services/roman_sanctoral_data.dart';

class ComputusEngine {
  /// Algoritmo de Butcher (Meeus/Jones/Butcher) para cálculo exato da Páscoa Gregoriana.
  static DateTime calculateEaster(int year) {
    final a = year % 19;
    final b = year ~/ 100;
    final c = year % 100;
    final d = b ~/ 4;
    final e = b % 4;
    final f = (b + 8) ~/ 25;
    final g = (b - f + 1) ~/ 3;
    final h = (19 * a + b - d - g + 15) % 30;
    final i = c ~/ 4;
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = (a + 11 * h + 22 * l) ~/ 451;
    final month = (h + l - 7 * m + 114) ~/ 31;
    final day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }

  /// Deslocamento exato de dias em calendário civil (sem distorção de horário de verão).
  static DateTime _offset(DateTime date, int days) {
    return DateTime(date.year, date.month, date.day + days);
  }

  /// Diferença exata em dias entre duas datas (usando UTC para imunidade total a fusos).
  static int _daysBetween(DateTime from, DateTime to) {
    final fromUtc = DateTime.utc(from.year, from.month, from.day);
    final toUtc = DateTime.utc(to.year, to.month, to.day);
    return toUtc.difference(fromUtc).inDays;
  }

  /// Retorna o primeiro domingo do Advento de determinado ano (4 domingos antes do Natal).
  static DateTime calculateFirstSundayOfAdvent(int year) {
    final christmas = DateTime(year, 12, 25);
    // Encontra o domingo mais próximo do dia 30 de Novembro (São André)
    var cursor = _offset(christmas, -1);
    var sundaysCount = 0;
    while (sundaysCount < 4) {
      if (cursor.weekday == DateTime.sunday) {
        sundaysCount++;
        if (sundaysCount == 4) {
          return DateTime(cursor.year, cursor.month, cursor.day);
        }
      }
      cursor = _offset(cursor, -1);
    }
    return DateTime(year, 11, 27);
  }

  /// Gera o dia litúrgico canônico completo para qualquer data.
  static LiturgicalDay getLiturgicalDay(DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    final year = dateOnly.year;

    final easter = calculateEaster(year);
    final ashWednesday = _offset(easter, -46);
    final palmSunday = _offset(easter, -7);
    final holyThursday = _offset(easter, -3);
    final goodFriday = _offset(easter, -2);
    final holySaturday = _offset(easter, -1);
    final pentecost = _offset(easter, 49);
    final trinitySunday = _offset(easter, 56);
    final corpusChristi = _offset(easter, 60);
    final sacredHeart = _offset(easter, 68);
    final immaculateHeart = _offset(easter, 69);

    final firstSundayOfAdvent = calculateFirstSundayOfAdvent(year);
    final christTheKing = _offset(firstSundayOfAdvent, -7);

    // Determinação do Tempo Litúrgico e Cor Canônica
    LiturgicalSeason season;
    LiturgicalColor color;
    LiturgicalRank rank = dateOnly.weekday == DateTime.sunday ? LiturgicalRank.solenidade : LiturgicalRank.feria;
    String title = '';

    // 1. Quaresma e Semana Santa
    if (dateOnly.isAtSameMomentAs(ashWednesday)) {
      season = LiturgicalSeason.quaresma;
      color = LiturgicalColor.purple;
      rank = LiturgicalRank.solenidade;
      title = 'Quarta-feira de Cinzas';
    } else if (dateOnly.isAfter(ashWednesday) && dateOnly.isBefore(holyThursday)) {
      season = LiturgicalSeason.quaresma;
      if (dateOnly.isAtSameMomentAs(palmSunday)) {
        color = LiturgicalColor.red;
        rank = LiturgicalRank.solenidade;
        title = 'Domingo de Ramos e da Paixão do Senhor';
      } else if (dateOnly.isAtSameMomentAs(_offset(easter, -21))) {
        // 4º Domingo da Quaresma (Laetare)
        color = LiturgicalColor.rose;
        rank = LiturgicalRank.solenidade;
        title = '4º Domingo da Quaresma (Domingo Laetare)';
      } else if (dateOnly.weekday == DateTime.sunday) {
        color = LiturgicalColor.purple;
        rank = LiturgicalRank.solenidade;
        final sundayNum = 5 - (_daysBetween(dateOnly, palmSunday) ~/ 7);
        title = '$sundayNumº Domingo da Quaresma';
      } else {
        color = LiturgicalColor.purple;
        rank = LiturgicalRank.feria;
        final weekNum = ((_daysBetween(ashWednesday, dateOnly) + 3) ~/ 7) + 1;
        title = '${_weekdayName(dateOnly.weekday)} da $weekNumª Semana da Quaresma';
      }
    }
    // 2. Tríduo Pascal
    else if (dateOnly.isAtSameMomentAs(holyThursday)) {
      season = LiturgicalSeason.triduoPascal;
      color = LiturgicalColor.white;
      rank = LiturgicalRank.solenidade;
      title = 'Quinta-feira Santa — Missa da Ceia do Senhor';
    } else if (dateOnly.isAtSameMomentAs(goodFriday)) {
      season = LiturgicalSeason.triduoPascal;
      color = LiturgicalColor.red;
      rank = LiturgicalRank.solenidade;
      title = 'Sexta-feira Santa — Celebração da Paixão do Senhor';
    } else if (dateOnly.isAtSameMomentAs(holySaturday)) {
      season = LiturgicalSeason.triduoPascal;
      color = LiturgicalColor.purple;
      rank = LiturgicalRank.solenidade;
      title = 'Sábado Santo — Sepultura do Senhor (Vigília Pascal)';
    } else if (dateOnly.isAtSameMomentAs(easter)) {
      season = LiturgicalSeason.tempoPascal;
      color = LiturgicalColor.white;
      rank = LiturgicalRank.solenidade;
      title = 'Domingo da Páscoa na Ressurreição do Senhor';
    }
    // 3. Tempo Pascal (até Pentecostes)
    else if (dateOnly.isAfter(easter) && dateOnly.isBefore(_offset(pentecost, 1))) {
      season = LiturgicalSeason.tempoPascal;
      if (dateOnly.isAtSameMomentAs(pentecost)) {
        color = LiturgicalColor.red;
        rank = LiturgicalRank.solenidade;
        title = 'Domingo de Pentecostes';
      } else if (dateOnly.isBefore(_offset(easter, 8))) {
        color = LiturgicalColor.white;
        rank = LiturgicalRank.solenidade;
        if (dateOnly.isAtSameMomentAs(_offset(easter, 7))) {
          title = '2º Domingo da Páscoa ou da Divina Misericórdia';
        } else {
          title = '${_weekdayName(dateOnly.weekday)} na Oitava da Páscoa';
        }
      } else if (dateOnly.weekday == DateTime.sunday) {
        color = LiturgicalColor.white;
        rank = LiturgicalRank.solenidade;
        final sundayNum = (_daysBetween(easter, dateOnly) ~/ 7) + 1;
        title = '$sundayNumº Domingo da Páscoa';
      } else {
        color = LiturgicalColor.white;
        rank = LiturgicalRank.feria;
        final weekNum = (_daysBetween(easter, dateOnly) ~/ 7) + 1;
        title = '${_weekdayName(dateOnly.weekday)} da $weekNumª Semana do Tempo Pascal';
      }
    }
    // 4. Advento
    else if (dateOnly.isAtSameMomentAs(firstSundayOfAdvent) ||
        (dateOnly.isAfter(firstSundayOfAdvent) && dateOnly.isBefore(DateTime(year, 12, 25)))) {
      season = LiturgicalSeason.advento;
      final gaudeteSunday = _offset(firstSundayOfAdvent, 14);

      if (dateOnly.isAtSameMomentAs(gaudeteSunday)) {
        color = LiturgicalColor.rose;
        rank = LiturgicalRank.solenidade;
        title = '3º Domingo do Advento (Domingo Gaudete)';
      } else if (dateOnly.weekday == DateTime.sunday) {
        color = LiturgicalColor.purple;
        rank = LiturgicalRank.solenidade;
        final sundayNum = (_daysBetween(firstSundayOfAdvent, dateOnly) ~/ 7) + 1;
        title = '$sundayNumº Domingo do Advento';
      } else {
        color = LiturgicalColor.purple;
        rank = LiturgicalRank.feria;
        final weekNum = (_daysBetween(firstSundayOfAdvent, dateOnly) ~/ 7) + 1;
        title = '${_weekdayName(dateOnly.weekday)} da $weekNumª Semana do Advento';
      }
    }
    // 5. Natal e Epifania (25/12 até o Batismo do Senhor no início de Janeiro)
    else if (dateOnly.month == 12 && dateOnly.day >= 25) {
      season = LiturgicalSeason.natal;
      color = LiturgicalColor.white;
      if (dateOnly.day == 25) {
        rank = LiturgicalRank.solenidade;
        title = 'Natal de Nosso Senhor Jesus Cristo';
      } else if (dateOnly.day == 26) {
        rank = LiturgicalRank.festa;
        color = LiturgicalColor.red;
        title = 'Santo Estêvão, primeiro mártir';
      } else if (dateOnly.day == 27) {
        rank = LiturgicalRank.festa;
        color = LiturgicalColor.white;
        title = 'São João, Apóstolo e Evangelista';
      } else if (dateOnly.day == 28) {
        rank = LiturgicalRank.festa;
        color = LiturgicalColor.red;
        title = 'Santos Inocentes, mártires';
      } else {
        rank = LiturgicalRank.solenidade;
        title = 'Dia ${_getOrdinal(dateOnly.day - 24)} na Oitava do Natal';
      }
    } else if (dateOnly.month == 1 && dateOnly.day <= 13 && _isBeforeBaptismOfLord(dateOnly)) {
      season = LiturgicalSeason.natal;
      color = LiturgicalColor.white;
      if (dateOnly.day == 1) {
        rank = LiturgicalRank.solenidade;
        title = 'Santa Maria, Mãe de Deus';
      } else if (dateOnly.day == 6) {
        rank = LiturgicalRank.solenidade;
        title = 'Epifania do Senhor';
      } else {
        title = 'Tempo do Natal (${dateOnly.day} de Janeiro)';
      }
    }
    // 6. Tempo Comum
    else {
      season = LiturgicalSeason.tempoComum;
      color = LiturgicalColor.green;

      // Solenidades Móveis do Tempo Comum
      if (dateOnly.isAtSameMomentAs(trinitySunday)) {
        color = LiturgicalColor.white;
        rank = LiturgicalRank.solenidade;
        title = 'Santíssima Trindade';
      } else if (dateOnly.isAtSameMomentAs(corpusChristi)) {
        color = LiturgicalColor.white;
        rank = LiturgicalRank.solenidade;
        title = 'Santíssimo Corpo e Sangue de Cristo (Corpus Christi)';
      } else if (dateOnly.isAtSameMomentAs(sacredHeart)) {
        color = LiturgicalColor.white;
        rank = LiturgicalRank.solenidade;
        title = 'Sagrado Coração de Jesus';
      } else if (dateOnly.isAtSameMomentAs(immaculateHeart)) {
        color = LiturgicalColor.white;
        rank = LiturgicalRank.memoriaObrigatoria;
        title = 'Imaculado Coração da Bem-Aventurada Virgem Maria';
      } else if (dateOnly.isAtSameMomentAs(christTheKing)) {
        color = LiturgicalColor.white;
        rank = LiturgicalRank.solenidade;
        title = 'Nosso Senhor Jesus Cristo, Rei do Universo';
      } else if (dateOnly.weekday == DateTime.sunday) {
        rank = LiturgicalRank.solenidade;
        final week = _calculateOrdinaryTimeWeek(dateOnly, easter, firstSundayOfAdvent);
        title = '$weekº Domingo do Tempo Comum';
      } else {
        rank = LiturgicalRank.feria;
        final week = _calculateOrdinaryTimeWeek(dateOnly, easter, firstSundayOfAdvent);
        title = '${_weekdayName(dateOnly.weekday)} da $weekª Semana do Tempo Comum';
      }
    }

    // Santo ou Memória do Calendário Romano Geral
    String? saintOfTheDay;
    final sanctoralEntry = RomanSanctoralData.getSaint(dateOnly.month, dateOnly.day);
    if (sanctoralEntry != null) {
      saintOfTheDay = sanctoralEntry.name;
      if (season == LiturgicalSeason.tempoComum && dateOnly.weekday != DateTime.sunday) {
        if (sanctoralEntry.rank.precedence < rank.precedence) {
          rank = sanctoralEntry.rank;
          color = sanctoralEntry.color;
          title = sanctoralEntry.name;
        }
      } else if (sanctoralEntry.rank == LiturgicalRank.solenidade || sanctoralEntry.rank == LiturgicalRank.festa) {
        if (sanctoralEntry.rank.precedence <= rank.precedence) {
          rank = sanctoralEntry.rank;
          color = sanctoralEntry.color;
          title = sanctoralEntry.name;
        }
      }
    }

    // Solenidades e Festas Fixas do Calendário Romano Geral
    final fixedFeast = _checkFixedRomanFeasts(dateOnly);
    if (fixedFeast != null) {
      if (fixedFeast.rank.precedence <= rank.precedence) {
        rank = fixedFeast.rank;
        color = fixedFeast.color;
        title = fixedFeast.title;
        saintOfTheDay ??= fixedFeast.title;
      }
    }

    // Celebrações Próprias do Opus Dei
    final opusDei = OpusDeiCalendarData.getCelebration(dateOnly.month, dateOnly.day);
    if (opusDei != null) {
      if (opusDei.classRank == OpusDeiClass.classeA) {
        rank = LiturgicalRank.solenidade;
        color = LiturgicalColor.white;
      } else if (opusDei.classRank == OpusDeiClass.classeB) {
        if (rank != LiturgicalRank.solenidade) {
          rank = LiturgicalRank.festa;
          color = (dateOnly.month == 9 && dateOnly.day == 14) ? LiturgicalColor.red : LiturgicalColor.white;
        }
      }
    }

    final novena = OpusDeiCalendarData.getNovenaNotice(dateOnly);

    return LiturgicalDay(
      date: dateOnly,
      title: title,
      season: season,
      color: color,
      rank: rank,
      opusDeiCelebration: opusDei,
      novenaNotice: novena,
      saintOfTheDay: saintOfTheDay,
    );
  }

  static bool _isBeforeBaptismOfLord(DateTime date) {
    // O Batismo do Senhor ocorre no domingo após 6 de janeiro
    final epiphany = DateTime(date.year, 1, 6);
    var cursor = _offset(epiphany, 1);
    while (cursor.weekday != DateTime.sunday) {
      cursor = _offset(cursor, 1);
    }
    return !date.isAfter(cursor);
  }

  static int _calculateOrdinaryTimeWeek(DateTime date, DateTime easter, DateTime firstSundayOfAdvent) {
    // Estimativa canônica da semana do Tempo Comum
    final ashWednesday = _offset(easter, -46);
    if (date.isBefore(ashWednesday)) {
      // 1ª Parte do Tempo Comum
      final baptism = DateTime(date.year, 1, 6);
      var firstMonday = _offset(baptism, 1);
      while (firstMonday.weekday != DateTime.monday) {
        firstMonday = _offset(firstMonday, 1);
      }
      final diff = _daysBetween(firstMonday, date);
      return (diff ~/ 7) + 1;
    } else {
      // 2ª Parte do Tempo Comum (contada retroativamente a partir de Cristo Rei que é a 34ª semana)
      final christTheKing = _offset(firstSundayOfAdvent, -7);
      final weeksBeforeEnd = (_daysBetween(date, christTheKing) ~/ 7);
      final week = 34 - weeksBeforeEnd;
      return week.clamp(1, 34);
    }
  }

  static ({String title, LiturgicalColor color, LiturgicalRank rank})? _checkFixedRomanFeasts(DateTime date) {
    final m = date.month;
    final d = date.day;

    if (m == 1 && d == 1) {
      return (title: 'Santa Maria, Mãe de Deus', color: LiturgicalColor.white, rank: LiturgicalRank.solenidade);
    }
    if (m == 3 && d == 19) {
      return (title: 'São José, Esposo da Virgem Maria', color: LiturgicalColor.white, rank: LiturgicalRank.solenidade);
    }
    if (m == 3 && d == 25) {
      return (title: 'Anunciação do Senhor', color: LiturgicalColor.white, rank: LiturgicalRank.solenidade);
    }
    if (m == 6 && d == 24) {
      return (title: 'Natividade de São João Batista', color: LiturgicalColor.white, rank: LiturgicalRank.solenidade);
    }
    if (m == 6 && d == 29) {
      return (title: 'Santos Pedro e Paulo, Apóstolos', color: LiturgicalColor.red, rank: LiturgicalRank.solenidade);
    }
    if (m == 8 && d == 6) {
      return (title: 'Transfiguração do Senhor', color: LiturgicalColor.white, rank: LiturgicalRank.festa);
    }
    if (m == 8 && d == 15) {
      return (title: 'Assunção da Bem-Aventurada Virgem Maria', color: LiturgicalColor.white, rank: LiturgicalRank.solenidade);
    }
    if (m == 9 && d == 8) {
      return (title: 'Natividade da Bem-Aventurada Virgem Maria', color: LiturgicalColor.white, rank: LiturgicalRank.festa);
    }
    if (m == 9 && d == 14) {
      return (title: 'Exaltação da Santa Cruz', color: LiturgicalColor.red, rank: LiturgicalRank.festa);
    }
    if (m == 9 && d == 29) {
      return (title: 'Santos Miguel, Gabriel e Rafael, Arcanjos', color: LiturgicalColor.white, rank: LiturgicalRank.festa);
    }
    if (m == 11 && d == 1) {
      return (title: 'Todos os Santos', color: LiturgicalColor.white, rank: LiturgicalRank.solenidade);
    }
    if (m == 11 && d == 2) {
      return (title: 'Comemoração de Todos os Fiéis Defuntos', color: LiturgicalColor.purple, rank: LiturgicalRank.solenidade);
    }
    if (m == 12 && d == 8) {
      return (title: 'Imaculada Conceição da Bem-Aventurada Virgem Maria', color: LiturgicalColor.white, rank: LiturgicalRank.solenidade);
    }
    return null;
  }

  static String _weekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Segunda-feira';
      case DateTime.tuesday:
        return 'Terça-feira';
      case DateTime.wednesday:
        return 'Quarta-feira';
      case DateTime.thursday:
        return 'Quinta-feira';
      case DateTime.friday:
        return 'Sexta-feira';
      case DateTime.saturday:
        return 'Sábado';
      case DateTime.sunday:
        return 'Domingo';
      default:
        return '';
    }
  }

  static String _getOrdinal(int n) {
    switch (n) {
      case 1:
        return '1º';
      case 2:
        return '2º';
      case 3:
        return '3º';
      case 4:
        return '4º';
      case 5:
        return '5º';
      case 6:
        return '6º';
      case 7:
        return '7º';
      case 8:
        return '8º';
      default:
        return '$nº';
    }
  }
}

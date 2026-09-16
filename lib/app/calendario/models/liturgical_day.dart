import 'package:flutter/material.dart';

enum LiturgicalColor {
  green,
  white,
  red,
  purple,
  rose,
}

extension LiturgicalColorExtension on LiturgicalColor {
  String get displayName {
    switch (this) {
      case LiturgicalColor.green:
        return 'Verde';
      case LiturgicalColor.white:
        return 'Branco';
      case LiturgicalColor.red:
        return 'Vermelho';
      case LiturgicalColor.purple:
        return 'Roxo';
      case LiturgicalColor.rose:
        return 'Rosa';
    }
  }

  Color get colorValue {
    switch (this) {
      case LiturgicalColor.green:
        return const Color(0xFF2E7D32); // Verde Litúrgico
      case LiturgicalColor.white:
        return const Color(0xFFD4AF37); // Ouro / Branco Nobre
      case LiturgicalColor.red:
        return const Color(0xFFC62828); // Vermelho Litúrgico
      case LiturgicalColor.purple:
        return const Color(0xFF6A1B9A); // Roxo Litúrgico
      case LiturgicalColor.rose:
        return const Color(0xFFE91E63); // Rosa Litúrgico (Gaudete / Laetare)
    }
  }

  Color containerColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (this) {
      case LiturgicalColor.green:
        return isDark ? const Color(0xFF1B3B22) : const Color(0xFFE8F5E9);
      case LiturgicalColor.white:
        return isDark ? const Color(0xFF332B14) : const Color(0xFFFFF9E6);
      case LiturgicalColor.red:
        return isDark ? const Color(0xFF3E1818) : const Color(0xFFFFEBEE);
      case LiturgicalColor.purple:
        return isDark ? const Color(0xFF2C133B) : const Color(0xFFF3E5F5);
      case LiturgicalColor.rose:
        return isDark ? const Color(0xFF3B1425) : const Color(0xFFFCE4EC);
    }
  }

  Color onContainerColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (this) {
      case LiturgicalColor.green:
        return isDark ? const Color(0xFFA5D6A7) : const Color(0xFF1B5E20);
      case LiturgicalColor.white:
        return isDark ? const Color(0xFFFFE082) : const Color(0xFFB78103);
      case LiturgicalColor.red:
        return isDark ? const Color(0xFFEF9A9A) : const Color(0xFFB71C1C);
      case LiturgicalColor.purple:
        return isDark ? const Color(0xFFCE93D8) : const Color(0xFF4A148C);
      case LiturgicalColor.rose:
        return isDark ? const Color(0xFFF48FB1) : const Color(0xFF880E4F);
    }
  }
}

enum LiturgicalSeason {
  advento,
  natal,
  tempoComum,
  quaresma,
  triduoPascal,
  tempoPascal,
}

extension LiturgicalSeasonExtension on LiturgicalSeason {
  String get displayName {
    switch (this) {
      case LiturgicalSeason.advento:
        return 'Tempo do Advento';
      case LiturgicalSeason.natal:
        return 'Tempo do Natal';
      case LiturgicalSeason.tempoComum:
        return 'Tempo Comum';
      case LiturgicalSeason.quaresma:
        return 'Tempo da Quaresma';
      case LiturgicalSeason.triduoPascal:
        return 'Tríduo Pascal';
      case LiturgicalSeason.tempoPascal:
        return 'Tempo Pascal';
    }
  }
}

enum LiturgicalRank {
  solenidade,
  festa,
  memoriaObrigatoria,
  memoriaFacultativa,
  feria,
}

extension LiturgicalRankExtension on LiturgicalRank {
  String get displayName {
    switch (this) {
      case LiturgicalRank.solenidade:
        return 'Solenidade';
      case LiturgicalRank.festa:
        return 'Festa';
      case LiturgicalRank.memoriaObrigatoria:
        return 'Memória';
      case LiturgicalRank.memoriaFacultativa:
        return 'Memória Facultativa';
      case LiturgicalRank.feria:
        return 'Dia de semana';
    }
  }

  int get precedence {
    switch (this) {
      case LiturgicalRank.solenidade:
        return 1;
      case LiturgicalRank.festa:
        return 2;
      case LiturgicalRank.memoriaObrigatoria:
        return 3;
      case LiturgicalRank.memoriaFacultativa:
        return 4;
      case LiturgicalRank.feria:
        return 5;
    }
  }
}

enum OpusDeiClass {
  classeA, // Grandes Solenidades da Prelazia
  classeB, // Festas de 2ª Classe e Patronos
  classeC, // Memórias e Aniversários Históricos
}

extension OpusDeiClassExtension on OpusDeiClass {
  String get badgeLabel {
    switch (this) {
      case OpusDeiClass.classeA:
        return 'Opus Dei - A';
      case OpusDeiClass.classeB:
        return 'Opus Dei - B';
      case OpusDeiClass.classeC:
        return 'Opus Dei - C';
    }
  }

  String get fullTitle {
    switch (this) {
      case OpusDeiClass.classeA:
        return 'Opus Dei - A';
      case OpusDeiClass.classeB:
        return 'Opus Dei - B';
      case OpusDeiClass.classeC:
        return 'Opus Dei - C';
    }
  }

  Color badgeColor(BuildContext context) {
    switch (this) {
      case OpusDeiClass.classeA:
        return const Color(0xFFDAB264); // Ouro Litúrgico
      case OpusDeiClass.classeB:
        return Theme.of(context).colorScheme.primary;
      case OpusDeiClass.classeC:
        return const Color(0xFFD97706); // Âmbar
    }
  }
}

class OpusDeiCelebration {
  final String name;
  final OpusDeiClass classRank;
  final String description;

  const OpusDeiCelebration({
    required this.name,
    required this.classRank,
    required this.description,
  });
}

class LiturgicalDay {
  final DateTime date;
  final String title;
  final LiturgicalSeason season;
  final LiturgicalColor color;
  final LiturgicalRank rank;
  final OpusDeiCelebration? opusDeiCelebration;
  final String? novenaNotice;
  final String? saintOfTheDay;

  const LiturgicalDay({
    required this.date,
    required this.title,
    required this.season,
    required this.color,
    required this.rank,
    this.opusDeiCelebration,
    this.novenaNotice,
    this.saintOfTheDay,
  });

  bool get isSunday => date.weekday == DateTime.sunday;
  bool get hasOpusDeiCelebration => opusDeiCelebration != null;
  bool get hasNovena => novenaNotice != null && novenaNotice!.isNotEmpty;
  bool get hasSaintOfTheDay => saintOfTheDay != null && saintOfTheDay!.isNotEmpty;
}


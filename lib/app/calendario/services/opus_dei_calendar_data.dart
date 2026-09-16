import 'package:coramdeo/app/calendario/models/liturgical_day.dart';

class OpusDeiCalendarData {
  static final Map<String, OpusDeiCelebration> celebrations = {
    // CLASSE A — Grandes Solenidades da Prelazia
    '02-14': const OpusDeiCelebration(
      name: 'Início do Apostolado com Mulheres e da Sociedade Sacerdotal da Santa Cruz',
      classRank: OpusDeiClass.classeA,
      description:
          'Em 14 de fevereiro de 1930, São Josemaria compreendeu por inspiração divina que o Opus Dei deveria desenvolver-se também entre as mulheres. No mesmo dia em 1943, nasceu a Sociedade Sacerdotal da Santa Cruz.',
    ),
    '03-19': const OpusDeiCelebration(
      name: 'São José, Esposo da Virgem Maria e Patrono da Obra',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade de São José, Patrono da Igreja e do Opus Dei. Neste dia, os fiéis da Obra renovam a sua consagração e compromisso de santidade no meio do mundo.',
    ),
    '05-02': const OpusDeiCelebration(
      name: 'Dedicação da Igreja Prelatícia de Santa Maria da Paz',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade da dedicação da igreja prelatícia em Roma, onde repousam os restos sagrados de São Josemaria e do Beato Álvaro del Portillo.',
    ),
    '06-26': const OpusDeiCelebration(
      name: 'São Josemaria Escrivá, Fundador do Opus Dei',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade litúrgica de São Josemaria Escrivá de Balaguer (1902–1975), canonizado por São João Paulo II como o proclamador da vocação universal à santidade no trabalho profissional e na vida cotidiana.',
    ),
    '10-02': const OpusDeiCelebration(
      name: 'Fundação do Opus Dei e Santos Anjos da Guarda',
      classRank: OpusDeiClass.classeA,
      description:
          'Solenidade da fundação do Opus Dei por inspiração divina recebida por São Josemaria em Madrid, no dia 2 de outubro de 1928, festa dos Santos Anjos da Guarda.',
    ),

    // CLASSE B — Festas de 2ª Classe e Patronos
    '05-12': const OpusDeiCelebration(
      name: 'Beato Álvaro del Portillo, bispo',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa litúrgica do primeiro sucessor de São Josemaria à frente do Opus Dei. Fiel cooperador e exemplo de paz e dedicação à Igreja.',
    ),
    '05-18': const OpusDeiCelebration(
      name: 'Beata Guadalupe Ortiz de Landázuri',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa da primeira fiel leiga do Opus Dei a ser elevada aos altares. Professora e cientista que viveu a santidade com alegre e generosa fidelidade.',
    ),
    '06-29': const OpusDeiCelebration(
      name: 'Santos Apóstolos Pedro e Paulo',
      classRank: OpusDeiClass.classeB,
      description:
          'Patronos do apostolado do Opus Dei. Devoção ardente à Santa Sé, ao Romano Pontífice e à unidade da Igreja Católica.',
    ),
    '09-14': const OpusDeiCelebration(
      name: 'Exaltação da Santa Cruz',
      classRank: OpusDeiClass.classeB,
      description:
          'Festa da Santa Cruz, titular da Sociedade Sacerdotal da Santa Cruz e símbolo central da Redenção e do amor apaixonado a Cristo Crucificado.',
    ),
    '09-29': const OpusDeiCelebration(
      name: 'Santos Arcanjos Miguel, Gabriel e Rafael',
      classRank: OpusDeiClass.classeB,
      description:
          'Patronos dos três apostolados da Obra: São Miguel (fidelidade e celibato apostólico), São Gabriel (supernumerários e cooperadores) e São Rafael (juventude).',
    ),
    '10-24': const OpusDeiCelebration(
      name: 'São Rafael Arcanjo',
      classRank: OpusDeiClass.classeB,
      description:
          'Patrono particular do trabalho formativo e apostólico com a juventude (Obra de São Rafael).',
    ),
    '11-08': const OpusDeiCelebration(
      name: 'Santos de que se Guardam Relíquias nos Oratórios',
      classRank: OpusDeiClass.classeB,
      description:
          'Comemoração festiva de todos os santos cujas santas relíquias estão presentes nos oratórios e centros da Prelazia.',
    ),
    '12-27': const OpusDeiCelebration(
      name: 'São João Apóstolo e Evangelista',
      classRank: OpusDeiClass.classeB,
      description:
          'Patrono do apostolado com cooperadores e amigos da Obra. Modelo de virgindade, fidelidade junto à Cruz e amor a Santa Maria.',
    ),

    // CLASSE C — Memórias e Aniversários Históricos da Prelazia
    '01-09': const OpusDeiCelebration(
      name: 'Nascimento de São Josemaria Escrivá (1902)',
      classRank: OpusDeiClass.classeC,
      description:
          'Aniversário de nascimento de São Josemaria em Barbastro, Espanha. Ação de graças pelo dom da sua vida à Igreja.',
    ),
    '03-23': const OpusDeiCelebration(
      name: 'Trânsito do Beato Álvaro del Portillo (1994)',
      classRank: OpusDeiClass.classeC,
      description:
          'Aniversário da partida para o Céu do Beato Álvaro del Portillo, poucas horas após o seu regresso de uma peregrinação à Terra Santa.',
    ),
    '03-28': const OpusDeiCelebration(
      name: 'Ordenação Sacerdotal de São Josemaria (1925)',
      classRank: OpusDeiClass.classeC,
      description:
          'Aniversário de ordenação sacerdotal do fundador do Opus Dei na igreja do Seminário de São Carlos, em Saragoça.',
    ),
    '05-17': const OpusDeiCelebration(
      name: 'Beatificação de São Josemaria (1992)',
      classRank: OpusDeiClass.classeC,
      description:
          'Aniversário da solene beatificação de São Josemaria pelo Papa São João Paulo II na Praça de São Pedro, em Roma.',
    ),
    '08-15': const OpusDeiCelebration(
      name: 'Consagração do Opus Dei a Nossa Senhora (1951)',
      classRank: OpusDeiClass.classeC,
      description:
          'Na Solenidade da Assunção de 1951, São Josemaria consagrou o Opus Dei ao Santíssimo Coração de Maria no Santuário de Loreto, Itália.',
    ),
    '08-21': const OpusDeiCelebration(
      name: 'Consagração da Obra ao Coração Dulcíssimo de Maria (1951)',
      classRank: OpusDeiClass.classeC,
      description:
          'Celebração anual da consagração mariana, pedindo pela perseverança e santidade de todas as pessoas da Prelazia.',
    ),
    '10-06': const OpusDeiCelebration(
      name: 'Canonização de São Josemaria (2002)',
      classRank: OpusDeiClass.classeC,
      description:
          'Aniversário da canonização de São Josemaria por São João Paulo II diante de centenas de milhares de peregrinos de mais de 80 países.',
    ),
    '11-28': const OpusDeiCelebration(
      name: 'Ereção do Opus Dei como Prelazia Pessoal (1982)',
      classRank: OpusDeiClass.classeC,
      description:
          'Aniversário da publicação da Constituição Apostólica "Ut Sit", pela qual São João Paulo II erigiu o Opus Dei em Prelazia Pessoal de âmbito internacional.',
    ),
  };

  /// Obtém a celebração do Opus Dei para um mês e dia específicos.
  static OpusDeiCelebration? getCelebration(int month, int day) {
    final key = '${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    return celebrations[key];
  }

  /// Retorna o aviso da novena tradicional em andamento se aplicável.
  static String? getNovenaNotice(DateTime date) {
    // 1. Sete Domingos de São José (7 domingos antes de 19 de Março)
    final year = date.year;
    // Encontrar os 7 domingos anteriores
    final sundays = <DateTime>[];
    var cursor = DateTime(year, 3, 18);
    while (sundays.length < 7) {
      if (cursor.weekday == DateTime.sunday) {
        sundays.insert(0, DateTime(cursor.year, cursor.month, cursor.day));
      }
      cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
    }

    final dateOnly = DateTime(date.year, date.month, date.day);
    for (int i = 0; i < sundays.length; i++) {
      if (dateOnly == sundays[i]) {
        return '${i + 1}º Domingo de São José (Dores e Alegrias)';
      }
    }

    // 2. Novena da Imaculada Conceição (29 de Novembro a 7 de Dezembro)
    if (date.month == 11 && date.day >= 29) {
      final dayNum = date.day - 28; // 29 -> 1, 30 -> 2
      return 'Novena da Imaculada Conceição (Dia $dayNum)';
    } else if (date.month == 12 && date.day <= 7) {
      final dayNum = date.day + 2; // 1 -> 3, 7 -> 9
      return 'Novena da Imaculada Conceição (Dia $dayNum)';
    }

    return null;
  }
}

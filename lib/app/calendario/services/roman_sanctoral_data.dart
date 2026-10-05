import 'package:coramdeo/app/calendario/models/liturgical_day.dart';

/// Santos e memórias celebradas no Calendário Romano Geral e Martirológio Romano.
class RomanSanctoralData {
  static final Map<
    String,
    ({String name, LiturgicalRank rank, LiturgicalColor color})
  >
  _sanctoral = {
    // JANEIRO
    '01-01': (
      name: 'Santa Maria, Mãe de Deus',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.white,
    ),
    '01-02': (
      name: 'São Basílio Magno e São Gregório Nazianzeno',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '01-03': (
      name: 'Santíssimo Nome de Jesus',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '01-04': (
      name: 'Santa Isabel Ana Seton',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-05': (
      name: 'São João Neumann',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-06': (
      name: 'Epifania do Senhor',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.white,
    ),
    '01-07': (
      name: 'São Raimundo de Peñafort',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '01-08': (
      name: 'São Severino de Nórica',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-09': (
      name: 'Santo Adriano de Cantuária',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-10': (
      name: 'São Gregório de Nissa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-11': (
      name: 'São Paulino de Aquileia',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-12': (
      name: 'São Bernardo de Corleone',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-13': (
      name: 'Santo Hilário',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '01-14': (
      name: 'São Félix de Nola',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-15': (
      name: 'Santo Arnoldo Janssen',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-16': (
      name: 'São Marcelo I',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-17': (
      name: 'Santo Antão',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '01-18': (
      name: 'Santa Margarida da Hungria',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-19': (
      name: 'São Germânico de Esmirna',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-20': (
      name: 'São Sebastião',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '01-21': (
      name: 'Santa Inês',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '01-22': (
      name: 'São Vicente',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '01-23': (
      name: 'Santo Ildefonso de Toledo',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-24': (
      name: 'São Francisco de Sales',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '01-25': (
      name: 'Conversão de São Paulo',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    '01-26': (
      name: 'Santos Timóteo e Tito',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '01-27': (
      name: 'Santa Ângela Mérici',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '01-28': (
      name: 'São Tomás de Aquino',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '01-29': (
      name: 'São Gildas de Rhuys',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-30': (
      name: 'Santa Jacinta Mariscotti',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '01-31': (
      name: 'São João Bosco',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    // FEVEREIRO
    '02-01': (
      name: 'Santo Ansgar',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-02': (
      name: 'Apresentação do Senhor',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    '02-03': (
      name: 'São Brás',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '02-04': (
      name: 'São João de Brito',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-05': (
      name: 'Santa Águeda',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '02-06': (
      name: 'Santos Paulo Miki e Companheiros',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '02-07': (
      name: 'São Ricardo, Rei',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-08': (
      name: 'Santa Josefina Bakhita',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '02-09': (
      name: 'Santa Apolônia',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-10': (
      name: 'Santa Escolástica',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '02-11': (
      name: 'Nossa Senhora de Lourdes',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '02-12': (
      name: 'Santos Mártires de Abitina',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-13': (
      name: 'Santa Catarina de Ricci',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-14': (
      name: 'Santos Cirilo e Metódio',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '02-15': (
      name: 'São Cláudio de la Colombière',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-16': (
      name: 'Santa Juliana de Nicomédia',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-17': (
      name: 'Sete Santos Fundadores dos Servitas',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '02-18': (
      name: 'São Fláviano de Constantinopla',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-19': (
      name: 'São Conrado de Piacenza',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-20': (
      name: 'Santos Francisco e Jacinta Marto',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-21': (
      name: 'São Pedro Damião',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '02-22': (
      name: 'Cátedra de São Pedro',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    '02-23': (
      name: 'São Policarpo',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '02-24': (
      name: 'São Modesto de Tréveris',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-25': (
      name: 'São Cesário de Nazianzo',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-26': (
      name: 'São Porfírio de Gaza',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-27': (
      name: 'São Gabriel de Nossa Senhora das Dores',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-28': (
      name: 'Santo Hilário, Papa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '02-29': (
      name: 'São Gregório de Narek',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    // MARÇO
    '03-01': (
      name: 'São Davi de Gales',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-02': (
      name: 'Santa Inês de Praga',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-03': (
      name: 'Santa Cunegundes',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-04': (
      name: 'São Casimiro',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '03-05': (
      name: 'São João José da Cruz',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-06': (
      name: 'Santa Coleta de Corbie',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-07': (
      name: 'Santas Perpétua e Felicidade',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '03-08': (
      name: 'São João de Deus',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '03-09': (
      name: 'Santa Francisca Romana',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '03-10': (
      name: 'São João Ogilvie',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-11': (
      name: 'São Sofrônio de Jerusalém',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-12': (
      name: 'São Maximiliano de Tébessa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-13': (
      name: 'Santa Eufrásia',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-14': (
      name: 'Santa Matilde',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-15': (
      name: 'Santa Luísa de Marillac',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-16': (
      name: 'São José Gabriel Brochero',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-17': (
      name: 'São Patrício',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '03-18': (
      name: 'São Cirilo de Jerusalém',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '03-19': (
      name: 'São José, Esposo da Virgem Maria',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.white,
    ),
    '03-20': (
      name: 'Santa Maria Josefa do Coração de Jesus',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-21': (
      name: 'São Nicolau de Flüe',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-22': (
      name: 'Santa Léa de Roma',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-23': (
      name: 'São Turíbio de Mogrovejo',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '03-24': (
      name: 'Santa Catarina da Suécia',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-25': (
      name: 'Anunciação do Senhor',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.white,
    ),
    '03-26': (
      name: 'São Bráulio de Saragoça',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-27': (
      name: 'São Ruperto de Salzburgo',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-28': (
      name: 'São Sisto III, Papa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-29': (
      name: 'São Ludolfo de Ratzeburg',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-30': (
      name: 'São João Clímaco',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '03-31': (
      name: 'São Benjamim',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    // ABRIL
    '04-01': (
      name: 'Santo Hugo de Grenoble',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-02': (
      name: 'São Francisco de Paula',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '04-03': (
      name: 'São Ricardo de Chichester',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-04': (
      name: 'Santo Isidoro',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '04-05': (
      name: 'São Vicente Ferrer',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '04-06': (
      name: 'São Marcelino de Cartago',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-07': (
      name: 'São João Batista de La Salle',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '04-08': (
      name: 'Santa Júlia Billiart',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-09': (
      name: 'Santa Casilda de Toledo',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-10': (
      name: 'Santa Madalena de Canossa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-11': (
      name: 'Santo Estanislau',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '04-12': (
      name: 'São Júlio I, Papa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-13': (
      name: 'São Martinho I',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '04-14': (
      name: 'Santa Lidvina',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-15': (
      name: 'São Damião de Veuster',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-16': (
      name: 'Santa Bernadete Soubirous',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-17': (
      name: 'Santo Estêvão Harding',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-18': (
      name: 'Santo Ursmar de Lobbes',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-19': (
      name: 'Santo Expedito',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-20': (
      name: 'Santa Inês de Montepulciano',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-21': (
      name: 'Santo Anselmo',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '04-22': (
      name: 'Santo Agapito I, Papa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-23': (
      name: 'São Jorge',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '04-24': (
      name: 'São Fidélis de Sigmaringa',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '04-25': (
      name: 'São Marcos',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '04-26': (
      name: 'São Rafael Arnáiz Barón',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-27': (
      name: 'Santa Zita de Lucca',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '04-28': (
      name: 'São Luís Maria Grignion de Montfort',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '04-29': (
      name: 'Santa Catarina de Sena',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '04-30': (
      name: 'São Pio V',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    // MAIO
    '05-01': (
      name: 'São José Operário',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '05-02': (
      name: 'Santo Atanásio',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '05-03': (
      name: 'Santos Filipe e Tiago',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '05-04': (
      name: 'São Floriano de Lorch',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-05': (
      name: 'Santo Ângelo de Jerusalém',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-06': (
      name: 'São Domingos Sávio',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-07': (
      name: 'Santa Rosa Venerini',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-08': (
      name: 'São Bonifácio IV, Papa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-09': (
      name: 'São Pacômio',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-10': (
      name: 'São João de Ávila',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-11': (
      name: 'Santo Inácio de Láconi',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-12': (
      name: 'Santos Nereu e Aquiles',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '05-13': (
      name: 'Nossa Senhora de Fátima',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '05-14': (
      name: 'São Matias',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '05-15': (
      name: 'Santo Isidro Lavrador',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-16': (
      name: 'São Simão Stock',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-17': (
      name: 'São Pascoal Bailão',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-18': (
      name: 'São João I',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '05-19': (
      name: 'Santo Ivo Helory',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-20': (
      name: 'São Bernardino de Sena',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '05-21': (
      name: 'São Cristóvão Magalhães e Companheiros',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '05-22': (
      name: 'Santa Rita de Cássia',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '05-23': (
      name: 'São João Batista de Rossi',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-24': (
      name: 'Nossa Senhora Auxiliadora',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-25': (
      name: 'São Beda Venerável',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '05-26': (
      name: 'São Filipe Néri',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '05-27': (
      name: 'Santo Agostinho de Cantuária',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '05-28': (
      name: 'São Germano de Paris',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-29': (
      name: 'São Paulo VI',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '05-30': (
      name: 'Santa Joana d\'Arc',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '05-31': (
      name: 'Visitação de Nossa Senhora',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    // JUNHO
    '06-01': (
      name: 'São Justino',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '06-02': (
      name: 'Santos Marcelino e Pedro',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '06-03': (
      name: 'Santos Carlos Lwanga e Companheiros',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '06-04': (
      name: 'São Francisco Caracciolo',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-05': (
      name: 'São Bonifácio',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '06-06': (
      name: 'São Norberto',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '06-07': (
      name: 'Santo Antônio Maria Gianelli',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-08': (
      name: 'São Medardo',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-09': (
      name: 'Santo Efrém',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '06-10': (
      name: 'Santo Anjo da Guarda de Portugal',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-11': (
      name: 'São Barnabé',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '06-12': (
      name: 'São Gaspar de Búfalo',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-13': (
      name: 'Santo Antônio de Pádua',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '06-14': (
      name: 'São Rufino e Valério',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-15': (
      name: 'Santa Germana Cousin',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-16': (
      name: 'São João Francisco Régis',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-17': (
      name: 'Santo Alberto Chmielowski',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-18': (
      name: 'Santos Marcos e Marceliano',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-19': (
      name: 'São Romualdo',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '06-20': (
      name: 'São Silvério, Papa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-21': (
      name: 'São Luís Gonzaga',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '06-22': (
      name: 'Santos Tomás More e João Fisher',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '06-23': (
      name: 'São José Cafasso',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-24': (
      name: 'Natividade de São João Batista',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.white,
    ),
    '06-25': (
      name: 'São Guilherme de Vercelli',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-26': (
      name: 'São Josemaria Escrivá',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '06-27': (
      name: 'São Cirilo de Alexandria',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '06-28': (
      name: 'Santo Irineu',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '06-29': (
      name: 'Santos Pedro e Paulo',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.red,
    ),
    '06-30': (
      name: 'Primeiros Santos Mártires de Roma',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    // JULHO
    '07-01': (
      name: 'São Junípero Serra',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-02': (
      name: 'São Bernardino Realino',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-03': (
      name: 'São Tomé',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '07-04': (
      name: 'Santa Isabel de Portugal',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '07-05': (
      name: 'Santo Antônio Maria Zaccaria',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '07-06': (
      name: 'Santa Maria Goretti',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '07-07': (
      name: 'São Panteno',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-08': (
      name: 'Santos Áquila e Priscila',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-09': (
      name: 'Santa Paulina',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '07-10': (
      name: 'Santo Olavo da Noruega',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-11': (
      name: 'São Bento',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '07-12': (
      name: 'Santos Luís e Zélia Martin',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-13': (
      name: 'Santo Henrique',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '07-14': (
      name: 'São Camilo de Léllis',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '07-15': (
      name: 'São Boaventura',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '07-16': (
      name: 'Nossa Senhora do Carmo',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '07-17': (
      name: 'Santo Aleixo',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-18': (
      name: 'São Frederico de Utrecht',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-19': (
      name: 'Santo Arsênio Magno',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-20': (
      name: 'Santo Apolinário',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '07-21': (
      name: 'São Lourenço de Brindisi',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '07-22': (
      name: 'Santa Maria Madalena',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    '07-23': (
      name: 'Santa Brígida',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '07-24': (
      name: 'São Charbel Makhlouf',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '07-25': (
      name: 'São Tiago Maior',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '07-26': (
      name: 'Santos Joaquim e Ana',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '07-27': (
      name: 'São Pantaleão',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-28': (
      name: 'São Pedro Poveda',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '07-29': (
      name: 'Santos Marta, Maria e Lázaro',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '07-30': (
      name: 'São Pedro Crisólogo',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '07-31': (
      name: 'Santo Inácio de Loyola',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    // AGOSTO
    '08-01': (
      name: 'Santo Afonso Maria de Ligório',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '08-02': (
      name: 'São Pedro Julião Eymard',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '08-03': (
      name: 'Santa Lídia de Filipos',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '08-04': (
      name: 'São João Maria Vianney',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '08-05': (
      name: 'Dedicação de Santa Maria Maior',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '08-06': (
      name: 'Transfiguração do Senhor',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    '08-07': (
      name: 'São Sisto II e Companheiros',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '08-08': (
      name: 'São Domingos de Gusmão',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '08-09': (
      name: 'Santa Teresa Benedita da Cruz',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '08-10': (
      name: 'São Lourenço',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '08-11': (
      name: 'Santa Clara',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '08-12': (
      name: 'Santa Joana Francisca de Chantal',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '08-13': (
      name: 'Santos Ponciano e Hipólito',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '08-14': (
      name: 'São Maximiliano Maria Kolbe',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '08-15': (
      name: 'Assunção de Nossa Senhora',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.white,
    ),
    '08-16': (
      name: 'Santo Estêvão da Hungria',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '08-17': (
      name: 'São Jacinto da Polônia',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '08-18': (
      name: 'Santa Helena, Imperatriz',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '08-19': (
      name: 'São João Eudes',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '08-20': (
      name: 'São Bernardo',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '08-21': (
      name: 'São Pio X',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '08-22': (
      name: 'Nossa Senhora Rainha',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '08-23': (
      name: 'Santa Rosa de Lima',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '08-24': (
      name: 'São Bartolomeu',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '08-25': (
      name: 'São Luís da França',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '08-26': (
      name: 'Santa Teresa de Jesus Jornet',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '08-27': (
      name: 'Santa Mônica',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '08-28': (
      name: 'Santo Agostinho',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '08-29': (
      name: 'Martírio de São João Batista',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '08-30': (
      name: 'Santa Margarida Ward',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '08-31': (
      name: 'São Raimundo Não-Nato',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    // SETEMBRO
    '09-01': (
      name: 'Santo Egídio',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-02': (
      name: 'Santo Agrícola de Avignon',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-03': (
      name: 'São Gregório Magno',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '09-04': (
      name: 'Santa Rosália de Palermo',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-05': (
      name: 'Santa Teresa de Calcutá',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-06': (
      name: 'São Zacarias, Profeta',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-07': (
      name: 'Santa Regina de Autun',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-08': (
      name: 'Natividade de Nossa Senhora',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    '09-09': (
      name: 'São Pedro Claver',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '09-10': (
      name: 'São Nicolau de Tolentino',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-11': (
      name: 'São Páfnuco do Egito',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-12': (
      name: 'Santíssimo Nome de Maria',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '09-13': (
      name: 'São João Crisóstomo',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '09-14': (
      name: 'Exaltação da Santa Cruz',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '09-15': (
      name: 'Nossa Senhora das Dores',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '09-16': (
      name: 'Santos Cornélio e Cipriano',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '09-17': (
      name: 'São Roberto Belarmino',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '09-18': (
      name: 'São José de Cupertino',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '09-19': (
      name: 'São Januário',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '09-20': (
      name: 'Santos André Kim Taegon e Companheiros',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '09-21': (
      name: 'São Mateus',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '09-22': (
      name: 'São Maurício e Companheiros',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-23': (
      name: 'São Pio de Pietrelcina (Padre Pio)',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '09-24': (
      name: 'Nossa Senhora das Mercês',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-25': (
      name: 'São Sérgio de Radonezh',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '09-26': (
      name: 'Santos Cosme e Damião',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '09-27': (
      name: 'São Vicente de Paulo',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '09-28': (
      name: 'São Venceslau',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '09-29': (
      name: 'Santos Arcanjos Miguel, Gabriel e Rafael',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    '09-30': (
      name: 'São Jerônimo',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    // OUTUBRO
    '10-01': (
      name: 'Santa Teresinha do Menino Jesus',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '10-02': (
      name: 'Santos Anjos da Guarda',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '10-03': (
      name: 'Santos Mártires de Cunhaú e Uruaçu',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-04': (
      name: 'São Francisco de Assis',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '10-05': (
      name: 'Santa Faustina Kowalska',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '10-06': (
      name: 'São Bruno',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '10-07': (
      name: 'Nossa Senhora do Rosário',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '10-08': (
      name: 'Santa Pelágia de Antioquia',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-09': (
      name: 'São Dionísio e Companheiros',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '10-10': (
      name: 'São Daniel Comboni',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-11': (
      name: 'São João XXIII',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '10-12': (
      name: 'Nossa Senhora da Conceição Aparecida',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.white,
    ),
    '10-13': (
      name: 'Santo Eduardo, o Confessor',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-14': (
      name: 'São Calisto I',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '10-15': (
      name: 'Santa Teresa de Ávila',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '10-16': (
      name: 'Santa Edwiges',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '10-17': (
      name: 'Santo Inácio de Antioquia',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '10-18': (
      name: 'São Lucas',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '10-19': (
      name: 'Santos João de Brébeuf, Isaac Jogues e Companheiros',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '10-20': (
      name: 'Santa Irene de Portugal',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-21': (
      name: 'Santa Úrsula e Companheiras',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-22': (
      name: 'São João Paulo II',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '10-23': (
      name: 'São João de Capistrano',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '10-24': (
      name: 'Santo Antônio Maria Claret',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '10-25': (
      name: 'Frei Galvão',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-26': (
      name: 'Santo Evaristo, Papa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-27': (
      name: 'São Gonçalo de Lagos',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-28': (
      name: 'Santos Simão e Judas',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '10-29': (
      name: 'São Narciso de Jerusalém',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-30': (
      name: 'São Marcelo de Tânger',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '10-31': (
      name: 'Santo Afonso Rodrigues',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    // NOVEMBRO
    '11-01': (
      name: 'Todos os Santos',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.white,
    ),
    '11-02': (
      name: 'Comemoração de Todos os Fiéis Defuntos',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.purple,
    ),
    '11-03': (
      name: 'São Martinho de Lima',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '11-04': (
      name: 'São Carlos Borromeu',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '11-05': (
      name: 'Santa Isabel e São Zacarias',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-06': (
      name: 'São Leonardo de Noblac',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-07': (
      name: 'São Vilibrordo',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-08': (
      name: 'Beato Duns Scotus',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-09': (
      name: 'Dedicação da Basílica de Latrão',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    '11-10': (
      name: 'São Leão Magno',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '11-11': (
      name: 'São Martinho de Tours',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '11-12': (
      name: 'São Josafá',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '11-13': (
      name: 'Santo Homobono de Cremona',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-14': (
      name: 'São José Pignatelli',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-15': (
      name: 'Santo Alberto Magno',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '11-16': (
      name: 'Santa Margarida da Escócia',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '11-17': (
      name: 'Santa Isabel da Hungria',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '11-18': (
      name: 'Dedicação das Basílicas de São Pedro e São Paulo',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '11-19': (
      name: 'São Roque González e Companheiros',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-20': (
      name: 'São Gregório Decapolita',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-21': (
      name: 'Apresentação de Nossa Senhora',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '11-22': (
      name: 'Santa Cecília',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '11-23': (
      name: 'São Clemente I',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '11-24': (
      name: 'Santo André Dung-Lac e Companheiros',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '11-25': (
      name: 'Santa Catarina de Alexandria',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '11-26': (
      name: 'São Leonardo de Porto Maurício',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-27': (
      name: 'Nossa Senhora das Graças',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-28': (
      name: 'São Tiago das Marcas',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-29': (
      name: 'São Saturnino de Toulouse',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '11-30': (
      name: 'Santo André',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    // DEZEMBRO
    '12-01': (
      name: 'Santo Elígio',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-02': (
      name: 'Santa Bibiana',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-03': (
      name: 'São Francisco Xavier',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '12-04': (
      name: 'São João Damasceno',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '12-05': (
      name: 'São Sabas',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-06': (
      name: 'São Nicolau',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '12-07': (
      name: 'Santo Ambrósio',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '12-08': (
      name: 'Imaculada Conceição de Nossa Senhora',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.white,
    ),
    '12-09': (
      name: 'São Juan Diego',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '12-10': (
      name: 'Nossa Senhora de Loreto',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '12-11': (
      name: 'São Dâmaso I',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '12-12': (
      name: 'Nossa Senhora de Guadalupe',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    '12-13': (
      name: 'Santa Luzia',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.red,
    ),
    '12-14': (
      name: 'São João da Cruz',
      rank: LiturgicalRank.memoriaObrigatoria,
      color: LiturgicalColor.white,
    ),
    '12-15': (
      name: 'Santa Maria Crucificada de Rosa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-16': (
      name: 'Santa Adelaide',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-17': (
      name: 'São Lázaro de Betânia',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-18': (
      name: 'São Malaquias, Profeta',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-19': (
      name: 'Santo Urbano V, Papa',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-20': (
      name: 'São Domingos de Silos',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-21': (
      name: 'São Pedro Canísio',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '12-22': (
      name: 'Santa Francisca Xavier Cabrini',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-23': (
      name: 'São João de Kenty',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
    '12-24': (
      name: 'Vigília do Natal do Senhor',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.purple,
    ),
    '12-25': (
      name: 'Natal de Nosso Senhor Jesus Cristo',
      rank: LiturgicalRank.solenidade,
      color: LiturgicalColor.white,
    ),
    '12-26': (
      name: 'Santo Estêvão',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '12-27': (
      name: 'São João Evangelista',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.white,
    ),
    '12-28': (
      name: 'Santos Inocentes',
      rank: LiturgicalRank.festa,
      color: LiturgicalColor.red,
    ),
    '12-29': (
      name: 'São Tomás Becket',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.red,
    ),
    '12-30': (
      name: 'São Rogério de Canas',
      rank: LiturgicalRank.feria,
      color: LiturgicalColor.green,
    ),
    '12-31': (
      name: 'São Silvestre I',
      rank: LiturgicalRank.memoriaFacultativa,
      color: LiturgicalColor.white,
    ),
  };

  /// Retorna o santo ou memória comemorada no dia especificado.
  static ({String name, LiturgicalRank rank, LiturgicalColor color})? getSaint(
    int month,
    int day,
  ) {
    final key =
        '${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    return _sanctoral[key];
  }

  /// Retorna todos os santos cadastrados.
  static Map<
    String,
    ({String name, LiturgicalRank rank, LiturgicalColor color})
  >
  get allSanctoral => _sanctoral;
}

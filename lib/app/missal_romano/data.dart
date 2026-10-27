import 'package:coramdeo/app/calendario/models/liturgical_day.dart';

class MissalBlock {
  final String? rubricPt;
  final String? rubricLa;
  final String? titlePt;
  final String? titleLa;
  final String? speaker;
  final String? latin;
  final String? portuguese;

  const MissalBlock.rubric(this.rubricPt, [this.rubricLa])
    : titlePt = null,
      titleLa = null,
      speaker = null,
      latin = null,
      portuguese = null;

  const MissalBlock.header(this.titlePt, [this.titleLa])
    : rubricPt = null,
      rubricLa = null,
      speaker = null,
      latin = null,
      portuguese = null;

  const MissalBlock.text({
    this.speaker,
    required this.latin,
    required this.portuguese,
  }) : rubricPt = null,
       rubricLa = null,
       titlePt = null,
       titleLa = null;

  bool get isRubric => rubricPt != null;
  bool get isHeader => titlePt != null;
}

class MissalProper {
  final String title;
  final String introitLatin;
  final String introitPt;
  final String collectLatin;
  final String collectPt;
  final String offeringsLatin;
  final String offeringsPt;
  final String communionAntiphonLatin;
  final String communionAntiphonPt;
  final String postCommunionLatin;
  final String postCommunionPt;

  const MissalProper({
    required this.title,
    required this.introitLatin,
    required this.introitPt,
    required this.collectLatin,
    required this.collectPt,
    required this.offeringsLatin,
    required this.offeringsPt,
    required this.communionAntiphonLatin,
    required this.communionAntiphonPt,
    required this.postCommunionLatin,
    required this.postCommunionPt,
  });
}

class MissalRomanoData {
  // ===========================================================================
  // 1. RITOS INICIAIS
  // ===========================================================================
  static const List<MissalBlock> ritosIniciais = [
    MissalBlock.header('Ritos Iniciais', 'Ritus Initiales'),
    MissalBlock.rubric(
      'Reunido o povo, enquanto o sacerdote entra com os ministros, canta-se o cântico de entrada. Chegando ao altar, o sacerdote faz a devida reverência, beija o altar e dirige-se à cátedra. Então, todos se benzem com o sinal da cruz.',
      'Populo congregato, dum sacerdos cum ministris ingreditur, incipitur cantus ad introitum. Cum pervenerit ad altare, sacerdos, facta debita reverentia, altare osculatur et ad sedem pergit.',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin: 'In nómine Patris, et Fílii, + et Spíritus Sancti.',
      portuguese: 'Em nome do Pai e do Filho + e do Espírito Santo.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Amen.',
      portuguese: 'Amém.',
    ),
    MissalBlock.rubric(
      'O sacerdote, estendendo as mãos, saúda o povo:',
      'Sacerdos, manus extendens, populum salutat:',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin:
          'Grátia Dómini nostri Iesu Christi, et cáritas Dei, et communicátio Sancti Spíritus sit cum ómnibus vobis.\n(vel: Dóminus vobíscum.)',
      portuguese:
          'A graça de nosso Senhor Jesus Cristo, o amor do Pai e a comunhão do Espírito Santo estejam convosco.\n(ou: O Senhor esteja convosco.)',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Et cum spíritu tuo.',
      portuguese: 'Ele está no meio de nós. (ou: E com o teu espírito.)',
    ),
    MissalBlock.header('Ato Penitencial', 'Actus Paenitentialis'),
    MissalBlock.rubric(
      'O sacerdote convida os fiéis ao arrependimento:',
      'Sacerdos invitat fideles ad paenitentiam:',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin:
          'Fratres, agnoscámus peccáta nostra, ut apti simus ad sacra mystéria celebránda.',
      portuguese:
          'Irmãos e irmãs, reconheçamos as nossas culpas para celebrarmos dignamente os santos mistérios.',
    ),
    MissalBlock.rubric(
      'Faz-se uma breve pausa em silêncio. Depois, todos rezam juntos a confissão geral:',
      'Fit brevis pausa silentii. Postea omnes simul faciunt confessionem generalem:',
    ),
    MissalBlock.text(
      speaker: 'Todos',
      latin:
          'Confíteor Deo omnipoténti et vobis, fratres, quia peccávi nimis cogitatióne, verbo, ópere et omissióne:\nmea culpa, mea culpa, mea máxima culpa.\nIdeo precor beátam Maríam semper Vírginem, omnes Angelos et Sanctos, et vos, fratres, oráre pro me ad Dóminum Deum nostrum.',
      portuguese:
          'Confesso a Deus todo-poderoso e a vós, irmãos e irmãs, que pequei muitas vezes por pensamentos e palavras, atos e omissões,\npor minha culpa, minha culpa, minha tão grande culpa.\nE peço à Virgem Maria, aos Anjos e Santos e a vós, irmãos e irmãs, que rogueis por mim a Deus, nosso Senhor.',
    ),
    MissalBlock.rubric(
      'Segue-se a absolvição do sacerdote:',
      'Sequitur absolutio sacerdotis:',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin:
          'Misereátur nostri omnípotens Deus et, dimíssis peccátis nostris, perdúcat nos ad vitam aetérnam.',
      portuguese:
          'Deus todo-poderoso tenha compaixão de nós, perdoe os nossos pecados e nos conduza à vida eterna.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Amen.',
      portuguese: 'Amém.',
    ),
    MissalBlock.header('Kyrie, eléison', 'Kýrie, eléison'),
    MissalBlock.text(
      speaker: 'V. / R.',
      latin:
          'V. Kýrie, eléison. — R. Kýrie, eléison.\nV. Christe, eléison. — R. Christe, eléison.\nV. Kýrie, eléison. — R. Kýrie, eléison.',
      portuguese:
          'V. Senhor, tende piedade de nós. — R. Senhor, tende piedade de nós.\nV. Cristo, tende piedade de nós. — R. Cristo, tende piedade de nós.\nV. Senhor, tende piedade de nós. — R. Senhor, tende piedade de nós.',
    ),
    MissalBlock.header('Glória', 'Glória in excélsis'),
    MissalBlock.rubric(
      'Quando prescrito pelas rubricas (domingos fora do Advento e da Quaresma, solenidades e festas), canta-se ou recita-se o Hino Angélico:',
      'Deinde, quando praescribitur, cantatur vel dicitur hymnus:',
    ),
    MissalBlock.text(
      speaker: 'Todos',
      latin:
          'Glória in excélsis Deo et in terra pax homínibus bonae voluntátis.\nLaudámus te, benedícimus te, adorámus te, glorificámus te, grátias ágimus tibi propter magnam glóriam tuam,\nDómine Deus, Rex caeléstis, Deus Pater omnípotens.\nDómine Fili unigénite, Iesu Christe, Dómine Deus, Agnus Dei, Fílius Patris,\nqui tollis peccáta mundi, miserére nobis;\nqui tollis peccáta mundi, súscipe deprecatiónem nostram;\nqui sedes ad déxteram Patris, miserére nobis.\nQuóniam tu solus Sanctus, tu solus Dóminus, tu solus Altíssimus, Iesu Christe,\ncum Sancto Spíritu: in glória Dei Patris. Amen.',
      portuguese:
          'Glória a Deus nas alturas, e paz na terra aos homens por Ele amados.\nSenhor Deus, rei dos céus, Deus Pai todo-poderoso:\nnós vos louvamos, nós vos bendizemos, nós vos adoramos, nós vos glorificamos, nós vos damos graças por vossa imensa glória.\nSenhor Jesus Cristo, Filho Unigênito, Senhor Deus, Cordeiro de Deus, Filho de Deus Pai.\nVós que tirais o pecado do mundo, tende piedade de nós.\nVós que tirais o pecado do mundo, acolhei a nossa súplica.\nVós que estais à direita do Pai, tende piedade de nós.\nSó vós sois o Santo, só vós, o Senhor, só vós, o Altíssimo, Jesus Cristo,\ncom o Espírito Santo, na glória de Deus Pai. Amém.',
    ),
    MissalBlock.header('Oração da Coleta', 'Collecta'),
    MissalBlock.rubric(
      'Terminado o hino, o sacerdote, de mãos unidas, diz "Oremos". E todos oram em silêncio por algum tempo. Depois o sacerdote, de mãos estendidas, profere a oração da Coleta (ver aba Próprio do Dia).',
      'Expleto hymno, sacerdos, manibus iunctis, dicit: Oremus. Et omnes una cum sacerdote per aliquod temporis spatium silentes orant.',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin:
          'Orémus.\n... Per Dóminum nostrum Iesum Christum, Fílium tuum, qui tecum vivit et regnat in unitáte Spíritus Sancti, Deus, per ómnia saécula saeculórum.',
      portuguese:
          'Oremos.\n... Por nosso Senhor Jesus Cristo, vosso Filho, que é Deus, e convosco vive e reina, na unidade do Espírito Santo, por todos os séculos dos séculos.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Amen.',
      portuguese: 'Amém.',
    ),
  ];

  // ===========================================================================
  // 2. LITURGIA DA PALAVRA
  // ===========================================================================
  static const List<MissalBlock> liturgiaDaPalavra = [
    MissalBlock.header('Liturgia da Palavra', 'Liturgia Verbi'),
    MissalBlock.rubric(
      'O leitor dirige-se ao ambão e proclama a Primeira Leitura, enquanto todos escutam sentados. Para indicar o fim da leitura, o leitor diz:',
      'Lector ad ambonem accedit et legit primam lectionem, quam omnes sedentes auscultant. Ad finem lectionis significandum, lector subdit:',
    ),
    MissalBlock.text(
      speaker: 'V. / R.',
      latin: 'V. Verbum Dómini. — R. Deo grátias.',
      portuguese: 'V. Palavra do Senhor. — R. Graças a Deus.',
    ),
    MissalBlock.rubric(
      'Segue-se o Salmo Responsorial e, nos domingos e solenidades, a Segunda Leitura. Depois, todos se levantam para a Aclamação ao Evangelho e a proclamação do Santo Evangelho:',
      'Postea psalmista seu cantor psalmos dicit, populo responsum proferente. Deinde, si habenda sit secunda lectio, lector eam in ambone legit. Postea omnes surgunt.',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin: 'Dóminus vobíscum.',
      portuguese: 'O Senhor esteja convosco.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Et cum spíritu tuo.',
      portuguese: 'Ele está no meio de nós.',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin: 'Léctio sancti Evangélii secúndum N.',
      portuguese: 'Proclamação do Evangelho de Jesus Cristo + segundo N.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Glória tibi, Dómine.',
      portuguese: 'Glória a vós, Senhor.',
    ),
    MissalBlock.rubric(
      'Acabado o Evangelho, o diácono ou o sacerdote aclama:',
      'Expleto Evangelio, diaconus, vel sacerdos, dicit:',
    ),
    MissalBlock.text(
      speaker: 'V. / R.',
      latin: 'V. Verbum Dómini. — R. Laus tibi, Christe.',
      portuguese: 'V. Palavra da Salvação. — R. Glória a vós, Senhor.',
    ),
    MissalBlock.rubric(
      'Em seguida faz-se a Homilia. Nos domingos e solenidades, profere-se a Profissão de Fé (Credo):',
      'Deinde fit homilia; qua peracta, cantatur vel dicitur, quando praescribitur, symbolum seu professio fidei:',
    ),
    MissalBlock.header(
      'Profissão de Fé (Símbolo Niceno-Constantinopolitano)',
      'Symbolum Nicaeno-Constantinopolitanum',
    ),
    MissalBlock.text(
      speaker: 'Todos',
      latin:
          'Credo in unum Deum, Patrem omnipoténtem, factórem caeli et terrae, visibílium ómnium et invisibílium.\nEt in unum Dóminum Iesum Christum, Fílium Dei unigénitum, et ex Patre natum ante ómnia saécula.\nDeum de Deo, lumen de lúmine, Deum verum de Deo vero, génitum, non factum, consubstantiálem Patri: per quem ómnia facta sunt.\nQui propter nos hómines et propter nostram salútem descéndit de caelis.\n(Ad verba quae sequuntur, usque ad factus est, omnes se inclinant)\nEt incarnátus est de Spíritu Sancto ex María Vírgine, et homo factus est.\nCrucifíxus étiam pro nobis sub Póntio Piláto; passus et sepúltus est,\net resurréxit tértia die, secúndum Scriptúras, et ascéndit in caelum, sedet ad déxteram Patris.\nEt íterum ventúrus est cum glória, iudicáre vivos et mórtuos, cuius regni non erit finis.\nEt in Spíritum Sanctum, Dóminum et vivificántem: qui ex Patre Filióque procédit.\nQui cum Patre et Fílio simul adorátur et conglorificátur: qui locútus est per prophétas.\nEt unam, sanctam, cathólicam et apostólicam Ecclésiam.\nConfíteor unum baptísma in remissiónem peccatórum.\nEt exspécto resurrectiónem mortuórum, et vitam ventúri saéculi. Amen.',
      portuguese:
          'Creio em um só Deus, Pai todo-poderoso, Criador do céu e da terra, de todas as coisas visíveis e invisíveis.\nCreio em um só Senhor, Jesus Cristo, Filho Unigênito de Deus, nascido do Pai antes de todos os séculos:\nDeus de Deus, luz da luz, Deus verdadeiro de Deus verdadeiro, gerado, não criado, consubstancial ao Pai. Por Ele todas as coisas foram feitas.\nE por nós, homens, e para nossa salvação, desceu dos céus:\n(Às palavras seguintes, até se fez homem, todos se inclinam)\ne se encarnou pelo Espírito Santo, no seio da Virgem Maria, e se fez homem.\nTambém por nós foi crucificado sob Pôncio Pilatos; padeceu e foi sepultado.\nRessuscitou ao terceiro dia, conforme as Escrituras, e subiu aos céus, onde está sentado à direita do Pai.\nE de novo há de vir, em sua glória, para julgar os vivos e os mortos; e o seu reino não terá fim.\nCreio no Espírito Santo, Senhor que dá a vida, e procede do Pai e do Filho;\ne com o Pai e o Filho é adorado e glorificado: Ele que falou pelos profetas.\nCreio na Igreja, una, santa, católica e apostólica.\nProfesso um só batismo para remissão dos pecados.\nE espero a ressurreição dos mortos e a vida do mundo que há de vir. Amém.',
    ),
    MissalBlock.rubric(
      'Segue-se a Oração Universal ou Oração dos Fiéis.',
      'Deinde fit oratio universalis, seu oratio fidelium.',
    ),
  ];

  // ===========================================================================
  // 3. LITURGIA EUCARÍSTICA — PREPARAÇÃO DAS OFERENDAS
  // ===========================================================================
  static const List<MissalBlock> preparacaoOferendas = [
    MissalBlock.header('Liturgia Eucarística', 'Liturgia Eucharistica'),
    MissalBlock.header('Preparação das Oferendas', 'Praeparatio Donorum'),
    MissalBlock.rubric(
      'O sacerdote toma a patena com o pão e, mantendo-a um pouco elevada sobre o altar, diz em voz baixa:',
      'Sacerdos, stans ad altare, accipit patenam cum pane, eamque ambabus manibus parum elevatam super altare tenens, submissa voce dicit:',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin:
          'Benedíctus es, Dómine, Deus univérsi, quia de tua largitáte accépimus panem, quem tibi offérimus, fructum terrae et óperis mánuum hóminum: ex quo nobis fiet panis vitae.',
      portuguese:
          'Bendito sejais, Senhor, Deus do universo, pelo pão que recebemos de vossa bondade, fruto da terra e do trabalho humano, que hoje vos apresentamos e que para nós se vai tornar Pão da vida.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Benedíctus Deus in saécula.',
      portuguese: 'Bendito seja Deus para sempre.',
    ),
    MissalBlock.rubric(
      'O diácono ou o sacerdote deita vinho e um pouco de água no cálice, dizendo em silêncio:',
      'Diaconus, vel sacerdos, infundit vinum et parum aquae in calicem, secreto dicens:',
    ),
    MissalBlock.text(
      speaker: 'Sacerdote',
      latin:
          'Per huius aquae et vini mystérium eius efficiámur divinitátis consórtes, qui humanitátis nostrae fíeri dignátus est párticeps.',
      portuguese:
          'Pelo mistério desta água e deste vinho possamos participar da divindade do vosso Filho, que se dignou assumir a nossa humanidade.',
    ),
    MissalBlock.rubric(
      'Depois o sacerdote toma o cálice e, mantendo-o um pouco elevado sobre o altar, diz:',
      'Postea sacerdos accipit calicem, eumque ambabus manibus parum elevatum super altare tenens, dicit:',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin:
          'Benedíctus es, Dómine, Deus univérsi, quia de tua largitáte accépimus vinum, quod tibi offérimus, fructum vitis et óperis mánuum hóminum, ex quo nobis fiet potus spiritális.',
      portuguese:
          'Bendito sejais, Senhor, Deus do universo, pelo vinho que recebemos de vossa bondade, fruto da videira e do trabalho humano, que hoje vos apresentamos e que para nós se vai tornar vinho da salvação.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Benedíctus Deus in saécula.',
      portuguese: 'Bendito seja Deus para sempre.',
    ),
    MissalBlock.rubric(
      'Em seguida o sacerdote, profundamente inclinado, diz em silêncio:',
      'Postea sacerdos, profunde inclinatus, secreto dicit:',
    ),
    MissalBlock.text(
      speaker: 'Sacerdote',
      latin:
          'In spíritu humilitátis et in ánimo contríto suscipiámur a te, Dómine; et sic fiat sacrifícium nostrum in conspéctu tuo hódie, ut pláceat tibi, Dómine Deus.',
      portuguese:
          'De coração contrito e humilde, sejamos, Senhor, acolhidos por vós; e seja o nosso sacrifício de tal modo oferecido que alcance a graça de vos agradar, Senhor, nosso Deus.',
    ),
    MissalBlock.rubric(
      'Depois o sacerdote, de pé ao lado do altar, lava as mãos dizendo em silêncio:',
      'Deinde sacerdos, stans ad latus altaris, lavat manus, secreto dicens:',
    ),
    MissalBlock.text(
      speaker: 'Sacerdote',
      latin: 'Lava me, Dómine, ab iniquitáte mea, et a peccáto meo munda me.',
      portuguese:
          'Lavai-me, Senhor, de minhas faltas e purificai-me de meus pecados.',
    ),
    MissalBlock.rubric(
      'Voltando ao meio do altar, o sacerdote, estendendo e unindo as mãos, convida o povo a orar:',
      'Postea, stans in medio altaris, versus ad populum, extendens et iungens manus, dicit:',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin:
          'Oráte, fratres: ut meum ac vestrum sacrifícium acceptábile fiat apud Deum Patrem omnipoténtem.',
      portuguese:
          'Orai, irmãos e irmãs, para que o meu e vosso sacrifício seja aceito por Deus Pai todo-poderoso.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin:
          'Súscipiat Dóminus sacrifícium de mánibus tuis ad laudem et glóriam nóminis sui, ad utilitátem quoque nostram totiúsque Ecclésiae suae sanctae.',
      portuguese:
          'Receba o Senhor por tuas mãos este sacrifício, para glória do seu nome, para nosso bem e de toda a sua santa Igreja.',
    ),
    MissalBlock.rubric(
      'Em seguida, de mãos estendidas, o sacerdote profere a Oração sobre as Oferendas, ao fim da qual o povo aclama: Amém.',
      'Deinde sacerdos, manibus extensis, dicit orationem super oblata, qua finita, populus acclamat: Amen.',
    ),
  ];

  // ===========================================================================
  // 4. PREFÁCIOS E SANCTUS
  // ===========================================================================
  static const List<MissalBlock> dialogoPrefacio = [
    MissalBlock.header('Oração Eucarística — Prefácio', 'Prex Eucharistica'),
    MissalBlock.text(
      speaker: 'V.',
      latin: 'Dóminus vobíscum.',
      portuguese: 'O Senhor esteja convosco.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Et cum spíritu tuo.',
      portuguese: 'Ele está no meio de nós.',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin: 'Sursum corda.',
      portuguese: 'Corações ao alto.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Habémus ad Dóminum.',
      portuguese: 'O nosso coração está em Deus.',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin: 'Grátias agámus Dómino Deo nostro.',
      portuguese: 'Demos graças ao Senhor, nosso Deus.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Dignum et iustum est.',
      portuguese: 'É nosso dever e nossa salvação.',
    ),
  ];

  static const Map<String, MissalBlock> prefacios = {
    'Domingos do Tempo Comum': MissalBlock.text(
      speaker: 'Prefácio',
      latin:
          'Vere dignum et iustum est, aéquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine, sancte Pater, omnípotens aetérne Deus: per Christum Dóminum nostrum.\nQuia per incarnáti Verbi mystérium nova mentis nostrae óculis lux tuae claritátis infúlsit: ut, dum visibíliter Deum cognóscimus, per hunc in invisibílium amórem rapiámur.\nEt ídeo cum Angelis et Archángelis, cum Thronis et Dominatiónibus, cumque omni milítia caeléstis exércitus, hymnum glóriae tuae cánimus, sine fine dicéntes:',
      portuguese:
          'Na verdade, é digno e justo, é nosso dever e salvação dar-vos graças, sempre e em todo lugar, Senhor, Pai santo, Deus eterno e todo-poderoso, por Cristo, Senhor nosso.\nPelo mistério da Encarnação do Verbo, nova luz da vossa glória brilhou para os olhos da nossa mente, a fim de que, conhecendo a Deus visivelmente, por Ele sejamos arrebatados ao amor das coisas invisíveis.\nPor isso, com os Anjos e Arcanjos, com os Tronos e Dominações e com toda a milícia do exército celeste, cantamos o hino da vossa glória, dizendo sem cessar:',
    ),
    'Advento': MissalBlock.text(
      speaker: 'Prefácio do Advento',
      latin:
          'Vere dignum et iustum est, aéquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine, sancte Pater, omnípotens aetérne Deus: per Christum Dóminum nostrum.\nQui, primo advéntu in humilitáte carnis assúmptae, dispositiónis antíquae munus implévit, nobísque salútis perpétuae trámites reserávit: ut, cum secúndo vénerit in suae maiestátis glória, manifésto demum múnere capiámus, quod vigilántes nunc audémus exspectáre promíssum.\nEt ídeo cum Angelis et Archángelis, hymnum glóriae tuae cánimus, sine fine dicéntes:',
      portuguese:
          'Na verdade, é digno e justo, é nosso dever e salvação dar-vos graças, sempre e em todo lugar, Senhor, Pai santo, Deus eterno e todo-poderoso, por Cristo, Senhor nosso.\nRevestido da nossa fragilidade, Ele veio a primeira vez para realizar o vosso eterno plano de amor e abrir-nos o caminho da salvação. Revestido de sua glória, Ele virá uma segunda vez para conceder-nos em plenitude os bens prometidos que hoje, vigilantes, esperamos.\nPor isso, com os Anjos e Arcanjos, cantamos o hino da vossa glória, dizendo sem cessar:',
    ),
    'Quaresma': MissalBlock.text(
      speaker: 'Prefácio da Quaresma',
      latin:
          'Vere dignum et iustum est, aéquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine, sancte Pater, omnípotens aetérne Deus:\nQui corporáli ieiúnio vítia cómprimis, mentem élevas, virtútem largíris et praémia: per Christum Dóminum nostrum.\nPer quem maiestátem tuam laudant Angeli, adórant Dominatiónes, tremunt Potestátes. Caeli caelorúmque Virtútes ac beáta Séraphim sócia exsultatióne concelebrant. Cum quibus et nostras voces ut admítti iúbeas, deprecámur, súpplici confessióne dicéntes:',
      portuguese:
          'Na verdade, é digno e justo, é nosso dever e salvação dar-vos graças, sempre e em todo lugar, Senhor, Pai santo, Deus eterno e todo-poderoso, por Cristo, Senhor nosso.\nPelo jejum quaresmal dominais nossas paixões, elevais o nosso espírito, dais-nos a força e a recompensa das virtudes.\nPor Ele, os Anjos celebram vossa grandeza e os Santos proclamam vossa glória. Concedei-nos também a nós associar-nos a seus louvores, cantando a uma só voz:',
    ),
    'Tempo Pascal': MissalBlock.text(
      speaker: 'Prefácio da Páscoa I',
      latin:
          'Vere dignum et iustum est, aéquum et salutáre, te, Dómine, omni témpore confitéri, sed in hoc potíssimum gloriósius praedicáre, cum Pascha nostrum immolátus est Christus.\nIpse enim verus est Agnus, qui ábstulit peccáta mundi. Qui mortem nostram moriéndo destrúxit, et vitam resurgéndo reparávit.\nQuaprópter, profúsis paschálibus gáudiis, totus in orbe terrárum mundus exsúltat. Sed et supérnae Virtútes atque angélicae Potestátes hymnum glóriae tuae cóncinunt, sine fine dicéntes:',
      portuguese:
          'Na verdade, é digno e justo, é nosso dever e salvação proclamar vossa glória, ó Pai, em todo tempo, mas mais ainda louvar-vos quando Cristo, nossa Páscoa, foi imolado.\nEle é o verdadeiro Cordeiro, que tirou o pecado do mundo; morrendo, destruiu a nossa morte e, ressuscitando, restaurou a vida.\nTransbordando de alegria pascal, nós nos unimos aos Anjos e a todos os Santos para celebrar a vossa glória, cantando a uma só voz:',
    ),
    'Santíssima Virgem Maria': MissalBlock.text(
      speaker: 'Prefácio da B. Virgem Maria',
      latin:
          'Vere dignum et iustum est, aéquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine, sancte Pater, omnípotens aetérne Deus: Et te in veneratióne beátae Maríae semper Vírginis collaudáre, benedícere et praedicáre.\nQuae et Unigénitum tuum Sancti Spíritus obumbratióne concépit, et, virginitátis glória permanénte, lumen aetérnum mundo effúdit, Iesum Christum Dóminum nostrum.\nPer quem maiestátem tuam laudant Angeli, cum quibus et nostras voces ut admítti iúbeas, deprecámur, súpplici confessióne dicéntes:',
      portuguese:
          'Na verdade, é digno e justo, é nosso dever e salvação dar-vos graças, sempre e em todo lugar, Senhor, Pai santo, Deus eterno e todo-poderoso, e na veneração da sempre Virgem Maria louvar, bendizer e proclamar a vossa grandeza.\nPorque ela concebeu o vosso Filho Unigênito pela sombra do Espírito Santo e, permanecendo intacta a glória de sua virgindade, deu ao mundo a Luz eterna, Jesus Cristo, Senhor nosso.\nPor Ele, os Anjos celebram a vossa majestade, aos quais unimos as nossas vozes, cantando a uma só voz:',
    ),
  };

  static const MissalBlock sanctus = MissalBlock.text(
    speaker: 'Todos',
    latin:
        'Sanctus, Sanctus, Sanctus Dóminus Deus Sábaoth.\nPleni sunt caeli et terra glória tua. Hosánna in excélsis.\nBenedíctus qui venit in nómine Dómini. Hosánna in excélsis.',
    portuguese:
        'Santo, Santo, Santo, Senhor, Deus do universo!\nO céu e a terra proclamam a vossa glória. Hosana nas alturas!\nBendito o que vem em nome do Senhor! Hosana nas alturas!',
  );

  // ===========================================================================
  // 5. ORAÇÕES EUCARÍSTICAS (I, II, III, IV)
  // ===========================================================================
  static const Map<String, List<MissalBlock>> oracoesEucaristicas = {
    'I (Cânon Romano)': [
      MissalBlock.header('Oração Eucarística I (Cânon Romano)', 'Canon Romanus'),
      MissalBlock.rubric(
        'O sacerdote, de braços abertos, diz:',
        'Sacerdos, manibus extensis, dicit:',
      ),
      MissalBlock.text(
        speaker: 'Sacerdote',
        latin:
            'Te ígitur, clementíssime Pater, per Iesum Christum, Fílium tuum, Dóminum nostrum, súpplices rogámus ac pétimus, uti accépta hábeas et benedícas + haec dona, haec múnera, haec sancta sacrifícia illibáta,\nin primis, quae tibi offérimus pro Ecclésia tua sancta cathólica: quam pacificáre, custodíre, adunáre et régere dignéris toto orbe terrárum: una cum fámulo tuo Papa nostro N. et Antístite nostro N. et ómnibus orthodóxis, atque cathólicae et apostólicae fídei cultóribus.',
        portuguese:
            'Pai de misericórdia, a quem sobem nossos louvores, suplicantes, vos rogamos e pedimos por Jesus Cristo, vosso Filho e Senhor nosso, que aceiteis e abençoeis + estes dons, estas oferendas, este sacrifício puro e santo,\nque oferecemos, antes de tudo, pela vossa Igreja santa e católica: concedei-lhe paz e proteção, unindo-a num só corpo e governando-a por toda a terra, em comunhão com o vosso servo o Papa N., o nosso Bispo N., e todos os que guardam a fé católica que receberam dos Apóstolos.',
      ),
      MissalBlock.text(
        speaker: 'Memento dos Vivos',
        latin:
            'Meménto, Dómine, famulórum famularúmque tuárum N. et N. et ómnium circumstántium, quorum tibi fides cógnita est et nota devótio, pro quibus tibi offérimus: vel qui tibi ófferunt hoc sacrifícium laudis, pro se suísque ómnibus: pro redemptióne animárum suárum, pro spe salútis et incolumitátis suae: tibíque reddunt vota sua aetérno Deo, vivo et vero.',
        portuguese:
            'Lembrai-vos, ó Pai, dos vossos filhos e filhas N. e N. e de todos os que circundam este altar, dos quais conheceis a fé e a dedicação ao vosso serviço. Por eles nós vos oferecemos e também eles vos oferecem este sacrifício de louvor por si e por todos os seus, e elevam a vós as suas preces, Deus eterno, vivo e verdadeiro, para alcançar o perdão de suas faltas, a segurança em suas vidas e a salvação que esperam.',
      ),
      MissalBlock.text(
        speaker: 'Communicantes',
        latin:
            'Communicántes, et memóriam venerántes, in primis gloriósae semper Vírginis Maríae, Genetrícis Dei et Dómini nostri Iesu Christi: sed et beáti Ioseph, eiúsdem Vírginis Sponsi, et beatórum Apostolórum ac Mártyrum tuórum, Petri et Pauli, Andréae, Iacóbi, Ioánnis, Thomae, Iacóbi, Philíppi, Bartholomaéi, Matthaéi, Simónis et Thaddaéi: Lini, Cleti, Cleméntis, Xysti, Cornélii, Cypriáni, Lauréntii, Chrysógoni, Ioánnis et Pauli, Cosmae et Damiáni: et ómnium Sanctórum tuórum; quorum méritis precibúsque concédas, ut in ómnibus protectiónis tuae muniámur auxílio. Per Christum Dóminum nostrum. Amen.',
        portuguese:
            'Em comunhão com toda a Igreja, celebramos em primeiro lugar a memória da Mãe de nosso Deus e Senhor Jesus Cristo, a gloriosa sempre Virgem Maria, a de seu esposo São José, e também a dos vossos bem-aventurados Apóstolos e Mártires: Pedro e Paulo, André, Tiago e João, Tomé, Tiago e Filipe, Bartolomeu e Mateus, Simão e Tadeu, Lino, Cleto, Clemente, Sisto, Cornélio e Cipriano, Lourenço e Crisógono, João e Paulo, Cosme e Damião, e todos os vossos Santos. Por seus méritos e preces concedei-nos sem cessar a vossa proteção. Por Cristo, nosso Senhor. Amém.',
      ),
      MissalBlock.text(
        speaker: 'Hanc ígitur & Quam oblatiónem',
        latin:
            'Hanc ígitur oblatiónem servitútis nostrae, sed et cunctae famíliac tuae, quaésumus, Dómine, ut placátus accípias: diésque nostros in tua pace dispónas, atque ab aetérna damnatióne nos éripi et in electórum tuórum iúbeas grege numerári.\nQuam oblatiónem tu, Deus, in ómnibus, quaésumus, benedíctam, adscríptam, ratam, rationábilem, acceptabilémque fácere dignéris: ut nobis Corpus et Sanguis fiat dilectíssimi Fílii tui, Dómini nostri Iesu Christi.',
        portuguese:
            'Aceitai, ó Pai, com bondade, a oblação dos vossos servos e de toda a vossa família; dai-nos sempre a vossa paz, livrai-nos da condenação eterna e acolhei-nos entre os vossos eleitos.\nDignai-vos, ó Pai, aceitar, abençoar e santificar estas oferendas; recebei-as como sacrifício espiritual perfeito, a fim de que se tornem para nós o Corpo e o Sangue de vosso amado Filho, nosso Senhor Jesus Cristo.',
      ),
      MissalBlock.header('Narrativa da Instituição e Consagração', 'Consecratio'),
      MissalBlock.text(
        speaker: 'Consagração do Pão',
        latin:
            'Qui, prídie quam paterétur, accépit panem in sanctas ac venerábiles manus suas, et elevátis óculis in caelum ad te Deum Patrem suum omnipoténtem, tibi grátias agens, benedíxit, fregit, dedítque discípulis suis, dicens:\nACCÍPITE ET MANDUCÁTE EX HOC OMNES: HOC EST ENIM CORPUS MEUM, QUOD PRO VOBIS TRADÉTUR.',
        portuguese:
            'Na véspera de sua paixão, Ele tomou o pão em suas santas e veneráveis mãos, elevou os olhos ao céu, a vós, ó Pai todo-poderoso, pronunciou a bênção de ação de graças, partiu o pão e o deu a seus discípulos, dizendo:\nTOMAI, TODOS, E COMEI: ISTO É O MEU CORPO, QUE SERÁ ENTREGUE POR VÓS.',
      ),
      MissalBlock.text(
        speaker: 'Consagração do Cálice',
        latin:
            'Símili modo, postquam cenátum est, accípiens et hunc praeclárum cálicem in sanctas ac venerábiles manus suas, item tibi grátias agens, benedíxit, dedítque discípulis suis, dicens:\nACCÍPITE ET BÍBITE EX EO OMNES: HIC EST ENIM CALIX SÁNGUINIS MEI NOVI ET AETÉRNI TESTAMÉNTI, QUI PRO VOBIS ET PRO MULTIS EFFUNDÉTUR IN REMISSIÓNEM PECCATÓRUM. HOC FÁCITE IN MEAM COMMEMORATIÓNEM.',
        portuguese:
            'Do mesmo modo, no fim da Ceia, Ele tomou este precioso cálice em suas santas e veneráveis mãos, pronunciou novamente a bênção de ação de graças e o deu a seus discípulos, dizendo:\nTOMAI, TODOS, E BEBEI: ESTE É O CÁLICE DO MEU SANGUE, O SANGUE DA NOVA E ETERNA ALIANÇA, QUE SERÁ DERRAMADO POR VÓS E POR TODOS PARA REMISSÃO DOS PECADOS. FAZEI ISTO EM MEMÓRIA DE MIM.',
      ),
      MissalBlock.text(
        speaker: 'V. / R.',
        latin:
            'V. Mystérium fídei.\nR. Mortem tuam annuntiámus, Dómine, et tuam resurrectiónem confitémur, donec vénias.',
        portuguese:
            'V. Mistério da fé!\nR. Anunciamos, Senhor, a vossa morte e proclamamos a vossa ressurreição. Vinde, Senhor Jesus!',
      ),
      MissalBlock.text(
        speaker: 'Unde et mémores & Supra quae',
        latin:
            'Unde et mémores, Dómine, nos servi tui, sed et plebs tua sancta, eiúsdem Christi, Fílii tui, Dómini nostri, tam beátae passiónis, nec non et ab ínferis resurrectiónis, sed et in caelos gloriósae ascensiónis: offérimus praeclárae maiestáti tuae de tuis donis ac datis hóstiam puram, hóstiam sanctam, hóstiam immaculátam, Panem sanctum vitae aetérnae et Cálicem salútis perpétuae.\nSupplices te rogámus, omnípotens Deus: iube haec perférri per manus sancti Angeli tui in sublíme altáre tuum, in conspéctu divínae maiestátis tuae; ut, quotquot ex hac altáris participatióne sacrosánctum Fílii tui Corpus et Sánguinem sumpsérimus, omni benedictióne caelésti et grátia repleámur.',
        portuguese:
            'Celebrando, pois, a memória da bem-aventurada paixão do vosso Filho, da sua ressurreição dentre os mortos e gloriosa ascensão aos céus, nós, vossos servos, e também o vosso povo santo, vos oferecemos, ó Pai, dentre os bens que nos destes, o sacrifício perfeito, santo e imaculado, Pão santo da vida eterna e Cálice da perpétua salvação.\nSuplicantes, vos pedimos, ó Deus onipotente, que esta nossa oferenda seja levada à vossa presença, no alto do céu, pelas mãos do vosso santo Anjo, para que todos nós, participando deste altar pela comunhão do santíssimo Corpo e Sangue do vosso Filho, sejamos repletos de todas as graças e bênçãos do céu.',
      ),
      MissalBlock.text(
        speaker: 'Memento dos Mortos & Nobis quoque peccatóribus',
        latin:
            'Meménto étiam, Dómine, famulórum famularúmque tuárum N. et N., qui nos praecessérunt cum signo fídei, et dórmiunt in somno pacis. Ipsis, Dómine, et ómnibus in Christo quiescéntibus, locum refrigérii, lucis et pacis, ut indúlgeas, deprecámur.\nNobis quoque peccatóribus fámulis tuis, de multitúdine miseratiónum tuárum sperántibus, partem áliquam et societátem donáre dignéris cum tuis sanctis Apóstolis et Martýribus: cum Ioánne, Stéphano, Matthía, Bárnaba, Ignátio, Alexándro, Marcellíno, Petro, Felicitáte, Perpétua, Ágatha, Lúcia, Agnéte, Caecília, Anastásia et ómnibus Sanctis tuis: intra quorum nos consórtium, non aestimátor mériti, sed véniae, quaésumus, largítor admítte.',
        portuguese:
            'Lembrai-vos também, ó Pai, dos vossos filhos e filhas N. e N. que partiram desta vida, marcados com o sinal da fé, e descansam no sono da paz. A eles, e a todos os que adormeceram no Cristo, concedei a felicidade, a luz e a paz.\nE a todos nós, pecadores, que esperamos na vossa infinita misericórdia, concedei, não por nossos méritos, mas por vossa bondade, o convívio dos Apóstolos e Mártires: João Batista e Estêvão, Matias e Barnabé, Inácio, Alexandre, Marcelino e Pedro, Felicidade e Perpétua, Águeda e Luzia, Inês, Cecília, Anastácia e todos os vossos Santos.',
      ),
      MissalBlock.text(
        speaker: 'Doxologia Final',
        latin:
            'Per ipsum, et cum ipso, et in ipso, est tibi Deo Patri omnipoténti, in unitáte Spíritus Sancti, omnis honor et glória per ómnia saécula saeculórum.\nR. Amen.',
        portuguese:
            'Por Cristo, com Cristo, e em Cristo, a vós, Deus Pai todo-poderoso, na unidade do Espírito Santo, toda honra e toda glória, por todos os séculos dos séculos.\nR. Amém.',
      ),
    ],
    'II': [
      MissalBlock.header('Oração Eucarística II', 'Prex Eucharistica II'),
      MissalBlock.text(
        speaker: 'Sacerdote',
        latin:
            'Vere Sanctus es, Dómine, fons omnis sanctitátis.\nHaec ergo dona, quaésumus, Spíritus tui rore sanctífica, ut nobis Corpus et + Sanguis fiant Dómini nostri Iesu Christi.',
        portuguese:
            'Na verdade, ó Pai, vós sois Santo, fonte de toda santidade.\nSantificai, pois, estas oferendas, derramando sobre elas o vosso Espírito, a fim de que se tornem para nós o Corpo e + o Sangue de nosso Senhor Jesus Cristo.',
      ),
      MissalBlock.text(
        speaker: 'Narrativa da Instituição e Consagração',
        latin:
            'Qui cum Passióni voluntárie traderétur, accépit panem et grátias agens fregit, dedítque discípulis suis, dicens:\nACCÍPITE ET MANDUCÁTE EX HOC OMNES: HOC EST ENIM CORPUS MEUM, QUOD PRO VOBIS TRADÉTUR.\nSímili modo, postquam cenátum est, accípiens et cálicem, íterum grátias agens dedit discípulis suis, dicens:\nACCÍPITE ET BÍBITE EX EO OMNES: HIC EST ENIM CALIX SÁNGUINIS MEI NOVI ET AETÉRNI TESTAMÉNTI, QUI PRO VOBIS ET PRO MULTIS EFFUNDÉTUR IN REMISSIÓNEM PECCATÓRUM. HOC FÁCITE IN MEAM COMMEMORATIÓNEM.',
        portuguese:
            'Estando para ser entregue e abraçando livremente a paixão, Jesus tomou o pão, pronunciou a bênção de ação de graças, partiu e o deu a seus discípulos, dizendo:\nTOMAI, TODOS, E COMEI: ISTO É O MEU CORPO, QUE SERÁ ENTREGUE POR VÓS.\nDo mesmo modo, no fim da Ceia, Ele tomou o cálice em suas mãos e, dando graças novamente, o entregou a seus discípulos, dizendo:\nTOMAI, TODOS, E BEBEI: ESTE É O CÁLICE DO MEU SANGUE, O SANGUE DA NOVA E ETERNA ALIANÇA, QUE SERÁ DERRAMADO POR VÓS E POR TODOS PARA REMISSÃO DOS PECADOS. FAZEI ISTO EM MEMÓRIA DE MIM.',
      ),
      MissalBlock.text(
        speaker: 'V. / R.',
        latin:
            'V. Mystérium fídei.\nR. Mortem tuam annuntiámus, Dómine, et tuam resurrectiónem confitémur, donec vénias.',
        portuguese:
            'V. Mistério da fé!\nR. Anunciamos, Senhor, a vossa morte e proclamamos a vossa ressurreição. Vinde, Senhor Jesus!',
      ),
      MissalBlock.text(
        speaker: 'Anamnese e Intercessões',
        latin:
            'Mémores ígitur mortis et resurrectiónis eius, tibi, Dómine, panem vitae et cálicem salútis offérimus, grátias agéntes quia nos dignos habuísti astáre coram te et tibi ministráre.\nEt súpplices deprecámur ut Córporis et Sánguinis Christi partícipes a Spíritu Sancto congregémur in unum.\nRecordáre, Dómine, Ecclésiae tuae toto orbe diffúsae, ut eam in caritáte perfícias una cum Papa nostro N. et Epíscopo nostro N. et univérso clero.\nMeménto étiam fratrum nostrórum, qui in spe resurrectiónis dormiérunt, omniúmque in tua miseratióne defunctórum, et eos in lumen vultus tui admítte.\nOmnium nostrum, quaésumus, miserére, ut cum beáta Dei Genetríce Vírgine María, beáto Ioseph, eius Sponso, beátis Apóstolis et ómnibus Sanctis, qui tibi a saéculo placuérunt, aetérnae vitae mereámur esse consórtes, et te laudémus et glorificémus per Fílium tuum Iesum Christum.',
        portuguese:
            'Celebrando, pois, a memória da morte e ressurreição do vosso Filho, nós vos oferecemos, ó Pai, o Pão da vida e o Cálice da salvação; e vos agradecemos porque nos tornastes dignos de estar aqui na vossa presença e vos servir.\nSuplicantes, vos pedimos que, participando do Corpo e Sangue de Cristo, sejamos reunidos pelo Espírito Santo num só corpo.\nLembrai-vos, ó Pai, da vossa Igreja que se faz presente pelo mundo inteiro; que ela cresça na caridade, em comunhão com o nosso Papa N., com o nosso Bispo N., os bispos do mundo inteiro, os presbíteros, os diáconos e todos os ministros do vosso povo.\nLembrai-vos também na vossa misericórdia dos nossos irmãos e irmãs que adormeceram na esperança da ressurreição e de todos os que partiram desta vida; acolhei-os junto a vós na luz da vossa face.\nEnfim, nós vos pedimos, tende piedade de todos nós e dai-nos participar da vida eterna, com a Virgem Maria, Mãe de Deus, São José, seu esposo, os Apóstolos e todos os Santos que neste mundo viveram na vossa amizade, a fim de vos louvarmos e glorificarmos por Jesus Cristo, vosso Filho.',
      ),
      MissalBlock.text(
        speaker: 'Doxologia Final',
        latin:
            'Per ipsum, et cum ipso, et in ipso, est tibi Deo Patri omnipoténti, in unitáte Spíritus Sancti, omnis honor et glória per ómnia saécula saeculórum.\nR. Amen.',
        portuguese:
            'Por Cristo, com Cristo, e em Cristo, a vós, Deus Pai todo-poderoso, na unidade do Espírito Santo, toda honra e toda glória, por todos os séculos dos séculos.\nR. Amém.',
      ),
    ],
    'III': [
      MissalBlock.header('Oração Eucarística III', 'Prex Eucharistica III'),
      MissalBlock.text(
        speaker: 'Sacerdote',
        latin:
            'Vere Sanctus es, Dómine, et mérito te laudat omnis a te cóndita creatúra, quia per Fílium tuum, Dóminum nostrum Iesum Christum, Spíritus Sancti operánte virtúte, vivíficas et sanctíficas univérsa, et pópulum tibi congregáre non desínis, ut a solis ortu usque ad occásum oblátio munda offerátur nómini tuo.\nSúpplices ergo te, Dómine, deprecámur, ut haec múnera, quae tibi sacránda detúlimus, eódem Spíritu بنedícas, ut Corpus et + Sanguis fiant Fílii tui Dómini nostri Iesu Christi, cuius mandáto haec mystéria celebrámus.',
        portuguese:
            'Na verdade, vós sois Santo, ó Deus do universo, e tudo o que criastes proclama o vosso louvor, porque, por Jesus Cristo, vosso Filho e Senhor nosso, e pela força do Espírito Santo, dais vida e santidade a todas as coisas e não cessais de reunir para vós um povo que vos ofereça em toda parte, do nascer ao pôr do sol, um sacrifício perfeito.\nPor isso, ó Pai, nós vos suplicamos: santificai pelo Espírito Santo as oferendas que vos apresentamos para serem consagradas, a fim de que se tornem o Corpo e + o Sangue de vosso Filho, nosso Senhor Jesus Cristo, que nos mandou celebrar estes mistérios.',
      ),
      MissalBlock.text(
        speaker: 'Narrativa da Instituição e Consagração',
        latin:
            'Ipse enim in qua nocte tradebátur accépit panem et tibi grátias agens benedíxit, fregit, dedítque discípulis suis, dicens:\nACCÍPITE ET MANDUCÁTE EX HOC OMNES: HOC EST ENIM CORPUS MEUM, QUOD PRO VOBIS TRADÉTUR.\nSímili modo, postquam cenátum est, accípiens cálicem, et tibi grátias agens benedíxit, dedítque discípulis suis, dicens:\nACCÍPITE ET BÍBITE EX EO OMNES: HIC EST ENIM CALIX SÁNGUINIS MEI NOVI ET AETÉRNI TESTAMÉNTI, QUI PRO VOBIS ET PRO MULTIS EFFUNDÉTUR IN REMISSIÓNEM PECCATÓRUM. HOC FÁCITE IN MEAM COMMEMORATIÓNEM.',
        portuguese:
            'Na noite em que ia ser entregue, Jesus tomou o pão, pronunciou a bênção de ação de graças, partiu e o deu a seus discípulos, dizendo:\nTOMAI, TODOS, E COMEI: ISTO É O MEU CORPO, QUE SERÁ ENTREGUE POR VÓS.\nDo mesmo modo, no fim da Ceia, Ele tomou o cálice em suas mãos, pronunciou a bênção de ação de graças, e o deu a seus discípulos, dizendo:\nTOMAI, TODOS, E BEBEI: ESTE É O CÁLICE DO MEU SANGUE, O SANGUE DA NOVA E ETERNA ALIANÇA, QUE SERÁ DERRAMADO POR VÓS E POR TODOS PARA REMISSÃO DOS PECADOS. FAZEI ISTO EM MEMÓRIA DE MIM.',
      ),
      MissalBlock.text(
        speaker: 'Anamnese e Intercessões',
        latin:
            'Mémores ígitur, Dómine, eiúsdem Fílii tui salutíferae passiónis necnon mirábilis resurrectiónis et ascensiónis in caelum, sed et praestolántes álterum eius advéntum, offérimus tibi, grátias referéntes, hoc sacrifícium vivum et sanctum.\nRóspice, quaésumus, in oblatiónem Ecclésiae tuae et, agnóscens Hóstiam, cuius voluísti immolatióne placári, concéde, ut qui Córpore et Sánguine Fílii tui refícimur, Spíritu eius Sancto repléti, unum corpus et unus spíritus inveniámur in Christo.\nIpse nos tibi perfíciat munus aetérnum, ut cum eléctis tuis hereditátem consequi valeámus, in primis cum beatíssima Vírgine, Dei Genetríce, María, cum beáto Ioseph, eius Sponso, cum beátis Apóstolis tuis et gloriósis Martýribus et ómnibus Sanctis, quorum intercessióne perpétuo apud te confídimus adiuvári.',
        portuguese:
            'Celebrando, ó Pai, a memória da paixão redentora do vosso Filho, da sua gloriosa ressurreição e ascensão ao céu, e enquanto esperamos a sua nova vinda, nós vos oferecemos em ação de graças este sacrifício vivo e santo.\nOlhai com bondade a oblação da vossa Igreja e reconhecei nela o sacrifício que nos reconciliou convosco; concedei que, alimentando-nos com o Corpo e o Sangue do vosso Filho, repletos do Espírito Santo, nos tornemos em Cristo um só corpo e um só espírito.\nQue o mesmo Espírito faça de nós uma eterna oferenda para alcançarmos a herança com os vossos eleitos: a santíssima Virgem Maria, Mãe de Deus, São José, seu esposo, os vossos santos Apóstolos e gloriosos Mártires, e todos os Santos, que não cessam de interceder por nós na vossa presença.',
      ),
      MissalBlock.text(
        speaker: 'Doxologia Final',
        latin:
            'Per ipsum, et cum ipso, et in ipso, est tibi Deo Patri omnipoténti, in unitáte Spíritus Sancti, omnis honor et glória per ómnia saécula saeculórum.\nR. Amen.',
        portuguese:
            'Por Cristo, com Cristo, e em Cristo, a vós, Deus Pai todo-poderoso, na unidade do Espírito Santo, toda honra e toda glória, por todos os séculos dos séculos.\nR. Amém.',
      ),
    ],
    'IV': [
      MissalBlock.header('Oração Eucarística IV', 'Prex Eucharistica IV'),
      MissalBlock.text(
        speaker: 'Sacerdote',
        latin:
            'Confitémur tibi, Pater sancte, quia magnus es et ómnia ópera tua in sapiéntia et caritáte fecísti. Hóminem ad tuam imáginem condidísti, eiúque curam mundi univérsi credidísti, ut, tibi soli Creatóri sérviens, creatúris ómnibus imperáret. Et cum amicítiam tuam, non oboédiens, amisísset, non eum dereliquísti in mortis potestáte.\nQuaesumus ígitur, Dómine, ut idem Spíritus Sanctus haec múnera sanctificáre dignétur, ut Corpus et + Sanguis fiant Dómini nostri Iesu Christi ad hoc magnum mystérium celebrándum, quod ipse nobis relíquit in foedus aetérnum.',
        portuguese:
            'Nós vos proclamamos, Pai santo, porque sois grande e fizestes todas as coisas com sabedoria e amor. Criastes o homem à vossa imagem e lhe confiastes o cuidado do universo, para que, servindo somente a vós, seu Criador, governasse todas as criaturas. E quando pela desobediência perdeu a vossa amizade, não o abandonastes ao poder da morte.\nPor isso, nós vos pedimos, ó Pai, que o mesmo Espírito Santo santifique estas oferendas, a fim de que se tornem o Corpo e + o Sangue de nosso Senhor Jesus Cristo para celebrarmos este grande mistério que Ele nos deixou em sinal da eterna aliança.',
      ),
      MissalBlock.text(
        speaker: 'Narrativa da Instituição e Consagração',
        latin:
            'Accépit panem et tibi grátias agens benedíxit, fregit, dedítque discípulis suis, dicens:\nACCÍPITE ET MANDUCÁTE EX HOC OMNES: HOC EST ENIM CORPUS MEUM, QUOD PRO VOBIS TRADÉTUR.\nSímili modo, accípiens cálicem ex genímine vitis repletum, grátias egit, dedítque discípulis suis, dicens:\nACCÍPITE ET BÍBITE EX EO OMNES: HIC EST ENIM CALIX SÁNGUINIS MEI NOVI ET AETÉRNI TESTAMÉNTI, QUI PRO VOBIS ET PRO MULTIS EFFUNDÉTUR IN REMISSIÓNEM PECCATÓRUM. HOC FÁCITE IN MEAM COMMEMORATIÓNEM.',
        portuguese:
            'Ele tomou o pão, pronunciou a bênção de ação de graças, partiu e o deu a seus discípulos, dizendo:\nTOMAI, TODOS, E COMEI: ISTO É O MEU CORPO, QUE SERÁ ENTREGUE POR VÓS.\nDo mesmo modo, tomou nas mãos o cálice com o fruto da videira, deu-vos graças novamente e o entregou a seus discípulos, dizendo:\nTOMAI, TODOS, E BEBEI: ESTE É O CÁLICE DO MEU SANGUE, O SANGUE DA NOVA E ETERNA ALIANÇA, QUE SERÁ DERRAMADO POR VÓS E POR TODOS PARA REMISSÃO DOS PECADOS. FAZEI ISTO EM MEMÓRIA DE MIM.',
      ),
      MissalBlock.text(
        speaker: 'Doxologia Final',
        latin:
            'Per ipsum, et cum ipso, et in ipso, est tibi Deo Patri omnipoténti, in unitáte Spíritus Sancti, omnis honor et glória per ómnia saécula saeculórum.\nR. Amen.',
        portuguese:
            'Por Cristo, com Cristo, e em Cristo, a vós, Deus Pai todo-poderoso, na unidade do Espírito Santo, toda honra e toda glória, por todos os séculos dos séculos.\nR. Amém.',
      ),
    ],
  };

  // ===========================================================================
  // 6. RITO DA COMUNHÃO E RITOS FINAIS
  // ===========================================================================
  static const List<MissalBlock> ritoComunhaoEFinais = [
    MissalBlock.header('Rito da Comunhão', 'Ritus Communionis'),
    MissalBlock.rubric(
      'Deposto o cálice e a patena, o sacerdote, de mãos unidas, diz:',
      'Repositis calice et patena, sacerdos, iunctis manibus, dicit:',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin:
          'Praecéptis salutáribus móniti, et divína institutióne formáti, audémus dícere:',
      portuguese:
          'Obedientes à palavra do Salvador e formados por seu divino ensinamento, ousamos dizer:',
    ),
    MissalBlock.text(
      speaker: 'Todos (Pater Noster)',
      latin:
          'Pater noster, qui es in caelis:\nsanctificétur nomen tuum;\nadvéniat regnum tuum;\nfiat volúntas tua, sicut in caelo, et in terra.\nPanem nostrum cotidiánum da nobis hódie;\net dimítte nobis débita nostra,\nsicut et nos dimíttimus debitóribus nostris;\net ne nos indúcas in tentatiónem;\nsed líbera nos a malo.',
      portuguese:
          'Pai nosso que estais nos céus,\nsantificado seja o vosso nome;\nvenha a nós o vosso reino;\nseja feita a vossa vontade, assim na terra como no céu.\nO pão nosso de cada dia nos dai hoje;\nperdoai-nos as nossas ofensas,\nassim como nós perdoamos a quem nos tem ofendido;\ne não nos deixeis cair em tentação,\nmas livrai-nos do mal.',
    ),
    MissalBlock.text(
      speaker: 'Embolismo',
      latin:
          'Líbera nos, quaésumus, Dómine, ab ómnibus malis, da propítius pacem in diébus nostris, ut, ope misericórdiae tuae adiúti, et a peccáto simus semper líberi et ab omni perturbatióne secúri: exspectántes beátam spem et advéntum Salvatóris nostri Iesu Christi.',
      portuguese:
          'Livrai-nos de todos os males, ó Pai, e dai-nos hoje a vossa paz. Ajudados pela vossa misericórdia, sejamos sempre livres do pecado e protegidos de todos os perigos, enquanto, vivendo a esperança, aguardamos a vinda do Cristo Salvador.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Quia tuum est regnum, et potéstas, et glória in saécula.',
      portuguese: 'Vosso é o reino, o poder e a glória para sempre!',
    ),
    MissalBlock.header('Rito da Paz', 'Ritus Pacis'),
    MissalBlock.text(
      speaker: 'V.',
      latin:
          'Dómine Iesu Christe, qui dixísti Apóstolis tuis: Pacem relínquo vobis, pacem meam do vobis: ne respícias peccáta nostra, sed fidem Ecclésiae tuae; eámque secúndum voluntátem tuam pacificáre et coadunáre dignéris. Qui vivis et regnas in saécula saeculórum.',
      portuguese:
          'Senhor Jesus Cristo, dissestes aos vossos Apóstolos: Eu vos deixo a paz, eu vos dou a minha paz. Não olheis os nossos pecados, mas a fé que anima vossa Igreja; dai-lhe, segundo o vosso desejo, a paz e a unidade. Vós que sois Deus com o Pai e o Espírito Santo.',
    ),
    MissalBlock.text(
      speaker: 'R.',
      latin: 'Amen.',
      portuguese: 'Amém.',
    ),
    MissalBlock.text(
      speaker: 'V. / R.',
      latin: 'V. Pax Dómini sit semper vobíscum. — R. Et cum spíritu tuo.',
      portuguese:
          'V. A paz do Senhor esteja sempre convosco. — R. O amor de Cristo nos uniu.',
    ),
    MissalBlock.header('Fração do Pão — Agnus Dei', 'Fractio Panis'),
    MissalBlock.text(
      speaker: 'Todos',
      latin:
          'Agnus Dei, qui tollis peccáta mundi: miserére nobis.\nAgnus Dei, qui tollis peccáta mundi: miserére nobis.\nAgnus Dei, qui tollis peccáta mundi: dona nobis pacem.',
      portuguese:
          'Cordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós.\nCordeiro de Deus, que tirais o pecado do mundo, dai-nos a paz.',
    ),
    MissalBlock.rubric(
      'O sacerdote faz genuflexão, toma a hóstia e, elevando-a um pouco sobre a patena ou sobre o cálice, diz voltado para o povo:',
      'Sacerdos genuflectit, accipit hostiam eamque parum elevatam super patenam vel super calicem tenens, versus ad populum, clara voce dicit:',
    ),
    MissalBlock.text(
      speaker: 'V.',
      latin:
          'Ecce Agnus Dei, ecce qui tollit peccáta mundi. Beáti qui ad cenam Agni vocáti sunt.',
      portuguese:
          'Felizes os convidados para a Ceia do Senhor. Eis o Cordeiro de Deus, que tira o pecado do mundo.',
    ),
    MissalBlock.text(
      speaker: 'Todos',
      latin:
          'Dómine, non sum dignus, ut intres sub tectum meum, sed tantum dic verbo, et sanábitur ánima mea.',
      portuguese:
          'Senhor, eu não sou digno(a) de que entreis em minha morada, mas dizei uma palavra e serei salvo(a).',
    ),
    MissalBlock.rubric(
      'Terminada a distribuição da Comunhão, guarda-se algum tempo de silêncio sagrado. Depois o sacerdote profere a Oração depois da Comunhão.',
      'Distributione Communionis expleta, sacerdos et fideles per aliquod temporis spatium secreto orant. Deinde sacerdos dicit orationem post Communionem.',
    ),
    MissalBlock.header('Ritos Finais', 'Ritus Conclusiones'),
    MissalBlock.text(
      speaker: 'V. / R.',
      latin: 'V. Dóminus vobíscum. — R. Et cum spíritu tuo.',
      portuguese:
          'V. O Senhor esteja convosco. — R. Ele está no meio de nós.',
    ),
    MissalBlock.text(
      speaker: 'V. / R.',
      latin:
          'V. Benedícat vos omnípotens Deus, Pater, et Fílius, + et Spíritus Sanctus. — R. Amen.',
      portuguese:
          'V. Abençoe-vos Deus todo-poderoso, Pai e Filho + e Espírito Santo. — R. Amém.',
    ),
    MissalBlock.text(
      speaker: 'V. / R.',
      latin: 'V. Ite, missa est. — R. Deo grátias.',
      portuguese: 'V. Ide em paz, e o Senhor vos acompanhe. — R. Graças a Deus.',
    ),
  ];

  // ===========================================================================
  // 7. PRÓPRIO DO TEMPO E DOS SANTOS (FASE 2)
  // ===========================================================================
  static MissalProper getProperForDay(LiturgicalDay day) {
    switch (day.season) {
      case LiturgicalSeason.advento:
        return const MissalProper(
          title: 'Próprio do Tempo do Advento',
          introitLatin:
              'Ad te levávi ánimam meam: Deus meus, in te confído, non erubéscam (Ps 24, 1-2).',
          introitPt:
              'A vós, meu Deus, elevo a minha alma. Em vós confio: que eu não seja envergonhado (Sl 24, 1-2).',
          collectLatin:
              'Da, quaésumus, omnípotens Deus, hanc tuis fidélibus voluntátem, ut, Christo tuo veniénti iustis opéribus occurréntes, eius déxterae sociáti, regnum mereántur possidére caeléste. Per Dóminum.',
          collectPt:
              'Concedei, ó Deus todo-poderoso, aos vossos fiéis o ardente desejo de acorrer com boas obras ao encontro do vosso Cristo que vem, para que, colocados à sua direita, mereçam possuir o reino celeste. Por nosso Senhor Jesus Cristo.',
          offeringsLatin:
              'Haec sacra nos, Dómine, потénti virtúte mundátos ad suum fáciant пуriores veníre princípium. Per Christum Dóminum nostrum.',
          offeringsPt:
              'Estes sagrados mistérios, Senhor, purificando-nos com a sua poderosa virtude, façam-nos chegar mais puros àquele que é o seu princípio. Por Cristo, nosso Senhor.',
          communionAntiphonLatin:
              'Dóminus dabit benignitátem, et terra nostra dabit fructum suum (Ps 84, 13).',
          communionAntiphonPt:
              'O Senhor dará a sua bondade e a nossa terra produzirá o seu fruto (Sl 84, 13).',
          postCommunionLatin:
              'Suscipiámus, Dómine, misericórdiam tuam in médio templi tui, ut reparatiónis nostrae ventúra sollémnia cóngruis honóribus praecedámus. Per Christum Dóminum nostrum.',
          postCommunionPt:
              'Acolhamos, Senhor, a vossa misericórdia no meio do vosso templo, para prepararmos com digna honra as próximas solenidades da nossa redenção. Por Cristo, nosso Senhor.',
        );
      case LiturgicalSeason.natal:
        return const MissalProper(
          title: 'Próprio do Tempo do Natal',
          introitLatin:
              'Puer natus est nobis, et fílius datus est nobis: cuius impérium super húmerum eius (Is 9, 6).',
          introitPt:
              'Um menino nasceu para nós, um filho nos foi dado! O poder repousa sobre os seus ombros (Is 9, 6).',
          collectLatin:
              'Omnípotens sempitérne Deus, qui hunc diem per incarnáti Verbi mystérium nova luce illustrásti, da, quaésumus, ut, quod fide in mente refúlget, ópere respléndeat in actióne. Per Dóminum.',
          collectPt:
              'Ó Deus eterno e todo-poderoso, que iluminastes este dia pelo mistério da Encarnação do Verbo, concedei que brilhe em nossas obras a luz da fé que resplandece em nossos corações. Por nosso Senhor Jesus Cristo.',
          offeringsLatin:
              'Grata tibi sit, Dómine, hodiénnae festivitátis oblátio, ut, tua grátia largiénte, per haec sacrosáncta commércia, in illíus inveniámur forma, in quo tecum est nostra substántia. Per Christum.',
          offeringsPt:
              'Seja-vos agradável, Senhor, a oblação desta solenidade, para que, por este sagrado intercâmbio, nos tornemos semelhantes Àquele em quem a nossa natureza está unida à vossa. Por Cristo, nosso Senhor.',
          communionAntiphonLatin:
              'Verbum caro factum est, et vidimus glóriam eius (Io 1, 14).',
          communionAntiphonPt:
              'O Verbo se fez carne, e nós vimos a sua glória (Jo 1, 14).',
          postCommunionLatin:
              'Da nobis, miséricors Deus, ut Nátus hódie Salvátor mundi, sicut divínae nobis generatiónis est auctor, ita et immortalitátis sit ipse largítor. Per Christum.',
          postCommunionPt:
              'Concedei-nos, ó Deus de misericórdia, que o Salvador do mundo, hoje nascido, assim como é para nós o autor da geração divina, também nos dê em plenitude a imortalidade. Por Cristo, nosso Senhor.',
        );
      case LiturgicalSeason.quaresma:
        return const MissalProper(
          title: 'Próprio do Tempo da Quaresma',
          introitLatin:
              'Invocábit me, et ego exáudiam eum; erípiam eum et glorificábo eum (Ps 90, 15).',
          introitPt:
              'Quando me invocar, eu o atenderei; na tribulação estarei com ele e o glorificarei (Sl 90, 15).',
          collectLatin:
              'Concéde nobis, omnípotens Deus, ut, per ánnua quadragesimális exercítia sacraménti, et ad intellegéndum Christi proficiámus arcánum, et efféctus eius digna conversatióne sectémur. Per Dóminum.',
          collectPt:
              'Concedei-nos, ó Deus todo-poderoso, que, ao longo desta celebração anual da Quaresma, progridamos no conhecimento do mistério de Cristo e traduzamos os seus efeitos numa conduta santa. Por nosso Senhor Jesus Cristo.',
          offeringsLatin:
              'Sacrifícium quadragesimális inítii sollémniter immolámus, te, Dómine, deprecántes, ut, cum epulárum restrictióne carnálium, a nóxiis quoque voluptatibus temperémus. Per Christum.',
          offeringsPt:
              'Oferecemos solenemente este sacrifício quaresmal, suplicando-vos, Senhor, que pelas obras de penitência e caridade sejamos preservados dos prazeres pecaminosos. Por Cristo, nosso Senhor.',
          communionAntiphonLatin:
              'Non in solo pane vivit homo, sed in omni verbo quod procédit de ore Dei (Mt 4, 4).',
          communionAntiphonPt:
              'Não só de pão vive o homem, mas de toda palavra que sai da boca de Deus (Mt 4, 4).',
          postCommunionLatin:
              'Caeléstis doni benedictióne percepta, súpplices te, Dómine, deprecámur, ut hoc idem nobis et sacraméntum sit véniam et salútis. Per Christum.',
          postCommunionPt:
              'Alimentados com o Pão celeste que reanima a fé, estimula a esperança e fortalece a caridade, nós vos suplicamos, Senhor: ensinai-nos a ter fome do Cristo, Pão vivo e verdadeiro. Por Cristo, nosso Senhor.',
        );
      case LiturgicalSeason.triduoPascal:
      case LiturgicalSeason.tempoPascal:
        return const MissalProper(
          title: 'Próprio do Tempo Pascal',
          introitLatin:
              'Resurréxi, et adhuc tecum sum, allelúia; posuísti super me manum tuam, allelúia (Ps 138, 18.5).',
          introitPt:
              'Ressuscitei e sempre estou convosco, aleluia; pousastes sobre mim a vossa mão, aleluia (Sl 138, 18.5).',
          collectLatin:
              'Deus, qui per Unigénitum tuum, aeternitátis nobis áditum, devícta morte, reserásti, vota nostra, quae praeveniéndo aspíras, étiam adiuvándo proséquere. Per Dóminum.',
          collectPt:
              'Ó Deus, que no dia de hoje, por vosso Filho Unigênito, vencedor da morte, nos abristes as portas da eternidade, concedei que os nossos desejos, que por vossa inspiração precedestes, sejam levados a bom termo pelo vosso auxílio. Por nosso Senhor Jesus Cristo.',
          offeringsLatin:
              'Exsultántes paschálibus gáudiis, Dómine, offérimus sacrifícia, quibus Ecclésia tua mirabíliter et pascitur et nutrítur. Per Christum.',
          offeringsPt:
              'Exultantes de alegria pascal, nós vos oferecemos, Senhor, o sacrifício pelo qual a vossa Igreja admiravelmente renasce e se alimenta. Por Cristo, nosso Senhor.',
          communionAntiphonLatin:
              'Pascha nostrum immolátus est Christus, allelúia (1 Cor 5, 7).',
          communionAntiphonPt:
              'Cristo, nossa Páscoa, foi imolado; celebremos a festa na sinceridade e na verdade, aleluia (1Cor 5, 7-8).',
          postCommunionLatin:
              'Spíritum nobis, Dómine, tuae caritátis infúnde, ut, quos sacraméntis paschálibus satiásti, tua fácias pietáte concórdes. Per Christum.',
          postCommunionPt:
              'Derramai em nós, Senhor, o espírito do vosso amor, para que, saciados pelos sacramentos pascais, sejamos unidos pela vossa bondade. Por Cristo, nosso Senhor.',
        );
      case LiturgicalSeason.tempoComum:
        return const MissalProper(
          title: 'Próprio do Tempo Comum',
          introitLatin:
              'Omnis terra adóret te, Deus, et psallat tibi; psalmum dicat nómini tuo, Altíssime (Ps 65, 4).',
          introitPt:
              'Toda a terra vos adore, ó Deus, e cante salmos ao vosso nome, ó Altíssimo (Sl 65, 4).',
          collectLatin:
              'Omnípotens sempitérne Deus, caeléstia simul et terréna moderáns, supplicatiónes pópuli tui cleménter exáudi, et pacem tuam nostris concéde tempóribus. Per Dóminum.',
          collectPt:
              'Ó Deus eterno e todo-poderoso, que governais o céu e a terra, escutai com bondade as súplicas do vosso povo e concedei ao nosso tempo a vossa paz. Por nosso Senhor Jesus Cristo.',
          offeringsLatin:
              'Concéde nobis, quaésumus, Dómine, haec digne frequentáre mystéria, quia, quóties huius hóstiae commemorátio celebrátur, opus nostrae redemptiónis exercétur. Per Christum.',
          offeringsPt:
              'Concedei-nos, Senhor, participar dignamente destes mistérios, porque, todas as vezes que se celebra a memória deste sacrifício, realiza-se a obra da nossa redenção. Por Cristo, nosso Senhor.',
          communionAntiphonLatin:
              'Parásti in conspéctu meo mensam, et calix meus inébrians quam praeclárus est! (Ps 22, 5).',
          communionAntiphonPt:
              'Preparastes para mim a vossa mesa, e quão precioso é o meu cálice transbordante! (Sl 22, 5).',
          postCommunionLatin:
              'Spíritum nobis, Dómine, tuae caritátis infúnde, ut, quos uno pane caelésti satiásti, una fácias pietáte concórdes. Per Christum.',
          postCommunionPt:
              'Derramai em nós, Senhor, o espírito do vosso amor, para que, saciados pelo único Pão celeste, sejamos unidos na mesma piedade. Por Cristo, nosso Senhor.',
        );
    }
  }
}

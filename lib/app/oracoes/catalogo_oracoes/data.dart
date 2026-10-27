class PrayerStrophe {
  final String? prefix;
  final String pt;
  final String lt;
  final bool isRubric;
  final bool isBold;

  const PrayerStrophe({
    this.prefix,
    required this.pt,
    required this.lt,
    this.isRubric = false,
    this.isBold = false,
  });
}

class OfficialPrayerData {
  final String route;
  final String title;
  final String? subtitle;
  final String category;
  final List<PrayerStrophe> strophes;
  final String? scoreAsset;
  final bool showAmen;

  const OfficialPrayerData({
    required this.route,
    required this.title,
    this.subtitle,
    required this.category,
    required this.strophes,
    this.scoreAsset,
    this.showAmen = true,
  });
}

class OfficialPrayersCatalog {
  static const Map<String, OfficialPrayerData> byRoute = {
    'trisagio-angelico': OfficialPrayerData(
      route: 'trisagio-angelico',
      title: 'Triságio Angélico',
      subtitle: 'Louvor à Santíssima Trindade',
      category: 'Hinos e Símbolos da Fé',
      showAmen: false,
      strophes: [
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'Santo Deus, Santo Forte, Santo Imortal.',
          lt: 'Sanctus Deus, Sanctus Fortis, Sanctus Immortális.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'Tende piedade de nós, e de todo o mundo.',
          lt: 'Miserére nobis, et totíus mundi.',
        ),
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'Glória ao Pai, e ao Filho, e ao Espírito Santo.',
          lt: 'Glória Patri, et Fílio, et Spirítui Sancto.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'Como era no princípio, agora e sempre. Amém.',
          lt: 'Sicut erat in princípio, et nunc, et semper, et in sǽcula sæculórum. Amen.',
        ),
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'A Vós o louvor, a Vós a glória, a Vós a ação de graças pelos séculos sem fim, ó Trindade Beatíssima!',
          lt: 'Tibi laus, Tibi glória, Tibi gratiárum áctio in sǽcula sempitérna, o Beáta Trínitas!',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'Santo, Santo, Santo é o Senhor Deus dos Exércitos: a terra e os céus estão cheios da vossa glória.',
          lt: 'Sanctus, Sanctus, Sanctus Dóminus Deus Exercítuum: pleni sunt cæli et terra glória tua.',
        ),
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'Bendito seja o Pai, e o Filho Unigênito, e também o Espírito Santo.',
          lt: 'Benedíctus Pater et Unigénitus Dei Fílius, Sanctus quoque Spíritus.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'Porque usou de misericórdia para conosco.',
          lt: 'Quia fecit nobíscum misericórdiam suam.',
        ),
        PrayerStrophe(
          pt: 'Oremos.',
          lt: 'Orémus.',
          isRubric: true,
        ),
        PrayerStrophe(
          pt: 'Deus todo-poderoso e eterno, que concedestes aos vossos servos, na confissão da verdadeira fé, reconhecer a glória da eterna Trindade e adorar a Unidade na majestade do vosso poder: nós Vos suplicamos que, pela firmeza desta mesma fé, sejamos sempre defendidos de todas as adversidades. Por Cristo, nosso Senhor. Amém.',
          lt: 'Omnípotens sempitérne Deus, qui dedísti fámulis tuis, in confessióne veræ fídei, ætérnæ Trinitátis glóriam agnóscere, et in poténtiæ maiestáte adoráre Unitátem: quǽsumus; ut, eiúsdem fídei firmitáte, ab ómnibus semper muniámur adversitátibus. Per Christum Dóminum nostrum. Amen.',
        ),
      ],
    ),

    'pange-lingua': OfficialPrayerData(
      route: 'pange-lingua',
      title: 'Pange Lingua',
      subtitle: 'Hino ao Santíssimo Sacramento (São Tomás de Aquino)',
      category: 'Ao Santíssimo Sacramento',
      scoreAsset: 'assets/images/oracoes/partitura_pange_lingua.png',
      strophes: [
        PrayerStrophe(
          prefix: '1. ',
          pt: 'Canta, ó língua, o mistério do glorioso Corpo e do Sangue precioso que o Rei das nações, fruto dum ventre generoso, derramou em preço do resgate do mundo.',
          lt: 'Pange, lingua, gloriósi Córporis mystérium, Sanguinísque pretiósi, quem in mundi prétium fructus ventris generósi Rex effúdit géntium.',
        ),
        PrayerStrophe(
          prefix: '2. ',
          pt: 'Foi-nos dado, nasceu para nós da Virgem intacta; e, tendo vivido no mundo, depois de espalhar a semente da sua palavra, encerrou de modo admirável o tempo da sua morada.',
          lt: 'Nobis datus, nobis natus ex intácta Vírgine, et in mundo conversátus, sparso verbi sémine, sui moras incolátus miro clausit órdine.',
        ),
        PrayerStrophe(
          prefix: '3. ',
          pt: 'Na noite da última Ceia, reclinado à mesa com os irmãos, tendo observado plenamente a Lei quanto ao cordeiro pascal, deu-Se por suas próprias mãos em alimento aos doze Apóstolos.',
          lt: 'In suprémæ nocte cœnæ recúmbens cum frátribus, observáta lege plene cibis in legálibus, cibum turbæ duodénæ se dat suis mánibus.',
        ),
        PrayerStrophe(
          prefix: '4. ',
          pt: 'O Verbo feito carne converte, com a sua palavra, o pão verdadeiro na sua própria Carne; e o vinho torna-se o Sangue de Cristo; e, se os sentidos desfalece, basta a fé somente para confirmar o coração sincero.',
          lt: 'Verbum caro, panem verum verbo carnem éfficit: fitque sanguis Christi merum, et si sensus déficit, ad firmándum cor sincérum sola fides súfficit.',
        ),
        PrayerStrophe(
          prefix: '5. ',
          pt: 'Tão grande Sacramento adoremos, pois, prostrados; e ceda o antigo rito ao novo mistério: supra a fé a fraqueza dos sentidos.',
          lt: 'Tantum ergo Sacraméntum venerémur cérnui: et antíquum documéntum novo cedat rítui: præstet fides suppleméntum sénsuum deféctui.',
        ),
        PrayerStrophe(
          prefix: '6. ',
          pt: 'Ao Pai e ao Filho sejam dados louvor e júbilo, salvação, honra, poder e também a bênção; e Àquele que procede de Ambos seja dado igual louvor.',
          lt: 'Genitóri, Genitóque laus et iubilátio, salus, honor, virtus quoque sit et benedíctio: Procedénti ab utróque compar sit laudátio.',
        ),
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'Do céu lhes destes o Pão.',
          lt: 'Panem de cælo præstitísti eis.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'Que contém em si todo o sabor.',
          lt: 'Omne delectaméntum in se habéntem.',
        ),
        PrayerStrophe(
          pt: 'Oremos. Ó Deus, que neste admirável Sacramento nos deixastes o memorial da vossa Paixão, concedei-nos, nós Vos pedimos, venerar de tal modo os sagrados mistérios do vosso Corpo e do vosso Sangue, que sintamos continuamente em nós o fruto da vossa Redenção. Vós que viveis e reinais pelos séculos dos séculos.',
          lt: 'Orémus. Deus, qui nobis sub Sacraménto mirábili passiónis tuæ memóriam reliquísti: tríbue, quǽsumus, ita nos Córporis et Sánguinis tui sacra mystéria venerári; ut redemptiónis tuæ fructum in nobis iúgiter sentiámus. Qui vivis et regnas in sǽcula sæculórum.',
        ),
      ],
    ),

    'vinde-espirito-santo': OfficialPrayerData(
      route: 'vinde-espirito-santo',
      title: 'Vinde, ó Espírito Santo',
      subtitle: 'Invocação e Sequência Veni Sancte Spiritus',
      category: 'Hinos e Símbolos da Fé',
      strophes: [
        PrayerStrophe(
          prefix: 'Ant. ',
          pt: 'Vinde, Espírito Santo, enchei os corações dos vossos fiéis e acendei neles o fogo do vosso amor.',
          lt: 'Veni, Sancte Spíritus, reple tuórum corda fidélium, et tui amóris in eis ignem accénde.',
          isBold: true,
        ),
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'Enviai o vosso Espírito e tudo será criado.',
          lt: 'Emítte Spíritum tuum, et creabúntur.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'E renovareis a face da terra.',
          lt: 'Et renovábis fáciem terræ.',
        ),
        PrayerStrophe(
          pt: 'Oremos. Ó Deus, que instruístes os corações dos vossos fiéis com a luz do Espírito Santo, fazei que apreciemos retamente todas as coisas segundo o mesmo Espírito e gozemos sempre da sua consolação. Por Cristo, Senhor nosso. Amém.',
          lt: 'Orémus. Deus, qui corda fidélium Sancti Spíritus illustratióne docuísti: da nobis in eódem Spíritu recta sápere; et de eius semper consolatióne gaudére. Per Christum Dóminum nostrum. Amen.',
        ),
        PrayerStrophe(
          pt: 'Sequência (Veni, Sancte Spíritus)',
          lt: 'Sequéntia (Veni, Sancte Spíritus)',
          isRubric: true,
        ),
        PrayerStrophe(
          prefix: '1. ',
          pt: 'Vinde, Espírito Santo, e enviai do céu um raio da vossa luz.',
          lt: 'Veni, Sancte Spíritus, et emítte cǽlitus lucis tuæ rádium.',
        ),
        PrayerStrophe(
          prefix: '2. ',
          pt: 'Vinde, Pai dos pobres, vinde, distribuidor dos dons, vinde, luz dos corações.',
          lt: 'Veni, pater páuperum, veni, dator múnerum, veni, lumen córdium.',
        ),
        PrayerStrophe(
          prefix: '3. ',
          pt: 'Consolador ótimo, doce hóspede da alma, doce refrigério.',
          lt: 'Consolátor óptime, dulcis hospes ánimæ, dulce refrigérium.',
        ),
        PrayerStrophe(
          prefix: '4. ',
          pt: 'No trabalho sois descanso, no calor sois brisa amena, no pranto sois consolo.',
          lt: 'In labóre réquies, in æstu tempéries, in fletu solátium.',
        ),
        PrayerStrophe(
          prefix: '5. ',
          pt: 'Ó Luz beatíssima, enchei o mais íntimo dos corações dos vossos fiéis.',
          lt: 'O lux beatíssima, reple cordis íntima tuórum fidélium.',
        ),
        PrayerStrophe(
          prefix: '6. ',
          pt: 'Sem a vossa graça divina nada há no homem, nada que seja inocente.',
          lt: 'Sine tuo númine, nihil est in hómine, nihil est innóxium.',
        ),
        PrayerStrophe(
          prefix: '7. ',
          pt: 'Lavai o que está manchado, regai o que está seco, curai o que está ferido.',
          lt: 'Lava quod est sórdidum, riga quod est áridum, sana quod est sáucium.',
        ),
        PrayerStrophe(
          prefix: '8. ',
          pt: 'Dobrai o que é rígido, aquecei o que é frio, guiai o que está transviado.',
          lt: 'Flecte quod est rígidum, fove quod est frígidum, rege quod est dévium.',
        ),
        PrayerStrophe(
          prefix: '9. ',
          pt: 'Concedei aos vossos fiéis, que em Vós confiam, os sete dons sagrados.',
          lt: 'Da tuis fidélibus, in te confidéntibus, sacrum septenárium.',
        ),
        PrayerStrophe(
          prefix: '10. ',
          pt: 'Dai-lhes o mérito da virtude, dai-lhes o porto da salvação, dai-lhes a alegria eterna.',
          lt: 'Da virtútis méritum, da salútis éxitum, da perénne gáudium.',
        ),
      ],
    ),

    'veni-creator': OfficialPrayerData(
      route: 'veni-creator',
      title: 'Veni Creator Spiritus',
      subtitle: 'Hino Litúrgico ao Espírito Santo',
      category: 'Hinos e Símbolos da Fé',
      strophes: [
        PrayerStrophe(
          prefix: '1. ',
          pt: 'Vinde, Espírito Criador, visitai as almas dos vossos e enchei da graça celestial os corações que Vós criastes.',
          lt: 'Veni, Creátor Spíritus, mentes tuórum vísita, imple supérna grátia, quæ tu creásti, péctora.',
        ),
        PrayerStrophe(
          prefix: '2. ',
          pt: 'Vós que sois chamado o Consolador, dom do Deus Altíssimo, fonte viva, fogo, caridade e espiritual unção.',
          lt: 'Qui díceris Paráclitus, altíssimi donum Dei, fons vivus, ignis, cáritas, et spiritális únctio.',
        ),
        PrayerStrophe(
          prefix: '3. ',
          pt: 'Vós que dais os sete dons, dedo da destra de Deus, solene promessa do Pai, que enriquecestes os lábios com a palavra.',
          lt: 'Tu septifórmis múnere, dígitus patérnæ déxteræ, tu rite promíssum Patris, sermóne ditans gúttura.',
        ),
        PrayerStrophe(
          prefix: '4. ',
          pt: 'Acendei a luz nos sentidos, infundi o amor nos corações, fortalecei com perpétua virtude a fraqueza do nosso corpo.',
          lt: 'Accénde lumen sénsibus, infúnde amórem córdibus, infírma nostri córporis virtúte firmans pérpeti.',
        ),
        PrayerStrophe(
          prefix: '5. ',
          pt: 'Afastai para longe o inimigo e dai-nos prontamente a paz; assim, indo Vós à nossa frente como guia, evitaremos todo o mal.',
          lt: 'Hostem repéllas lóngius, pacémque dones prótinus; ductóre sic te prǽvio vitémus omne nóxium.',
        ),
        PrayerStrophe(
          prefix: '6. ',
          pt: 'Fazei que por Vós conheçamos o Pai e conheçamos também o Filho; e creiamos sempre em Vós, Espírito de Ambos.',
          lt: 'Per te sciámus da Patrem, noscámus atque Fílium; teque utriúsque Spíritum credámus omni témpore.',
        ),
        PrayerStrophe(
          prefix: '7. ',
          pt: 'A Deus Pai seja dada a glória, e ao Filho que ressuscitou dos mortos, e ao Paráclito, pelos séculos dos séculos.',
          lt: 'Deo Patri sit glória, et Fílio, qui a mórtuis surréxit, ac Paráclito, in sæculórum sǽcula.',
        ),
      ],
    ),

    'consagracao-nossa-senhora': OfficialPrayerData(
      route: 'consagracao-nossa-senhora',
      title: 'Consagração a Nossa Senhora',
      subtitle: 'Ó Senhora minha, ó minha Mãe',
      category: 'Devoções Marianas',
      strophes: [
        PrayerStrophe(
          pt: 'Ó Senhora minha, ó minha Mãe, eu me ofereço todo a Vós, e em prova da minha devoção para convosco, Vos consagro neste dia os meus olhos, os meus ouvidos, a minha boca, o meu coração e inteiramente todo o meu ser.',
          lt: 'O Dómina mea! O Mater mea! Tibi me totum óffero, atque, ut me tibi probem devótum, cónsecro tibi hódie óculos meos, aures meas, os meum, cor meum, plane me totum.',
        ),
        PrayerStrophe(
          pt: 'E porque assim sou vosso, ó incomparável Mãe, guardai-me e defendei-me como coisa e propriedade vossa.',
          lt: 'Quóniam ítaque tuus sum, o bona Mater, serva me, defénde me ut rem ac possessiónem tuam.',
        ),
      ],
    ),

    'alma-redemptoris-mater': OfficialPrayerData(
      route: 'alma-redemptoris-mater',
      title: 'Alma Redemptoris Mater',
      subtitle: 'Antífona Mariana (Advento até a Apresentação do Senhor)',
      category: 'Devoções Marianas',
      strophes: [
        PrayerStrophe(
          pt: 'Mãe amorosa do Redentor, que sois a porta sempre aberta do céu e a estrela do mar, socorrei o povo que cai, mas procura levantar-se; Vós que gerastes, com admiração da natureza, o vosso santo Criador, Virgem antes e depois de terdes recebido da boca de Gabriel aquele Ave, tende piedade dos pecadores.',
          lt: 'Alma Redemptóris Mater, quæ pérvia cæli porta manes, et stella maris, succúrre cadénti, surgére qui curat, pópulo: tu quæ genuísti, natúra miránte, tuum sanctum Genitórem, Virgo prius ac postérius, Gabriélis ab ore sumens illud Ave, peccatórum miserére.',
        ),
        PrayerStrophe(
          pt: 'No Advento:',
          lt: 'In Advéntu:',
          isRubric: true,
        ),
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'O Anjo do Senhor anunciou a Maria.',
          lt: 'Ángelus Dómini nuntiávit Maríæ.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'E Ela concebeu pelo Espírito Santo.',
          lt: 'Et concépit de Spíritu Sancto.',
        ),
        PrayerStrophe(
          pt: 'Oremos. Infundi, Senhor, nós Vos pedimos, a vossa graça em nossas almas, para que nós, que conhecemos pela anunciação do Anjo a Encarnação de Jesus Cristo, vosso Filho, pela sua Paixão e Cruz sejamos conduzidos à glória da Ressurreição. Pelo mesmo Cristo, nosso Senhor.',
          lt: 'Orémus. Grátiam tuam, quǽsumus, Dómine, méntibus nostris infúnde; ut qui, Ángelo nuntiánte, Christi Fílii tui Incarnatiónem cognóvimus, per passiónem eius et crucem, ad resurrectiónis glóriam perducámur. Per eúndem Christum Dóminum nostrum.',
        ),
        PrayerStrophe(
          pt: 'Das Primeiras Vésperas do Natal até a Apresentação (2 de fevereiro):',
          lt: 'A primis Vésperis Nativitátis Dómini usque ad Purificationem:',
          isRubric: true,
        ),
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'Depois do parto permanecestes Virgem imaculada.',
          lt: 'Post partum, Virgo, invioláta permansísti.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'Mãe de Deus, intercedei por nós.',
          lt: 'Dei Génitrix, intercédere pro nobis.',
        ),
        PrayerStrophe(
          pt: 'Oremos. Ó Deus, que pela virgindade fecunda da Bem-aventurada Maria destes ao gênero humano os bens da salvação eterna: concedei-nos, nós Vos suplicamos, que sintamos a intercessão daquela por quem merecemos receber o Autor da vida, nosso Senhor Jesus Cristo, vosso Filho.',
          lt: 'Orémus. Deus, qui salútis ætérnæ, beátæ Maríæ virginitáte fecúnda, humáno géneri prǽmia præstitísti: tríbue, quǽsumus; ut ipsam pro nobis intercédere sentiámus, per quam merúimus Auctórem vitæ suscípere, Dóminum nostrum Iesum Christum Fílium tuum.',
        ),
      ],
    ),

    'ave-regina-caelorum': OfficialPrayerData(
      route: 'ave-regina-caelorum',
      title: 'Ave, Regina Cælorum',
      subtitle: 'Antífona Mariana (Após a Apresentação até a Quarta-Feira Santa)',
      category: 'Devoções Marianas',
      strophes: [
        PrayerStrophe(
          pt: 'Ave, Rainha dos céus! Ave, Senhora dos Anjos! Salve, raiz santa, salve, porta feliz pela qual nasceu a Luz para o mundo! Alegrai-Vos, ó Virgem gloriosa, entre todas a mais bela! Salve, ó cheio de formosura, e rogai sempre a Cristo por nós.',
          lt: 'Ave, Regína cælórum, Ave, Dómina Angelórum: Salve, radix, salve, porta, Ex qua mundo lux est orta: Gaude, Virgo gloriósa, Super omnes speciósa, Vale, o valde decóra, Et pro nobis Christum exóra.',
        ),
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'Permiti que eu Vos louve, ó Virgem sagrada.',
          lt: 'Dignáre me laudáre te, Virgo sacráta.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'Dai-me força contra os vossos inimigos.',
          lt: 'Da mihi virtútem contra hostes tuos.',
        ),
        PrayerStrophe(
          pt: 'Oremos. Concedei, ó Deus misericordioso, proteção à nossa fraqueza, para que nós, que celebramos a memória da Santa Mãe de Deus, nos levantemos das nossas iniquidades com o auxílio da sua intercessão. Pelo mesmo Cristo, nosso Senhor.',
          lt: 'Orémus. Concéde, miséricors Deus, fragilitáti nostræ præsídium: ut, qui sanctæ Dei Genitrícis memóriam ágimus; intercessiónis eius auxílio, a nostris iniquitátibus resurgámus. Per eúndem Christum Dóminum nostrum.',
        ),
      ],
    ),

    'salve-regina': OfficialPrayerData(
      route: 'salve-regina',
      title: 'Salve Regina (Salve Rainha)',
      subtitle: 'Antífona Mariana (Tempo Comum)',
      category: 'Devoções Marianas',
      scoreAsset: 'assets/images/oracoes/partitura_salve_regina.png',
      strophes: [
        PrayerStrophe(
          pt: 'Salve, Rainha, Mãe de misericórdia, vida, doçura e esperança nossa, salve! A Vós bradamos, os degredados filhos de Eva; a Vós suspiramos, gemendo e chorando neste vale de lágrimas. Eia, pois, advogada nossa, esses vossos olhos misericordiosos a nós volvei; e depois deste desterro mostrai-nos Jesus, bendito fruto do vosso ventre, ó clemente, ó piedosa, ó doce sempre Virgem Maria!',
          lt: 'Salve, Regína, Mater misericórdiæ, vita, dulcédo, et spes nostra, salve. Ad te clamámus, éxsules fílii Hevæ. Ad te suspirámus, geméntes et flentes in hac lacrimárum valle. Eia, ergo, advocáta nostra, illos tuos misericórdes óculos ad nos convérte; et Iesum, benedíctum fructum ventris tui, nobis post hoc exsílium osténde. O clemens, O pia, O dulcis Virgo María.',
        ),
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'Rogai por nós, Santa Mãe de Deus.',
          lt: 'Ora pro nobis, sancta Dei Génitrix.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'Para que sejamos dignos das promessas de Cristo.',
          lt: 'Ut digni efficiámur promissiónibus Christi.',
        ),
        PrayerStrophe(
          pt: 'Oremos. Deus eterno e todo-poderoso, que pela cooperação do Espírito Santo preparastes o corpo e a alma da gloriosa Virgem e Mãe Maria para ser digna morada do vosso Filho: concedei que, celebrando com alegria a sua memória, pela sua piedosa intercessão sejamos livres dos males presentes e da morte perpétua. Por Cristo, nosso Senhor.',
          lt: 'Orémus. Omnípotens sempitérne Deus, qui gloriósæ Vírginis Matris Maríæ corpus et ánimam, ut dignum Fílii tui habitáculum éffici mererétur, Spiritu Sancto cooperánte, præparásti: da, ut cuius commemoratióne lætámur, eius pia intercessióne, ab instántibus malis, et a morte perpétua liberémur. Per eúndem Christum Dóminum nostrum.',
        ),
      ],
    ),

    'sub-tuum-praesidium': OfficialPrayerData(
      route: 'sub-tuum-praesidium',
      title: 'Sub Tuum Præsidium',
      subtitle: 'À Vossa Proteção Recorremos',
      category: 'Devoções Marianas',
      showAmen: true,
      strophes: [
        PrayerStrophe(
          pt: 'À vossa proteção recorremos, Santa Mãe de Deus; não desprezeis as nossas súplicas em nossas necessidades, mas livrai-nos sempre de todos os perigos, ó Virgem gloriosa e bendita.',
          lt: 'Sub tuum præsídium confúgimus, sancta Dei Génitrix; nostras deprecatiónes ne despícias in necessitátibus, sed a perículis cunctis líbera nos semper, Virgo gloriósa et benedícta.',
        ),
      ],
    ),

    'magnificat': OfficialPrayerData(
      route: 'magnificat',
      title: 'Magnificat',
      subtitle: 'Cântico de Nossa Senhora (Lc 1, 46-55)',
      category: 'Devoções Marianas',
      strophes: [
        PrayerStrophe(
          prefix: '1. ',
          pt: 'A minha alma engrandece ao Senhor, * e o meu espírito exulta em Deus, meu Salvador.',
          lt: 'Magníficat * ánima mea Dóminum. Et exsultávit spíritus meus * in Deo, salutári meo.',
        ),
        PrayerStrophe(
          prefix: '2. ',
          pt: 'Porque olhou para a humildade de sua serva; * doravante todas as gerações me chamarão bem-aventurada.',
          lt: 'Quia respéxit humilitátem ancíllæ suæ: * ecce enim ex hoc beátam me dicent omnes generatiónes.',
        ),
        PrayerStrophe(
          prefix: '3. ',
          pt: 'Porque o Todo-poderoso fez em mim maravilhas; * e Santo é o seu nome.',
          lt: 'Quia fecit mihi magna, qui potens est: * et sanctum nomen eius.',
        ),
        PrayerStrophe(
          prefix: '4. ',
          pt: 'E a sua misericórdia se estende de geração em geração * sobre aqueles que O temem.',
          lt: 'Et misericórdia eius, a progénie in progénies, * timéntibus eum.',
        ),
        PrayerStrophe(
          prefix: '5. ',
          pt: 'Manifestou o poder do seu braço: * dispersou os soberbos nos pensamentos de seus corações.',
          lt: 'Fecit poténtiam in bráchio suo: * dispérsit supérbos mente cordis sui.',
        ),
        PrayerStrophe(
          prefix: '6. ',
          pt: 'Depôs do trono os poderosos * e elevou os humildes.',
          lt: 'Depósuit poténtes de sede, * et exaltávit húmiles.',
        ),
        PrayerStrophe(
          prefix: '7. ',
          pt: 'Encheu de bens os famintos * e despediu os ricos de mãos vazias.',
          lt: 'Esuriéntes implévit bonis: * et dívites dimísit inánes.',
        ),
        PrayerStrophe(
          prefix: '8. ',
          pt: 'Socorreu Israel, seu servo, * lembrando-Se da sua misericórdia.',
          lt: 'Suscépit Ísrael púerum suum, * recordátus misericórdiæ suæ.',
        ),
        PrayerStrophe(
          prefix: '9. ',
          pt: 'Assim como prometera a nossos pais, * a Abraão e à sua descendência para sempre.',
          lt: 'Sicut locútus est ad patres nostros, * Ábraham, et sémini eius in sǽcula.',
        ),
        PrayerStrophe(
          prefix: '10. ',
          pt: 'Glória ao Pai, e ao Filho, * e ao Espírito Santo. Como era no princípio, agora e sempre, * e por todos os séculos dos séculos.',
          lt: 'Glória Patri, et Fílio, * et Spirítui Sancto. Sicut erat in princípio, et nunc, et semper, * et in sǽcula sæculórum.',
        ),
      ],
    ),

    'oracao-nossa-senhora-antes-missa': OfficialPrayerData(
      route: 'oracao-nossa-senhora-antes-missa',
      title: 'Oração a Nossa Senhora (Antes da Missa)',
      subtitle: 'O Mater pietatis et misericordiae',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'Ó Mãe de piedade e de misericórdia, beatíssima Virgem Maria! Eu, miserável e indigno pecador, recorro a Vós de todo o coração e com todo o afeto, e imploro a vossa bondade: assim como estivestes de pé junto à Cruz do vosso dulcíssimo Filho, dignai-Vos também assistir-me com clemência, a mim miserável pecador e a todos os sacerdotes e fiéis que hoje oferecem e participam deste Sacrifício em toda a Santa Igreja.',
          lt: 'O Mater pietátis et misericórdiæ, beatíssima Virgo María, ego miser et indígnus peccátor ad te confúgio toto corde et afféctu; et precor pietátem tuam, ut, sicut dulcíssimo Fílio tuo in Cruce pendénti astitísti, ita et mihi, mísero peccatóri, et sacerdótibus ómnibus, hic et in tota sancta Ecclésia hódie offeréntibus, cleménter assístere dignéris.',
        ),
        PrayerStrophe(
          pt: 'Para que, auxiliados pela vossa graça, possamos oferecer uma hóstia digna e aceitável na presença da suprema e indivisa Trindade.',
          lt: 'Ut, tua grátia adiúti, dignam et acceptábilem hóstiam in conspéctu summæ et indivíduæ Trinitátis offérre valeámus.',
        ),
      ],
    ),

    'oracao-sao-jose-antes-missa': OfficialPrayerData(
      route: 'oracao-sao-jose-antes-missa',
      title: 'Oração a São José (Antes da Missa)',
      subtitle: 'O felicissime vir, beate Ioseph',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'Ó ditosíssimo varão, bem-aventurado José, a quem foi concedido não só ver e ouvir o Deus a quem muitos reis quiseram ver e não viram, ouvir e não ouviram, mas também trazê-Lo nos braços, beijá-Lo, vesti-Lo e guardá-Lo!',
          lt: 'O felicíssime vir, beáte Ioseph, cui datum est Deum, quem multi reges voluérunt vidére et non vidérunt, audíre et non audiérunt, non solum vidére et audíre, sed étiam portáre, deosculári, vestíre et custodíre!',
        ),
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'Rogai por nós, bem-aventurado José.',
          lt: 'Ora pro nobis, beáte Ioseph.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'Para que sejamos dignos das promessas de Cristo.',
          lt: 'Ut digni efficiámur promissiónibus Christi.',
        ),
        PrayerStrophe(
          pt: 'Oremos. Ó Deus, que nos destes um sacerdócio real: concedei-nos, nós Vos pedimos, que assim como São José mereceu tratar e trazer em suas mãos com reverência o vosso Filho Unigênito, nascido da Virgem Maria, também nós Vos sirvamos com coração limpo e obras puras, de modo que hoje recebamos dignamente o sacrossanto Corpo e Sangue do vosso Filho, e na vida futura mereçamos alcançar o prêmio eterno. Por Cristo, nosso Senhor.',
          lt: 'Orémus. Deus, qui dedísti nobis regále sacerdótium: præsta, quǽsumus; ut, sicut beátus Ioseph unigénitum Fílium tuum, natum ex María Vírgine, suis mánibus reverénter tractáre méruit et portáre, ita nos fácias cum cordis mundítia et óperis innocéntia tuis sanctis altáribus deservíre, ut sacro Fílii tui Córpore et Sánguine hódie digne sumpto, in futúro sǽculo prǽmium habére mereámur ætérnum. Per Christum Dóminum nostrum.',
        ),
      ],
    ),

    'oracao-sao-tomas-antes-missa': OfficialPrayerData(
      route: 'oracao-sao-tomas-antes-missa',
      title: 'Oração de São Tomás de Aquino (Antes da Missa)',
      subtitle: 'Omnipotens sempiterne Deus, ecce accedo',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'Deus eterno e todo-poderoso, eis que me aproximo do sacramento do vosso Filho Unigênito, nosso Senhor Jesus Cristo. Aproximo-me como um enfermo ao médico da vida, como um impuro à fonte da misericórdia, como um cego à luz da claridade eterna, como um pobre e indigente ao Senhor do céu e da terra.',
          lt: 'Omnípotens sempitérne Deus, ecce, accédo ad sacraméntum Unigéniti Fílii tui, Dómini nostri Iesu Christi; accédo tamquam infírmus ad médicum vitæ, immúndus ad fontem misericórdiæ, cæcus ad lumen claritátis ætérnæ, pauper et egénus ad Dóminum cæli et terræ.',
        ),
        PrayerStrophe(
          pt: 'Imploro, pois, a abundância da vossa imensa generosidade, para que Vos digneis curar a minha enfermidade, lavar a minha imundície, iluminar a minha cegueira, enriquecer a minha pobreza e vestir a minha nudez; a fim de que eu receba o Pão dos Anjos, o Rei dos reis e o Senhor dos senhores com tanta reverência e humildade, com tanta contrição e devoção, com tal pureza e fé, com tal propósito e intenção, como convém à salvação da minha alma.',
          lt: 'Rogo ergo imménsæ largitátis tuæ abundántiam, quatenus meam curáre dignéris infirmitátem, laváre fœditátem, illumináre cæcitátem, ditáre paupertátem, vestíre nuditátem: ut panem Angelórum, Regem regum et Dóminum dominántium, tanta suscípiam reveréntia et humilitáte, tanta contritióne et devotióne, tanta puritáte et fide, tali propósito et intentióne, sicut éxpedit salúti ánimæ meæ.',
        ),
        PrayerStrophe(
          pt: 'Dai-me, peço-Vos, receber não só o Sacramento do Corpo e do Sangue do Senhor, mas também a graça e a virtude do Sacramento. Ó Deus benigníssimo, concedei-me acolher de tal modo o Corpo do vosso Filho Unigênito, nosso Senhor Jesus Cristo, que Ele tomou da Virgem Maria, que eu mereça ser incorporado ao seu Corpo Místico e contado entre os seus membros.',
          lt: 'Da mihi, quæso, Domínici Córporis et Sánguinis non solum suscípere sacraméntum, sed étiam rem et virtútem sacraménti. O mitíssime Deus, da mihi corpus Unigéniti Fílii tui, Dómini nostri Iesu Christi, quod traxit de Vírgine María, sic suscípere, ut córpori suo mýstico mérear incorporári, et inter eius membra connumerári.',
        ),
        PrayerStrophe(
          pt: 'Ó Pai amantíssimo, concedei-me contemplar finalmente, de face descoberta e por toda a eternidade, o vosso dileto Filho, que agora me proponho receber sob o véu na caminhada desta vida. Ele, que sendo Deus, vive e reina convosco na unidade do Espírito Santo, por todos os séculos dos séculos.',
          lt: 'O amantíssime Pater, concéde mihi diléctum Fílium tuum, quem nunc velátum in via suscipere propóno, reveláta tandem fácie perpétuo contemplári: Qui tecum vivit et regnat in unitáte Spíritus Sancti Deus, per ómnia sǽcula sæculórum.',
        ),
      ],
    ),

    'oracao-santo-ambrosio-antes-missa': OfficialPrayerData(
      route: 'oracao-santo-ambrosio-antes-missa',
      title: 'Oração de Santo Ambrósio (Antes da Missa)',
      subtitle: 'Ad mensam dulcissimi convivii tui',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'À mesa do vosso dulcíssimo banquete, ó piedoso Senhor Jesus Cristo, eu, pecador, nada presumindo dos meus próprios méritos, mas confiando na vossa misericórdia e bondade, temo e tremo ao aproximar-me. Pois tenho o corpo e o coração manchados por muitas culpas, e não guardei com solicitude a mente e a língua.',
          lt: 'Ad mensam dulcíssimi convívii tui, pie Dómine Iesu Christe, ego peccátor de própriis meis méritis nihil præsúmens, sed de tua confidens misericórdia et bonitáte, accédere véreor et contremísco. Nam cor et corpus hábeo multis crimínibus maculátum, mentem et linguam non caute custodítam.',
        ),
        PrayerStrophe(
          pt: 'Por isso, ó bondosa Divindade, ó temível Majestade, eu, miserável, preso entre tantas angústias, recorro a Vós, fonte de misericórdia; a Vós me apresso para ser curado, sob a vossa proteção me refugio; e Àquele que não posso suportar como Juiz, anseio ter como Salvador.',
          lt: 'Ergo, o pia Déitas, o treménda Maiéstas, ego miser, inter angústias deprehénsus, ad te fontem misericórdiæ recúrro, ad te festíno sanándus, sub tuam protectiónem fúgio: et, quem Iúdicem sustinére néqueo, Salvatórem habére suspíro.',
        ),
        PrayerStrophe(
          pt: 'A Vós, Senhor, mostro as minhas chagas; a Vós descubro a minha vergonha. Sei que os meus pecados são muitos e grandes, e por causa deles temo; mas espero nas vossas misericórdias, que não têm limite. Olhai, pois, para mim com os olhos da vossa misericórdia, Senhor Jesus Cristo, Rei eterno, Deus e Homem, crucificado por causa do homem.',
          lt: 'Tibi, Dómine, plagas meas osténdo, tibi verecúndiam meam détego. Scio peccáta mea multa et magna, pro quibus tímeo: spero in misericórdiis tuis, quarum non est númerus. Réspice ergo in me óculis misericórdiæ tuæ, Dómine Iesu Christe, Rex ætérne, Deus et homo, crucifíxus propter hóminem.',
        ),
        PrayerStrophe(
          pt: 'Escutai-me, pois espero em Vós; tende compaixão de mim, cheio de misérias e pecados, Vós que jamais deixareis de fazer jorrar a fonte da compaixão. Salve, Vítima salvadora, oferecida no patíbulo da Cruz por mim e por todo o gênero humano! Salve, nobre e precioso Sangue, que jorras das chagas do meu Senhor Jesus Cristo crucificado e lavas os pecados do mundo inteiro!',
          lt: 'Exáudi me sperántem in te: miserére mei pleni misériis et peccátis, tu qui fontem miseratiónis numquam manáre cessábis. Salve, salutáris Víctima, pro me et omni humáno génere in patíbulo Crucis obláta. Salve, nóbilis et pretióse Sanguis, de vulnéribus crucifíxi Dómini mei Iesu Christi prófluens, et peccáta totíus mundi ábluens.',
        ),
        PrayerStrophe(
          pt: 'Lembrai-Vos, Senhor, da vossa criatura, que remistes com o vosso Sangue. Arrependo-me de ter pecado, desejo emendar o que fiz. Tirai de mim, portanto, ó Pai clementíssimo, todas as minhas iniquidades e pecados, para que, purificado na alma e no corpo, mereça saborear dignamente o Santo dos santos; e concedei que esta santa comunhão do vosso Corpo e do vosso Sangue, que eu, indigno, me proponho receber, seja o perdão dos meus pecados, a perfeita purificação dos meus delitos, a expulsão dos maus pensamentos, a regeneração dos bons sentimentos e a eficácia salutar das obras que Vos agradam, bem como a firmeza segura da alma e do corpo contra as ciladas dos meus inimigos.',
          lt: 'Recordáre, Dómine, creatúræ tuæ, quam tuo Sánguine redemísti. Pœnitet me peccásse, cúpio emendáre quod feci. Aufer ergo a me, clementíssime Pater, omnes iniquitátes et peccáta mea; ut, purificátus mente et córpore, digne degustáre mérear Sancta sanctórum. Et concéde, ut hæc sancta prælibátio Córporis et Sánguinis tui, quam ego indígnus súmere intendo, sit peccatórum meórum remíssio, sit delictórum perfécta purgátio, sit túrpium cogitatiónum effugátio, ac bonórum sénsuum regenerátio, operúmque tibi placéntium salúbris efficácia, ánimæ quoque et córporis contra inimicórum meórum insídias firmíssima tuítio.',
        ),
      ],
    ),

    'oracao-sao-miguel-arcanjo': OfficialPrayerData(
      route: 'oracao-sao-miguel-arcanjo',
      title: 'Oração a São Miguel Arcanjo',
      subtitle: 'Sancte Michael Archangele (Papa Leão XIII)',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'São Miguel Arcanjo, defendei-nos no combate; sede o nosso refúgio contra as maldades e ciladas do demônio. Ordene-lhe Deus, instantemente o pedimos; e vós, Príncipe da milícia celeste, pelo poder divino, precipitai no inferno a Satanás e aos outros espíritos malignos, que andam pelo mundo para perder as almas.',
          lt: 'Sancte Míchaël Archángele, defénde nos in prœlio; contra nequítiam et insídias diáboli esto præsídium. Ímperet illi Deus, súpplices deprecámur: tuque, Princeps milítiæ cæléstis, Sátanam aliósque spíritus malígnos, qui ad perditiónem animárum pervagántur in mundo, divína virtúte, in inférnum detrúde.',
        ),
      ],
    ),

    'oracao-sao-boaventura': OfficialPrayerData(
      route: 'oracao-sao-boaventura',
      title: 'Oração de São Boaventura (Depois da Missa)',
      subtitle: 'Transfige, dulcissime Domine Iesu',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'Transpassai, dulcíssimo Senhor Jesus, a medula e as entranhas da minha alma com o suavíssimo e salutaríssimo dardo do vosso amor, com a verdadeira, serena e santíssima caridade apostólica, a fim de que a minha alma desfaleça e se derreta sempre só no amor e no desejo de Vós; que por Vós suspire e desfaleça nos vossos átrios, e deseje dissolver-se e estar convosco.',
          lt: 'Transfíge, dulcíssime Dómine Iesu, medúllas et víscera ánimæ meæ suavíssimo ac salubérrimo amóris tui vúlnere, vera, serénaque et apostólica sanctíssima caritáte, ut lángueat et liquefíat ánima mea solo semper amóre et desidério tui; te concupíscat et defíciat in átria tua, cúpiat dissólvi et esse tecum.',
        ),
        PrayerStrophe(
          pt: 'Concedei que a minha alma tenha fome de Vós, Pão dos Anjos, alimento das almas santas, Pão nosso cotidiano, supersubstancial, que tendes toda a doçura e todo o sabor e todo o suave encanto. Que o meu coração tenha sempre fome e se alimente de Vós, a quem os Anjos desejam contemplar, e que o mais íntimo da minha alma fique repleto da doçura do vosso sabor.',
          lt: 'Da, ut ánima mea te esúriat, panem Angelórum, refectiónem animárum sanctárum, panem nostrum cotidiánum, supersubstantiálem, habéntem omnem dulcédinem et sapórem et omne delectaméntum suavitátis. Te, in quem desíderant Ángeli prospícere, semper esúriat et cómedat cor meum, et dulcédine sapóris tui repleántur víscera ánimæ meæ.',
        ),
        PrayerStrophe(
          pt: 'Que tenha sempre sede de Vós, fonte da vida, fonte da sabedoria e da ciência, fonte da luz eterna, torrente de delícias, abundância da casa de Deus. Que sempre Vos procure, Vos busque, Vos encontre, para Vós caminhe, a Vós chegue, em Vós medite, de Vós fale e tudo faça para louvor e glória do vosso nome, com humildade e discrição, com amor e deleite, com facilidade e afeto, com perseverança até ao fim.',
          lt: 'Te semper sítiat fontem vitæ, fontem sapiéntiæ et sciéntiæ, fontem ætérni lúminis, torréntem voluptátis, ubertátem domus Dei: te semper ámbiat, te quærat, te invéniat, ad te tendat, ad te pervéniat, te medítetur, te loquátur, et ómnia operétur in laudem et glóriam nóminis tui, cum humilitáte et discretióne, cum dilectióne et delectatióne, cum facilitáte et afféctu, cum perseverántia usque in finem.',
        ),
        PrayerStrophe(
          pt: 'E sede Vós só sempre a minha esperança, toda a minha confiança, a minha riqueza, o meu deleite, a minha alegria, o meu gozo, o meu descanso e a minha tranquilidade, a minha paz, a minha suavidade, o meu perfume, a minha doçura, o meu alimento, o meu refúgio, o meu auxílio, a minha sabedoria, a minha herança, a minha posse e o meu tesouro, no qual estejam sempre fixos, firmes e inabalavelmente enraizados a minha mente e o meu coração.',
          lt: 'Et tu sis solus semper spes mea, tota fidúcia mea, divítiæ meæ, delectátio mea, iucúnditas mea, gáudium meum, quies et tranquíllitas mea, pax mea, suávitas mea, odor meus, dulcédo mea, cibus meus, reféctio mea, refúgium meum, auxílium meum, sapiéntia mea, pórtio mea, posséssio mea, thesáurus meus; in quo fixa et firma et immobíliter semper sit radicáta mens mea et cor meum.',
        ),
      ],
    ),

    'oracao-universal-clemente-xi': OfficialPrayerData(
      route: 'oracao-universal-clemente-xi',
      title: 'Oração Universal (Depois da Missa)',
      subtitle: 'Atribuída ao Papa Clemente XI',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'Meu Deus, creio em Vós, mas fortalecei a minha fé; espero em Vós, mas assegurai a minha esperança; amo-Vos, mas abrasai o meu amor; arrependo-me de ter pecado, mas aumentai o meu arrependimento.',
          lt: 'Credo, Dómine, sed credam fírmius; spero, sed sperem secúrius; amo, sed amem ardéntius; dóleo, sed dóleam veheméntius.',
        ),
        PrayerStrophe(
          pt: 'Adoro-Vos como primeiro princípio; desejo-Vos como fim último; louvo-Vos como benfeitor perpétuo; invoco-Vos como defensor benigno.',
          lt: 'Adóro te ut primum princípium; desídero ut finem últimum; laudo ut benefactórem perpétuum; ínvoco ut defensórem propítium.',
        ),
        PrayerStrophe(
          pt: 'Dirigi-me com a vossa sabedoria, contende-me com a vossa justiça, consolai-me com a vossa clemência, protegei-me com o vosso poder.',
          lt: 'Tua me sapiéntia dírige, iustítia cóntine, cleméntia soláre, poténtia prótege.',
        ),
        PrayerStrophe(
          pt: 'Ofereço-Vos, Senhor, os meus pensamentos, para que se dirijam a Vós; as minhas palavras, para que falem de Vós; as minhas ações, para que sejam segundo a vossa vontade; os meus sofrimentos, para que os suporte por Vós.',
          lt: 'Óffero tibi, Dómine, cogitánda, ut sint ad te; dicénda, ut sint de te; faciénda, ut sint secúndum te; ferénda, ut sint propter te.',
        ),
        PrayerStrophe(
          pt: 'Quero o que quereis, quero-o porque o quereis, quero-o como o quereis, quero-o até quando o quereis.',
          lt: 'Volo quidquid vis, volo quia vis, volo quómodo vis, volo quámdiu vis.',
        ),
        PrayerStrophe(
          pt: 'Peço-Vos, Senhor: iluminai o meu entendimento, inflamai a minha vontade, purificai o meu coração, santificai a minha alma.',
          lt: 'Oro, Dómine: intelléctum illúmines, voluntátem inflámmes, cor emúndes, ánimam sanctífices.',
        ),
        PrayerStrophe(
          pt: 'Fazei que eu chore os pecados passados, repila as tentações futuras, corrija as más inclinações e cultive as virtudes necessárias.',
          lt: 'Defléam præteríta iniquitátes, repéllam futúras tentatiónes, córrigam vitiósas propensiónes, excolam idóneas virtútes.',
        ),
        PrayerStrophe(
          pt: 'Concedei-me, ó bom Deus, amor a Vós e aversão a mim mesmo, zelo pelo próximo e desprezo do mundo. Que eu me esforce por obedecer aos superiores, socorrer os inferiores, atender aos amigos e perdoar aos inimigos.',
          lt: 'Tríbue mihi, bone Deus, amórem tui, ódium mei, zelum próximi, contémptum mundi. Stúdeam superióribus obedíre, inferióribus subveníre, amícis consúlere, inimícis párcere.',
        ),
        PrayerStrophe(
          pt: 'Que eu vença a sensualidade pela mortificação, a avareza pela generosidade, a ira pela mansidão, a tibieza pelo fervor.',
          lt: 'Vincam voluptátem austeritáte, avarítiam largitáte, iracúndiam lenitáte, tepiditátem fervóre.',
        ),
        PrayerStrophe(
          pt: 'Tornai-me prudente nos conselhos, constante nos perigos, paciente nas adversidades e humilde na prosperidade.',
          lt: 'Redde me prudéntem in consíliis, constántem in perículis, patiéntem in advérsis, húmilem in prósperis.',
        ),
        PrayerStrophe(
          pt: 'Fazei, Senhor, que eu seja atento na oração, sóbrio na mesa, diligente no cumprimento do dever e firme nos propósitos.',
          lt: 'Fac, Dómine, ut sim in oratióne atténtus, in épulis sóbrius, in múnere sédulus, in propósito firmus.',
        ),
        PrayerStrophe(
          pt: 'Que eu cuide de ter pureza interior, modéstia exterior, conversação exemplar e vida ordenada.',
          lt: 'Curem habére innocéntiam interiórem, modéstiam exteriórem, conversatiónem exemplárem, vitam regulárem.',
        ),
        PrayerStrophe(
          pt: 'Que eu vigie assiduamente para dominar a natureza, colaborar com a graça, guardar a vossa Lei e merecer a salvação.',
          lt: 'Assídue invígilem natúræ domándæ, grátiæ fovéndæ, legi servándæ, salúti promeréndæ.',
        ),
        PrayerStrophe(
          pt: 'Que eu aprenda de Vós quão frágil é o que é terreno, quão grande o que é divino, quão breve o que é temporal, quão duradouro o que é eterno.',
          lt: 'Discam a te quam tenue quod terrénum, quam grande quod divínum, quam breve quod temporáneum, quam durábile quod ætérnum.',
        ),
        PrayerStrophe(
          pt: 'Concedei-me preparar-me para a morte, temer o juízo, escapar do inferno e alcançar o paraíso. Por Cristo, nosso Senhor.',
          lt: 'Da, ut mortem prævéniam, iudícium pertímeam, inférnum effúgiam, paradísum obtíneam. Per Christum Dóminum nostrum.',
        ),
      ],
    ),

    'oracao-jesus-crucificado': OfficialPrayerData(
      route: 'oracao-jesus-crucificado',
      title: 'Oração a Jesus Crucificado (Depois da Missa)',
      subtitle: 'En ego, o bone et dulcissime Iesu',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'Eis-me aqui, ó bom e dulcíssimo Jesus! De joelhos me prostro na vossa divina presença e Vos suplico, com o mais ardente fervor da minha alma, que Vos digneis imprimir no meu coração vivos sentimentos de fé, esperança e caridade, e um verdadeiro arrependimento dos meus pecados, com vontade firmíssima de os emendar.',
          lt: 'En ego, o bone et dulcíssime Iesu, ante conspéctum tuum génibus me provólvo, ac máximo ánimi ardóre te oro atque obtéstor, ut meum in cor vividos fídei, spei et caritátis sensus, atque veram peccatórum meórum pœniténtiam, eáque emendándi firmíssimam voluntátem velis imprímere.',
        ),
        PrayerStrophe(
          pt: 'Enquanto com grande afeto e dor da alma considero e contemplo em mim mesmo as vossas cinco Chagas, tendo diante dos olhos aquilo que já o profeta Davi punha em vossos lábios acerca de Vós, ó bom Jesus: "Transpassaram as minhas mãos e os meus pés, e contaram todos os meus ossos" (Sl 21, 17-18).',
          lt: 'Dum magno ánimi afféctu et dolóre tua quinque Vúlnera mecum ipse consídero ac mente contémplor, illud præ óculis habens, quod iam in ore ponébat tuo David prophéta de te, o bone Iesu: "Fodérunt manus meas et pedes meos: dinumeravérunt ómnia ossa mea".',
        ),
      ],
    ),

    'anima-christi': OfficialPrayerData(
      route: 'anima-christi',
      title: 'Aspirações ao Santíssimo Redentor (Alma de Cristo)',
      subtitle: 'Anima Christi (Depois da Missa)',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'Alma de Cristo, santificai-me.\nCorpo de Cristo, salvai-me.\nSangue de Cristo, inebriai-me.\nÁgua do lado de Cristo, lavai-me.\nPaixão de Cristo, confortai-me.\nÓ bom Jesus, ouvi-me.\nDentro das vossas Chagas, escondei-me.\nNão permitais que eu me separe de Vós.\nDo inimigo maligno, defendei-me.\nNa hora da minha morte, chamai-me.\nE mandai-me ir para Vós,\npara que com os vossos Santos Vos louve\npelos séculos dos séculos.',
          lt: 'Ánima Christi, sanctífica me.\nCorpus Christi, salva me.\nSanguis Christi, inébria me.\nAqua láteris Christi, lava me.\nPássio Christi, confórta me.\nO bone Iesu, exáudi me.\nIntra tua vúlnera abscónde me.\nNe permíttas me separári a te.\nAb hoste malígno defénde me.\nIn hora mortis meæ voca me.\nEt iube me veníre ad te,\nut cum Sanctis tuis laudem te\nin sǽcula sæculórum.',
        ),
      ],
    ),

    'oracao-nossa-senhora-depois-missa': OfficialPrayerData(
      route: 'oracao-nossa-senhora-depois-missa',
      title: 'Oração a Nossa Senhora (Depois da Missa)',
      subtitle: 'O Maria, Virgo et Mater sanctissima',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'Ó Maria, Virgem e Mãe santíssima, eis que recebi o vosso amantíssimo Filho, que concebestes no vosso seio imaculado, destes à luz, amamentastes e estreitastes com ternura em vossos braços.',
          lt: 'O María, Virgo et Mater sanctíssima, ecce, suscépi dilectíssimum Fílium tuum, quem immaculáto útero tuo concepísti, genuísti, lactásti, atque suavíssimis ampléxibus strinxísti.',
        ),
        PrayerStrophe(
          pt: 'Eis Aquele cuja visão Vos enchia de alegria e Vos cumulava de todas as delícias: humildemente e com amor vo-Lo apresento e ofereço, para que O abraceis em vossos braços, O ameis com o vosso coração e O ofereçais à Santíssima Trindade em culto supremo de adoração, para vossa honra e glória, e pelas minhas necessidades e as do mundo inteiro.',
          lt: 'Ecce, cuius aspéctu lætabáris et ómnibus delíciis replebáris, illum ipsum tibi humíliter et amánter repræsénto et óffero, tuis bráchiis complecténdum, tuo corde amándum, sanctissimǽque Trinitáti in suprémum latríæ cultum, pro tui ipsíus honóre et glória et pro meis totiúsque mundi necessitátibus, offeréndum.',
        ),
        PrayerStrophe(
          pt: 'Peço-Vos, pois, ó Mãe piedosíssima, alcançai-me o perdão de todos os meus pecados e graça abundante para servir-Lhe daqui em diante com maior fidelidade; e, por fim, a graça final, para que convosco possa louvá-Lo por todos os séculos dos séculos.',
          lt: 'Rogo ergo te, piíssima Mater, ímpetra mihi véniam ómnium peccatórum meórum, uberémque grátiam ipsi deínceps fidélius serviéndi, ac deníque grátiam finálem, ut eum tecum laudáre possim per ómnia sǽcula sæculórum.',
        ),
      ],
    ),

    'oracao-sao-jose-depois-missa': OfficialPrayerData(
      route: 'oracao-sao-jose-depois-missa',
      title: 'Oração a São José (Depois da Missa)',
      subtitle: 'Virginum custos et pater, sancte Ioseph',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          pt: 'Guarda das virgens e pai, São José, a cuja fiel custódia foram confiadas a própria Inocência, Cristo Jesus, e a Virgem das virgens, Maria:',
          lt: 'Vírginum custos et pater, sancte Ioseph, cuius fidéli custódiæ ipsa Innocéntia Christus Iesus et Virgo vírginum María commíssa fuit:',
        ),
        PrayerStrophe(
          pt: 'Por este duplo e caríssimo penhor, Jesus e Maria, eu vos rogo e suplico que me alcanceis ser preservado de toda impureza, e que com mente incontaminada, coração puro e corpo casto, sirva sempre castissimamente a Jesus e a Maria.',
          lt: 'Te per hoc utrúmque caríssimum pignus Iesum et Maríam óbsecro et obtéstor, ut me, ab omni immundítia præservátum, mente incontamináta, puro corde et casto córpore Iesu et Maríæ semper fácias castíssime famulári.',
        ),
      ],
    ),

    'cantico-tres-jovens': OfficialPrayerData(
      route: 'cantico-tres-jovens',
      title: 'Cântico dos Três Jovens (Depois da Missa)',
      subtitle: 'Trium Puerorum (Dn 3, 57-88.56)',
      category: 'Santa Missa (Antes e Depois)',
      strophes: [
        PrayerStrophe(
          prefix: 'Ant. ',
          pt: 'Cantemos o hino dos três jovens, que os santos cantavam na fornalha ardente, bendizendo ao Senhor.',
          lt: 'Trium puerórum cantémus hymnum, quem cantábant sancti in camíno ignis, benedicéntes Dóminum.',
          isBold: true,
        ),
        PrayerStrophe(
          prefix: '1. ',
          pt: 'Obras todas do Senhor, bendizei ao Senhor: * louvai-O e exaltai-O pelos séculos sem fim.',
          lt: 'Benedícite, ómnia ópera Dómini, Dómino: * laudáte et superexaltáte eum in sǽcula.',
        ),
        PrayerStrophe(
          prefix: '2. ',
          pt: 'Anjos do Senhor, bendizei ao Senhor: * céus, bendizei ao Senhor.',
          lt: 'Benedícite, Ángeli Dómini, Dómino: * benedícite, cæli, Dómino.',
        ),
        PrayerStrophe(
          prefix: '3. ',
          pt: 'Águas todas que estais sobre os céus, bendizei ao Senhor: * poderes todos do Senhor, bendizei ao Senhor.',
          lt: 'Benedícite, aquæ omnes, quæ super cælos sunt, Dómino: * benedícite, omnes virtútes Dómini, Dómino.',
        ),
        PrayerStrophe(
          prefix: '4. ',
          pt: 'Sol e lua, bendizei ao Senhor: * estrelas do céu, bendizei ao Senhor.',
          lt: 'Benedícite, sol et luna, Dómino: * benedícite, stellæ cæli, Dómino.',
        ),
        PrayerStrophe(
          prefix: '5. ',
          pt: 'Toda a chuva e orvalho, bendizei ao Senhor: * todos os ventos, bendizei ao Senhor.',
          lt: 'Benedícite, omnis imber et ros, Dómino: * benedícite, omnes spíritus Dei, Dómino.',
        ),
        PrayerStrophe(
          prefix: '6. ',
          pt: 'Fogo e calor, bendizei ao Senhor: * frio e ardor, bendizei ao Senhor.',
          lt: 'Benedícite, ignis et æstus, Dómino: * benedícite, frigus et æstus, Dómino.',
        ),
        PrayerStrophe(
          prefix: '7. ',
          pt: 'Orvalhos e geadas, bendizei ao Senhor: * gelo e frio, bendizei ao Senhor.',
          lt: 'Benedícite, rores et pruína, Dómino: * benedícite, gelu et frigus, Dómino.',
        ),
        PrayerStrophe(
          prefix: '8. ',
          pt: 'Geadas e neves, bendizei ao Senhor: * noites e dias, bendizei ao Senhor.',
          lt: 'Benedícite, glácies et nives, Dómino: * benedícite, noctes et dies, Dómino.',
        ),
        PrayerStrophe(
          prefix: '9. ',
          pt: 'Luz e trevas, bendizei ao Senhor: * relâmpagos e nuvens, bendizei ao Senhor.',
          lt: 'Benedícite, lux et ténebræ, Dómino: * benedícite, fúlgura et nubes, Dómino.',
        ),
        PrayerStrophe(
          prefix: '10. ',
          pt: 'Bendiga a terra ao Senhor: * louve-O e exalte-O pelos séculos sem fim.',
          lt: 'Benedícat terra Dóminum: * laudet et superexáltet eum in sǽcula.',
        ),
        PrayerStrophe(
          prefix: '11. ',
          pt: 'Montes e colinas, bendizei ao Senhor: * tudo o que germina na terra, bendizei ao Senhor.',
          lt: 'Benedícite, montes et colles, Dómino: * benedícite, univérsa germinántia in terra, Dómino.',
        ),
        PrayerStrophe(
          prefix: '12. ',
          pt: 'Fontes, bendizei ao Senhor: * mares e rios, bendizei ao Senhor.',
          lt: 'Benedícite, fontes, Dómino: * benedícite, mária et flúmina, Dómino.',
        ),
        PrayerStrophe(
          prefix: '13. ',
          pt: 'Cetáceos e tudo o que se move nas águas, bendizei ao Senhor: * todas as aves do céu, bendizei ao Senhor.',
          lt: 'Benedícite, cete, et ómnia, quæ movéntur in aquis, Dómino: * benedícite, omnes vólucres cæli, Dómino.',
        ),
        PrayerStrophe(
          prefix: '14. ',
          pt: 'Todos os animais selvagens e domésticos, bendizei ao Senhor: * filhos dos homens, bendizei ao Senhor.',
          lt: 'Benedícite, omnes béstiæ et pécora, Dómino: * benedícite, fílii hóminum, Dómino.',
        ),
        PrayerStrophe(
          prefix: '15. ',
          pt: 'Bendiga Israel ao Senhor: * louve-O e exalte-O pelos séculos sem fim.',
          lt: 'Benedícat Ísrael Dóminum: * laudet et superexáltet eum in sǽcula.',
        ),
        PrayerStrophe(
          prefix: '16. ',
          pt: 'Sacerdotes do Senhor, bendizei ao Senhor: * servos do Senhor, bendizei ao Senhor.',
          lt: 'Benedícite, sacerdótes Dómini, Dómino: * benedícite, servi Dómini, Dómino.',
        ),
        PrayerStrophe(
          prefix: '17. ',
          pt: 'Espíritos e almas dos justos, bendizei ao Senhor: * santos e humildes de coração, bendizei ao Senhor.',
          lt: 'Benedícite, spíritus, et ánimæ iustórum, Dómino: * benedícite, sancti, et húmiles corde, Dómino.',
        ),
        PrayerStrophe(
          prefix: '18. ',
          pt: 'Ananias, Azarias e Misael, bendizei ao Senhor: * louvai-O e exaltai-O pelos séculos sem fim.',
          lt: 'Benedícite, Ananía, Azaría, Mísaël, Dómino: * laudáte et superexaltáte eum in sǽcula.',
        ),
        PrayerStrophe(
          prefix: '19. ',
          pt: 'Bendigamos ao Pai, e ao Filho, com o Espírito Santo: * louvemo-Lo e exaltemo-Lo pelos séculos sem fim.',
          lt: 'Benedicámus Patrem et Fílium cum Sancto Spíritu: * laudémus et superexaltémus eum in sǽcula.',
        ),
        PrayerStrophe(
          prefix: '20. ',
          pt: 'Bendito sois, Senhor, no firmamento do céu: * e digno de louvor, glorioso e superexaltado pelos séculos sem fim.',
          lt: 'Benedíctus es, Dómine, in firmaménto cæli: * et laudábilis, et gloriósus, et superexaltátus in sǽcula.',
        ),
        PrayerStrophe(
          pt: 'Oremos. Ó Deus, que mitigastes as chamas do fogo aos três jovens: concedei propício que a nós, vossos servos, não nos abrase a chama dos vícios. Actiones nostras: Inspirai, Senhor, as nossas ações com a vossa graça e acompanhai-as com o vosso auxílio, a fim de que todas as nossas orações e trabalhos comecem sempre em Vós e por Vós sejam concluídos. Por Cristo, nosso Senhor.',
          lt: 'Orémus. Deus, qui tribus púeris mitigásti flammas ígnium: concéde propítius; ut nos fámulos tuos non exúrat flamma vitiórum. Actiónes nostras, quǽsumus, Dómine, aspirándo prǽveni et adiuvándo proséquere: ut cuncta nostra orátio et operátio a te semper incípiat, et per te cœpta finiátur. Per Christum Dóminum nostrum.',
        ),
      ],
    ),

    'salmo-50': OfficialPrayerData(
      route: 'salmo-50',
      title: 'Salmo 50 (Miserere)',
      subtitle: 'Salmo Penitencial',
      category: 'Hinos e Símbolos da Fé',
      strophes: [
        PrayerStrophe(
          prefix: '1. ',
          pt: 'Tende piedade de mim, ó Deus, segundo a vossa grande misericórdia; * e segundo a multidão das vossas clemências, apagai a minha iniquidade.',
          lt: 'Miserére mei, Deus, * secúndum magnam misericórdiam tuam. Et secúndum multitúdinem miseratiónum tuárum, * dele iniquitátem meam.',
        ),
        PrayerStrophe(
          prefix: '2. ',
          pt: 'Lavai-me cada vez mais da minha iniquidade, * e purificai-me do meu pecado.',
          lt: 'Ámplius lava me ab iniquitáte mea: * et a peccáto meo munda me.',
        ),
        PrayerStrophe(
          prefix: '3. ',
          pt: 'Porque eu conheço a minha iniquidade, * e o meu pecado está sempre diante de mim.',
          lt: 'Quóniam iniquitátem meam ego cognósco: * et peccátum meum contra me est semper.',
        ),
        PrayerStrophe(
          prefix: '4. ',
          pt: 'Pequei contra Vós só, e fiz o mal diante dos vossos olhos; * para que sejais reconhecido justo nas vossas palavras e vençais quando fordes julgado.',
          lt: 'Tibi soli peccávi, et malum coram te feci: * ut iustificéris in sermónibus tuis, et vincas cum iudicáris.',
        ),
        PrayerStrophe(
          prefix: '5. ',
          pt: 'Eis que fui concebido na iniquidade, * e em pecados me concebeu minha mãe.',
          lt: 'Ecce enim in iniquitátibus concéptus sum: * et in peccátis concépit me mater mea.',
        ),
        PrayerStrophe(
          prefix: '6. ',
          pt: 'Eis que amastes a verdade: * manifestastes-me os segredos ocultos da vossa sabedoria.',
          lt: 'Ecce enim veritátem dilexísti: * incérta et occúlta sapiéntiæ tuæ manifestásti mihi.',
        ),
        PrayerStrophe(
          prefix: '7. ',
          pt: 'Aspergir-me-eis com o hissopo, e ficarei limpo; * lavar-me-eis, e ficarei mais branco do que a neve.',
          lt: 'Aspérges me hyssópo, et mundábor: * lavábis me, et super nivem dealbábor.',
        ),
        PrayerStrophe(
          prefix: '8. ',
          pt: 'Far-me-eis ouvir gozo e alegria, * e exultarão os ossos humilhados.',
          lt: 'Audítui meo dabis gáudium et lætítiam: * et exsultábunt ossa humiliáta.',
        ),
        PrayerStrophe(
          prefix: '9. ',
          pt: 'Apartai a vossa face dos meus pecados, * e apagai todas as minhas iniquidades.',
          lt: 'Avérte fáciem tuam a peccátis meis: * et omnes iniquitátes meas dele.',
        ),
        PrayerStrophe(
          prefix: '10. ',
          pt: 'Criai em mim um coração puro, ó Deus, * e renovai no meu íntimo um espírito reto.',
          lt: 'Cor mundum crea in me, Deus: * et spíritum rectum ínnova in viscéribus meis.',
        ),
        PrayerStrophe(
          prefix: '11. ',
          pt: 'Não me afasteis da vossa presença, * e não retireis de mim o vosso Santo Espírito.',
          lt: 'Ne proiícias me a fácie tua: * et spíritum sanctum tuum ne áuferas a me.',
        ),
        PrayerStrophe(
          prefix: '12. ',
          pt: 'Restituí-me a alegria da vossa salvação, * e confirmai-me com um espírito generoso.',
          lt: 'Redde mihi lætítiam salutáris tui: * et spíritu principáli confírma me.',
        ),
        PrayerStrophe(
          prefix: '13. ',
          pt: 'Ensinarei aos iníquos os vossos caminhos, * e os ímpios se converterão a Vós.',
          lt: 'Docébo iníquos vias tuas: * et ímpii ad te converténtur.',
        ),
        PrayerStrophe(
          prefix: '14. ',
          pt: 'Livrai-me do crime de sangue, ó Deus, Deus da minha salvação, * e a minha língua exaltará a vossa justiça.',
          lt: 'Líbera me de sanguínibus, Deus, Deus salútis meæ: * et exsultábit lingua mea iustítiam tuam.',
        ),
        PrayerStrophe(
          prefix: '15. ',
          pt: 'Abrirei, Senhor, os meus lábios, * e a minha boca anunciará o vosso louvor.',
          lt: 'Dómine, lábia mea apéries: * et os meum annuntiábit laudem tuam.',
        ),
        PrayerStrophe(
          prefix: '16. ',
          pt: 'Porque se quisésseis um sacrifício, eu vo-lo teria oferecido; * mas não Vos deleitais com holocaustos.',
          lt: 'Quóniam si voluísses sacrifícium, dedíssem útique: * holocáustis non delectáberis.',
        ),
        PrayerStrophe(
          prefix: '17. ',
          pt: 'O sacrifício para Deus é o espírito contrito: * um coração contrito e humilhado, ó Deus, não o desprezareis.',
          lt: 'Sacrifícium Deo spíritus contribulátus: * cor contrítum, et humiliátum, Deus, non despícies.',
        ),
        PrayerStrophe(
          prefix: '18. ',
          pt: 'Tratai benignamente a Sião, Senhor, na vossa boa vontade, * para que se edifiquem os muros de Jerusalém.',
          lt: 'Benígne fac, Dómine, in bona voluntáte tua Sion: * ut ædificéntur muri Ierúsalem.',
        ),
        PrayerStrophe(
          prefix: '19. ',
          pt: 'Então aceitareis o sacrifício de justiça, as oblações e os holocaustos; * então porão novilhos sobre o vosso altar.',
          lt: 'Tunc acceptábis sacrifícium iustítiæ, oblatiónes, et holocáusta: * tunc impónent super altáre tuum vítulos.',
        ),
        PrayerStrophe(
          prefix: '20. ',
          pt: 'Glória ao Pai, e ao Filho, e ao Espírito Santo. * Como era no princípio, agora e sempre, e por todos os séculos dos séculos.',
          lt: 'Glória Patri, et Fílio, et Spirítui Sancto. * Sicut erat in princípio, et nunc, et semper, et in sǽcula sæculórum.',
        ),
      ],
    ),

    'salve-santa-cruz': OfficialPrayerData(
      route: 'salve-santa-cruz',
      title: 'Salve, Santa Cruz',
      subtitle: 'Adoração e Louvor à Santa Cruz',
      category: 'Hinos e Símbolos da Fé',
      strophes: [
        PrayerStrophe(
          prefix: 'V. ',
          pt: 'Nós Vos adoramos, Senhor Jesus Cristo, e Vos bendizemos.',
          lt: 'Adorámus te, Christe, et benedícimus tibi.',
        ),
        PrayerStrophe(
          prefix: 'R. ',
          pt: 'Porque pela vossa Santa Cruz remistes o mundo.',
          lt: 'Quia per sanctam Crucem tuam redemísti mundum.',
        ),
        PrayerStrophe(
          pt: 'Salve, ó Cruz, nossa única esperança! Neste tempo da Paixão, aumentai aos justos a graça e apagai aos pecadores a culpa. A Vós, Trindade fonte de salvação, louve todo o espírito; e aqueles a quem dais a vitória pela Cruz, guiai-os pelos séculos.',
          lt: 'O Crux, ave, spes única! Hoc Passiónis témpore piis adáuge grátiam, reísque dele crímina. Te, fons salútis Trínitas, colláudet omnis spíritus: quibus Crucis victóriam largíris, adde prǽmium.',
        ),
        PrayerStrophe(
          pt: 'Salve, Cruz preciosa, santificada pelo Corpo de meu Senhor e ornada com seus membros como de ricas pérolas! Antes que o Senhor subisse a ti, eras objeto de pavor terreno; agora, dotada de amor celeste, és acolhida como dom de salvação.',
          lt: 'O Crux benedícta, quæ sola fuísti digna portáre Regem cælórum et Dóminum! Salve, Crux pretiósa, suscepta cum desidério ab amatóribus Christi.',
        ),
        PrayerStrophe(
          pt: 'Pelo sinal ✠ da Santa Cruz, livrai-nos, Deus, ✠ nosso Senhor, dos nossos ✠ inimigos. Em nome do Pai, e do Filho, e do Espírito Santo.',
          lt: 'Per signum ✠ Crucis de inimícis ✠ nostris líbera nos, Deus ✠ noster. In nómine Patris, et Fílii, et Spíritus Sancti.',
        ),
      ],
    ),

    'atos-fe-esperanca-caridade': OfficialPrayerData(
      route: 'atos-fe-esperanca-caridade',
      title: 'Atos de Fé, Esperança e Caridade',
      subtitle: 'Virtudes Teologais',
      category: 'Orações do Dia',
      strophes: [
        PrayerStrophe(
          pt: 'Ato de Fé',
          lt: 'Actus Fídei',
          isRubric: true,
        ),
        PrayerStrophe(
          pt: 'Meu Deus, eu creio firmemente em todas as verdades que Vós revelastes e que a Santa Igreja nos propõe para crer, porque Vós, que sois a própria Verdade infalível, as revelastes, não podendo enganar-Vos nem enganar-nos.',
          lt: 'Dómine Deus, firma fide credo et confíteor ómnia et síngula quæ sancta Ecclésia Cathólica propónit, quia tu, Deus, ea ómnia revelásti, qui es ætérna véritas et sapiéntia quæ nec fállere nec falli potest. In hac fide vívere et mori státuo.',
        ),
        PrayerStrophe(
          pt: 'Ato de Esperança',
          lt: 'Actus Spei',
          isRubric: true,
        ),
        PrayerStrophe(
          pt: 'Meu Deus, espero com firme confiança que me dareis, pelos méritos de Jesus Cristo, a vossa graça neste mundo e a vida eterna no outro, cumprindo as vossas santas leis, porque Vós o prometestes, que sois infinitamente bom, fiel às vossas promessas e todo-poderoso.',
          lt: 'Dómine Deus, spero per grátiam tuam remissiónem ómnium peccatórum, et post hanc vitam ætérnam felicitátem me esse consecutúrum: quia tu promisísti, qui es infiníte potens, fidélis, benígnus, et miséricors. In hac spe vívere et mori státuo.',
        ),
        PrayerStrophe(
          pt: 'Ato de Caridade',
          lt: 'Actus Caritátis',
          isRubric: true,
        ),
        PrayerStrophe(
          pt: 'Meu Deus, amo-Vos de todo o meu coração e sobre todas as coisas, porque sois infinitamente bom e amável; e por vosso amor amo ao meu próximo como a mim mesmo, perdoando de coração a todos os que me ofenderam.',
          lt: 'Dómine Deus, amo te super ómnia et próximum meum propter te, quia tu es summum, infinítum, et perfectíssimum bonum, omni dilectióne dignum. In hac caritáte vívere et mori státuo.',
        ),
      ],
    ),

    'anjo-da-guarda': OfficialPrayerData(
      route: 'anjo-da-guarda',
      title: 'Oração ao Santo Anjo da Guarda',
      subtitle: 'Angele Dei',
      category: 'Orações do Dia',
      strophes: [
        PrayerStrophe(
          pt: 'Santo Anjo do Senhor, meu zeloso guardador, se a ti me confiou a piedade divina, sempre me rege, me guarda, me governa e me ilumina.',
          lt: 'Ángele Dei, qui custos es mei, me, tibi commíssum pietáte supérna, illúmina, custódi, rege et gubérna.',
        ),
      ],
    ),

    'benedictus': OfficialPrayerData(
      route: 'benedictus',
      title: 'Benedictus (Cântico de Zacarias)',
      subtitle: 'Cântico Evangélico de Laudes (Lc 1, 68-79)',
      category: 'Orações do Dia',
      strophes: [
        PrayerStrophe(
          prefix: '1. ',
          pt: 'Bendito seja o Senhor, Deus de Israel, * porque visitou e redimiu o seu povo.',
          lt: 'Benedíctus Dóminus, Deus Ísrael, * quia visitávit, et fecit redemptiónem plebis suæ.',
        ),
        PrayerStrophe(
          prefix: '2. ',
          pt: 'E suscitou para nós uma força de salvação * na casa de Davi, seu servo.',
          lt: 'Et eréxit cornu salútis nobis: * in domo David, púeri sui.',
        ),
        PrayerStrophe(
          prefix: '3. ',
          pt: 'Como falara pela boca dos seus santos, * os profetas desde os tempos antigos.',
          lt: 'Sicut locútus est per os sanctórum, * qui a sǽculo sunt, prophetárum eius:',
        ),
        PrayerStrophe(
          prefix: '4. ',
          pt: 'Para nos salvar dos nossos inimigos * e da mão de todos os que nos odeiam.',
          lt: 'Salútem ex inimícis nostris, * et de manu ómnium, qui odérunt nos:',
        ),
        PrayerStrophe(
          prefix: '5. ',
          pt: 'Para usar de misericórdia com os nossos pais * e lembrar-Se da sua santa aliança.',
          lt: 'Ad faciéndam misericórdiam cum pátribus nostris: * et memorári testaménti sui sancti.',
        ),
        PrayerStrophe(
          prefix: '6. ',
          pt: 'Do juramento que fez a nosso pai Abraão, * de nos conceder que, libertos da mão dos inimigos, O sirvamos sem temor.',
          lt: 'Iusiurándum, quod iurávit ad Ábraham patrem nostrum, * datúrum se nobis: ut sine timóre, de manu inimicórum nostrórum liberáti, * serviámus illi.',
        ),
        PrayerStrophe(
          prefix: '7. ',
          pt: 'Em santidade e justiça diante d\'Ele, * todos os nossos dias.',
          lt: 'In sanctitáte, et iustítia coram ipso, * ómnibus diébus nostris.',
        ),
        PrayerStrophe(
          prefix: '8. ',
          pt: 'E tu, menino, serás chamado profeta do Altíssimo, * porque irás adiante da face do Senhor a preparar os seus caminhos.',
          lt: 'Et tu, puer, prophéta Altíssimi vocáberis: * præíbis enim ante fáciem Dómini paráre vias eius:',
        ),
        PrayerStrophe(
          prefix: '9. ',
          pt: 'Para dar ao seu povo o conhecimento da salvação, * na remissão dos seus pecados.',
          lt: 'Ad dandam sciéntiam salútis plebi eius: * in remissiónem peccatórum eórum:',
        ),
        PrayerStrophe(
          prefix: '10. ',
          pt: 'Pelas entranhas da misericórdia do nosso Deus, * com que nos visitou o Sol nascente do alto.',
          lt: 'Per víscera misericórdiæ Dei nostri: * in quibus visitávit nos, óriens ex alto:',
        ),
        PrayerStrophe(
          prefix: '11. ',
          pt: 'Para iluminar os que estão sentados nas trevas e na sombra da morte, * para dirigir os nossos pés no caminho da paz.',
          lt: 'Illumináre his, qui in ténebris, et in umbra mortis sedent: * ad dirigéndos pedes nostros in viam pacis.',
        ),
        PrayerStrophe(
          prefix: '12. ',
          pt: 'Glória ao Pai, e ao Filho, e ao Espírito Santo. * Como era no princípio, agora e sempre, e por todos os séculos dos séculos.',
          lt: 'Glória Patri, et Fílio, * et Spirítui Sancto. Sicut erat in princípio, et nunc, et semper, * et in sǽcula sæculórum.',
        ),
      ],
    ),

    'nunc-dimittis': OfficialPrayerData(
      route: 'nunc-dimittis',
      title: 'Nunc Dimittis (Cântico de Simeão)',
      subtitle: 'Cântico Evangélico de Completas (Lc 2, 29-32)',
      category: 'Orações do Dia',
      strophes: [
        PrayerStrophe(
          prefix: '1. ',
          pt: 'Agora, Senhor, deixai o vosso servo ir em paz, * segundo a vossa palavra.',
          lt: 'Nunc dimíttis servum tuum, Dómine, * secúndum verbum tuum in pace:',
        ),
        PrayerStrophe(
          prefix: '2. ',
          pt: 'Porque os meus olhos viram * a vossa salvação,',
          lt: 'Quia vidérunt óculi mei * salutáre tuum,',
        ),
        PrayerStrophe(
          prefix: '3. ',
          pt: 'Que preparastes * diante da face de todos os povos:',
          lt: 'Quod parásti * ante fáciem ómnium populórum:',
        ),
        PrayerStrophe(
          prefix: '4. ',
          pt: 'Luz para se revelar às nações, * e glória de Israel, vosso povo.',
          lt: 'Lumen ad revelatiónem géntium, * et glóriam plebis tuæ Ísrael.',
        ),
        PrayerStrophe(
          prefix: '5. ',
          pt: 'Glória ao Pai, e ao Filho, e ao Espírito Santo. * Como era no princípio, agora e sempre, e por todos os séculos dos séculos.',
          lt: 'Glória Patri, et Fílio, * et Spirítui Sancto. Sicut erat in princípio, et nunc, et semper, * et in sǽcula sæculórum.',
        ),
      ],
    ),
  };
}

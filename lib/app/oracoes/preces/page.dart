import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';

class PrecesPage extends StatefulWidget {
  const PrecesPage({super.key});

  @override
  State<PrecesPage> createState() => _PrecesPageState();
}

class _PrecesPageState extends State<PrecesPage> {
  Widget _prayline(String prefix, String text, double fontSize) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$prefix  ",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          TextSpan(
            text: text,
            style: TextStyle(fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  Widget _bilingualPrayline(String prefix, String lt, String pt, double fontSize) {
    return BilingualPrayerRow(
      latin: _prayline(prefix, lt, fontSize),
      portuguese: _prayline(prefix, pt, fontSize),
    );
  }

  List<Widget> _buildBilingualPreces(AppProvider fs) {
    final double fSize = fs.fontSize;

    return [
      const BilingualPrayerHeader(),
      BilingualPrayerRow(
        latin: Text("Sérviam!", style: TextStyle(fontSize: fSize + 1, fontWeight: FontWeight.bold)),
        portuguese: Text("Servirei!", style: TextStyle(fontSize: fSize + 1, fontWeight: FontWeight.bold)),
      ),
      _bilingualPrayline("℣.", "Ad Trinitátem Beatíssimam.", "À Santíssima Trindade.", fSize),
      _bilingualPrayline(
        "℟.",
        "Grátias tibi, Deus, grátias tibi: vera et una Trínitas, una et summa Déitas, sancta et una Únitas.",
        "Graças a vós, Senhor Deus, graças a vós. Verdadeira e única Trindade, divindade suprema e única, indivisa e Santa Trindade.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Ad Iesum Christum Regem.", "A Jesus Cristo, Rei.", fSize),
      _bilingualPrayline(
        "℟.",
        "Dóminus Iudex noster; Dóminus Légifer noster; Dóminus Rex noster. Ipse salvabit nos.",
        "O Senhor é nosso Juiz, nosso Legislador e nosso Rei. Ele nos salvará.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Christe, Fili Dei vivi, miserére nobis.", "Cristo, Filho do Deus vivo, tende misericórdia de nós.", fSize),
      _bilingualPrayline("℟.", "Christe, Fili Dei vivi, miserére nobis.", "Cristo, Filho do Deus vivo, tende misericórdia de nós.", fSize),
      _bilingualPrayline("℣.", "Exsúrge, Christe, ádiuva nos.", "Levantai-vos, ó Cristo, vinde em nosso auxílio.", fSize),
      _bilingualPrayline("℟.", "Et líbera nos propter nomen tuum.", "Libertai-nos pelo vosso nome.", fSize),
      _bilingualPrayline("℣.", "Dóminus illuminátio mea et salus mea: quem timébo?", "O Senhor é a minha luz e salvação, a quem temerei?", fSize),
      _bilingualPrayline(
        "℟.",
        "Si consístant advérsum me castra, non timébit cor meum; si exsúrgat advérsum me prœlium, in hoc ego sperábo.",
        "Se os inimigos vierem contra mim, não temerá meu coração; se me combaterem, em Deus esperarei.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Ad Beátam Vírginem Maríam Mediatrícem.", "À Bem-aventurada Virgem Maria, medianeira.", fSize),
      _bilingualPrayline(
        "℟.",
        "Recordáre, Virgo Mater Dei, dum stéteris in conspéctu Dómini, ut loquáris pro nobis bona.",
        "Lembrai-vos, ó Virgem Mãe de Deus, de falar coisas boas de nós quando estiverdes na presença do Senhor.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Ad Sanctum Ioseph Sponsum Beátæ Maríæ Vírginis.", "A São José, esposo da Santíssima Virgem Maria.", fSize),
      _bilingualPrayline(
        "℟.",
        "Fecit te Deus quasi Patrem Regis, et dóminum univérsæ domus eius: ora pro nobis.",
        "Deus colocou-vos no lugar de Pai do Rei e de senhor da sua casa: rogai por nós.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Ad Ángelos Custódes.", "Aos Anjos da Guarda.", fSize),
      _bilingualPrayline(
        "℟.",
        "Sancti Ángeli Custódes nostri, deféndite nos in prœlio ut non pereámus in treméndo iudício.",
        "Ó nossos Santos Anjos da Guarda, defendei-nos no combate, para que não pereçamos no tremendo juízo.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Ad Sanctum Iosephmaríam Conditórem nostrum.", "A São Josemaria, nosso Fundador.", fSize),
      _bilingualPrayline(
        "℟.",
        "Intercéde pro fíliis tuis ut, fidéles spirítui Óperis Dei, labórem sanctificémus et ánimas Christo lucrifácere quærámus.",
        "Intercedei pelos vossos filhos, para que, fiéis ao espírito do Opus Dei, santifiquemos o trabalho e ganhemos almas para Cristo.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Orémus pro Beatíssimo Papa nostro ...", "Oremos pelo nosso Santo Padre, o Papa ...", fSize),
      _bilingualPrayline(
        "℟.",
        "Dóminus consérvet eum, et vivíficet eum, et beátum fáciat eum in terra, et non tradat eum in ánimam inimicórum eius.",
        "Que Deus o conserve e lhe dê vida e o faça santo na terra, e não o entregue nas mãos dos seus inimigos.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Orémus et pro Antístite huius diœcésis.", "Oremos também pelo Bispo desta diocese.", fSize),
      _bilingualPrayline(
        "℟.",
        "Stet et pascat in fortitúdine tua, Dómine, in sublimitáte nóminis tui.",
        "Senhor, que ele apascente, vigilante, o seu rebanho, com a vossa fortaleza e na grandeza do vosso Nome.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Orémus pro unitáte apostolátus.", "Oremos pela unidade do apostolado.", fSize),
      _bilingualPrayline(
        "℟.",
        "Ut omnes unum sint, sicut tu Pater in me et ego in te: ut sint unum, sicut et nos unum sumus.",
        "Que todos sejam um, como tu, Pai, estás em mim, e eu em ti: para que eles sejam um, assim como nós somos um.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Omne regnum divísum contra se, desolábitur.", "Todo reino dividido contra si mesmo será destruído.", fSize),
      _bilingualPrayline("℟.", "Et omnis cívitas vel domus divísa contra se non stabit.", "E toda cidade ou casa internamente dividida não se manterá.", fSize),
      _bilingualPrayline("℣.", "Orémus pro benefactóribus nostris.", "Oremos pelos nossos benfeitores.", fSize),
      _bilingualPrayline(
        "℟.",
        "Retribúere dignáre, Dómine, ómnibus nobis bona faciéntibus propter nomen tuum, vitam ætérnam. Amen.",
        "Dignai-vos, Senhor, recompensar com a vida eterna todos aqueles que nos fazem o bem pelo vosso nome. Amém.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Orémus pro Patre.", "Oremos pelo Padre.", fSize),
      _bilingualPrayline(
        "℟.",
        "Misericórdia Dómini ab ætérno et usque in ætérnum super eum: custódit enim Dóminus omnes diligéntes se.",
        "Que a misericórdia do Senhor esteja sobre ele desde sempre e para sempre, pois o Senhor protege todos os que o amam.",
        fSize,
      ),
      _bilingualPrayline("℣.", "Orémus et pro frátribus nostris Óperis Dei, vivis atque defúnctis.", "Oremos pelos nossos irmãos do Opus Dei, vivos e defuntos.", fSize),
      _bilingualPrayline("℟.", "Salvos fac servos tuos, Deus meus, sperántes in te.", "Salvai, meu Deus, os vossos servos, que em vós esperam.", fSize),
      _bilingualPrayline("℣.", "Mitte eis, Dómine, auxílium de sancto.", "Enviai-lhes, Senhor, o auxílio do céu.", fSize),
      _bilingualPrayline("℟.", "Et de Sion tuére eos.", "E, do santo monte Sião, protegei-os.", fSize),
      _bilingualPrayline("℣.", "Réquiem ætérnam dona eis, Dómine.", "Dai-lhes, Senhor, o descanso eterno.", fSize),
      _bilingualPrayline("℟.", "Et lux perpétua lúceat eis.", "E brilhe sobre eles a vossa luz.", fSize),
      _bilingualPrayline("℣.", "Requiéscant in pace.", "Descansem em paz.", fSize),
      _bilingualPrayline("℟.", "Amen.", "Amém.", fSize),
      _bilingualPrayline("℣.", "Dómine, exáudi oratiónem meam.", "Ouvi, Senhor, minha oração.", fSize),
      _bilingualPrayline("℟.", "Et clamor meus ad te véniat.", "E chegue até vós o meu clamor.", fSize),
      BilingualPrayerRow(
        latin: Text(
          "Sacerdos, si Preces moderatur, exsurgit et addit Dóminus vobiscum, stans etiam dum recitat orationem.",
          style: TextStyle(fontSize: fSize - 1, color: Colors.red, fontStyle: FontStyle.italic),
        ),
        portuguese: Text(
          "Se é um sacerdote quem dirige as Preces, levanta-se e acrescenta: O Senhor esteja convosco, permanecendo de pé enquanto reza a oração.",
          style: TextStyle(fontSize: fSize - 1, color: Colors.red, fontStyle: FontStyle.italic),
        ),
      ),
      _bilingualPrayline("℣.", "Dóminus vobíscum.", "O Senhor esteja convosco.", fSize),
      _bilingualPrayline("℟.", "Et cum spíritu tuo.", "Ele está no meio de nós.", fSize),
      BilingualPrayerRow(
        latin: Text("Orémus", style: TextStyle(fontSize: fSize + 1, fontWeight: FontWeight.bold)),
        portuguese: Text("Oremos", style: TextStyle(fontSize: fSize + 1, fontWeight: FontWeight.bold)),
      ),
      BilingualPrayerRow(
        latin: Text(
          "Deus, cui próprium est miseréri semper et párcere: súscipe deprecatiónem nostram. Ure igne Sancti Spíritus renes nostros et cor nostrum, Dómine: ut tibi casto córpore serviámus, et mundo corde placeámus.",
          style: TextStyle(fontSize: fSize),
        ),
        portuguese: Text(
          "Ó Deus, de quem é próprio ter misericórdia sempre e perdoar: recebei as nossas humildes súplicas. Inflamai, Senhor, as nossas entranhas e o nosso coração com o fogo do Espirito Santo: para que vos sirvamos com um corpo casto, e vos agrademos com o coração limpo.",
          style: TextStyle(fontSize: fSize),
        ),
      ),
      BilingualPrayerRow(
        latin: Text(
          "Actiónes nostras, quǽsumus Dómine, aspirándo prǽveni et adiuvándo proséquere: ut cuncta nostra orátio et operátio a te semper incípiat, et per te cœpta finiátur. Per Christum Dóminum nostrum.",
          style: TextStyle(fontSize: fSize),
        ),
        portuguese: Text(
          "Nós Vos pedimos, Senhor, que prepareis as nossas ações com a vossa inspiração, e as acompanheis com a vossa ajuda, a fim de que todos os nossos trabalhos e orações em vós comecem sempre e por vós acabem. Por Cristo, Senhor Nosso.",
          style: TextStyle(fontSize: fSize),
        ),
      ),
      _bilingualPrayline("℟.", "Amen.", "Amém.", fSize),
      BilingualPrayerRow(
        latin: Text("Omnes dicunt:", style: TextStyle(fontSize: fSize - 1, color: Colors.red, fontStyle: FontStyle.italic)),
        portuguese: Text("Todos dizem:", style: TextStyle(fontSize: fSize - 1, color: Colors.red, fontStyle: FontStyle.italic)),
      ),
      BilingualPrayerRow(
        latin: Text(
          "Gáudium cum pace, emendatiónem vitæ, spátium veræ pœniténtiæ, grátiam et consolatiónem Sancti Spíritus atque in Ópere Dei perseverántiam, tríbuat nobis Omnípotens et Miséricors Dóminus.",
          style: TextStyle(fontSize: fSize),
        ),
        portuguese: Text(
          "Que o Senhor onipotente e misericordioso nos conceda a alegria e a paz, a conversão da nossa vida, um tempo de verdadeira penitência, a graça e o consolo do Espírito Santo e a perseverança no Opus Dei.",
          style: TextStyle(fontSize: fSize),
        ),
      ),
      _bilingualPrayline("℣.", "Sancte Míchaël.", "São Miguel.", fSize),
      _bilingualPrayline("℟.", "Ora pro nobis.", "Rogai por nós", fSize),
      _bilingualPrayline("℣.", "Sancte Gábriel.", "São Gabriel.", fSize),
      _bilingualPrayline("℟.", "Ora pro nobis.", "Rogai por nós.", fSize),
      _bilingualPrayline("℣.", "Sancte Ráphaël.", "São Rafael.", fSize),
      _bilingualPrayline("℟.", "Ora pro nobis.", "Rogai por nós.", fSize),
      _bilingualPrayline("℣.", "Sancte Petre.", "São Pedro.", fSize),
      _bilingualPrayline("℟.", "Ora pro nobis.", "Rogai por nós.", fSize),
      _bilingualPrayline("℣.", "Sancte Paule.", "São Paulo.", fSize),
      _bilingualPrayline("℟.", "Ora pro nobis.", "Rogai por nós.", fSize),
      _bilingualPrayline("℣.", "Sancte Ioánnes.", "São João.", fSize),
      _bilingualPrayline("℟.", "Ora pro nobis.", "Rogai por nós.", fSize),
      BilingualPrayerRow(
        latin: Text(
          "Cum adsit aliquis Sacerdos, dignior ait:",
          style: TextStyle(fontSize: fSize - 1, color: Colors.red, fontStyle: FontStyle.italic),
        ),
        portuguese: Text(
          "Quando estiver presente um sacerdote, o diretor ou quem o substitua diz:",
          style: TextStyle(fontSize: fSize - 1, color: Colors.red, fontStyle: FontStyle.italic),
        ),
      ),
      BilingualPrayerRow(
        latin: Text("Iube, Domne, benedícere.", style: TextStyle(fontSize: fSize)),
        portuguese: Text("Dignai-vos, padre, abençoar-nos.", style: TextStyle(fontSize: fSize)),
      ),
      BilingualPrayerRow(
        latin: Text("Sacerdos benedicit:", style: TextStyle(fontSize: fSize - 1, color: Colors.red, fontStyle: FontStyle.italic)),
        portuguese: Text("O sacerdote abençoa:", style: TextStyle(fontSize: fSize - 1, color: Colors.red, fontStyle: FontStyle.italic)),
      ),
      BilingualPrayerRow(
        latin: Text(
          "Dóminus sit in córdibus vestris, et in lábiis vestris, in nómine Patris † et Fílii et Spíritus Sancti.",
          style: TextStyle(fontSize: fSize),
        ),
        portuguese: Text(
          "Que o Senhor esteja em vossos corações e em vossos lábios, em nome do Pai † e do Filho e do Espírito Santo.",
          style: TextStyle(fontSize: fSize),
        ),
      ),
      _bilingualPrayline("℟.", "Amen.", "Amém.", fSize),
      _bilingualPrayline("℣.", "Pax.", "Paz.", fSize),
      _bilingualPrayline("℟.", "In ætérnum.", "Para sempre.", fSize),
    ];
  }

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    final bool isBilingual = fs.bilingualMode;
    final String language = fs.prayerLanguage;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Preces", maxLines: 2, style: TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            onPressed: fs.toggleBilingualMode,
            icon: Icon(isBilingual ? Icons.vertical_split : Icons.vertical_split_outlined),
            tooltip: isBilingual ? "Modo coluna única" : "Modo bilíngue lado a lado",
          ),
          IconButton(onPressed: fs.decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: fs.increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: isBilingual
                  ? _buildBilingualPreces(fs)
                  : [
                      Text(
                        language == "pt" ? "Servirei!" : "Sérviam!",
                        style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold),
                      ),
                      _prayline("\n℣.", language == "pt" ? "À Santíssima Trindade." : "Ad Trinitátem Beatíssimam.", fs.fontSize),
                      _prayline(
                        "℟.",
                        language == "pt"
                            ? "Graças a vós, Senhor Deus, graças a vós. Verdadeira e única Trindade, divindade suprema e única, indivisa e Santa Trindade."
                            : "Grátias tibi, Deus, grátias tibi: vera et una Trínitas, una et summa Déitas, sancta et una Únitas.",
                        fs.fontSize,
                      ),
                      _prayline("\n℣.", language == "pt" ? "A Jesus Cristo, Rei." : "Ad Iesum Christum Regem.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "O Senhor é nosso Juiz, nosso Legislador e nosso Rei. Ele nos salvará." : "Dóminus Iudex noster; Dóminus Légifer noster; Dóminus Rex noster. Ipse salvabit nos.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "Cristo, Filho do Deus vivo, tende misericórdia de nós." : "Christe, Fili Dei vivi, miserére nobis.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Cristo, Filho do Deus vivo, tende misericórdia de nós." : "Christe, Fili Dei vivi, miserére nobis.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "Levantai-vos, ó Cristo, vinde em nosso auxílio." : "Exsúrge, Christe, ádiuva nos.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Libertai-nos pelo vosso nome." : "Et líbera nos propter nomen tuum.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "O Senhor é a minha luz e salvação, a quem temerei?" : "Dóminus illuminátio mea et salus mea: quem timébo?", fs.fontSize),
                      _prayline(
                        "℟.",
                        language == "pt" ? "Se os inimigos vierem contra mim, não temerá meu coração; se me combaterem, em Deus esperarei." : "Si consístant advérsum me castra, non timébit cor meum; si exsúrgat advérsum me prœlium, in hoc ego sperábo.",
                        fs.fontSize,
                      ),
                      _prayline("\n℣.", language == "pt" ? "À Bem-aventurada Virgem Maria, medianeira." : "Ad Beátam Vírginem Maríam Mediatrícem.", fs.fontSize),
                      _prayline(
                        "℟.",
                        language == "pt" ? "Lembrai-vos, ó Virgem Mãe de Deus, de falar coisas boas de nós quando estiverdes na presença do Senhor." : "Recordáre, Virgo Mater Dei, dum stéteris in conspéctu Dómini, ut loquáris pro nobis bona.",
                        fs.fontSize,
                      ),
                      _prayline("\n℣.", language == "pt" ? "A São José, esposo da Santíssima Virgem Maria." : "Ad Sanctum Ioseph Sponsum Beátæ Maríæ Vírginis.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Deus colocou-vos no lugar de Pai do Rei e de senhor da sua casa: rogai por nós." : "Fecit te Deus quasi Patrem Regis, et dóminum univérsæ domus eius: ora pro nobis.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "Aos Anjos da Guarda." : "Ad Ángelos Custódes.", fs.fontSize),
                      _prayline(
                        "℟.",
                        language == "pt" ? "Ó nossos Santos Anjos da Guarda, defendei-nos no combate, para que não pereçamos no tremendo juízo." : "Sancti Ángeli Custódes nostri, deféndite nos in prœlio ut non pereámus in treméndo iudício.",
                        fs.fontSize,
                      ),
                      _prayline("\n℣.", language == "pt" ? "A São Josemaria, nosso Fundador." : "Ad Sanctum Iosephmaríam Conditórem nostrum.", fs.fontSize),
                      _prayline(
                        "℟.",
                        language == "pt"
                            ? "Intercedei pelos vossos filhos, para que, fiéis ao espírito do Opus Dei, santifiquemos o trabalho e ganhemos almas para Cristo."
                            : "Intercéde pro fíliis tuis ut, fidéles spirítui Óperis Dei, labórem sanctificémus et ánimas Christo lucrifácere quærámus.",
                        fs.fontSize,
                      ),
                      _prayline("\n℣.", language == "pt" ? "Oremos pelo nosso Santo Padre, o Papa ..." : "Orémus pro Beatíssimo Papa nostro ...", fs.fontSize),
                      _prayline(
                        "℟.",
                        language == "pt"
                            ? "Que Deus o conserve e lhe dê vida e o faça santo na terra, e não o entregue nas mãos dos seus inimigos."
                            : "Dóminus consérvet eum, et vivíficet eum, et beátum fáciat eum in terra, et non tradat eum in ánimam inimicórum eius.",
                        fs.fontSize,
                      ),
                      _prayline("\n℣.", language == "pt" ? "Oremos também pelo Bispo desta diocese." : "Orémus et pro Antístite huius diœcésis.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Senhor, que ele apascente, vigilante, o seu rebanho, com a vossa fortaleza e na grandeza do vosso Nome." : "Stet et pascat in fortitúdine tua, Dómine, in sublimitáte nóminis tui.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "Oremos pela unidade do apostolado." : "Orémus pro unitáte apostolátus.", fs.fontSize),
                      _prayline(
                        "℟.",
                        language == "pt" ? "Que todos sejam um, como tu, Pai, estás em mim, e eu em ti: para que eles sejam um, assim como nós somos um." : "Ut omnes unum sint, sicut tu Pater in me et ego in te: ut sint unum, sicut et nos unum sumus.",
                        fs.fontSize,
                      ),
                      _prayline("\n℣.", language == "pt" ? "Todo reino dividido contra si mesmo será destruído." : "Omne regnum divísum contra se, desolábitur.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "E toda cidade ou casa internamente dividida não se manterá." : "Et omnis cívitas vel domus divísa contra se non stabit.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "Oremos pelos nossos benfeitores." : "Orémus pro benefactóribus nostris.", fs.fontSize),
                      _prayline(
                        "℟.",
                        language == "pt"
                            ? "Dignai-vos, Senhor, recompensar com a vida eterna todos aqueles que nos fazem o bem pelo vosso nome. Amém."
                            : "Retribúere dignáre, Dómine, ómnibus nobis bona faciéntibus propter nomen tuum, vitam ætérnam. Amen.",
                        fs.fontSize,
                      ),
                      _prayline("\n℣.", language == "pt" ? "Oremos pelo Padre." : "Orémus pro Patre.", fs.fontSize),
                      _prayline(
                        "℟.",
                        language == "pt"
                            ? "Que a misericórdia do Senhor esteja sobre ele desde sempre e para sempre, pois o Senhor protege todos os que o amam."
                            : "Misericórdia Dómini ab ætérno et usque in ætérnum super eum: custódit enim Dóminus omnes diligéntes se.",
                        fs.fontSize,
                      ),
                      _prayline("\n℣.", language == "pt" ? "Oremos pelos nossos irmãos do Opus Dei, vivos e defuntos." : "Orémus et pro frátribus nostris Óperis Dei, vivis atque defúnctis.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Salvai, meu Deus, os vossos servos, que em vós esperam." : "Salvos fac servos tuos, Deus meus, sperántes in te.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "Enviai-lhes, Senhor, o auxílio do céu." : "Mitte eis, Dómine, auxílium de sancto.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "E, do santo monte Sião, protegei-os." : "Et de Sion tuére eos.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "Dai-lhes, Senhor, o descanso eterno." : "Réquiem ætérnam dona eis, Dómine.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "E brilhe sobre eles a vossa luz." : "Et lux perpétua lúceat eis.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "Descansem em paz." : "Requiéscant in pace.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Amém." : "Amen.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "Ouvi, Senhor, minha oração." : "Dómine, exáudi oratiónem meam.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "E chegue até vós o meu clamor." : "Et clamor meus ad te véniat.", fs.fontSize),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: language == "pt" ? "\nSe é um sacerdote quem dirige as Preces, levanta-se e acrescenta:" : "\nSacerdos, si Preces moderatur, exsurgit et addit",
                              style: TextStyle(fontSize: fs.fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                            ),
                            TextSpan(
                              text: language == "pt" ? " O Senhor esteja convosco, " : " Dóminus vobiscum, ",
                              style: TextStyle(fontSize: fs.fontSize),
                            ),
                            TextSpan(
                              text: language == "pt" ? "permanecendo de pé enquanto reza a oração." : "stans etiam dum recitat orationem.",
                              style: TextStyle(fontSize: fs.fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      _prayline("\n℣.", language == "pt" ? "O Senhor esteja convosco." : "Dóminus vobíscum.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Ele está no meio de nós." : "Et cum spíritu tuo.", fs.fontSize),
                      Text(
                        language == "pt" ? "\nOremos" : "\nOrémus",
                        style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        language == "pt"
                            ? "\nÓ Deus, de quem é próprio ter misericórdia sempre e perdoar: recebei as nossas humildes súplicas. Inflamai, Senhor, as nossas entranhas e o nosso coração com o fogo do Espirito Santo: para que vos sirvamos com um corpo casto, e vos agrademos com o coração limpo."
                            : "\nDeus, cui próprium est miseréri semper et párcere: súscipe deprecatiónem nostram. Ure igne Sancti Spíritus renes nostros et cor nostrum, Dómine: ut tibi casto córpore serviámus, et mundo corde placeámus.",
                        style: TextStyle(fontSize: fs.fontSize),
                      ),
                      Text(
                        language == "pt"
                            ? "\nNós Vos pedimos, Senhor, que prepareis as nossas ações com a vossa inspiração, e as acompanheis com a vossa ajuda, a fim de que todos os nossos trabalhos e orações em vós comecem sempre e por vós acabem. Por Cristo, Senhor Nosso."
                            : "\nActiónes nostras, quǽsumus Dómine, aspirándo prǽveni et adiuvándo proséquere: ut cuncta nostra orátio et operátio a te semper incípiat, et per te cœpta finiátur. Per Christum Dóminum nostrum.",
                        style: TextStyle(fontSize: fs.fontSize),
                      ),
                      _prayline("\n℟.", language == "pt" ? "Amém." : "Amen.", fs.fontSize),
                      Text(
                        language == "pt" ? "\nTodos dizem:" : "\nOmnes dicunt:",
                        style: TextStyle(fontSize: fs.fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        language == "pt"
                            ? "\nQue o Senhor onipotente e misericordioso nos conceda a alegria e a paz, a conversão da nossa vida, um tempo de verdadeira penitência, a graça e o consolo do Espírito Santo e a perseverança no Opus Dei."
                            : "\nGáudium cum pace, emendatiónem vitæ, spátium veræ pœniténtiæ, grátiam et consolatiónem Sancti Spíritus atque in Ópere Dei perseverántiam, tríbuat nobis Omnípotens et Miséricors Dóminus.",
                        style: TextStyle(fontSize: fs.fontSize),
                      ),
                      _prayline("\n℣.", language == "pt" ? "São Miguel." : "Sancte Míchaël.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Rogai por nós" : "Ora pro nobis.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "São Gabriel." : "Sancte Gábriel.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Rogai por nós." : "Ora pro nobis.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "São Rafael." : "Sancte Ráphaël.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Rogai por nós." : "Ora pro nobis.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "São Pedro." : "Sancte Petre.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Rogai por nós." : "Ora pro nobis.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "São Paulo." : "Sancte Paule.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Rogai por nós." : "Ora pro nobis.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "São João." : "Sancte Ioánnes.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Rogai por nós." : "Ora pro nobis.", fs.fontSize),
                      Text(
                        language == "pt" ? "\nQuando estiver presente um sacerdote, o diretor ou quem o substitua diz:" : "\nCum adsit aliquis Sacerdos, dignior ait:",
                        style: TextStyle(fontSize: fs.fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                      ),
                      Text(language == "pt" ? "\nDignai-vos, padre, abençoar-nos." : "\nIube, Domne, benedícere.", style: TextStyle(fontSize: fs.fontSize)),
                      Text(
                        language == "pt" ? "\nO sacerdote abençoa:" : "\nSacerdos benedicit:",
                        style: TextStyle(fontSize: fs.fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        language == "pt"
                            ? "\nQue o Senhor esteja em vossos corações e em vossos lábios, em nome do Pai † e do Filho e do Espírito Santo."
                            : "\nDóminus sit in córdibus vestris, et in lábiis vestris, in nómine Patris † et Fílii et Spíritus Sancti.",
                        style: TextStyle(fontSize: fs.fontSize),
                      ),
                      _prayline("\n℟.", language == "pt" ? "Amém." : "Amen.", fs.fontSize),
                      _prayline("\n℣.", language == "pt" ? "Paz." : "Pax.", fs.fontSize),
                      _prayline("℟.", language == "pt" ? "Para sempre." : "In ætérnum.", fs.fontSize),
                      const Divider(height: 25, color: Colors.transparent),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}

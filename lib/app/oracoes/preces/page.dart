import 'package:flutter/material.dart';

class PrecesPage extends StatefulWidget {
  const PrecesPage({super.key});

  @override
  State<PrecesPage> createState() => _PrecesPageState();
}

class _PrecesPageState extends State<PrecesPage> {
  double fontSize = 17.0;
  String language = "pt";

  void decreaseFontSize() {
    setState(() {
      fontSize--;
    });
  }

  void increaseFontSize() {
    setState(() {
      fontSize++;
    });
  }

  void toggleLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  Widget _prayline(String prefix, String text) {
    return Text.rich(
      TextSpan(
        children: [TextSpan(text: "$prefix  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)), TextSpan(text: text, style: TextStyle(fontSize: fontSize))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preces"),
        actions: [
          IconButton(onPressed: () => toggleLanguage(language == "pt" ? "lt" : "pt"), icon: Text(language == "pt" ? "lt".toUpperCase() : "pt".toUpperCase()), tooltip: language == "pt" ? "Mudar para Latim" : "Mudar para Português"),
          IconButton(onPressed: decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Divider(height: 15, color: Colors.transparent),
                Text(language == "pt" ? "Servirei!" : "Sérviam!", style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.bold)),
                _prayline("\n℣.", language == "pt" ? "À Santíssima Trindade." : "Ad Trinitátem Beatíssimam."),
                _prayline("℟.", language == "pt"
                    ? "Graças a vós, Senhor Deus, graças a vós. Verdadeira e única Trindade, divindade suprema e única, indivisa e Santa Trindade."
                    : "Grátias tibi, Deus, grátias tibi: vera et una Trínitas, una et summa Déitas, sancta et una Únitas."),
                _prayline("\n℣.", language == "pt" ? "A Jesus Cristo, Rei." : "Ad Iesum Christum Regem."),
                _prayline("℟.", language == "pt" ? "O Senhor é nosso Juiz, nosso Legislador e nosso Rei. Ele nos salvará." : "Dóminus Iudex noster; Dóminus Légifer noster; Dóminus Rex noster. Ipse salvabit nos."),
                _prayline("\n℣.", language == "pt" ? "Cristo, Filho do Deus vivo, tende misericórdia de nós." : "Christe, Fili Dei vivi, miserére nobis."),
                _prayline("℟.", language == "pt" ? "Cristo, Filho do Deus vivo, tende misericórdia de nós." : "Christe, Fili Dei vivi, miserére nobis."),
                _prayline("\n℣.", language == "pt" ? "Levantai-vos, ó Cristo, vinde em nosso auxílio." : "Exsúrge, Christe, ádiuva nos."),
                _prayline("℟.", language == "pt" ? "Libertai-nos pelo vosso nome." : "Et líbera nos propter nomen tuum."),
                _prayline("\n℣.", language == "pt" ? "O Senhor é a minha luz e salvação, a quem temerei?" : "Dóminus illuminátio mea et salus mea: quem timébo?"),
                _prayline("℟.", language == "pt" ? "Se os inimigos vierem contra mim, não temerá meu coração; se me combaterem, em Deus esperarei." : "Si consístant advérsum me castra, non timébit cor meum; si exsúrgat advérsum me prœlium, in hoc ego sperábo."),
                _prayline("\n℣.", language == "pt" ? "À Bem-aventurada Virgem Maria, medianeira." : "Ad Beátam Vírginem Maríam Mediatrícem."),
                _prayline("℟.", language == "pt" ? "Lembrai-vos, ó Virgem Mãe de Deus, de falar coisas boas de nós quando estiverdes na presença do Senhor." : "Recordáre, Virgo Mater Dei, dum stéteris in conspéctu Dómini, ut loquáris pro nobis bona."),
                _prayline("\n℣.", language == "pt" ? "A São José, esposo da Santíssima Virgem Maria." : "Ad Sanctum Ioseph Sponsum Beátæ Maríæ Vírginis."),
                _prayline("℟.", language == "pt" ? "Deus colocou-vos no lugar de Pai do Rei e de senhor da sua casa: rogai por nós." : "Fecit te Deus quasi Patrem Regis, et dóminum univérsæ domus eius: ora pro nobis."),
                _prayline("\n℣.", language == "pt" ? "Aos Anjos da Guarda." : "Ad Ángelos Custódes."),
                _prayline("℟.", language == "pt" ? "Ó nossos Santos Anjos da Guarda, defendei-nos no combate, para que não pereçamos no tremendo juízo." : "Sancti Ángeli Custódes nostri, deféndite nos in prœlio ut non pereámus in treméndo iudício."),
                _prayline("\n℣.", language == "pt" ? "A São Josemaria, nosso Fundador." : "Ad Sanctum Iosephmaríam Conditórem nostrum."),
                _prayline("℟.", language == "pt"
                    ? "Intercedei pelos vossos filhos, para que, fiéis ao espírito do Opus Dei, santifiquemos o trabalho e ganhemos almas para Cristo."
                    : "Intercéde pro fíliis tuis ut, fidéles spirítui Óperis Dei, labórem sanctificémus et ánimas Christo lucrifácere quærámus."),
                _prayline("\n℣.", language == "pt" ? "Oremos pelo nosso Santo Padre, o Papa ..." : "Orémus pro Beatíssimo Papa nostro ..."),
                _prayline("℟.", language == "pt"
                    ? "Que Deus o conserve e lhe dê vida e o faça santo na terra, e não o entregue nas mãos dos seus inimigos."
                    : "Dóminus consérvet eum, et vivíficet eum, et beátum fáciat eum in terra, et non tradat eum in ánimam inimicórum eius."),
                _prayline("\n℣.", language == "pt" ? "Oremos também pelo Bispo desta diocese." : "Orémus et pro Antístite huius diœcésis."),
                _prayline("℟.", language == "pt" ? "Senhor, que ele apascente, vigilante, o seu rebanho, com a vossa fortaleza e na grandeza do vosso Nome." : "Stet et pascat in fortitúdine tua, Dómine, in sublimitáte nóminis tui."),
                _prayline("\n℣.", language == "pt" ? "Oremos pela unidade do apostolado." : "Orémus pro unitáte apostolátus."),
                _prayline("℟.", language == "pt" ? "Que todos sejam um, como tu, Pai, estás em mim, e eu em ti: para que eles sejam um, assim como nós somos um." : "Ut omnes unum sint, sicut tu Pater in me et ego in te: ut sint unum, sicut et nos unum sumus."),
                _prayline("\n℣.", language == "pt" ? "Todo reino dividido contra si mesmo será destruído." : "Omne regnum divísum contra se, desolábitur."),
                _prayline("℟.", language == "pt" ? "E toda cidade ou casa internamente dividida não se manterá." : "Et omnis cívitas vel domus divísa contra se non stabit."),
                _prayline("\n℣.", language == "pt" ? "Oremos pelos nossos benfeitores." : "Orémus pro benefactóribus nostris."),
                _prayline("℟.", language == "pt"
                    ? "Dignai-vos, Senhor, recompensar com a vida eterna todos aqueles que nos fazem o bem pelo vosso nome. Amém."
                    : "Retribúere dignáre, Dómine, ómnibus nobis bona faciéntibus propter nomen tuum, vitam ætérnam. Amen."),
                _prayline("\n℣.", language == "pt" ? "Oremos pelo Padre." : "Orémus pro Patre."),
                _prayline("℟.", language == "pt"
                    ? "Que a misericórdia do Senhor esteja sobre ele desde sempre e para sempre, pois o Senhor protege todos os que o amam."
                    : "Misericórdia Dómini ab ætérno et usque in ætérnum super eum: custódit enim Dóminus omnes diligéntes se."),
                _prayline("\n℣.", language == "pt" ? "Oremos pelos nossos irmãos do Opus Dei, vivos e defuntos." : "Orémus et pro frátribus nostris Óperis Dei, vivis atque defúnctis."),
                _prayline("℟.", language == "pt" ? "Salvai, meu Deus, os vossos servos, que em vós esperam." : "Salvos fac servos tuos, Deus meus, sperántes in te."),
                _prayline("\n℣.", language == "pt" ? "Enviai-lhes, Senhor, o auxílio do céu." : "Mitte eis, Dómine, auxílium de sancto."),
                _prayline("℟.", language == "pt" ? "E, do santo monte Sião, protegei-os." : "Et de Sion tuére eos."),
                _prayline("\n℣.", language == "pt" ? "Dai-lhes, Senhor, o descanso eterno." : "Réquiem ætérnam dona eis, Dómine."),
                _prayline("℟.", language == "pt" ? "E brilhe sobre eles a vossa luz." : "Et lux perpétua lúceat eis."),
                _prayline("\n℣.", language == "pt" ? "Descansem em paz." : "Requiéscant in pace."),
                _prayline("℟.", language == "pt" ? "Amém." : "Amen."),
                _prayline("\n℣.", language == "pt" ? "Ouvi, Senhor, minha oração." : "Dómine, exáudi oratiónem meam."),
                _prayline("℟.", language == "pt" ? "E chegue até vós o meu clamor." : "Et clamor meus ad te véniat."),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: language == "pt" ? "\nSe é um sacerdote quem dirige as Preces, levanta-se e acrescenta:" : "\nSacerdos, si Preces moderatur, exsurgit et addit",
                    style: TextStyle(fontSize: fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                  ),
                  TextSpan(
                    text: language == "pt" ? " O Senhor esteja convosco, " : " Dóminus vobiscum, ",
                    style: TextStyle(fontSize: fontSize),
                  ),
                  TextSpan(
                    text: language == "pt" ? "permanecendo de pé enquanto reza a oração." : "stans etiam dum recitat orationem.",
                    style: TextStyle(fontSize: fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                  ),
                ])),
                _prayline("\n℣.", language == "pt" ? "O Senhor esteja convosco." : "Dóminus vobíscum."),
                _prayline("℟.", language == "pt" ? "Ele está no meio de nós." : "Et cum spíritu tuo."),
                Text(language == "pt" ? "\nOremos" : "\nOrémus", style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.bold)),
                Text(
                  language == "pt"
                      ? "\nÓ Deus, de quem é próprio ter misericórdia sempre e perdoar: recebei as nossas humildes súplicas. Inflamai, Senhor, as nossas entranhas e o nosso coração com o fogo do Espirito Santo: para que vos sirvamos com um corpo casto, e vos agrademos com o coração limpo."
                      : "\nDeus, cui próprium est miseréri semper et párcere: súscipe deprecatiónem nostram. Ure igne Sancti Spíritus renes nostros et cor nostrum, Dómine: ut tibi casto córpore serviámus, et mundo corde placeámus.",
                  style: TextStyle(fontSize: fontSize),
                ),
                Text(
                  language == "pt"
                      ? "\nNós Vos pedimos, Senhor, que prepareis as nossas ações com a vossa inspiração, e as acompanheis com a vossa ajuda, a fim de que todos os nossos trabalhos e orações em vós comecem sempre e por vós acabem. Por Cristo, Senhor Nosso."
                      : "\nActiónes nostras, quǽsumus Dómine, aspirándo prǽveni et adiuvándo proséquere: ut cuncta nostra orátio et operátio a te semper incípiat, et per te cœpta finiátur. Per Christum Dóminum nostrum.",
                  style: TextStyle(fontSize: fontSize),
                ),
                _prayline("\n℟.", language == "pt" ? "Amém." : "Amen."),
                Text(language == "pt" ? "\nTodos dizem:" : "\nOmnes dicunt:", style: TextStyle(fontSize: fontSize, color: Colors.red, fontStyle: FontStyle.italic)),
                Text(
                    language == "pt"
                        ? "\nQue o Senhor onipotente e misericordioso nos conceda a alegria e a paz, a conversão da nossa vida, um tempo de verdadeira penitência, a graça e o consolo do Espírito Santo e a perseverança no Opus Dei."
                        : "\nGáudium cum pace, emendatiónem vitæ, spátium veræ pœniténtiæ, grátiam et consolatiónem Sancti Spíritus atque in Ópere Dei perseverántiam, tríbuat nobis Omnípotens et Miséricors Dóminus.",
                    style: TextStyle(fontSize: fontSize)),
                _prayline("\n℣.", language == "pt" ? "São Miguel." : "Sancte Míchaël."),
                _prayline("℟.", language == "pt" ? "Rogai por nós" : "Ora pro nobis."),
                _prayline("\n℣.", language == "pt" ? "São Gabriel." : "Sancte Gábriel."),
                _prayline("℟.", language == "pt" ? "Rogai por nós." : "Ora pro nobis."),
                _prayline("\n℣.", language == "pt" ? "São Rafael." : "Sancte Ráphaël."),
                _prayline("℟.", language == "pt" ? "Rogai por nós." : "Ora pro nobis."),
                _prayline("\n℣.", language == "pt" ? "São Pedro." : "Sancte Petre."),
                _prayline("℟.", language == "pt" ? "Rogai por nós." : "Ora pro nobis."),
                _prayline("\n℣.", language == "pt" ? "São Paulo." : "Sancte Paule."),
                _prayline("℟.", language == "pt" ? "Rogai por nós." : "Ora pro nobis."),
                _prayline("\n℣.", language == "pt" ? "São João." : "Sancte Ioánnes."),
                _prayline("℟.", language == "pt" ? "Rogai por nós." : "Ora pro nobis."),
                Text(
                  language == "pt" ? "\nQuando estiver presente um sacerdote, o diretor ou quem o substitua diz:" : "\nCum adsit aliquis Sacerdos, dignior ait:",
                  style: TextStyle(fontSize: fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                ),
                Text(
                  language == "pt" ? "\nDignai-vos, padre, abençoar-nos." : "\nIube, Domne, benedícere.",
                  style: TextStyle(fontSize: fontSize),
                ),
                Text(
                  language == "pt" ? "\nO sacerdote abençoa:" : "\nSacerdos benedicit:",
                  style: TextStyle(fontSize: fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                ),
                Text(
                  language == "pt"
                      ? "\nQue o Senhor esteja em vossos corações e em vossos lábios, em nome do Pai † e do Filho e do Espírito Santo."
                      : "\nDóminus sit in córdibus vestris, et in lábiis vestris, in nómine Patris † et Fílii et Spíritus Sancti.",
                  style: TextStyle(fontSize: fontSize),
                ),
                _prayline("\n℟.", language == "pt" ? "Amén." : "Amen."),
                _prayline("\n℣.", language == "pt" ? "Paz." : "Pax."),
                _prayline("℟.", language == "pt" ? "Para sempre." : "In ætérnum."),
                const Divider(height: 25, color: Colors.transparent),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

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
      fontSize --;
    });
  }

  void increaseFontSize() {
    setState(() {
      fontSize ++;
    });
  }

  void toggleLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preces"),
        actions: [
          IconButton(
            onPressed: () => toggleLanguage(language == "pt" ? "lt" : "pt"),
            icon: Text(language == "pt" ? "lt".toUpperCase() : "pt".toUpperCase()),
            tooltip: language == "pt" ? "Mudar para Latim" : "Mudar para Português"
          ),
          IconButton(onPressed: decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                const Divider(height: 15, color: Colors.transparent),
                Text(language == "pt" ? "Servirei!" : "Sérviam!", style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.bold)),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "À Santíssima Trindade." 
                          : "Ad Trinitátem Beatíssimam.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Graças a vós, Senhor Deus, graças a vós. Verdadeira e única Trindade, divindade suprema e única, indivisa e Santa Trindade."
                          : "Grátias tibi, Deus, grátias tibi: vera et una Trínitas, una et summa Déitas, sancta et una Únitas.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "A Jesus Cristo, Rei." 
                          : "Ad Iesum Christum Regem.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "O Senhor é nosso Juiz, nosso Legislador e nosso Rei. Ele nos salvará."
                          : "Dóminus Iudex noster; Dóminus Légifer noster; Dóminus Rex noster. Ipse salvabit nos.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Cristo, Filho do Deus vivo, tende misericórdia de nós." 
                          : "Christe, Fili Dei vivi, miserére nobis.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Cristo, Filho do Deus vivo, tende misericórdia de nós."
                          : "Christe, Fili Dei vivi, miserére nobis.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Levantai-vos, ó Cristo, vinde em nosso auxílio." 
                          : "Exsúrge, Christe, ádiuva nos.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Libertai-nos pelo vosso nome."
                          : "Et líbera nos propter nomen tuum.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "O Senhor é a minha luz e salvação, a quem temerei?" 
                          : "Dóminus illuminátio mea et salus mea: quem timébo?", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Se os inimigos vierem contra mim, não temerá meu coração; se me combaterem, em Deus esperarei."
                          : "Si consístant advérsum me castra, non timébit cor meum; si exsúrgat advérsum me prœlium, in hoc ego sperábo.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "À Bem-aventurada Virgem Maria, medianeira." 
                          : "Ad Beátam Vírginem Maríam Mediatrícem.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Lembrai-vos, ó Virgem Mãe de Deus, de falar coisas boas de nós quando estiverdes na presença do Senhor."
                          : "Recordáre, Virgo Mater Dei, dum stéteris in conspéctu Dómini, ut loquáris pro nobis bona.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "A São José, esposo da Santíssima Virgem Maria." 
                          : "Ad Sanctum Ioseph Sponsum Beátæ Maríæ Vírginis.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Deus colocou-vos no lugar de Pai do Rei e de senhor da sua casa: rogai por nós."
                          : "Fecit te Deus quasi Patrem Regis, et dóminum univérsæ domus eius: ora pro nobis.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Aos Anjos da Guarda." 
                          : "Ad Ángelos Custódes.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Ó nossos Santos Anjos da Guarda, defendei-nos no combate, para que não pereçamos no tremendo juízo."
                          : "Sancti Ángeli Custódes nostri, deféndite nos in prœlio ut non pereámus in treméndo iudício.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "A São Josemaria, nosso Fundador." 
                          : "Ad Sanctum Iosephmaríam Conditórem nostrum.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Intercedei pelos vossos filhos, para que, fiéis ao espírito do Opus Dei, santifiquemos o trabalho e ganhemos almas para Cristo."
                          : "Intercéde pro fíliis tuis ut, fidéles spirítui Óperis Dei, labórem sanctificémus et ánimas Christo lucrifácere quærámus.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Oremos pelo nosso Santo Padre, o Papa"
                          : "Orémus pro Beatíssimo Papa nostro",
                        style: TextStyle(fontSize: fontSize)
                      ),
                      TextSpan(
                        text: " N.",
                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)
                      )
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Que Deus o conserve e lhe dê vida e o faça santo na terra, e não o entregue nas mãos dos seus inimigos."
                          : "Dóminus consérvet eum, et vivíficet eum, et beátum fáciat eum in terra, et non tradat eum in ánimam inimicórum eius.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Oremos também pelo Bispo desta diocese." 
                          : "Orémus et pro Antístite huius diœcésis.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Senhor, que ele apascente, vigilante, o seu rebanho, com a vossa fortaleza e na grandeza do vosso Nome."
                          : "Stet et pascat in fortitúdine tua, Dómine, in sublimitáte nóminis tui.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Oremos pela unidade do apostolado." 
                          : "Orémus pro unitáte apostolátus.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Que todos sejam um, como tu, Pai, estás em mim, e eu em ti: para que eles sejam um, assim como nós somos um."
                          : "Ut omnes unum sint, sicut tu Pater in me et ego in te: ut sint unum, sicut et nos unum sumus.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Todo reino dividido contra si mesmo será destruído." 
                          : "Omne regnum divísum contra se, desolábitur.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "E toda cidade ou casa internamente dividida não se manterá."
                          : "Et omnis cívitas vel domus divísa contra se non stabit.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Oremos pelos nossos benfeitores." 
                          : "Orémus pro benefactóribus nostris.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Dignai-vos, Senhor, recompensar com a vida eterna todos aqueles que nos fazem o bem pelo vosso nome. Amém."
                          : "Retribúere dignáre, Dómine, ómnibus nobis bona faciéntibus propter nomen tuum, vitam ætérnam. Amen.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Oremos pelo Padre." 
                          : "Orémus pro Patre.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Que a misericórdia do Senhor esteja sobre ele desde sempre e para sempre, pois o Senhor protege todos os que o amam."
                          : "Misericórdia Dómini ab ætérno et usque in ætérnum super eum: custódit enim Dóminus omnes diligéntes se.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Oremos pelos nossos irmãos do Opus Dei, vivos e defuntos." 
                          : "Orémus et pro frátribus nostris Óperis Dei, vivis atque defúnctis.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Salvai, meu Deus, os vossos servos, que em vós esperam."
                          : "Salvos fac servos tuos, Deus meus, sperántes in te.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Enviai-lhes, Senhor, o auxílio do céu." 
                          : "Mitte eis, Dómine, auxílium de sancto.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "E, do santo monte Sião, protegei-os."
                          : "Et de Sion tuére eos.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Dai-lhes, Senhor, o descanso eterno." 
                          : "Réquiem ætérnam dona eis, Dómine.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "E brilhe sobre eles a vossa luz."
                          : "Et lux perpétua lúceat eis.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Descansem em paz." 
                          : "Requiéscant in pace.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Amém."
                          : "Amen.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Ouvi, Senhor, minha oração." 
                          : "Dómine, exáudi oratiónem meam.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "E chegue até vós o meu clamor."
                          : "Et clamor meus ad te véniat.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: language == "pt"
                          ? "\nSe é um sacerdote quem dirige as Preces, levanta-se e acrescenta:"  
                          : "\nSacerdos, si Preces moderatur, exsurgit et addit",
                        style: TextStyle(fontSize: fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                      ),
                      TextSpan(
                        text: language == "pt"
                          ? " O Senhor esteja convosco, "  
                          : " Dóminus vobiscum, ",
                        style: TextStyle(fontSize: fontSize),
                      ),
                      TextSpan(
                        text: language == "pt"
                          ? "permanecendo de pé enquanto reza a oração."  
                          : "stans etiam dum recitat orationem.",
                        style: TextStyle(fontSize: fontSize, color: Colors.red),
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "O Senhor esteja convosco." 
                          : "Dóminus vobíscum.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Ele está no meio de nós."
                          : "Et cum spíritu tuo.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
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
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Amém."
                          : "Amen.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text(language == "pt" ? "\nTodos dizem:" : "\nOmnes dicunt:", style: TextStyle(fontSize: fontSize, color: Colors.red, fontStyle: FontStyle.italic)),
                Text(
                  language == "pt" 
                    ? "\nQue o Senhor onipotente e misericordioso nos conceda a alegria e a paz, a conversão da nossa vida, um tempo de verdadeira penitência, a graça e o consolo do Espírito Santo e a perseverança no Opus Dei." 
                    : "\nGáudium cum pace, emendatiónem vitæ, spátium veræ pœniténtiæ, grátiam et consolatiónem Sancti Spíritus atque in Ópere Dei perseverántiam, tríbuat nobis Omnípotens et Miséricors Dóminus.", 
                  style: TextStyle(fontSize: fontSize)
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "São Miguel." 
                          : "Sancte Míchaël.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Rogai por nós"
                          : "Ora pro nobis.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "São Gabriel." 
                          : "Sancte Gábriel.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Rogai por nós."
                          : "Ora pro nobis.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "São Rafael." 
                          : "Sancte Ráphaël.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Rogai por nós."
                          : "Ora pro nobis.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "São Pedro." 
                          : "Sancte Petre.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Rogai por nós."
                          : "Ora pro nobis.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "São Paulo." 
                          : "Sancte Paule.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Rogai por nós."
                          : "Ora pro nobis.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "São João." 
                          : "Sancte Ioánnes.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Rogai por nós."
                          : "Ora pro nobis.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text(
                  language == "pt"
                    ? "\nQuando estiver presente um sacerdote, o diretor ou quem o substitua diz:"
                    : "\nCum adsit aliquis Sacerdos, dignior ait:",
                  style: TextStyle(fontSize: fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                ),
                Text(
                  language == "pt"
                    ? "\nDignai-vos, padre, abençoar-nos."
                    : "\nIube, Domne, benedícere.",
                  style: TextStyle(fontSize: fontSize),
                ),
                Text(
                  language == "pt"
                    ? "\nO sacerdote abençoa:"
                    : "\nSacerdos benedicit:",
                  style: TextStyle(fontSize: fontSize, color: Colors.red, fontStyle: FontStyle.italic),
                ),
                Text(
                  language == "pt"
                    ? "\nQue o Senhor esteja em vossos corações e em vossos lábios, em nome do Pai † e do Filho e do Espírito Santo."
                    : "\nDóminus sit in córdibus vestris, et in lábiis vestris, in nómine Patris † et Fílii et Spíritus Sancti.",
                  style: TextStyle(fontSize: fontSize),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Amém."
                          : "Amen.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt" 
                          ? "Paz." 
                          : "Pax.", 
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                        text: language == "pt"
                          ? "Para sempre."
                          : "In ætérnum.",
                        style: TextStyle(fontSize: fontSize)
                      ),
                    ]
                  )
                ),
                const Divider(height: 25, color: Colors.transparent),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
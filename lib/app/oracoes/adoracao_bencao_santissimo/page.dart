import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';
import 'widgets/gregorian_score.dart';

class AdoracaoBencaoSantissimoPage extends StatefulWidget {
  const AdoracaoBencaoSantissimoPage({super.key});

  @override
  State<AdoracaoBencaoSantissimoPage> createState() =>
      _AdoracaoBencaoSantissimoPageState();
}

class _AdoracaoBencaoSantissimoPageState
    extends State<AdoracaoBencaoSantissimoPage> {
  Widget _prayline(
    String prefix,
    String text,
    double fontSize, {
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 3.0),
  }) {
    return Padding(
      padding: padding,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: prefix.isEmpty ? "" : "$prefix  ",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            TextSpan(
              text: text,
              style: TextStyle(
                fontSize: fontSize,
                fontStyle: prefix.isEmpty ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bilingualPrayline(
    String prefix,
    String lt,
    String pt,
    double fontSize,
  ) {
    return BilingualPrayerRow(
      latin: _prayline(prefix, lt, fontSize, padding: EdgeInsets.zero),
      portuguese: _prayline(prefix, pt, fontSize, padding: EdgeInsets.zero),
    );
  }

  Widget _rubric(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize - 1,
          color: Colors.red,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  // --- 1. Pange Lingua (1ª Estrofe) ---
  static const List<Map<String, String>> _pangeLinguaStrophes = [
    {
      "lt":
          "Pange, lingua, gloriósi\nCórporis mystérium,\nSanguinísque pretiósi,\nquem in mundi prétium\nfructus ventris generósi\nRex effúdit géntium.",
      "pt":
          "Vamos todos louvar juntos\no mistério do amor.\nPois o preço deste mundo\nfoi o sangue redentor.\nRecebido de Maria\nque nos deu o Salvador.",
    },
  ];

  // --- 3. Visita ao Santíssimo Sacramento ---
  static const Map<String, dynamic> _aclamacaoEucaristica = {
    "v": {
      "lt": "Adorémus in ætérnum Sanctíssimum Sacraméntum.",
      "pt": "Graças e louvores sejam dadas a todo o momento,",
    },
    "r": {
      "lt": "Adorémus in ætérnum Sanctíssimum Sacraméntum.",
      "pt": "ao Santíssimo e diviníssimo Sacramento.",
    },
  };

  static const Map<String, String> _comunhaoEspiritual = {
    "text":
        "Eu quisera, Senhor, receber-vos com aquela pureza, humildade e devoção com que vos recebeu a vossa Santíssima Mãe, com o espírito e o fervor dos Santos.",
  };

  // --- 5. Tantum Ergo (Estrofes 5 e 6) ---
  static const List<Map<String, String>> _tantumErgoStrophes = [
    {
      "lt":
          "Tantum ergo Sacraméntum\nvenerémur cérnui:\net antíquum documéntum\nnovo cedat rítui:\npræstet fides suppleméntum\nsénsuum deféctui.",
      "pt":
          "Tão sublime Sacramento\nadoremos neste altar,\npois o Antigo Testamento\ndeu ao Novo o seu lugar;\nvenha a fé por suplemento\nos sentidos confortar.",
    },
    {
      "lt":
          "Genitóri, Genitóque\nlaus et iubilátio,\nsalus, honor, virtus quoque\nsit et benedíctio:\nprocedénti ab utróque\ncompar sit laudátio.\nAmen.",
      "pt":
          "Ao eterno Pai cantemos\ne a Jesus, o Salvador,\nao Espírito exaltemos,\nna Trindade eterno amor;\nao Deus Uno e Trino demos\na alegria do louvor.\nAmém.",
    },
  ];

  // --- 8. Bendito seja Deus (Laudes Divinas) ---
  static const List<Map<String, String>> _laudesDivinas = [
    {"lt": "Benedíctus Deus.", "pt": "Bendito seja Deus."},
    {
      "lt": "Benedíctum Nomen sanctum eius.",
      "pt": "Bendito seja o seu Santo Nome.",
    },
    {
      "lt": "Benedíctus Iesus Christus, verus Deus et verus homo.",
      "pt": "Bendito seja Jesus Cristo, verdadeiro Deus e verdadeiro Homem.",
    },
    {"lt": "Benedíctum Nomen Iesu.", "pt": "Bendito seja o Nome de Jesus."},
    {
      "lt": "Benedíctum Cor eius sacratíssimum.",
      "pt": "Bendito seja o seu Sacratíssimo Coração.",
    },
    {
      "lt": "Benedíctus Sanguis eius pretiosíssimus.",
      "pt": "Bendito seja o seu Preciosíssimo Sangue.",
    },
    {
      "lt": "Benedíctus Iesus in sanctíssimo Altáris Sacraménto.",
      "pt": "Bendito seja Jesus no Santíssimo Sacramento do Altar.",
    },
    {
      "lt": "Benedíctus Sanctus Spíritus, Paráclitus.",
      "pt": "Bendito seja o Espírito Santo Consolador.",
    },
    {
      "lt": "Benedícta excelsa Mater Dei, María sanctíssima.",
      "pt": "Bendita seja a excelsa Mãe de Deus, Maria Santíssima.",
    },
    {
      "lt": "Benedícta sancta eius et immaculáta Concéptio.",
      "pt": "Bendita seja a sua Santa e Imaculada Conceição.",
    },
    {
      "lt": "Benedícta eius gloriósa Assúmptio.",
      "pt": "Bendita seja a sua gloriosa Assunção.",
    },
    {
      "lt": "Benedíctum nomen Maríæ, Vírginis et Matris.",
      "pt": "Bendito seja o nome de Maria, Virgem e Mãe.",
    },
    {
      "lt": "Benedíctus sanctus Ioseph, eius castíssimus Sponsus.",
      "pt": "Bendito seja São José, seu castíssimo esposo.",
    },
    {
      "lt": "Benedíctus Deus in Angelis suis, et in Sanctis suis. Amen.",
      "pt": "Bendito seja Deus nos seus Anjos e nos seus Santos. Amém.",
    },
  ];

  // --- 9. Laudate Dominum ---
  static const List<Map<String, String>> _laudateDominumLines = [
    {
      "lt": "Laudáte Dóminum, omnes gentes; * laudáte eum, omnes pópuli.",
      "pt": "Louvai o Senhor, todos os povos; * louvai-o, todas as gentes.",
    },
    {
      "lt":
          "Quóniam confirmáta est super nos misericórdia eius; * et véritas Dómini manet in ætérnum.",
      "pt":
          "Porque a sua misericórdia é confirmada sobre nós; * e a verdade do Senhor permanece para sempre.",
    },
    {
      "lt":
          "Glória Patri, et Fílio, * et Spirítui Sancto.\nSicut erat in princípio, et nunc, et semper, * et in saécula sæculórum. Amen.",
      "pt":
          "Glória ao Pai e ao Filho * e ao Espírito Santo.\nComo era no princípio, agora e sempre, * por todos os séculos dos séculos. Amém.",
    },
  ];

  // --- 10. Salve Regina ---
  static const Map<String, String> _salveRegina = {
    "lt":
        "Salve, Regína, Mater misericórdiæ, vita, dulcédo et spes nostra, salve. Ad te clamámus, éxsules fílii Evæ. Ad te suspirámus, geméntes et flentes in hac lacrimárum valle. Eia ergo, advocáta nostra, illos tuos misericórdes óculos ad nos convérte. Et Iesum, benedíctum fructum ventris tui, nobis post hoc exsílium osténde. O clemens, o pia, o dulcis Virgo María.",
    "pt":
        "Salve, Rainha, Mãe de misericórdia, vida, doçura e esperança nossa, salve! A vós bradamos, os degredados filhos de Eva. A vós suspiramos, gemendo e chorando neste vale de lágrimas. Eia, pois, advogada nossa, esses vossos olhos misericordiosos a nós volvei. E depois deste desterro, mostrai-nos Jesus, bendito fruto do vosso ventre. Ó clemente, ó piedosa, ó doce sempre Virgem Maria.",
  };

  @override
  Widget build(BuildContext context) {
    final fs = Provider.of<AppProvider>(context);
    final bool isBilingual = fs.bilingualMode;
    final String language = fs.prayerLanguage;
    final double fSize = fs.fontSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Adoração e Bênção",
          maxLines: 2,
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: fs.toggleBilingualMode,
            icon: Icon(
              isBilingual
                  ? Icons.vertical_split
                  : Icons.vertical_split_outlined,
            ),
            tooltip: isBilingual
                ? "Modo coluna única"
                : "Modo bilíngue lado a lado",
          ),
          IconButton(
            onPressed: fs.decreaseFontSize,
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: fs.increaseFontSize,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20,
              left: 15,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 10, color: Colors.transparent),
                if (isBilingual) ...[
                  const BilingualPrayerHeader(),
                  ..._buildBilingualBody(fs, fSize),
                ] else ...[
                  ..._buildSingleLanguageBody(fs, language, fSize),
                ],
                const Divider(height: 25, color: Colors.transparent),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =================== MODO BILÍNGUE ===================
  List<Widget> _buildBilingualBody(AppProvider fs, double fSize) {
    return [
      // 1. Pange Lingua
      const GregorianScoreTile(
        title: "Pange Lingua",
        mode: "III.",
        imageAsset: "assets/images/oracoes/partitura_pange_lingua.png",
      ),
      for (final st in _pangeLinguaStrophes)
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: BilingualPrayerRow(
            latin: Text(st["lt"]!, style: TextStyle(fontSize: fSize)),
            portuguese: Text(st["pt"]!, style: TextStyle(fontSize: fSize)),
          ),
        ),
      // 2. Leitura do Evangelho
      _rubric("Leitura da Sagrada Escritura (ou do Evangelho do dia)", fSize),
      Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: FilledButton.tonal(
          onPressed: () => Navigator.pushNamed(context, '/liturgia'),
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            "Abrir Evangelho do Dia",
            style: TextStyle(fontSize: fSize),
          ),
        ),
      ),
      const Divider(height: 10, color: Colors.transparent),
      // 3. Visita ao Santíssimo Sacramento
      _rubric(
        "Visita ao Santíssimo Sacramento (repete-se 3 vezes; em seguida a Comunhão Espiritual):",
        fSize,
      ),
      const Divider(height: 10, color: Colors.transparent),
      ExpansionTile(
        title: Text("Visita ao Santíssimo"),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        collapsedBackgroundColor: Theme.of(
          context,
        ).colorScheme.secondaryContainer,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        children: [
          // Aclamação Eucarística
          for (int i = 0; i < 3; i++) ...[
            _bilingualPrayline(
              "℣.",
              _aclamacaoEucaristica["v"]!["lt"]!,
              _aclamacaoEucaristica["v"]!["pt"]!,
              fSize,
            ),
            _bilingualPrayline(
              "℟.",
              _aclamacaoEucaristica["r"]!["lt"]!,
              _aclamacaoEucaristica["r"]!["pt"]!,
              fSize,
            ),
            const Divider(height: 15, color: Colors.transparent),

            // Pater Noster
            _bilingualPrayline(
              "",
              "Pater noster, Ave Maria e Glória",
              "Pai nosso, Ave Maria e Glória",
              fSize,
            ),
            const Divider(height: 15, color: Colors.transparent),
          ],

          _bilingualPrayline(
            "℣.",
            _aclamacaoEucaristica["v"]!["lt"]!,
            _aclamacaoEucaristica["v"]!["pt"]!,
            fSize,
          ),
          _bilingualPrayline(
            "℟.",
            _aclamacaoEucaristica["r"]!["lt"]!,
            _aclamacaoEucaristica["r"]!["pt"]!,
            fSize,
          ),
          const Divider(height: 20, color: Colors.transparent),

          // Comunhão Espiritual
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
            child: Text(
              "Comunhão espiritual",
              style: TextStyle(fontSize: fSize, fontWeight: FontWeight.bold),
            ),
          ),
          Text(_comunhaoEspiritual["text"]!, style: TextStyle(fontSize: fSize)),
        ],
      ),
      const Divider(height: 10, color: Colors.transparent),

      // 4. Preces
      _rubric("Preces (Opcional):", fSize),
      Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: FilledButton.tonal(
          onPressed: () => Navigator.pushNamed(context, '/preces'),
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text("Rezar as Preces", style: TextStyle(fontSize: fSize)),
        ),
      ),
      const Divider(height: 15, color: Colors.transparent),

      // 5. Tantum Ergo
      const GregorianScoreTile(
        title: "Tantum Ergo",
        mode: "III.",
        imageAsset: "assets/images/oracoes/partitura_tantum_ergo.png",
      ),
      for (final st in _tantumErgoStrophes)
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: BilingualPrayerRow(
            latin: Text(st["lt"]!, style: TextStyle(fontSize: fSize)),
            portuguese: Text(st["pt"]!, style: TextStyle(fontSize: fSize)),
          ),
        ),
      const Divider(height: 15, color: Colors.transparent),

      // 6. Panem de Cælo
      _bilingualPrayline(
        "℣.",
        "Panem de cælo præstitísti eis (T.P. Allelúia).",
        "Vós sois o Pão que desceu do Céu (T.P. Aleluia).",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Omne delectaméntum in se habéntem (T.P. Allelúia).",
        "Para dar a vida ao mundo (T.P. Aleluia).",
        fSize,
      ),
      const Divider(height: 12, color: Colors.transparent),

      // 7. Oração e Bênção
      _bilingualPrayline("℣.", "Orémus.", "Oremos.", fSize),
      BilingualPrayerRow(
        latin: Text(
          "Deus, qui nobis sub sacraménto mirábili passiónis tuæ memóriam reliquísti, tríbue, quaésumus, ita nos Córporis et Sánguinis tui sacra mystéria venerári, ut redemptiónis tuæ fructum in nobis iúgiter sentiámus. Qui vivis et regnas in saécula sæculórum.",
          style: TextStyle(fontSize: fSize),
        ),
        portuguese: Text(
          "Senhor Jesus Cristo, que neste admirável sacramento nos deixastes o memorial da vossa paixão, concedei-nos a graça de venerar de tal modo os mistérios do vosso Corpo e Sangue que sintamos continuamente os frutos da vossa redenção. Vós que sois Deus com o Pai, na unidade do Espírito Santo.",
          style: TextStyle(fontSize: fSize),
        ),
      ),
      _bilingualPrayline("℟.", "Amen.", "Amém.", fSize),
      const Divider(height: 15, color: Colors.transparent),
      _rubric("O sacerdote abençoa o povo com o Santíssimo Sacramento.", fSize),
      const Divider(height: 15, color: Colors.transparent),

      // 8. Bendito seja Deus (Laudes Divinas)
      for (final item in _laudesDivinas)
        _bilingualPrayline("℟.", item["lt"]!, item["pt"]!, fSize),
      const Divider(height: 15, color: Colors.transparent),

      // 9. Laudate Dominum
      const GregorianScoreTile(
        title: "Laudate Dominum",
        mode: "V.",
        imageAsset: "assets/images/oracoes/partitura_laudate_dominum.png",
      ),
      for (final line in _laudateDominumLines)
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: BilingualPrayerRow(
            latin: Text(line["lt"]!, style: TextStyle(fontSize: fSize)),
            portuguese: Text(line["pt"]!, style: TextStyle(fontSize: fSize)),
          ),
        ),
      const Divider(height: 8, color: Colors.transparent),
      _bilingualPrayline(
        "℣.",
        "Adorémus in ætérnum Sanctíssimum Sacraméntum.",
        "Graças e louvores sejam dadas a todo o momento,",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "In ætérnum.",
        "ao Santíssimo e diviníssimo Sacramento.",
        fSize,
      ),
      const Divider(height: 15, color: Colors.transparent),

      // 10. Salve Regina
      const GregorianScoreTile(
        title: "Salve Regina",
        mode: "Tonus simplex",
        imageAsset: "assets/images/oracoes/partitura_salve_regina.png",
      ),
      BilingualPrayerRow(
        latin: Text(_salveRegina["lt"]!, style: TextStyle(fontSize: fSize)),
        portuguese: Text(
          _salveRegina["pt"]!,
          style: TextStyle(fontSize: fSize),
        ),
      ),
      _bilingualPrayline(
        "℣.",
        "Ora pro nobis, sancta Dei Génetrix.",
        "Rogai por nós, Santa Mãe de Deus.",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Ut digni efficiámur promissiónibus Christi.",
        "Para que sejamos dignos das promessas de Cristo.",
        fSize,
      ),
    ];
  }

  // =================== MODO COLUNA ÚNICA ===================
  List<Widget> _buildSingleLanguageBody(
    AppProvider fs,
    String language,
    double fSize,
  ) {
    final bool isPt = language == "pt";

    return [
      // 1. Pange Lingua
      const GregorianScoreTile(
        title: "Pange Lingua",
        mode: "III.",
        imageAsset: "assets/images/oracoes/partitura_pange_lingua.png",
      ),
      for (final st in _pangeLinguaStrophes)
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            isPt ? st["pt"]! : st["lt"]!,
            style: TextStyle(fontSize: fSize),
          ),
        ),
      const Divider(height: 15, color: Colors.transparent),

      // 2. Leitura do Evangelho
      _rubric(
        isPt
            ? "Leitura da Sagrada Escritura (ou do Evangelho do dia)"
            : "Léctio Sancti Evangélii:",
        fSize,
      ),
      Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: FilledButton.tonal(
          onPressed: () => Navigator.pushNamed(context, '/liturgia'),
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            "Abrir Evangelho do Dia",
            style: TextStyle(fontSize: fSize),
          ),
        ),
      ),
      const Divider(height: 15, color: Colors.transparent),

      // 3. Visita ao Santíssimo Sacramento
      _rubric(
        isPt
            ? "Visita ao Santíssimo Sacramento (repete-se 3 vezes; em seguida a Comunhão espiritual):"
            : "Visitatio ad Sanctíssimum Sacraméntum (ter repetitur; deinde Communio spiritualis):",
        fSize,
      ),
      const Divider(height: 10, color: Colors.transparent),
      ExpansionTile(
        title: Text("Visita ao Santíssimo"),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        collapsedBackgroundColor: Theme.of(
          context,
        ).colorScheme.secondaryContainer,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        children: [
          for (int i = 0; i < 3; i++) ...[
            // Aclamação Eucarística
            _prayline(
              "℣.",
              isPt
                  ? _aclamacaoEucaristica["v"]!["pt"]!
                  : _aclamacaoEucaristica["v"]!["lt"]!,
              fSize,
            ),
            _prayline(
              "℟.",
              isPt
                  ? _aclamacaoEucaristica["r"]!["pt"]!
                  : _aclamacaoEucaristica["r"]!["lt"]!,
              fSize,
            ),
            const Divider(height: 15, color: Colors.transparent),

            _prayline(
              "",
              isPt
                  ? "Pai nosso, Ave Maria e Glória"
                  : "Pater noster, Ave Maria et Gloria",
              fSize,
            ),

            const Divider(height: 15, color: Colors.transparent),
          ],
          _prayline(
            "℣.",
            isPt
                ? _aclamacaoEucaristica["v"]!["pt"]!
                : _aclamacaoEucaristica["v"]!["lt"]!,
            fSize,
          ),
          _prayline(
            "℟.",
            isPt
                ? _aclamacaoEucaristica["r"]!["pt"]!
                : _aclamacaoEucaristica["r"]!["lt"]!,
            fSize,
          ),
          const Divider(height: 20, color: Colors.transparent),
          Text(
            "Comunhão espiritual",
            style: TextStyle(
              fontSize: fs.fontSize + 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 6, color: Colors.transparent),
          Text(
            "Eu quisera, Senhor, receber-Vos com aquela pureza, humildade e devoção com que Vos recebeu a Vossa Santíssima Mãe, com o espírito e o fervor dos Santos.",
            style: TextStyle(fontSize: fs.fontSize),
          ),
        ],
      ),
      const Divider(height: 10, color: Colors.transparent),

      // 4. Preces
      _rubric(isPt ? "Preces (Opcional):" : "Preces (ad libitum):", fSize),
      Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
        child: FilledButton.tonal(
          onPressed: () => Navigator.pushNamed(context, '/preces'),
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text("Rezar as Preces", style: TextStyle(fontSize: fSize)),
        ),
      ),
      const Divider(height: 15, color: Colors.transparent),

      // 5. Tantum Ergo
      const GregorianScoreTile(
        title: "Tantum Ergo",
        mode: "III.",
        imageAsset: "assets/images/oracoes/partitura_tantum_ergo.png",
      ),
      for (final st in _tantumErgoStrophes)
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            isPt ? st["pt"]! : st["lt"]!,
            style: TextStyle(fontSize: fSize),
          ),
        ),
      const Divider(height: 15, color: Colors.transparent),

      // 6. Panem de Cælo
      _prayline(
        "℣.",
        isPt
            ? "Vós lhes destes o pão do céu (T.P. Aleluia)."
            : "Panem de cælo præstitísti eis (T.P. Allelúia).",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt
            ? "Que contém em si todo o sabor (T.P. Aleluia)."
            : "Omne delectaméntum in se habéntem (T.P. Allelúia).",
        fSize,
      ),
      const Divider(height: 12, color: Colors.transparent),

      // 7. Oração e Bênção
      _prayline("℣.", isPt ? "Oremos." : "Orémus.", fSize),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Text(
          isPt
              ? "Senhor Jesus Cristo, que neste admirável sacramento nos deixastes o memorial da vossa paixão, concedei-nos a graça de venerar de tal modo os sagrados mistérios do vosso Corpo e do vosso Sangue, que sintamos continuamente em nós o fruto da vossa redenção. Vós que sois Deus com o Pai na unidade do Espírito Santo."
              : "Deus, qui nobis sub sacraménto mirábili passiónis tuæ memóriam reliquísti: tríbue, quaésumus, ita nos córporis et sánguinis tui sacra mystéria venerári, ut redemptiónis tuæ fructum in nobis iúgiter sentiámus. Qui vivis et regnas in saécula sæculórum.",
          style: TextStyle(fontSize: fSize),
        ),
      ),
      _prayline("℟.", isPt ? "Amém." : "Amen.", fSize),
      const Divider(height: 15, color: Colors.transparent),
      _rubric(
        isPt
            ? "O sacerdote abençoa o povo com o Santíssimo Sacramento."
            : "Sacerdos benedícit pópulum cum Sanctíssimo Sacraménto.",
        fSize,
      ),
      const Divider(height: 15, color: Colors.transparent),

      // 8. Bendito seja Deus (Laudes Divinas)
      for (final item in _laudesDivinas)
        _prayline("℟.", isPt ? item["pt"]! : item["lt"]!, fSize),
      const Divider(height: 15, color: Colors.transparent),

      // 9. Laudate Dominum
      const GregorianScoreTile(
        title: "Laudate Dominum",
        mode: "V.",
        imageAsset: "assets/images/oracoes/partitura_laudate_dominum.png",
      ),
      for (final line in _laudateDominumLines)
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            isPt ? line["pt"]! : line["lt"]!,
            style: TextStyle(fontSize: fSize),
          ),
        ),
      const Divider(height: 8, color: Colors.transparent),
      _prayline(
        "℣.",
        isPt
            ? "Graças e louvores sejam dadas a todo o momento,"
            : "Adorémus in ætérnum Sanctíssimum Sacraméntum.",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt ? "ao Santíssimo e diviníssimo Sacramento." : "In ætérnum.",
        fSize,
      ),
      const Divider(height: 15, color: Colors.transparent),

      // 10. Salve Regina
      const GregorianScoreTile(
        title: "Salve Regina",
        mode: "Tonus simplex",
        imageAsset: "assets/images/oracoes/partitura_salve_regina.png",
      ),
      Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
        child: Text(
          isPt ? _salveRegina["pt"]! : _salveRegina["lt"]!,
          style: TextStyle(fontSize: fSize),
        ),
      ),
      _prayline(
        "℣.",
        isPt
            ? "Rogai por nós, Santa Mãe de Deus."
            : "Ora pro nobis, sancta Dei Génetrix.",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt
            ? "Para que sejamos dignos das promessas de Cristo."
            : "Ut digni efficiámur promissiónibus Christi.",
        fSize,
      ),
    ];
  }
}

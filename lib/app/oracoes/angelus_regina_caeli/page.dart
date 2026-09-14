import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';

class AngelusReginaCaeliPage extends StatefulWidget {
  const AngelusReginaCaeliPage({super.key});

  @override
  State<AngelusReginaCaeliPage> createState() => _AngelusReginaCaeliPageState();
}

class _AngelusReginaCaeliPageState extends State<AngelusReginaCaeliPage> {
  String selected = "angelus";
  String language = "pt";

  void toggleSelected(String value) {
    setState(() {
      selected = value;
    });
  }

  void toggleLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  static const String _aveMariaPt =
      "Ave, Maria, cheia de graça, o Senhor é convosco. Bendita sois vós entre as mulheres, e bendito é o fruto do vosso ventre, Jesus. Santa Maria, Mãe de Deus, rogai por nós, pecadores, agora e na hora da nossa morte. Amem.";
  static const String _aveMariaLt =
      "Ave María, gratia plena, Dominus tecum, benedicta tu in muliéribus, et benedictus fructus ventris tui Iesus. Sancta Maria, Mater Dei, ora pro nobis peccatoribus, nunc et in hora mortis nostrae. Amen.";

  Widget _buildVersicle(String prefix, String text, double fontSize) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$prefix  ",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          TextSpan(text: text, style: TextStyle(fontSize: fontSize)),
        ],
      ),
    );
  }

  List<Widget> _buildAngelusBilingual(double fontSize) {
    return [
      const BilingualPrayerHeader(),
      BilingualPrayerRow(
        latin: _buildVersicle("℣.", "Angelus Dómini nuntiávit Maríæ.", fontSize),
        portuguese: _buildVersicle("℣.", "O Anjo do Senhor anunciou a Maria.", fontSize),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℟.", "Et concépit de Spíritu Sancto.", fontSize),
        portuguese: _buildVersicle("℟.", "E Ela concebeu pelo poder do Espírito Santo.", fontSize),
      ),
      BilingualPrayerRow(
        latin: Text(_aveMariaLt, style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
        portuguese: Text(_aveMariaPt, style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℣.", "Ecce ancílla Dómini.", fontSize),
        portuguese: _buildVersicle("℣.", "Eis aqui a escrava do Senhor.", fontSize),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℟.", "Fiat mihi secúndum verbum tuum.", fontSize),
        portuguese: _buildVersicle("℟.", "Faça-se em Mim segundo a vossa palavra.", fontSize),
      ),
      BilingualPrayerRow(
        latin: Text(_aveMariaLt, style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
        portuguese: Text(_aveMariaPt, style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℣.", "Et Verbum caro factum est.", fontSize),
        portuguese: _buildVersicle("℣.", "E o Verbo Divino se fez carne.", fontSize),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℟.", "Et habitávit in nobis.", fontSize),
        portuguese: _buildVersicle("℟.", "E habitou entre nós.", fontSize),
      ),
      BilingualPrayerRow(
        latin: Text(_aveMariaLt, style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
        portuguese: Text(_aveMariaPt, style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℣.", "Ora pro nobis, sancta Dei Génetríx.", fontSize),
        portuguese: _buildVersicle("℣.", "Rogai por nós, Santa Mãe de Deus.", fontSize),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℟.", "Ut digni efficiámur promissionibus Christi.", fontSize),
        portuguese: _buildVersicle("℟.", "Para que sejamos dignos das promessas de Cristo.", fontSize),
      ),
      BilingualPrayerRow(
        latin: Text("Oremus:", style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.bold)),
        portuguese: Text("Oremos:", style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.bold)),
      ),
      BilingualPrayerRow(
        latin: Text(
          "Grátiam tuam, quæsumus, Dómine, méntibus nostris infúnde: ut qui, Angelo nuntiánte, Christi Filii tui incarnatió- nem cognóvimus, per passiónem eius et crucem ad resurrec- tiónis glóriam perducámur. Per eumdem Christum Dóminum nostrum.",
          style: TextStyle(fontSize: fontSize),
        ),
        portuguese: Text(
          "Infundi, Senhor, nós Vos pedimos, em nossas almas a vossa graça, para que nós, que conhecemos pela Anunciação do Anjo a Encarnação de Jesus Cristo, vosso Filho, cheguemos por sua Paixão e sua Cruz à glória da Ressurreição. Pelo mesmo Jesus Cristo, Senhor nosso.",
          style: TextStyle(fontSize: fontSize),
        ),
      ),
      BilingualPrayerRow(
        latin: Center(child: Text("Amen", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold))),
        portuguese: Center(child: Text("Amém", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold))),
      ),
    ];
  }

  List<Widget> _buildReginaBilingual(double fontSize) {
    return [
      const BilingualPrayerHeader(),
      BilingualPrayerRow(
        latin: _buildVersicle("℣.", "Regína Cæli, lætáre, alleluia.", fontSize),
        portuguese: _buildVersicle("℣.", "Rainha do céu, alegrai-Vos, aleluia.", fontSize),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℟.", "Quia quem meruísti portáre, alleluia", fontSize),
        portuguese: _buildVersicle("℟.", "Porque quem merecestes trazer em vosso seio, aleluia.", fontSize),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℣.", "Resurréxit, sicut dixit, alleluia.", fontSize),
        portuguese: _buildVersicle("℣.", "Ressuscitou como disse, aleluia.", fontSize),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℟.", "Ora pro nóbis Deum, alleluia.", fontSize),
        portuguese: _buildVersicle("℟.", "Rogai a Deus por nós, aleluia.", fontSize),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℣.", "Gaude et lætáre, Virgo Maria, alleluia.", fontSize),
        portuguese: _buildVersicle("℣.", "Exultai e alegrai-Vos, ó Virgem Maria, aleluia.", fontSize),
      ),
      BilingualPrayerRow(
        latin: _buildVersicle("℟.", "Quia surréxit Dóminus vere, alleluia.", fontSize),
        portuguese: _buildVersicle("℟.", "Porque o Senhor ressuscitou verdadeiramente, aleluia.", fontSize),
      ),
      BilingualPrayerRow(
        latin: Text("Oremus:", style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.bold)),
        portuguese: Text("Oremos:", style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.bold)),
      ),
      BilingualPrayerRow(
        latin: Text(
          "Deus, qui per resurrectiónem Filii tui Dómini nostri Jesu Christi mundum lætificáre dignátus es: præsta, quæsumus; ut, per eius Genitrícem Vírginem Mariam, perpétuæ capiámus gáudia vitæ. Per eumdem Christum, Dóminum nostrum.",
          style: TextStyle(fontSize: fontSize),
        ),
        portuguese: Text(
          "Ó Deus, que Vos dignastes alegrar o mundo com a Ressurreição do Vosso Filho Jesus Cristo, Senhor Nosso, concedei-nos, Vos suplicamos, que por sua Mãe, a Virgem Maria, alcancemos as alegrias da vida eterna. Por Cristo Senhor nosso.",
          style: TextStyle(fontSize: fontSize),
        ),
      ),
      BilingualPrayerRow(
        latin: Center(child: Text("Amen", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold))),
        portuguese: Center(child: Text("Amém", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold))),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    final bool isBilingual = fs.bilingualMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(selected == "angelus" ? "Ângelus" : "Regina Cæli", maxLines: 2, style: const TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            onPressed: fs.toggleBilingualMode,
            icon: Icon(isBilingual ? Icons.vertical_split : Icons.vertical_split_outlined),
            tooltip: isBilingual ? "Modo coluna única" : "Modo bilíngue lado a lado",
          ),
          if (!isBilingual)
            IconButton(
              onPressed: () => toggleLanguage(language == "pt" ? "lt" : "pt"),
              icon: Text(language == "pt" ? "LT" : "PT"),
              tooltip: language == "pt" ? "Mudar para Latim" : "Mudar para Português",
            ),
          IconButton(onPressed: fs.decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: fs.increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: isBilingual
                        ? (selected == "angelus"
                            ? _buildAngelusBilingual(fs.fontSize)
                            : _buildReginaBilingual(fs.fontSize))
                        : (selected == "angelus"
                            ? [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "℣.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "O Anjo do Senhor anunciou a Maria." : "Angelus Dómini nuntiávit Maríæ.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n℟.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "E Ela concebeu pelo poder do Espírito Santo." : "Et concépit de Spíritu Sancto.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "\n\n$_aveMariaPt" : "\n\n$_aveMariaLt",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n\n℣.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "Eis aqui a escrava do Senhor." : "Ecce ancílla Dómini.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n℟.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "Faça-se em Mim segundo a vossa palavra." : "Fiat mihi secúndum verbum tuum.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "\n\n$_aveMariaPt" : "\n\n$_aveMariaLt",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n\n℣.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "E o Verbo Divino se fez carne." : "Et Verbum caro factum est.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n℟.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "E habitou entre nós." : "Et habitávit in nobis.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "\n\n$_aveMariaPt" : "\n\n$_aveMariaLt",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n\n℣.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "Rogai por nós, Santa Mãe de Deus." : "Ora pro nobis, sancta Dei Génetríx.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n℟.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "Para que sejamos dignos das promessas de Cristo." : "Ut digni efficiámur promissionibus Christi.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "\n\nOremos:" : "\n\nOremus:",
                                        style: TextStyle(fontSize: fs.fontSize + 2, fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: language == "pt"
                                            ? "\nInfundi, Senhor, nós Vos pedimos, em nossas almas a vossa graça, para que nós, que conhecemos pela Anunciação do Anjo a Encarnação de Jesus Cristo, vosso Filho, cheguemos por sua Paixão e sua Cruz à glória da Ressurreição. Pelo mesmo Jesus Cristo, Senhor nosso."
                                            : "\nGrátiam tuam, quæsumus, Dómine, méntibus nostris infúnde: ut qui, Angelo nuntiánte, Christi Filii tui incarnatió- nem cognóvimus, per passiónem eius et crucem ad resurrec- tiónis glóriam perducámur. Per eumdem Christum Dóminum nostrum.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    language == "pt" ? "\nAmém" : "\nAmen",
                                    style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]
                            : [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "℣.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "Rainha do céu, alegrai-Vos, aleluia." : "Regína Cæli, lætáre, alleluia.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n℟.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "Porque quem merecestes trazer em vosso seio, aleluia." : "Quia quem meruísti portáre, alleluia",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n\n℣.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "Ressuscitou como disse, aleluia." : "Resurréxit, sicut dixit, alleluia.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n℟.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "Rogai a Deus por nós, aleluia." : "Ora pro nóbis Deum, alleluia.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n\n℣.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "Exultai e alegrai-Vos, ó Virgem Maria, aleluia." : "Gaude et lætáre, Virgo Maria, alleluia.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: "\n℟.  ",
                                        style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "Porque o Senhor ressuscitou verdadeiramente, aleluia." : "Quia surréxit Dóminus vere, alleluia.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                      TextSpan(
                                        text: language == "pt" ? "\n\nOremos:" : "\n\nOremus:",
                                        style: TextStyle(fontSize: fs.fontSize + 2, fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: language == "pt"
                                            ? "\nÓ Deus, que Vos dignastes alegrar o mundo com a Ressurreição do Vosso Filho Jesus Cristo, Senhor Nosso, concedei-nos, Vos suplicamos, que por sua Mãe, a Virgem Maria, alcancemos as alegrias da vida eterna. Por Cristo Senhor nosso."
                                            : "\nDeus, qui per resurrectiónem Filii tui Dómini nostri Jesu Christi mundum lætificáre dignátus es: præsta, quæsumus; ut, per eius Genitrícem Vírginem Mariam, perpétuæ capiámus gáudia vitæ. Per eumdem Christum, Dóminum nostrum.",
                                        style: TextStyle(fontSize: fs.fontSize),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    language == "pt" ? "\nAmém" : "\nAmen",
                                    style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]),
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
                child: FilledButton.tonal(
                  onPressed: () => toggleSelected(selected == "angelus" ? "regina" : "angelus"),
                  style: ButtonStyle(shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
                  child: Text(selected == "angelus" ? "Regina Cæli" : "Ângelus", style: const TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

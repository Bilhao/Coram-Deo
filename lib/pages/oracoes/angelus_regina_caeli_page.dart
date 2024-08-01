import 'package:flutter/material.dart';

class AngelusReginaCaeliPage extends StatefulWidget {
  const AngelusReginaCaeliPage({super.key});

  @override
  State<AngelusReginaCaeliPage> createState() => _AngelusReginaCaeliPageState();
}

class _AngelusReginaCaeliPageState extends State<AngelusReginaCaeliPage> {
  double fontSize = 18.0;
  String selected = "angelus";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: selected == "angelus" ? const Text('Ângelus') : const Text('Regina Cæli'),
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
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    children: selected == "angelus"
                      ? [
                        const Divider(height: 15, color: Colors.transparent),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: "℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "O Anjo do Senhor anunciou a Maria." : "Angelus Dómini nuntiávit Maríæ.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "E Ela concebeu pelo poder do Espírito Santo." : "Et concépit de Spíritu Sancto.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(
                                text: language == "pt" 
                                  ? "\n\nAve, Maria, cheia de graça, o Senhor é convosco. Bendita sois vós entre as mulheres, e bendito é o fruto do vosso ventre, Jesus. Santa Maria, Mãe de Deus, rogai por nós, pecadores, agora e na hora da nossa morte. Amem."
                                  : "\n\nAve María, gratia plena, Dominus tecum, benedicta tu in muliéribus, et benedictus fructus ventris tui Iesus. Sancta Maria, Mater Dei, ora pro nobis peccatoribus, nunc et in hora mortis nostrae. Amen.",
                                style: TextStyle(fontSize: fontSize)
                              ),
                              TextSpan(text: "\n\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "Eis aqui a escrava do Senhor." : "Ecce ancílla Dómini.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "Faça-se em Mim segundo a vossa palavra." : "Fiat mihi secúndum verbum tuum.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(
                                text: language == "pt" 
                                  ? "\n\nAve, Maria, cheia de graça, o Senhor é convosco. Bendita sois vós entre as mulheres, e bendito é o fruto do vosso ventre, Jesus. Santa Maria, Mãe de Deus, rogai por nós, pecadores, agora e na hora da nossa morte. Amem."
                                  : "\n\nAve María, gratia plena, Dominus tecum, benedicta tu in muliéribus, et benedictus fructus ventris tui Iesus. Sancta Maria, Mater Dei, ora pro nobis peccatoribus, nunc et in hora mortis nostrae. Amen.",
                                style: TextStyle(fontSize: fontSize)
                              ),
                              TextSpan(text: "\n\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "E o Verbo Divino se fez carne." : "Et Verbum caro factum est.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "E habitou entre nós." : "Et habitávit in nobis.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(
                                text: language == "pt" 
                                  ? "\n\nAve, Maria, cheia de graça, o Senhor é convosco. Bendita sois vós entre as mulheres, e bendito é o fruto do vosso ventre, Jesus. Santa Maria, Mãe de Deus, rogai por nós, pecadores, agora e na hora da nossa morte. Amem."
                                  : "\n\nAve María, gratia plena, Dominus tecum, benedicta tu in muliéribus, et benedictus fructus ventris tui Iesus. Sancta Maria, Mater Dei, ora pro nobis peccatoribus, nunc et in hora mortis nostrae. Amen.",
                                style: TextStyle(fontSize: fontSize)
                              ),
                              TextSpan(text: "\n\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "Rogai por nós, Santa Mãe de Deus." : "Ora pro nobis, sancta Dei Génetríx.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "Para que sejamos dignos das promessas de Cristo." : "Ut digni efficiámur promissionibus Christi.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: language == "pt" ? "\n\nOremos:" : "\n\nOremus:", style: TextStyle(fontSize: fontSize+2, fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: language == "pt" 
                                  ? "\nInfundi, Senhor, nós Vos pedimos, em nossas almas a vossa graça, para que nós, que conhecemos pela Anunciação do Anjo a Encarnação de Jesus Cristo, vosso Filho, cheguemos por sua Paixão e sua Cruz à glória da Ressurreição. Pelo mesmo Jesus Cristo, Senhor nosso."
                                  : "\nGrátiam tuam, quæsumus, Dómine, méntibus nostris infúnde: ut qui, Angelo nuntiánte, Christi Filii tui incarnatió- nem cognóvimus, per passiónem eius et crucem ad resurrec- tiónis glóriam perducámur. Per eumdem Christum Dóminum nostrum.",
                                style: TextStyle(fontSize: fontSize)
                              ),
                            ]
                          )
                        ),
                        Text(language == "pt" ? "\nAmém." : "\nAmen.", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      ] : [
                        const Divider(height: 15, color: Colors.transparent),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: "℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "Rainha do céu, alegrai-Vos, aleluia." : "Regína Cæli, lætáre, alleluia.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "Porque quem merecestes trazer em vosso seio, aleluia." : "Quia quem meruísti portáre, alleluia", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: "\n\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "Ressuscitou como disse, aleluia." : "Resurréxit, sicut dixit, alleluia.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: "\nR℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "Rogai a Deus por nós, aleluia." : "Ora pro nóbis Deum, alleluia.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: "\n\n℣.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "Exultai e alegrai-Vos, ó Virgem Maria, aleluia." : "Gaude et lætáre, Virgo Maria, alleluia.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                              TextSpan(text: language == "pt" ? "Porque o Senhor ressuscitou verdadeiramente, aleluia." : "Quia surréxit Dóminus vere, alleluia.", style: TextStyle(fontSize: fontSize)),
                              TextSpan(text: language == "pt" ? "\n\nOremos:" : "\n\nOremus:", style: TextStyle(fontSize: fontSize+2, fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: language == "pt" 
                                  ? "\nÓ Deus, que Vos dignastes alegrar o mundo com a Ressurreição do Vosso Filho Jesus Cristo, Senhor Nosso, concedei-nos, Vos suplicamos, que por sua Mãe, a Virgem Maria, alcancemos as alegrias da vida eterna. Por Cristo Senhor nosso."
                                  : "\nDeus, qui per resurrectiónem Filii tui Dómini nostri Jesu Christi mundum lætificáre dignátus es: præsta, quæsumus; ut, per eius Genitrícem Vírginem Mariam, perpétuæ capiámus gáudia vitæ. Per eumdem Christum, Dóminum nostrum.",
                                style: TextStyle(fontSize: fontSize)),
                            ]
                          )
                        ),
                        Text(language == "pt" ? "\nAmém." : "\nAmen.", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      ],
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
                child: FilledButton.tonal(
                  onPressed: () => toggleSelected(selected == "angelus" ? "regina" : "angelus"),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(selected == "angelus" ? "Regina Cæli" : "Ângelus", style: const TextStyle(fontSize: 16)),
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}
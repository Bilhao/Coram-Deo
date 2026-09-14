import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';

class Salmo2Page extends StatefulWidget {
  const Salmo2Page({super.key});

  @override
  State<Salmo2Page> createState() => _Salmo2PageState();
}

class _Salmo2PageState extends State<Salmo2Page> {
  static const List<Map<String, String>> _verses = [
    {
      "num": "1. ",
      "pt": "Porque se agitam em tumulto as nações e os povos intentam vãos projectos?",
      "lt": "Quare fremuérunt gentes, et pópuli meditáti sunt inánia?",
    },
    {
      "num": "2. ",
      "pt": "Revoltam-se os reis da terra e os príncipes conspiram juntos contra o Senhor e contra o Seu Ungido:",
      "lt": "Astitérunt reges terræ, et príncipes convenérunt in unum advérsus Dóminum et advérsus Christum eius:",
    },
    {
      "num": "3. ",
      "pt": "«Quebremos as Suas algemas e atiremos para longe o Seu jugo».",
      "lt": "«Dirumpámus víncula eórum et proiciámus a nobis iugum ipsórum!».",
    },
    {
      "num": "4. ",
      "pt": "Aquele que mora nos Céus sorri, o Senhor escarnece deles.",
      "lt": "Qui hábitat in cælis, irridébit eos, Dóminus subsannábit eos.",
    },
    {
      "num": "5. ",
      "pt": "Então lhes fala com ira e com a Sua cólera os atemoriza:",
      "lt": "Tunc loquétur ad eos in ira sua et in furóre suo conturbábit eos:",
    },
    {
      "num": "6. ",
      "pt": "«Fui Eu quem ungiu o meu Rei sobre Sião, minha montanha sagrada».",
      "lt": "«Ego autem constítui regem meum super Sion, montem sanctum meum!».",
    },
    {
      "num": "7. ",
      "pt": "Vou proclamar o decreto do Senhor. Ele disse-me: «Tu és meu Filho, Eu hoje te gerei.",
      "lt": "Prædicábo decrétum eius. Dóminus dixit ad me: «Fílius meus es tu; ego hódie génui te.",
    },
    {
      "num": "8. ",
      "pt": "Pede-me e te darei as nações por herança e os confins da terra para teu domínio.",
      "lt": "Póstula a me, et dabo tibi gentes hereditátem tuam et possessiónem tuam términos terræ.",
    },
    {
      "num": "9. ",
      "pt": "Hás-de governá-los com ceptro de ferro, quebrá-los como vasos de barro».",
      "lt": "Reges eos in virga férrea et tamquam vas fíguli confrínges eos».",
    },
    {
      "num": "10. ",
      "pt": "E agora, ó reis, tomai sentido, atendei, vós que julgais a terra.",
      "lt": "Et nunc, reges, intellégite, erudímini, qui iudicátis terram.",
    },
    {
      "num": "11. ",
      "pt": "Servi ao Senhor com temor, aclamai-o com respeito.",
      "lt": "Servíte Dómino in timóre et exsultáte ei cum tremóre.",
    },
    {
      "num": "12. ",
      "pt": "Reverenciai-O para que não Se irrite, e fiqueis perdidos; porque num repente se inflama a Sua ira. Felizes todos os que confiam no Senhor.",
      "lt": "Apprehéndite disciplínam, ne quando irascátur, et pereátis de via, cum exárserit in brevi ira eius. Beati omnes, qui confídunt in eo.",
    },
    {
      "num": "13. ",
      "pt": "Glória ao Pai, ao Filho e ao Espírito Santo.",
      "lt": "Glória Patri, et Fílio, et Spirítui Sancto.",
    },
    {
      "num": "14. ",
      "pt": "Como era no princípio, agora e sempre. Ámen.",
      "lt": "Sicut erat in princípio, et nunc, et semper, et in sǽcula sæculórum. Amen.",
    },
  ];

  Widget _buildAntiphon(String lang, double fontSize) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: lang == "pt" ? "Antífona: " : "Antiphona: ",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: lang == "pt"
                ? "O Seu reino é um reino eterno, e todos os reis O servirão e Lhe obedecerão."
                : "Regnum eius regnum sempitérnum est, et omnes reges sérvient ei et obœdient.",
            style: TextStyle(fontSize: fontSize),
          ),
          TextSpan(
            text: lang == "pt" ? "\n(T. P. Aleluia)." : "\n(T. P. Allelúia).",
            style: TextStyle(fontSize: fontSize, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildVersicle(String prefix, String pt, String lt, String lang, double fontSize) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$prefix  ",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          TextSpan(
            text: lang == "pt" ? pt : lt,
            style: TextStyle(fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    final bool isBilingual = fs.bilingualMode;
    final String language = fs.prayerLanguage;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Salmo 2", maxLines: 2, style: TextStyle(fontSize: 20)),
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
              children: [
                const Divider(height: 15, color: Colors.transparent),
                if (isBilingual) ...[
                  const BilingualPrayerHeader(),
                  BilingualPrayerRow(
                    latin: _buildAntiphon("lt", fs.fontSize),
                    portuguese: _buildAntiphon("pt", fs.fontSize),
                  ),
                  for (final v in _verses)
                    BilingualPrayerRow(
                      latin: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: v["num"]!,
                              style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            TextSpan(text: v["lt"]!, style: TextStyle(fontSize: fs.fontSize)),
                          ],
                        ),
                      ),
                      portuguese: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: v["num"]!,
                              style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            TextSpan(text: v["pt"]!, style: TextStyle(fontSize: fs.fontSize)),
                          ],
                        ),
                      ),
                    ),
                  BilingualPrayerRow(
                    latin: _buildAntiphon("lt", fs.fontSize),
                    portuguese: _buildAntiphon("pt", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℣.", "", "Dómine, exaudi oratiónem meam.", "lt", fs.fontSize),
                    portuguese: _buildVersicle("℣.", "Ouvi, Senhor, a minha oração.", "", "pt", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℟.", "", "Et clamor meus ad te véniat.", "lt", fs.fontSize),
                    portuguese: _buildVersicle("℟.", "E o meu clamor chegue até Vós.", "", "pt", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: Text("Sacerdotes addunt:", style: TextStyle(fontSize: fs.fontSize - 1, color: Colors.red, fontStyle: FontStyle.italic)),
                    portuguese: Text("Os sacerdotes acrescentam:", style: TextStyle(fontSize: fs.fontSize - 1, color: Colors.red, fontStyle: FontStyle.italic)),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℣.", "", "Dóminus vobíscum.", "lt", fs.fontSize),
                    portuguese: _buildVersicle("℣.", "O Senhor esteja convosco.", "", "pt", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℟.", "", "Et cum spíritu tuo.", "lt", fs.fontSize),
                    portuguese: _buildVersicle("℟.", "Ele está no meio de nós.", "", "pt", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: Text("Orémus", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                    portuguese: Text("Oremos", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                  ),
                  BilingualPrayerRow(
                    latin: Text(
                      "Omnípotens sempitérne Deus, qui in dilécto Fílio tuo, universórum Rege, ómnia instauráre voluísti: ut cunctæ famíliæ géntium, peccáti vúlnere disgregátæ, eius suavíssimo subdántur império: Qui tecum vivit et regnat in unitáte Spíritus Sancti Deus: per ómnia sǽcula sæculórum.",
                      style: TextStyle(fontSize: fs.fontSize),
                    ),
                    portuguese: Text(
                      "Ó Deus, omnipotente e eterno, que quisestes restaurar toda a criação na pessoa do Vosso amado Filho, Senhor do universo, concedei-nos, pela Vossa misericórdia, que todas as nações, divididas pela ferida do pecado, se submetam ao suave império de Cristo. Que conVosco vive e reina na unidade do Espírito Santo.",
                      style: TextStyle(fontSize: fs.fontSize),
                    ),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℟.", "", "Amen.", "lt", fs.fontSize),
                    portuguese: _buildVersicle("℟.", "Amém.", "", "pt", fs.fontSize),
                  ),
                ] else ...[
                  _buildAntiphon(language, fs.fontSize),
                  for (final v in _verses)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: v["num"]!,
                              style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            TextSpan(
                              text: language == "pt" ? v["pt"]! : v["lt"]!,
                              style: TextStyle(fontSize: fs.fontSize),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: _buildAntiphon(language, fs.fontSize),
                  ),
                  const SizedBox(height: 10),
                  _buildVersicle("℣.", "Ouvi, Senhor, a minha oração.", "Dómine, exaudi oratiónem meam.", language, fs.fontSize),
                  _buildVersicle("℟.", "E o meu clamor chegue até Vós.", "Et clamor meus ad te véniat.", language, fs.fontSize),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      language == "pt" ? "Os sacerdotes acrescentam:" : "Sacerdotes addunt:",
                      style: TextStyle(fontSize: fs.fontSize - 1, color: Colors.red, fontStyle: FontStyle.italic),
                    ),
                  ),
                  _buildVersicle("℣.", "O Senhor esteja convosco.", "Dóminus vobíscum.", language, fs.fontSize),
                  _buildVersicle("℟.", "Ele está no meio de nós.", "Et cum spíritu tuo.", language, fs.fontSize),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
                    child: Text(
                      language == "pt" ? "Oremos" : "Orémus",
                      style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    language == "pt"
                        ? "Ó Deus, omnipotente e eterno, que quisestes restaurar toda a criação na pessoa do Vosso amado Filho, Senhor do universo, concedei-nos, pela Vossa misericórdia, que todas as nações, divididas pela ferida do pecado, se submetam ao suave império de Cristo. Que conVosco vive e reina na unidade do Espírito Santo."
                        : "Omnípotens sempitérne Deus, qui in dilécto Fílio tuo, universórum Rege, ómnia instauráre voluísti: ut cunctæ famíliæ géntium, peccáti vúlnere disgregátæ, eius suavíssimo subdántur império: Qui tecum vivit et regnat in unitáte Spíritus Sancti Deus: per ómnia sǽcula sæculórum.",
                    style: TextStyle(fontSize: fs.fontSize),
                  ),
                  const SizedBox(height: 6),
                  _buildVersicle("℟.", "Amém.", "Amen.", language, fs.fontSize),
                ],
                const Divider(height: 15, color: Colors.transparent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';

class AdoroTeDevotePage extends StatefulWidget {
  const AdoroTeDevotePage({super.key});

  @override
  State<AdoroTeDevotePage> createState() => _AdoroTeDevotePageState();
}

class _AdoroTeDevotePageState extends State<AdoroTeDevotePage> {
  String language = "pt";

  static const List<Map<String, String>> _strophes = [
    {
      "num": "1. ",
      "pt": "Adoro-Te com amor, Deus escondido, que sob estas espécies és presente. Dou-Te o meu coração inteiramente, Em Tua contemplação desfalecido.",
      "lt": "Adóro te devóte, latens Déitas, quæ sub his figúris vere látitas. Tibi se cor meum totum súbiicit, quia, te contémplans, totum déficit.",
    },
    {
      "num": "2. ",
      "pt": "A vista, o tacto, o gosto, nada sabem; só no que o ouvido sabe se há-de crer. Creio em tudo o que o Filho de Deus veio dizer: Nada mais verdadeiro pode ser do que a própria Palavra da Verdade.",
      "lt": "Visus, tactus, gustus in te fállitur, sed audítu solo tuto créditur. Credo quidquid dixit Dei Fílius: nil hoc verbo veritátis vérius.",
    },
    {
      "num": "3. ",
      "pt": "Na Cruz estava oculta a Divindade; aqui também o está a humanidade. E, contudo, eu creio e o confesso, que ambas aqui estão na realidade; e o que pedia o bom ladrão, eu peço.",
      "lt": "In Cruce latébat sola Déitas; at hic latet simul et humánitas. Ambo tamen credens atque cónfitens, peto quod petívit latro pœnitens.",
    },
    {
      "num": "4. ",
      "pt": "Não vejo as chagas, como Tomé, mas confesso-Te, meu Deus e meu Senhor. Faz-me ter cada vez em Ti mais fé, uma esperança maior e mais amor.",
      "lt": "Plagas, sicut Thomas, non intúeor; Deum tamen meum te confíteor. Fac me tibi semper magis crédere, in te spem habére, te dilígere.",
    },
    {
      "num": "5. ",
      "pt": "Ó memorial da morte do Senhor! Ó vivo pão que ao homem dás a vida! Que a minha alma sempre de Ti viva! Que sempre lhe seja doce o Teu sabor!",
      "lt": "O memoriále mortis Dómini! Panis vivus vitam præstans hómini, præsta meæ menti de te vívere, et te illi semper dulce sápere.",
    },
    {
      "num": "6. ",
      "pt": "Ó doce pelicano! Ó bom Jesus! Lava-me com o Teu sangue, a mim, imundo, com esse sangue, do qual uma só gota Pode salvar do pecado todo o mundo.",
      "lt": "Pie pellicáne, Iesu Dómine, me immúndum munda tuo sánguine: cuius una stilla salvum fácere totum mundum quit ab omni scélere.",
    },
    {
      "num": "7. ",
      "pt": "Jesus, a Quem contemplo oculto agora, dá-me o que eu desejo ansiosamente: ver-Te, face a face, na Tua glória, e na glória contemplar-Te eternamente.",
      "lt": "Iesu, quem velátum nunc aspício, oro, fiat illud quod tam sítio; ut te reveláta cernens fácie, visu sim beátus tuæ glóriæ.",
    },
  ];

  void toggleLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    final bool isBilingual = fs.bilingualMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoro Te Devote", maxLines: 2, style: TextStyle(fontSize: 20)),
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 15, color: Colors.transparent),
                if (isBilingual) ...[
                  const BilingualPrayerHeader(),
                  for (final s in _strophes)
                    BilingualPrayerRow(
                      latin: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: s["num"]!,
                              style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            TextSpan(
                              text: s["lt"]!,
                              style: TextStyle(fontSize: fs.fontSize),
                            ),
                          ],
                        ),
                      ),
                      portuguese: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: s["num"]!,
                              style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            TextSpan(
                              text: s["pt"]!,
                              style: TextStyle(fontSize: fs.fontSize),
                            ),
                          ],
                        ),
                      ),
                    ),
                  BilingualPrayerRow(
                    latin: Center(
                      child: Text("Amen", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold)),
                    ),
                    portuguese: Center(
                      child: Text("Amém", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ] else ...[
                  for (int i = 0; i < _strophes.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: _strophes[i]["num"]!,
                              style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            TextSpan(
                              text: language == "pt" ? _strophes[i]["pt"]! : _strophes[i]["lt"]!,
                              style: TextStyle(fontSize: fs.fontSize),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      language == "pt" ? "Amém" : "Amen",
                      style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold),
                    ),
                  ),
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

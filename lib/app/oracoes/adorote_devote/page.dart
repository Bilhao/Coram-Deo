import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/fontsize_provider.dart';

class AdoroTeDevotePage extends StatefulWidget {
  const AdoroTeDevotePage({super.key});

  @override
  State<AdoroTeDevotePage> createState() => _AdoroTeDevotePageState();
}

class _AdoroTeDevotePageState extends State<AdoroTeDevotePage> {
  String language = "pt";

  void toggleLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    FontSizeProvider fs = Provider.of<FontSizeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoro Te Devote"),
        actions: [
          IconButton(onPressed: () => toggleLanguage(language == "pt" ? "lt" : "pt"), icon: Text(language == "pt" ? "lt".toUpperCase() : "pt".toUpperCase()), tooltip: language == "pt" ? "Mudar para Latim" : "Mudar para Português"),
          IconButton(onPressed: fs.decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: fs.increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Divider(height: 15, color: Colors.transparent),
                Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: "1. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                        TextSpan(
                            text: language == "pt"
                                ? "Adoro-Te com amor, Deus escondido, que sob estas espécies és presente. Dou-Te o meu coração inteiramente, Em Tua contemplação desfalecido."
                                : "Adóro te devóte, latens Déitas, quæ sub his figúris vere látitas. Tibi se cor meum totum súbiicit, quia, te contémplans, totum déficit.",
                            style: TextStyle(fontSize: fs.fontSize))
                      ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n2. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "A vista, o tacto, o gosto, nada sabem; só no que o ouvido sabe se há-de crer. Creio em tudo o que o Filho de Deus veio dizer: Nada mais verdadeiro pode ser do que a própria Palavra da Verdade."
                              : "Visus, tactus, gustus in te fállitur, sed audítu solo tuto créditur. Credo quidquid dixit Dei Fílius: nil hoc verbo veritátis vérius.",
                          style: TextStyle(fontSize: fs.fontSize))
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n3. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Na Cruz estava oculta a Divindade; aqui também o está a humanidade. E, contudo, eu creio e o confesso, que ambas aqui estão na realidade; e o que pedia o bom ladrão, eu peço."
                              : "In Cruce latébat sola Déitas; at hic latet simul et humánitas. Ambo tamen credens atque cónfitens, peto quod petívit latro pœnitens.",
                          style: TextStyle(fontSize: fs.fontSize))
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n4. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Não vejo as chagas, como Tomé, mas confesso-Te, meu Deus e meu Senhor. Faz-me ter cada vez em Ti mais fé, uma esperança maior e mais amor."
                              : "Plagas, sicut Thomas, non intúeor; Deum tamen meum te confíteor. Fac me tibi semper magis crédere, in te spem habére, te dilígere.",
                          style: TextStyle(fontSize: fs.fontSize))
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n5. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Ó memorial da morte do Senhor! Ó vivo pão que ao homem dás a vida! Que a minha alma sempre de Ti viva! Que sempre lhe seja doce o Teu sabor!"
                              : "O memoriále mortis Dómini! Panis vivus vitam præstans hómini, præsta meæ menti de te vívere, et te illi semper dulce sápere.",
                          style: TextStyle(fontSize: fs.fontSize))
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n6. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Ó doce pelicano! Ó bom Jesus! Lava-me com o Teu sangue, a mim, imundo, com esse sangue, do qual uma só gota Pode salvar do pecado todo o mundo."
                              : "Pie pellicáne, Iesu Dómine, me immúndum munda tuo sánguine: cuius una stilla salvum fácere totum mundum quit ab omni scélere.",
                          style: TextStyle(fontSize: fs.fontSize))
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "\n7. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Jesus, a Quem contemplo oculto agora, dá-me o que eu desejo ansiosamente: ver-Te, face a face, na Tua glória, e na glória contemplar-Te eternamente."
                              : "Iesu, quem velátum nunc aspício, oro, fiat illud quod tam sítio; ut te reveláta cernens fácie, visu sim beátus tuæ glóriæ.",
                          style: TextStyle(fontSize: fs.fontSize))
                    ],
                  ),
                ),
                Align(alignment: Alignment.center, child: Text(language == "pt" ? "\nAmém" : "\nAmen", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold))),
                const Divider(height: 15, color: Colors.transparent),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

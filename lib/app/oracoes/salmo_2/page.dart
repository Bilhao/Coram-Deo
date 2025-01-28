import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/fontsize_provider.dart';

class Salmo2Page extends StatefulWidget {
  const Salmo2Page({super.key});

  @override
  State<Salmo2Page> createState() => _Salmo2PageState();
}

class _Salmo2PageState extends State<Salmo2Page> {
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
        title: const Text("Salmo 2"),
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
                  TextSpan(children: [
                    TextSpan(text: language == "pt" ? "Antífona: " : "Antiphona: ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: language == "pt"
                            ? "O Seu reino é um reino eterno, e todos os reis O servirão e Lhe obedecerão."
                            : "Regnum eius regnum sempitérnum est, et omnes reges sérvient ei et obœdient.",
                        style: TextStyle(fontSize: fs.fontSize)
                    ),
                    TextSpan(
                        text: language == "pt"
                            ? "\n(T. P. Aleluia)."
                            : "\n(T. P. Allelúia).",
                        style: TextStyle(fontSize: fs.fontSize, color: Colors.red)
                    ),
                  ])
                ),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(text: "\n1. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                    TextSpan(
                        text: language == "pt"
                            ? "Porque se agitam em tumulto as nações e os povos intentam vãos projectos?"
                            : "Quare fremuérunt gentes, et pópuli meditáti sunt inánia?",
                        style: TextStyle(fontSize: fs.fontSize)
                    ),
                  ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n2. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Revoltam-se os reis da terra e os príncipes conspiram juntos contra o Senhor e contra o Seu Ungido:"
                              : "Astitérunt reges terræ, et príncipes convenérunt in unum advérsus Dóminum et advérsus Christum eius:",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n3. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "«Quebremos as Suas algemas e atiremos para longe o Seu jugo»."
                              : "«Dirumpámus víncula eórum et proiciámus a nobis iugum ipsórum!».",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n4. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Aquele que mora nos Céus sorri, o Senhor escarnece deles."
                              : "Qui hábitat in cælis, irridébit eos, Dóminus subsannábit eos.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n5. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Então lhes fala com ira e com a Sua cólera os atemoriza:"
                              : "Tunc loquétur ad eos in ira sua et in furóre suo conturbábit eos:",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n6. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "«Fui Eu quem ungiu o meu Rei sobre Sião, minha montanha sagrada»."
                              : "«Ego autem constítui regem meum super Sion, montem sanctum meum!».",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n7. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Vou proclamar o decreto do Senhor. Ele disse-me: «Tu és meu Filho, Eu hoje te gerei."
                              : "Prædicábo decrétum eius. Dóminus dixit ad me: «Fílius meus es tu; ego hódie génui te.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n8. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Pede-me e te darei as nações por herança e os confins da terra para teu domínio."
                              : "Póstula a me, et dabo tibi gentes hereditátem tuam et possessiónem tuam términos terræ.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n9. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Hás-de governá-los com ceptro de ferro, quebrá-los como vasos de barro»."
                              : "Reges eos in virga férrea et tamquam vas fíguli confrínges eos».",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n10. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "E agora, ó reis, tomai sentido, atendei, vós que julgais a terra."
                              : "Et nunc, reges, intellégite, erudímini, qui iudicátis terram.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n11. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Servi ao Senhor com temor, aclamai-o com respeito."
                              : "Servíte Dómino in timóre et exsultáte ei cum tremóre.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n12. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Reverenciai-O para que não Se irrite, e fiqueis perdidos; porque num repente se inflama a Sua ira. Felizes todos os que confiam no Senhor."
                              : "Apprehéndite disciplínam, ne quando irascátur, et pereátis de via, cum exárserit in brevi ira eius. Beati omnes, qui confídunt in eo.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n13. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Glória ao Pai, ao Filho e ao Espírito Santo."
                              : "Glória Patri, et Fílio, et Spirítui Sancto.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n14. ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Como era no princípio, agora e sempre. Ámen."
                              : "Sicut erat in princípio, et nunc, et semper, et in sǽcula sæculórum. Amen.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: language == "pt" ? "\nAntífona: " : "\nAntiphona: ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: language == "pt"
                              ? "O Seu reino é um reino eterno, e todos os reis O servirão e Lhe obedecerão."
                              : "Regnum eius regnum sempitérnum est, et omnes reges sérvient ei et obœdient.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                      TextSpan(
                          text: language == "pt"
                              ? "\n(T. P. Aleluia)."
                              : "\n(T. P. Allelúia).",
                          style: TextStyle(fontSize: fs.fontSize, color: Colors.red)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Ouvi, Senhor, a minha oração."
                              : "Dómine, exaudi oratiónem meam.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "E o meu clamor chegue até Vós."
                              : "Et clamor meus ad te véniat.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text(language == "pt" ? "\nOs sacerdotes acrescentam:" : "\nSacerdotes addunt:", style: TextStyle(fontSize: fs.fontSize - 1, color: Colors.red, fontStyle: FontStyle.italic)),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "O Senhor esteja convosco."
                              : "Dóminus vobíscum.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "℟.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Ele está no meio de nós."
                              : "Et cum spíritu tuo.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                Text(language == "pt" ? "\nOremos\n" : "\nOrémus\n", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                Text(
                  language == "pt"
                      ? "Ó Deus, omnipotente e eterno, que quisestes restaurar toda a criação na pessoa do Vosso amado Filho, Senhor do universo, concedei-nos, pela Vossa misericórdia, que todas as nações, divididas pela ferida do pecado, se submetam ao suave império de Cristo. Que conVosco vive e reina na unidade do Espírito Santo."
                      : "Omnípotens sempitérne Deus, qui in dilécto Fílio tuo, universórum Rege, ómnia instauráre voluísti: ut cunctæ famíliæ géntium, peccáti vúlnere disgregátæ, eius suavíssimo subdántur império: Qui tecum vivit et regnat in unitáte Spíritus Sancti Deus: per ómnia sǽcula sæculórum.",
                  style: TextStyle(fontSize: fs.fontSize),
                ),
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(
                          text: language == "pt"
                              ? "Amém."
                              : "Amen.",
                          style: TextStyle(fontSize: fs.fontSize)
                      ),
                    ])
                ),
                const Divider(height: 15, color: Colors.transparent),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

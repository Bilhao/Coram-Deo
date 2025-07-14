import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';

class GratiasTibiAgoPage extends StatefulWidget {
  const GratiasTibiAgoPage({super.key});

  @override
  State<GratiasTibiAgoPage> createState() => _GratiasTibiAgoPageState();
}

class _GratiasTibiAgoPageState extends State<GratiasTibiAgoPage> {
  String language = "pt";

  void toggleLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gratias tibi ago"),
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
                Text(
                    language == "pt"
                        ? "Dou-Vos graças, Senhor santo, Pai onipotente, Deus, a Vós que, sem merecimento algum de minha parte, mas por efeito da vossa misericórdia, Vos dignastes saciar-me, sendo eu pecador e vosso indigno servo, com o Corpo adorável e com o Sangue precioso do vosso Filho, Nosso Senhor Jesus Cristo."
                        : "GRATIAS tibi ago, Domine, sancte Pater, omnipotens æterne Deus,qui me peccatorem, indignum famulum tuum, nullis meis meritis, sed sola dignatione misericordiæ tuæ satiare dignatus es pretioso Corpore et Sanguine Filii tui, Domini nostri Iesu Christi.",
                    style: TextStyle(fontSize: fs.fontSize)),
                Text(
                    language == "pt"
                        ? "\nEu vos peço que esta comunhão não me seja imputada como uma falta digna de castigo, mas interceda eficazmente para alcançar o meu perdão; seja a armadura da minha fé e o escudo da minha boa vontade; livre-me dos meus vícios; apague os meus maus desejos; mortifique a minha concupiscência; aumente em mim a caridade e a paciência, a humildade, a obediência e todas as virtudes; sirva-me de firme defesa contra os embustes de todos os meus inimigos, tanto visíveis como invisíveis; serene e regule perfeitamente os movimentos, tanto da minha carne como do meu espírito; una-me firmemente a Vós, que sois o único e verdadeiro Deus; e seja enfim a feliz consumação do meu destino."
                        : "\nEt precor, ut hæc sancta communio non sit mihi reatus ad pœnam, sed intercessio salutaris ad veniam. Sit mihi armatura fidei et scutum bonæ voluntatis. Sit vitiorum meorum evacuatio, concupiscentiæ et libidinis exterminatio, caritatis et patientiæ, humilitatis et obœdientiæ omniumque virtutum augmentatio: contra insidias inimicorum omnium, tam visibilium quam invisibilium firma defensio; motuum meorum, tam carnalium quam spiritualium, perfecta quietatio: in te uno ac vero Deo firma adhæsio; atque finis mei felix consummatio.",
                    style: TextStyle(fontSize: fs.fontSize)),
                Text(
                    language == "pt"
                        ? "\nDignai-Vos, Senhor, eu Vos suplico, conduzir-me, a mim, pecador, a esse inefável banquete onde, com o vosso Filho e o Espírito Santo, sois para os vossos santos luz verdadeira, gozo pleno e alegria eterna, cúmulo de delícias e felicidade perfeita. Pelo mesmo Jesus Cristo, Senhor Nosso."
                        : "\nEt precor te, ut ad illud ineffabile convivium me peccatorem perducere digneris, ubi tu, cum Filio tuo et Spiritu Sancto, Sanctis tuis es lux vera, satietas plena, gaudium sempiternum, iucunditas consummata et felicitas perfecta. Per eundem Christum Dominum nostrum.",
                    style: TextStyle(fontSize: fs.fontSize)),
                Align(
                  alignment: Alignment.center,
                  child: Text(language == "pt" ? "\nAmém." : "\nAmen.", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

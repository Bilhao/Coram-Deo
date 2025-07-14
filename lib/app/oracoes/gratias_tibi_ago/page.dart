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
                        ? "Dou-Vos graças,\nSenhor santo, Pai onipotente,\nDeus, a Vós que, sem merecimento algum de minha parte,\nmas por efeito da vossa misericórdia,\nVos dignastes saciar-me,\nsendo eu pecador e vosso indigno servo,\ncom o Corpo adorável e com o Sangue precioso do vosso Filho,\nNosso Senhor Jesus Cristo."
                        : "GRATIAS tibi ago,\nDomine, sancte Pater, omnipotens æterne Deus,\nqui me peccatorem, indignum famulum tuum,\nnullis meis meritis,\nsed sola dignatione misericordiæ tuæ\nsatiare dignatus es\npretioso Corpore et Sanguine Filii tui,\nDomini nostri Iesu Christi.",
                    style: TextStyle(fontSize: fs.fontSize)),
                Text(
                    language == "pt"
                        ? "\nEu vos peço que esta comunhão\nnão me seja imputada como uma falta digna de castigo,\nmas interceda eficazmente para alcançar o meu perdão;\nseja a armadura da minha fé\ne o escudo da minha boa vontade;\nlivre-me dos meus vícios;\napague os meus maus desejos;\nmortifique a minha concupiscência;\naumente em mim a caridade e a paciência, a humildade, a obediência e todas as virtudes;\nsirva-me de firme defesa contra os embustes de todos os meus inimigos,\ntanto visíveis como invisíveis;\nserene e regule perfeitamente os movimentos,\ntanto da minha carne como do meu espírito;\nuna-me firmemente a Vós, que sois o único e verdadeiro Deus;\ne seja enfim a feliz consumação do meu destino."
                        : "\nEt precor,\nut hæc sancta communio\nnon sit mihi reatus ad pœnam,\nsed intercessio salutaris ad veniam.\nSit mihi armatura fidei\net scutum bonæ voluntatis.\nSit vitiorum meorum evacuatio,\nconcupiscentiæ et libidinis exterminatio,\ncaritatis et patientiæ,\nhumilitatis et obœdientiæ\nomniumque virtutum augmentatio:\ncontra insidias inimicorum omnium,\ntam visibilium quam invisibilium\nfirma defensio;\nmotuum meorum,\ntam carnalium quam spiritualium,\nperfecta quietatio:\nin te uno ac vero Deo firma adhæsio;\natque finis mei felix consummatio.",
                    style: TextStyle(fontSize: fs.fontSize)),
                Text(
                    language == "pt"
                        ? "\nDignai-Vos, Senhor, eu Vos suplico, conduzir-me, a mim, pecador,\na esse inefável banquete onde,\ncom o vosso Filho e o Espírito Santo,\nsois para os vossos santos luz verdadeira,\ngozo pleno e alegria eterna,\ncúmulo de delícias e felicidade perfeita.\nPelo mesmo Jesus Cristo, Senhor Nosso."
                        : "\nEt precor te,\nut ad illud ineffabile convivium\nme peccatorem perducere digneris,\nubi tu, cum Filio tuo et Spiritu Sancto,\nSanctis tuis es lux vera,\nsatietas plena,\ngaudium sempiternum,\niucunditas consummata\net felicitas perfecta.\nPer eundem Christum Dominum nostrum.",
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
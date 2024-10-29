import 'package:flutter/material.dart';

class CredoPage extends StatefulWidget {
  const CredoPage({super.key});

  @override
  State<CredoPage> createState() => _CredoPageState();
}

class _CredoPageState extends State<CredoPage> {
  double fontSize = 18.0;
  String language = "pt";

  void decreaseFontSize() {
    setState(() {
      fontSize--;
    });
  }

  void increaseFontSize() {
    setState(() {
      fontSize++;
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
        title: const Text("Credo Niceno-Constantinopolitano"),
        actions: [
          IconButton(onPressed: () => toggleLanguage(language == "pt" ? "lt" : "pt"), icon: Text(language == "pt" ? "lt".toUpperCase() : "pt".toUpperCase()), tooltip: language == "pt" ? "Mudar para Latim" : "Mudar para Português"),
          IconButton(onPressed: decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: increaseFontSize, icon: const Icon(Icons.add)),
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
                        ? "Creio em um só Deus, Pai todo-poderoso, Criador do Céu e da Terra, de todas as coisas visíveis e invisíveis."
                        : "Credo in unum Deum, Patrem omni­po­téntem, factórem cæli et terræ, visibílium ómnium et in­vi­si­bílium.",
                    style: TextStyle(fontSize: fontSize)),
                Text(
                    language == "pt"
                        ? "\nCreio em um só Senhor, Jesus Cristo, Filho Unigénito de Deus, nascido do Pai antes de todos os séculos: Deus de Deus, luz da luz, Deus verdadeiro de Deus verdadeiro; gerado, não criado, consubstancial ao Pai. Por Ele todas as coisas foram feitas. E por nós, homens, e para nossa salvação desceu dos Céus. e se encarnou pelo Espírito Santo, no seio da Virgem Maria, e se fez homem. Também por nós foi crucificado sob Pôncio Pilatos; padeceu e foi sepultado. Ressuscitou ao terceiro dia, conforme as Escrituras; e subiu aos Céus, onde está sentado à direita do Pai. E de novo há de vir, em sua glória, para julgar os vivos e os mortos; e o seu reino não terá fim."
                        : "\nEt in unum Dóminum Iesum Christum, Fílium Dei unigénitum et ex Patre natum ante ómnia sǽcula: Deum de Deo, Lumen de Lúmine, Deum verum de Deo vero, génitum, non factum, con­subs­tantiálem Patri: per quem ómnia facta sunt; qui propter nos hómines et propter nostram salútem, descéndit de cælis, et incarnátus est de Spíritu Sancto ex Maria Vírgine et homo factus est, crucifíxus etiam pro nobis sub Póntio Piláto, passus et sepúltus est, et resurréxit tértia die secúndum Scriptúras, et ascéndit in cælum, sedet ad déxteram Patris. Et íterum ventúrus est cum glória, Iudicáre vivos et mórtuos, Cuius regni non erit finis.",
                    style: TextStyle(fontSize: fontSize)),
                Text(
                    language == "pt"
                        ? "\nCreio no Espírito Santo, Senhor que dá a vida, e procede do Pai e do Filho; e com o Pai e o Filho é adorado e glorificado: Ele que falou pelos profetas."
                        : "\nEt in Spíritum Sanctum, Dóminum et vi­vi­fi­cántem, qui ex Patre Filióque procédit, qui cum Patre et Fílio simul adorátur et con­glo­ri­ficátur, qui locútus est per Prophétas.",
                    style: TextStyle(fontSize: fontSize)),
                Text(
                    language == "pt"
                        ? "\nCreio na Igreja una, santa, católica e apostólica. Professo um só Baptismo para remissão dos pecados. E espero a ressurreição dos mortos, e a vida do mundo que há de vir."
                        : "\nEt unam sanctam cathólicam et apos­tó­li­cam Ecclésiam. Confíteor unum Baptísma in re­mi­ssiónem peccatórum. Et exspécto re­su­rrec­tiónem mortuórum, et vitam ventúri sǽculi.",
                    style: TextStyle(fontSize: fontSize)),
                Align(
                  alignment: Alignment.center,
                  child: Text(language == "pt" ? "\nAmém." : "\nAmen.", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';

class CredoPage extends StatefulWidget {
  const CredoPage({super.key});

  @override
  State<CredoPage> createState() => _CredoPageState();
}

class _CredoPageState extends State<CredoPage> {
  String language = "pt";

  static const List<Map<String, String>> _articles = [
    {
      "pt": "Creio em um só Deus, Pai todo-poderoso, Criador do Céu e da Terra, de todas as coisas visíveis e invisíveis.",
      "lt": "Credo in unum Deum, Patrem omni­po­téntem, factórem cæli et terræ, visibílium ómnium et in­vi­si­bílium.",
    },
    {
      "pt": "Creio em um só Senhor, Jesus Cristo, Filho Unigénito de Deus, nascido do Pai antes de todos os séculos: Deus de Deus, luz da luz, Deus verdadeiro de Deus verdadeiro; gerado, não criado, consubstancial ao Pai. Por Ele todas as coisas foram feitas. E por nós, homens, e para nossa salvação desceu dos Céus. e se encarnou pelo Espírito Santo, no seio da Virgem Maria, e se fez homem. Também por nós foi crucificado sob Pôncio Pilatos; padeceu e foi sepultado. Ressuscitou ao terceiro dia, conforme as Escrituras; e subiu aos Céus, onde está sentado à direita do Pai. E de novo há de vir, em sua glória, para julgar os vivos e os mortos; e o seu reino não terá fim.",
      "lt": "Et in unum Dóminum Iesum Christum, Fílium Dei unigénitum et ex Patre natum ante ómnia sǽcula: Deum de Deo, Lumen de Lúmine, Deum verum de Deo vero, génitum, non factum, con­subs­tantiálem Patri: per quem ómnia facta sunt; qui propter nos hómines et propter nostram salútem, descéndit de cælis, et incarnátus est de Spíritu Sancto ex Maria Vírgine et homo factus est, crucifíxus etiam pro nobis sub Póntio Piláto, passus et sepúltus est, et resurréxit tértia die secúndum Scriptúras, et ascéndit in cælum, sedet ad déxteram Patris. Et íterum ventúrus est cum glória, Iudicáre vivos et mórtuos, Cuius regni non erit finis.",
    },
    {
      "pt": "Creio no Espírito Santo, Senhor que dá a vida, e procede do Pai e do Filho; e com o Pai e o Filho é adorado e glorificado: Ele que falou pelos profetas.",
      "lt": "Et in Spíritum Sanctum, Dóminum et vi­vi­fi­cántem, qui ex Patre Filióque procédit, qui cum Patre et Fílio simul adorátur et con­glo­ri­ficátur, qui locútus est per Prophétas.",
    },
    {
      "pt": "Creio na Igreja una, santa, católica e apostólica. Professo um só Baptismo para remissão dos pecados. E espero a ressurreição dos mortos, e a vida do mundo que há de vir.",
      "lt": "Et unam sanctam cathólicam et apos­tó­li­cam Ecclésiam. Confíteor unum Baptísma in re­mi­ssiónem peccatórum. Et exspécto re­su­rrec­tiónem mortuórum, et vitam ventúri sǽculi.",
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
        title: const Text("Credo Niceno-Constantinopolitano", maxLines: 2, style: TextStyle(fontSize: 20)),
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
                  for (final art in _articles)
                    BilingualPrayerRow(
                      latin: Text(art["lt"]!, style: TextStyle(fontSize: fs.fontSize)),
                      portuguese: Text(art["pt"]!, style: TextStyle(fontSize: fs.fontSize)),
                    ),
                  BilingualPrayerRow(
                    latin: Center(
                      child: Text("Amen.", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold)),
                    ),
                    portuguese: Center(
                      child: Text("Amém.", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ] else ...[
                  for (final art in _articles)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        language == "pt" ? art["pt"]! : art["lt"]!,
                        style: TextStyle(fontSize: fs.fontSize),
                      ),
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      language == "pt" ? "Amém." : "Amen.",
                      style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

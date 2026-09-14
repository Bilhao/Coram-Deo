import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';

class LembraiVosPage extends StatefulWidget {
  const LembraiVosPage({super.key});

  @override
  State<LembraiVosPage> createState() => _LembraiVosPageState();
}

class _LembraiVosPageState extends State<LembraiVosPage> {
  static const List<Map<String, String>> _paragraphs = [
    {
      "pt": "Lembrai-vos, ó piíssima Virgem Maria, de que nunca se ouviu dizer que algum daqueles que têm recorrido à Vossa protecção, implorado a Vossa assistência e reclamado o Vosso socorro, fosse por Vós desamparado.",
      "lt": "Memoráre, o piíssima Virgo Maria, non esse audítum a sǽculo, quemquam ad tua curréntem præsídia, tua implorántem auxilia, tua peténtem suffrágia, esse derelíctum.",
    },
    {
      "pt": "Animado eu, pois, de igual confiança, a Vós, Virgem entre todas singular, como a Mãe recorro, de Vós me valho, e, gemendo sob o peso dos meus pecados, me prostro a Vossos pés. Não desprezeis as minhas súplicas, ó Mãe do Filho de Deus humanado, mas dignai-Vos de as ouvir propícia e de me alcançar o que Vos rogo.",
      "lt": "Ego tali animátus confidéntia, ad te, Virgo Vírginum, Mater, curro, ad te vénio, coram te gemens peccátor assísto. Noli, Mater Verbi, verba mea despícere; sed áudi propítia et exáudi.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    final bool isBilingual = fs.bilingualMode;
    final String language = fs.prayerLanguage;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isBilingual
              ? "Lembrai-Vos / Memoráre"
              : (language == "pt" ? "Lembrai-Vos" : "Memoráre"),
          maxLines: 2,
          style: const TextStyle(fontSize: 20),
        ),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    frameBuilder: (BuildContext context, Widget child, int? frame, bool? wasSynchronouslyLoaded) {
                      return child;
                    },
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    image: const AssetImage("assets/images/oracoes/lembraivos.jpg"),
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
                const Divider(height: 15, color: Colors.transparent),
                if (isBilingual) ...[
                  const BilingualPrayerHeader(),
                  for (final p in _paragraphs)
                    BilingualPrayerRow(
                      latin: Text(p["lt"]!, style: TextStyle(fontSize: fs.fontSize)),
                      portuguese: Text(p["pt"]!, style: TextStyle(fontSize: fs.fontSize)),
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
                  for (final p in _paragraphs)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        language == "pt" ? p["pt"]! : p["lt"]!,
                        style: TextStyle(fontSize: fs.fontSize),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

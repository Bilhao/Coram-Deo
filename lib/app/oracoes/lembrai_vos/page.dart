import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';

class LembraiVosPage extends StatefulWidget {
  const LembraiVosPage({super.key});

  @override
  State<LembraiVosPage> createState() => _LembraiVosPageState();
}

class _LembraiVosPageState extends State<LembraiVosPage> {
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
        title: Text(language == "pt" ? "Lembrai-Vos" : "Memoráre"),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 15, color: Colors.transparent),
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
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                      image: AssetImage("assets/images/oracoes/lembraivos.jpg"),
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Divider(height: 15, color: Colors.transparent),
                  Text(
                      language == "pt"
                          ? "Lembrai-vos, ó piíssima Virgem Maria, de que nunca se ouviu dizer que algum daqueles que têm recorrido à Vossa protecção, implorado a Vossa assistência e reclamado o Vosso socorro, fosse por Vós desamparado."
                          : "Memoráre, o piíssima Virgo Maria, non esse audítum a sǽculo, quemquam ad tua curréntem præsídia, tua implorántem auxilia, tua peténtem suffrágia, esse derelíctum.",
                      style: TextStyle(fontSize: fs.fontSize)),
                  Text(
                      language == "pt"
                          ? "\nAnimado eu, pois, de igual confiança, a Vós, Virgem entre todas singular, como a Mãe recorro, de Vós me valho, e, gemendo sob o peso dos meus pecados, me prostro a Vossos pés. Não desprezeis as minhas súplicas, ó Mãe do Filho de Deus humanado, mas dignai-Vos de as ouvir propícia e de me alcançar o que Vos rogo."
                          : "\nEgo tali animátus confidéntia, ad te, Virgo Vírginum, Mater, curro, ad te vénio, coram te gemens peccátor assísto. Noli, Mater Verbi, verba mea despícere; sed áudi propítia et exáudi.",
                      style: TextStyle(fontSize: fs.fontSize)),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      language == "pt" ? "\nAmém" : "\nAmen",
                      style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}

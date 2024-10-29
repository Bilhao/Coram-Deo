import 'package:flutter/material.dart';

class SantoRosarioPage extends StatefulWidget {
  const SantoRosarioPage({super.key});

  @override
  State<SantoRosarioPage> createState() => _SantoRosarioPageState();
}

class _SantoRosarioPageState extends State<SantoRosarioPage> {
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
        title: const Text("Santo Rosário"),
        actions: [
          IconButton(onPressed: () => toggleLanguage(language == "pt" ? "lt" : "pt"), icon: Text(language == "pt" ? "lt".toUpperCase() : "pt".toUpperCase()), tooltip: language == "pt" ? "Mudar para Latim" : "Mudar para Português"),
          IconButton(onPressed: decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: const SafeArea(
        child: SelectionArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(children: []),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class VisitaAoSantissimoPage extends StatefulWidget {
  const VisitaAoSantissimoPage({super.key});

  @override
  State<VisitaAoSantissimoPage> createState() => _VisitaAoSantissimoPageState();
}

class _VisitaAoSantissimoPageState extends State<VisitaAoSantissimoPage> {
  double fontSize = 18.0;

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

  Widget _prayline(String prefix, String text) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$prefix  ",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          TextSpan(
            text: text,
            style: TextStyle(fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visita ao Santíssimo"),
        actions: [
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
                for (int i = 0; i < 3; i++) ...[
                  _prayline("℣.", "Graças e louvores sejam dadas a todo o momento,"),
                  _prayline("℟.", "ao Santíssimo e diviníssimo Sacramento."),
                  Text("\nPai nosso, Ave Maria e Glória\n", style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
                ],
                _prayline("℣.", "Graças e louvores sejam dadas a todo o momento,"),
                _prayline("℟.", "ao Santíssimo e diviníssimo Sacramento."),
                Text("\nComunhão espiritual", style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.bold)),
                Text("\nEu quisera, Senhor, receber-Vos com aquela pureza, humildade e devoção com que Vos recebeu a Vossa Santíssima Mãe, com o espírito e o fervor dos Santos.", style: TextStyle(fontSize: fontSize))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

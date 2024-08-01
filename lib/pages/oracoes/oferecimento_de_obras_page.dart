import 'package:flutter/material.dart';

class OferecimentoDeObrasPage extends StatefulWidget {
  const OferecimentoDeObrasPage({super.key});

  @override
  State<OferecimentoDeObrasPage> createState() => _OferecimentoDeObrasPageState();
}

class _OferecimentoDeObrasPageState extends State<OferecimentoDeObrasPage> {
  double fontSize = 18.0;

  void decreaseFontSize() {
    setState(() {
      fontSize --;
    });
  }

  void increaseFontSize() {
    setState(() {
      fontSize ++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oferecimento de obras"),
        actions: [
          IconButton(onPressed: decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                const Divider(height: 15, color: Colors.transparent),
                Text("Eu Vos adoro, meu Deus, e Vos amo de todo o coração.", style: TextStyle(fontSize: fontSize)),
                Text("\nDou-Vos graças por me terdes criado, feito cristão pelo santo Batismo e me conservado nesta noite.", style: TextStyle(fontSize: fontSize)),
                Text("\nOfereço-Vos as ações deste dia; fazei que sejam todas segundo a Vossa santa vontade, para maior glória Vossa.", style: TextStyle(fontSize: fontSize)),
                Text("\nPreservai-me do pecado e de todo o mal.", style: TextStyle(fontSize: fontSize)),
                Text("\nA Vossa graça esteja sempre comigo e com todos os que me são queridos.", style: TextStyle(fontSize: fontSize)),
                Text("\nAmém", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
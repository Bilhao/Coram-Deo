import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/fontsize_provider.dart';

class OferecimentoDeObrasPage extends StatefulWidget {
  const OferecimentoDeObrasPage({super.key});

  @override
  State<OferecimentoDeObrasPage> createState() => _OferecimentoDeObrasPageState();
}

class _OferecimentoDeObrasPageState extends State<OferecimentoDeObrasPage> {
  @override
  Widget build(BuildContext context) {
    FontSizeProvider fs = Provider.of<FontSizeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oferecimento de obras"),
        actions: [
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
                Text("Eu Vos adoro, meu Deus, e Vos amo de todo o coração.", style: TextStyle(fontSize: fs.fontSize)),
                Text("\nDou-Vos graças por me terdes criado, feito cristão pelo santo Batismo e me conservado nesta noite.", style: TextStyle(fontSize: fs.fontSize)),
                Text("\nOfereço-Vos as ações deste dia; fazei que sejam todas segundo a Vossa santa vontade, para maior glória Vossa.", style: TextStyle(fontSize: fs.fontSize)),
                Text("\nPreservai-me do pecado e de todo o mal.", style: TextStyle(fontSize: fs.fontSize)),
                Text("\nA Vossa graça esteja sempre comigo e com todos os que me são queridos.", style: TextStyle(fontSize: fs.fontSize)),
                Align(alignment: Alignment.center, child: Text("\nAmém", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold))),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';

class OferecimentoDeObrasPage extends StatefulWidget {
  const OferecimentoDeObrasPage({super.key});

  @override
  State<OferecimentoDeObrasPage> createState() => _OferecimentoDeObrasPageState();
}

class _OferecimentoDeObrasPageState extends State<OferecimentoDeObrasPage> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oferecimento de obras"),
        actions: [
          IconButton(onPressed: appProvider.decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: appProvider.increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Divider(height: 15, color: Colors.transparent),
                Text("Eu Vos adoro, meu Deus, e Vos amo de todo o coração.", style: TextStyle(fontSize: appProvider.fontSize)),
                Text("\nDou-Vos graças por me terdes criado, feito cristão pelo santo Batismo e me conservado nesta noite.", style: TextStyle(fontSize: appProvider.fontSize)),
                Text("\nOfereço-Vos as ações deste dia; fazei que sejam todas segundo a Vossa santa vontade, para maior glória Vossa.", style: TextStyle(fontSize: appProvider.fontSize)),
                Text("\nPreservai-me do pecado e de todo o mal.", style: TextStyle(fontSize: appProvider.fontSize)),
                Text("\nA Vossa graça esteja sempre comigo e com todos os que me são queridos.", style: TextStyle(fontSize: appProvider.fontSize)),
                Align(alignment: Alignment.center, child: Text("\nAmém", style: TextStyle(fontSize: appProvider.fontSize, fontWeight: FontWeight.bold))),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

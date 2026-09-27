import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';

class VisitaAoSantissimoPage extends StatefulWidget {
  const VisitaAoSantissimoPage({super.key});

  @override
  State<VisitaAoSantissimoPage> createState() => _VisitaAoSantissimoPageState();
}

class _VisitaAoSantissimoPageState extends State<VisitaAoSantissimoPage> {
  Widget _prayline(String prefix, String text) {
    AppProvider fs = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "$prefix  ",
              style: TextStyle(
                fontSize: fs.fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            TextSpan(
              text: text,
              style: TextStyle(fontSize: fs.fontSize),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Visita ao Santíssimo",
          maxLines: 2,
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: fs.decreaseFontSize,
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: fs.increaseFontSize,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20,
              left: 15,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < 3; i++) ...[
                  _prayline(
                    "℣.",
                    "Graças e louvores sejam dadas a todo o momento,",
                  ),
                  _prayline("℟.", "ao Santíssimo e diviníssimo Sacramento."),
                  const Divider(height: 15, color: Colors.transparent),
                  Text(
                    "Pai nosso, Ave Maria e Glória",
                    style: TextStyle(
                      fontSize: fs.fontSize,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Divider(height: 15, color: Colors.transparent),
                ],
                _prayline(
                  "℣.",
                  "Graças e louvores sejam dadas a todo o momento,",
                ),
                _prayline("℟.", "ao Santíssimo e diviníssimo Sacramento."),
                const Divider(height: 20, color: Colors.transparent),
                Text(
                  "Comunhão espiritual",
                  style: TextStyle(
                    fontSize: fs.fontSize + 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(height: 6, color: Colors.transparent),
                Text(
                  "Eu quisera, Senhor, receber-Vos com aquela pureza, humildade e devoção com que Vos recebeu a Vossa Santíssima Mãe, com o espírito e o fervor dos Santos.",
                  style: TextStyle(fontSize: fs.fontSize),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:coramdeo/providers/oracoes_providers/comentario_do_evangelho_provider.dart';
import 'package:provider/provider.dart';

class ComentarioDoEvangelhoPage extends StatefulWidget {
  const ComentarioDoEvangelhoPage({super.key});

  @override
  State<ComentarioDoEvangelhoPage> createState() => _ComentarioDoEvangelhoPageState();
}

class _ComentarioDoEvangelhoPageState extends State<ComentarioDoEvangelhoPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ComentarioDoEvangelhoProvider(),
      child:Consumer<ComentarioDoEvangelhoProvider>(builder: (context, provider, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
        if (provider.error) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Conection Error"),
              content: const Text("There was an error connecting to the server. Please try again later."),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
        });
        return Scaffold(
          appBar: AppBar(
            title: const Text('Comentários do Evangelho do dia'),
            actions: [
              IconButton(onPressed: provider.decreaseFontSize, icon: const Icon(Icons.remove)),
              IconButton(onPressed: provider.increaseFontSize, icon: const Icon(Icons.add)),
            ],
            bottom: provider.isLoading ? const PreferredSize(
              preferredSize: Size.fromHeight(2.0),
              child: LinearProgressIndicator(),
            ) : null
          ),
          body: provider.isLoading ? Container() : SafeArea(
            child: SelectionArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: ListView(
                  children: [
                    const Divider(height: 15, color: Colors.transparent),
                    Text(provider.evangelho, textAlign: TextAlign.center, style: TextStyle(fontSize: provider.fontSize + 4, fontWeight: FontWeight.bold)),
                    const Divider(height: 15, color: Colors.transparent),
                    Text.rich(
                      TextSpan(
                        children: [
                          for (String text in provider.evangelhoText) TextSpan(text: "$text ".replaceFirst(provider.evangelho, ""), style: TextStyle(fontSize: provider.fontSize))
                        ]
                      )
                    ),
                    const Divider(height: 25, color: Colors.transparent),
                    Text(provider.comentarios, textAlign: TextAlign.center, style: TextStyle(fontSize: provider.fontSize + 4, fontWeight: FontWeight.bold)),
                    const Divider(height: 15, color: Colors.transparent),
                    for (String text in provider.comentariosText)
                      Text("$text\n", style: TextStyle(fontSize: provider.fontSize)),
                    const Divider(height: 15, color: Colors.transparent),
                    Text("Fonte: https://opusdei.org/pt-br/gospel/", style: TextStyle(fontSize: provider.fontSize - 2, fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
            ),
          )
        );
      }),
    );
  }
}
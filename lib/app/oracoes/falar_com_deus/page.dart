import 'package:flutter/material.dart';
import 'package:coramdeo/app/oracoes/falar_com_deus/provider.dart';
import 'package:provider/provider.dart';

import '../../app_provider.dart';

class FalarComDeusPage extends StatefulWidget {
  const FalarComDeusPage({super.key});

  @override
  State<FalarComDeusPage> createState() => _FalarComDeusPageState();
}

class _FalarComDeusPageState extends State<FalarComDeusPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FalarComDeusProvider(),
        child: Consumer2<FalarComDeusProvider, AppProvider>(builder: (context, provider, fs, child) {
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
                  title: const Text("Falar com Deus"),
                  actions: [
                    IconButton(onPressed: fs.decreaseFontSize, icon: const Icon(Icons.remove)),
                    IconButton(onPressed: fs.increaseFontSize, icon: const Icon(Icons.add)),
                  ],
                  bottom: provider.isLoading
                      ? const PreferredSize(
                    preferredSize: Size.fromHeight(2.0),
                    child: LinearProgressIndicator(),
                  )
                      : null),
              body: provider.isLoading
                  ? Container()
                  : SafeArea(
                child: SelectionArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (String day in provider.day) Align(alignment: Alignment.centerRight, child: Text(day, style: TextStyle(fontSize: fs.fontSize - 2))),
                          const Divider(height: 15, color: Colors.transparent),
                          for (String title in provider.title) Align(alignment: Alignment.center, child: Text(title, style: TextStyle(fontSize: fs.fontSize + 4, fontWeight: FontWeight.bold))),
                          const Divider(height: 15, color: Colors.transparent),
                          for (String subtitle in provider.subtitle) Text(subtitle, style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.w300)),
                          const Divider(height: 10, color: Colors.transparent),
                          for (String note in provider.note) Text(note, style: TextStyle(fontSize: fs.fontSize, fontStyle: FontStyle.italic)),
                          const Divider(height: 15, color: Colors.transparent),
                          for (String content in provider.content) Text("$content\n", style: TextStyle(fontSize: fs.fontSize)),
                          const Divider(height: 15, color: Colors.transparent),
                          for (String reference in provider.reference) Text(reference),
                          const Divider(height: 15, color: Colors.transparent),
                          Text("Fonte: https://www.hablarcondios.org/pt/meditacaodiaria.aspx", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        })
    );
  }
}

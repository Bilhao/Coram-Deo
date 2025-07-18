import 'package:coramdeo/app/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:coramdeo/app/liturgia_diaria/provider.dart';
import 'package:provider/provider.dart';

class LiturgiaDiariaPage extends StatefulWidget {
  const LiturgiaDiariaPage({super.key});

  @override
  State<LiturgiaDiariaPage> createState() => _LiturgiaDiariaPageState();
}

class _LiturgiaDiariaPageState extends State<LiturgiaDiariaPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LiturgiaDiariaProvider(),
      child: Consumer2<LiturgiaDiariaProvider, AppProvider>(
        builder: (context, provider, fs, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (provider.error != null) {
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
                title: const Text("Liturgia Diária"),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => fs.decreaseFontSize()
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => fs.increaseFontSize(),
                  )
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
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text("Liturgia do dia: ${provider.date}", style: TextStyle(fontSize: fs.fontSize + 2),)),
                                  IconButton(
                                    onPressed: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(DateTime.now().year, DateTime.now().month),
                                        lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
                                        initialDate: DateTime(DateTime.now().year, provider.month, provider.day),
                                      );
                                      if (pickedDate != null) {
                                        provider.changeDate(pickedDate.day, pickedDate.month);
                                      }
                                    },
                                    icon: const Icon(Icons.calendar_month),
                                  )
                                ],
                              ),
                              const Divider(height: 15, color: Colors.transparent),
                              Text(provider.liturgia, style: TextStyle(fontSize: fs.fontSize + 2)),
                              const Divider(height: 15, color: Colors.transparent),
                              Align(
                                alignment: Alignment.center,
                                child: Text("Primeira Leitura (${provider.primeiraLeituraReferencia})", style: TextStyle(fontSize: fs.fontSize + 6, fontWeight: FontWeight.bold)),
                              ),
                              const Divider(height: 15, color: Colors.transparent),
                              Text(provider.primeiraLeituraTitulo, style: TextStyle(fontSize: fs.fontSize + 3), textAlign: TextAlign.left),
                              const Divider(height: 15, color: Colors.transparent),
                              Text(provider.primeiraLeituraText, style: TextStyle(fontSize: fs.fontSize + 2)),
                              const Divider(height: 25, color: Colors.transparent),
                              Align(
                                alignment: Alignment.center,
                                child: Text("Salmo (${provider.salmoReferencia})", style: TextStyle(fontSize: fs.fontSize + 6, fontWeight: FontWeight.bold)),
                              ),
                              const Divider(height: 10, color: Colors.transparent),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: "℟. ",
                                  style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold, color: Colors.red),
                                ),
                                TextSpan(
                                  text: provider.salmoRefrao,
                                  style: TextStyle(fontSize: fs.fontSize + 2, fontWeight: FontWeight.bold),
                                ),
                              ])),
                              const Divider(height: 15, color: Colors.transparent),
                              Text(provider.salmoText, style: TextStyle(fontSize: fs.fontSize + 2)),
                              const Divider(height: 25, color: Colors.transparent),
                              if (provider.segundaLeituraTitulo != "")
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("Segunda Leitura (${provider.segundaLeituraReferencia})", style: TextStyle(fontSize: fs.fontSize + 6, fontWeight: FontWeight.bold)),
                                ),
                              if (provider.segundaLeituraReferencia != "") const Divider(height: 15, color: Colors.transparent),
                              if (provider.segundaLeituraTitulo != "") Text(provider.segundaLeituraTitulo, style: TextStyle(fontSize: fs.fontSize + 3), textAlign: TextAlign.left),
                              if (provider.segundaLeituraText != "") const Divider(height: 15, color: Colors.transparent),
                              if (provider.segundaLeituraText != "") Text(provider.segundaLeituraText, style: TextStyle(fontSize: fs.fontSize + 2)),
                              if (provider.segundaLeituraText != "") const Divider(height: 25, color: Colors.transparent),
                              Align(
                                alignment: Alignment.center,
                                child: Text("Evangelho (${provider.evangelhoReferencia})", style: TextStyle(fontSize: fs.fontSize + 6, fontWeight: FontWeight.bold)),
                              ),
                              const Divider(height: 15, color: Colors.transparent),
                              Text(provider.evangelhoTitle, style: TextStyle(fontSize: fs.fontSize + 3), textAlign: TextAlign.left),
                              const Divider(height: 15, color: Colors.transparent),
                              Text(provider.evangelhoText, style: TextStyle(fontSize: fs.fontSize + 2)),
                              const Divider(height: 15, color: Colors.transparent),
                              Text("Fonte: https://liturgia.up.railway.app", style: TextStyle(fontSize: fs.fontSize - 2, fontWeight: FontWeight.w300))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

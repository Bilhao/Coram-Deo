import 'package:flutter/material.dart';
import 'package:coramdeo/providers/liturgia_diaria_provider.dart';
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
      child: Consumer<LiturgiaDiariaProvider>(
        builder: (context, provider, child) {
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
              title: const Text("Liturgia Diária"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => provider.decreaseFontSize(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => provider.increaseFontSize(),
                )
              ],
              bottom: provider.isLoading ? const PreferredSize(
                preferredSize: Size.fromHeight(2.0),
                child: LinearProgressIndicator(),
              ) : null
            ),
            body: provider.isLoading ? Container() : SafeArea(
              child: SelectionArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    children: [
                      Container(
                        width: double.infinity,
                      ),
                      const Divider(height: 15, color: Colors.transparent),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Liturgia do dia: ${provider.date}",
                              style: TextStyle(fontSize: provider.fontsize + 2),
                            )
                          ),
                          const VerticalDivider(width: 10, color: Colors.transparent),
                          IconButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(DateTime.now().year, DateTime.now().month),
                                lastDate: DateTime(DateTime.now().year, DateTime.now().month+1),
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
                      Text(provider.liturgia, style: TextStyle(fontSize: provider.fontsize + 2)),
                      const Divider(height: 15, color: Colors.transparent),
                      Text("Primeira Leitura (${provider.primeiraLeituraReferencia})", style: TextStyle(fontSize: provider.fontsize + 6, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      const Divider(height: 15, color: Colors.transparent),
                      Text(provider.primeiraLeituraTitulo, style: TextStyle(fontSize: provider.fontsize + 3), textAlign: TextAlign.left),
                      const Divider(height: 15, color: Colors.transparent),
                      Text(provider.primeiraLeituraText, style: TextStyle(fontSize: provider.fontsize + 2)),
                      const Divider(height: 25, color: Colors.transparent),
                      Text("Salmo (${provider.salmoReferencia})", style: TextStyle(fontSize: provider.fontsize + 6, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      const Divider(height: 10, color: Colors.transparent),
                      Text("— ${provider.salmoRefrao}", style: TextStyle(fontSize: provider.fontsize + 2)),
                      Text("R — ${provider.salmoRefrao}", style: TextStyle(fontSize: provider.fontsize + 2, fontWeight: FontWeight.bold)),
                      const Divider(height: 15, color: Colors.transparent),
                      Text(provider.salmoText, style: TextStyle(fontSize: provider.fontsize + 2)),
                      const Divider(height: 25, color: Colors.transparent),
                      if (provider.segundaLeituraTitulo != "") Text("Segunda Leitura (${provider.segundaLeituraReferencia})", style: TextStyle(fontSize: provider.fontsize + 6, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      if (provider.segundaLeituraReferencia != "") const Divider(height: 15, color: Colors.transparent),
                      if (provider.segundaLeituraTitulo != "") Text(provider.segundaLeituraTitulo, style: TextStyle(fontSize: provider.fontsize + 3), textAlign: TextAlign.left),
                      if (provider.segundaLeituraText != "") const Divider(height: 15, color: Colors.transparent),
                      if (provider.segundaLeituraText != "") Text(provider.segundaLeituraText, style: TextStyle(fontSize: provider.fontsize + 2)),
                      if (provider.segundaLeituraText != "") const Divider(height: 25, color: Colors.transparent),
                      Text("Evangelho (${provider.evangelhoReferencia})", style: TextStyle(fontSize: provider.fontsize + 6, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      const Divider(height: 15, color: Colors.transparent),
                      Text(provider.evangelhoTitle, style: TextStyle(fontSize: provider.fontsize + 3), textAlign: TextAlign.left),
                      const Divider(height: 15, color: Colors.transparent),
                      Text(provider.evangelhoText, style: TextStyle(fontSize: provider.fontsize + 2)),
                      const Divider(height: 15, color: Colors.transparent),
                      Text("Fonte: https://liturgiadiaria.site/", style: TextStyle(fontSize: provider.fontsize - 2, fontWeight: FontWeight.w300))
                    ],
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
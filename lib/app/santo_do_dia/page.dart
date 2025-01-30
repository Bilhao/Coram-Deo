import 'package:flutter/material.dart';
import 'package:coramdeo/app/santo_do_dia/provider.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';

class SantoDoDiaPage extends StatefulWidget {
  const SantoDoDiaPage({super.key});

  @override
  State<SantoDoDiaPage> createState() => _SantoDoDiaPageState();
}

class _SantoDoDiaPageState extends State<SantoDoDiaPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SantoDoDiaProvider(),
      child: Consumer2<SantoDoDiaProvider, AppProvider>(builder: (context, provider, fs, child) {
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
              title: const Text("Santo do Dia"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => fs.decreaseFontSize(),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(height: 15, color: Colors.transparent),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              provider.name,
                              style: TextStyle(fontSize: fs.fontSize + 5),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const VerticalDivider(width: 10, color: Colors.transparent),
                          Row(
                            children: [
                              Text("${provider.day}/${provider.month}"),
                              IconButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2030),
                                    initialDate: DateTime(DateTime.now().year, provider.month, provider.day),
                                  );
                                  if (pickedDate != null) {
                                    provider.changeDate(pickedDate.day, pickedDate.month);
                                  }
                                },
                                icon: const Icon(Icons.calendar_month),
                              )
                            ],
                          )
                        ],
                      ),
                      const Divider(height: 30, color: Colors.transparent),
                      for (String text in provider.text)
                        Align(
                          alignment: provider.boldText.contains(text) ? Alignment.center : Alignment.centerLeft,
                          child: Text(
                            provider.boldText.contains(text) ? "$text\n" : "${text.trim()}\n",
                            style: TextStyle(
                              fontSize: provider.boldText.contains(text) ? fs.fontSize + 5 : fs.fontSize + 2,
                              fontWeight: provider.boldText.contains(text) ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      Text("Fonte: https://www.a12.com/reze-no-santuario/santo-do-dia", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:coramdeo/app/plano_de_vida/provider.dart';
import 'package:coramdeo/utils/notification.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';

class PlanoDeVidaPage extends StatefulWidget {
  const PlanoDeVidaPage({super.key});

  @override
  State<PlanoDeVidaPage> createState() => _PlanoDeVidaPageState();
}

class _PlanoDeVidaPageState extends State<PlanoDeVidaPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PlanoDeVidaProvider(),
        child: Consumer<PlanoDeVidaProvider>(builder: (context, provider, child) {
          return DefaultTabController(
            length: 3,
            initialIndex: 1,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Plano de Vida"),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: "Todos os itens", icon: Icon(Icons.list)),
                    Tab(text: "Itens do dia", icon: Icon(Icons.watch_later_outlined)),
                    Tab(text: "Completos", icon: Icon(Icons.check_box)),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  TodosOsItens(),
                  Selecionados(),
                  Concluidos(),
                ],
              ),
            ),
          );
        }));
  }
}

class TodosOsItens extends StatefulWidget {
  const TodosOsItens({super.key});

  @override
  State<TodosOsItens> createState() => _TodosOsItensState();
}

class _TodosOsItensState extends State<TodosOsItens> {
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanoDeVidaProvider>(builder: (context, provider, child) {
      return Column(children: [
        Expanded(
          child: ListView(
            children: [
              const Divider(height: 20, color: Colors.transparent),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Novo item',
                      ),
                      onChanged: (value) {
                        setState(() {
                          titleController.text = value;
                        });
                      },
                    ),
                  ),
                  const VerticalDivider(width: 10, color: Colors.transparent),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.add),
                    style: ButtonStyle(shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
                    onPressed: titleController.text.isEmpty
                        ? null
                        : () {
                      provider.addItem(titleController.text, 1, 0, 0, 0);
                      titleController.text = "";
                    }),
                ]),
              ),
              const Divider(height: 15, color: Colors.transparent),
              for (int i = 0; i < provider.titles.length; i++)
                ListTile(
                  title: Text(provider.titles[i], style: const TextStyle(fontSize: 18)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      provider.titlesIsCustom.contains(provider.titles[i])
                          ? IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          provider.removeItem(provider.titles[i]);
                        },
                      )
                          : Container(),
                      Checkbox(
                        value: provider.titlesIsSelected.contains(provider.titles[i]),
                        onChanged: (value) {
                          provider.toggleItemSelection(provider.titles[i]);
                        },
                      ),
                      // Show more options button only for selected items
                      provider.titlesIsSelected.contains(provider.titles[i])
                          ? IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ChangeNotifierProvider.value(
                                    value: provider,
                                    child: InfoAlertDialog(title: provider.titles[i]),
                                  ),
                                );
                              },
                            )
                          : Container(),
                    ],
                  ),
                  onTap: () => provider.toggleItemSelection(provider.titles[i]),
                ),
            ],
          )
        ),
      ]);
    });
  }
}

class Selecionados extends StatelessWidget {
  const Selecionados({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanoDeVidaProvider>(builder: (context, provider, child) {
      // Get today's items based on weekday selection
      List<String> todaysItems = provider.getTodaysItems();
      
      return Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: todaysItems.length,
            itemBuilder: (context, index) {
              String title = todaysItems[index];
              return ListTile(
                title: Text(
                  title,
                  style: provider.titlesIsCompletedToday.contains(title)
                    ? const TextStyle(fontSize: 18, decoration: TextDecoration.lineThrough)
                    : const TextStyle(fontSize: 18)
                ),
                leading: provider.titlesIsCompletedToday.contains(title) 
                    ? const Icon(Icons.check) 
                    : const Icon(Icons.watch_later_outlined),
                trailing: Checkbox(
                  value: provider.titlesIsCompletedToday.contains(title),
                  onChanged: (value) {
                    provider.toggleItemCompletion(title);
                  },
                ),
                onTap: () {
                  provider.toggleItemCompletion(title);
                },
              );
            })
        ),
      ]);
    });
  }
}

class InfoAlertDialog extends StatelessWidget {
  InfoAlertDialog({super.key, required this.title});

  final String title;
  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanoDeVidaProvider>(
      builder: (context, provider, child) {
        return AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          scrollable: true,
          content: Column(
            children: [
              Container(
                width: double.maxFinite,
              ),
              // Weekday Selector
              const ListTile(
                title: Text("Dias da semana"),
                leading: Icon(Icons.calendar_today),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: WeekdaySelector(
                  onChanged: (int day) {
                    List<bool> currentSelection = provider.getItemWeekdays(title);
                    // day parameter is 0-based (0=Monday, 6=Sunday)
                    currentSelection[day] = !currentSelection[day];
                    provider.updateItemWeekdays(title, currentSelection);
                  },
                  values: provider.getItemWeekdays(title),
                  selectedFillColor: Theme.of(context).primaryColor,
                  selectedColor: Colors.white,
                  disabledFillColor: Colors.grey.shade300,
                  disabledColor: Colors.grey.shade600,
                  fillColor: Colors.grey.shade200,
                  color: Colors.grey.shade700,
                ),
              ),
              const Divider(),
              ExpansionTile(
                title: const Text("Adicionar lembrete"),
                leading: const Icon(Icons.alarm),
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 7, minute: 0),
                    );
                    if (pickedTime != null) {
                      if (await Notifier.verifyNotificationPermission() != null && await Notifier.verifyNotificationPermission() != false) {
                        await provider.activateItemNotification(title);
                        await provider.insertNotificationTime(title, pickedTime.format(context));
                        
                        // Get the notification ID for this specific time
                        int notificationId = await provider.getNotificationIdForTime(title, pickedTime.format(context));
                        
                        await Notifier.scheduledNotification(
                          CustomNotification(
                            id: notificationId, 
                            title: title, 
                            body: "Lembrete para: $title", 
                            payload: "/oracoes"
                          ), 
                          pickedTime
                        );
                        controller.expand();
                      }
                    }
                  },
                ),
                initiallyExpanded: (provider.notificationTimes[title] == null) ? false : true,
                controller: controller,
                children: [
                  if (provider.notificationTimes[title] != null)
                    for (String time in (provider.notificationTimes[title] ?? "").split(","))
                      ListTile(
                        title: Text("Lembrete para: $time"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            // Get the specific notification ID for this time before deleting
                            int notificationId = await provider.getNotificationIdForTime(title, time);
                            
                            // Cancel the specific notification
                            if (notificationId != -1) {
                              await Notifier.stopNotification(notificationId);
                            }
                            
                            // Remove from database
                            await provider.deleteNotificationTime(title, time);
                            
                            // Check if this was the last notification time for this title
                            if (provider.notificationTimes[title] == null || 
                                (provider.notificationTimes[title] as String).isEmpty) {
                              await provider.deactivateItemNotification(title);
                            }
                          },
                        ),
                      ),
                  if (provider.notificationTimes[title] == null)
                    const ListTile(
                      title: Text("Nenhum lembrete configurado", textAlign: TextAlign.center),
                    ),
                ],
              ),
              ListTile(
                title: const Text("Excluir"),
                leading: const Icon(Icons.delete),
                onTap: () {
                  provider.removeItem(provider.titles[i]);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class Concluidos extends StatelessWidget {
  const Concluidos({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanoDeVidaProvider>(builder: (context, provider, child) {
      return Column(children: [
        ListTile(
            title: Text("Concluídos do dia ${provider.day}/${provider.month}/${provider.year}", style: const TextStyle(fontSize: 19)),
            trailing: IconButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  initialDate: DateTime(provider.year, provider.month, provider.day),
                );
                if (pickedDate != null) {
                  provider.changeDate(pickedDate.year, pickedDate.month, pickedDate.day);
                }
              },
              icon: const Icon(Icons.calendar_month),
            )),
        Expanded(
            child: ListView.builder(
                itemCount: provider.titlesIsCompleted.length,
                itemBuilder: (context, index) {
                  return (provider.completedDates[provider.titlesIsCompleted[index]] ?? "").split(",").contains("${provider.day}/${provider.month}/${provider.year}")
                      ? ListTile(
                    title: Text(provider.titlesIsCompleted[index], style: const TextStyle(fontSize: 18)),
                    leading: const Icon(Icons.check),
                  )
                      : Container();
                })),
      ]);
    });
  }
}

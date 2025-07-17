import 'package:flutter/material.dart';
import 'package:coramdeo/app/plano_de_vida/provider.dart';
import 'package:coramdeo/utils/notification.dart';
import 'package:provider/provider.dart';

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
                    Tab(text: "Progresso", icon: Icon(Icons.analytics)),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  TodosOsItens(),
                  Selecionados(),
                  Progresso(),
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
                    Checkbox(
                      value: provider.titlesIsSelected.contains(provider.titles[i]),
                      onChanged: (value) {
                        provider.toggleItemSelection(provider.titles[i]);
                      },
                    ),
                    // Show more options button for all items
                    IconButton(
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
                    ),
                  ],
                ),
                onTap: () => provider.toggleItemSelection(provider.titles[i]),
              ),
          ],
        )),
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
                    title: Text(title, style: provider.titlesIsCompletedToday.contains(title) ? const TextStyle(fontSize: 18, decoration: TextDecoration.lineThrough) : const TextStyle(fontSize: 18)),
                    leading: provider.titlesIsCompletedToday.contains(title) ? const Icon(Icons.check) : const Icon(Icons.watch_later_outlined),
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
                })),
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
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Weekday Selector
                const ListTile(
                  title: Text("Dias da semana"),
                  leading: Icon(Icons.calendar_month),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _CustomWeekdaySelector(
                    values: provider.getItemWeekdays(title),
                    onChanged: (int day) {
                      List<bool> currentSelection = provider.getItemWeekdays(title);
                      // day parameter is 0-based (0=Monday, 6=Sunday)
                      currentSelection[day] = !currentSelection[day];
                      provider.updateItemWeekdays(title, currentSelection);
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    unselectedColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 10),
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
                          // ignore: use_build_context_synchronously
                          await provider.insertNotificationTime(title, pickedTime.format(context));

                          // Get the notification ID for this specific time
                          // ignore: use_build_context_synchronously
                          int notificationId = await provider.getNotificationIdForTime(title, pickedTime.format(context));

                          await Notifier.scheduledNotification(CustomNotification(id: notificationId, title: title, body: "Lembrete para: $title", payload: "/oracoes"), pickedTime);
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
                              if (provider.notificationTimes[title] == null || (provider.notificationTimes[title] as String).isEmpty) {
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
                    provider.removeItem(title);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Progresso extends StatelessWidget {
  const Progresso({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanoDeVidaProvider>(builder: (context, provider, child) {
      return _buildProgressView(context, provider);
    });
  }

  Widget _buildProgressView(BuildContext context, PlanoDeVidaProvider provider) {
    List<String> todaysItems = provider.getTodaysItems();
    int completedToday = todaysItems.where((title) => provider.titlesIsCompletedToday.contains(title)).length;
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          "Análise de Progresso",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // Overall Statistics Card
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.analytics, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    const Text(
                      "Estatísticas Gerais",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildStatRow("Itens do dia", "${todaysItems.length}", Icons.list),
                const SizedBox(height: 8),
                _buildStatRow("Itens completados hoje", "$completedToday", Icons.check_circle),
                const SizedBox(height: 8),
                if (todaysItems.isNotEmpty) _buildStatRow("Taxa de conclusão hoje", "${((completedToday / todaysItems.length) * 100).toStringAsFixed(1)}%", Icons.trending_up),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Individual Item Progress
        Row(
          children: [
            Icon(Icons.insights, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            const Text(
              "Progresso por Item",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),

        ...provider.titlesIsSelected.map((title) => _buildItemProgressCard(context, provider, title)),
      ],
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 14)),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildItemProgressCard(BuildContext context, PlanoDeVidaProvider provider, String title) {
    double completionWeek = provider.getItemCompletionPercentageWeek(title);
    double completionMonth = provider.getItemCompletionPercentageMonth(title);
    double completionYear = provider.getItemCompletionPercentageYear(title);
    int currentStreak = provider.getItemCurrentStreak(title);
    int totalCompleted = provider.getItemTotalCompletedDays(title);
    List<Map<String, dynamic>> weekData = provider.getMonthlyWeekCompletionSummary(title);
    List<Map<String, dynamic>> monthData = provider.getLast3MonthsCompletionSummary(title);
    List<Map<String, dynamic>> yearData = provider.getLast2YearsCompletionSummary(title);

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  currentStreak > 0 ? Icons.trending_up : Icons.radio_button_unchecked,
                  color: currentStreak > 0 ? Colors.green : Colors.grey,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text("Sequência de $currentStreak dia${currentStreak > 1 ? 's' : ''}", style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: completionWeek / 100,
              valueColor: AlwaysStoppedAnimation<Color>(completionWeek >= 80
                  ? Colors.green
                  : completionWeek >= 60
                      ? Colors.orange
                      : Colors.red),
            ),
            Text(
              "Semana: ${completionWeek.toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: completionMonth / 100,
              valueColor: AlwaysStoppedAnimation<Color>(completionMonth >= 80
                  ? Colors.green
                  : completionMonth >= 60
                      ? Colors.orange
                      : Colors.red),
            ),
            Text(
              "Mês: ${completionMonth.toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: completionYear / 100,
              valueColor: AlwaysStoppedAnimation<Color>(completionYear >= 80
                  ? Colors.green
                  : completionYear >= 60
                      ? Colors.orange
                      : Colors.red),
            ),
            Text(
              "Ano: ${completionYear.toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Statistics Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(context, "Sequência Atual", "$currentStreak dias", Icons.trending_up),
                    _buildStatItem(context, "Total Concluído", "$totalCompleted", Icons.check_circle),
                    _buildStatItem(context, "Mês", "${completionMonth.toStringAsFixed(1)}%", Icons.calendar_month),
                  ],
                ),
                const SizedBox(height: 20),
                // Weekly Progress (Semana do mês)
                Row(
                  children: [
                    Icon(Icons.bar_chart, color: Theme.of(context).colorScheme.primary, size: 16),
                    const SizedBox(width: 8),
                    const Text(
                      "Progresso por Semana",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...weekData.map((week) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(week['week'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                          ),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: week['total'] > 0 ? week['completed'] / week['total'] : 0,
                              valueColor: AlwaysStoppedAnimation<Color>(week['percentage'] >= 80
                                  ? Colors.green
                                  : week['percentage'] >= 60
                                      ? Colors.orange
                                      : Colors.red),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "  ${week['completed']}/${week['total']}",
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                // Monthly Progress
                Row(
                  children: [
                    Icon(Icons.calendar_month, color: Theme.of(context).colorScheme.primary, size: 16),
                    const SizedBox(width: 8),
                    const Text(
                      "Progresso Mensal",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...monthData.map((month) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(month['month'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                          ),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: month['total'] > 0 ? month['completed'] / month['total'] : 0,
                              valueColor: AlwaysStoppedAnimation<Color>(month['percentage'] >= 80
                                  ? Colors.green
                                  : month['percentage'] >= 60
                                      ? Colors.orange
                                      : Colors.red),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "  ${month['completed']}/${month['total']}",
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                // Yearly Progress
                Row(
                  children: [
                    Icon(Icons.view_timeline, color: Theme.of(context).colorScheme.primary, size: 16),
                    const SizedBox(width: 8),
                    const Text(
                      "Progresso Anual",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...yearData.map((year) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(year['year'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                          ),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: year['total'] > 0 ? year['completed'] / year['total'] : 0,
                              valueColor: AlwaysStoppedAnimation<Color>(year['percentage'] >= 80
                                  ? Colors.green
                                  : year['percentage'] >= 60
                                      ? Colors.orange
                                      : Colors.red),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "  ${year['completed']}/${year['total']}",
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    )),

                // Motivational Message
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getMotivationalIcon(completionWeek, currentStreak),
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getMotivationalMessage(completionWeek, currentStreak),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width - 74) / 3,
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getMotivationalIcon(double completion7Days, int streak) {
    if (streak >= 7) {
      return Icons.local_fire_department;
    } else if (completion7Days >= 80) {
      return Icons.stars;
    } else if (completion7Days >= 60) {
      return Icons.trending_up;
    } else if (completion7Days >= 40) {
      return Icons.track_changes;
    } else {
      return Icons.eco;
    }
  }

  String _getMotivationalMessage(double completion7Days, int streak) {
    if (streak >= 7) {
      return "Excelente! Você está mantendo uma sequência de $streak dias!";
    } else if (completion7Days >= 80) {
      return "Ótimo progresso! Continue assim!";
    } else if (completion7Days >= 60) {
      return "Bom ritmo! Você pode melhorar ainda mais!";
    } else if (completion7Days >= 40) {
      return "Você está no caminho certo, continue!";
    } else {
      return "Todo grande objetivo começa com pequenos passos!";
    }
  }
}

// Simple custom weekday selector to replace the problematic flutter_weekday_selector
class _CustomWeekdaySelector extends StatelessWidget {
  final List<bool> values;
  final Function(int) onChanged;
  final Color selectedColor;
  final Color unselectedColor;

  const _CustomWeekdaySelector({
    required this.values,
    required this.onChanged,
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> weekdayLabels = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
    final List<String> weekdayNames = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (uiIndex) {
        // Map UI index (Domingo=0) to values index (Segunda=0, Domingo=6)
        int valuesIndex = (uiIndex == 0) ? 6 : uiIndex - 1;
        final bool isSelected = valuesIndex < values.length ? values[valuesIndex] : false;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: GestureDetector(
              onTap: () => onChanged(valuesIndex),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : unselectedColor,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: selectedColor,
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weekdayLabels[uiIndex],
                        style: TextStyle(
                          color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        weekdayNames[uiIndex],
                        style: TextStyle(
                          color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                          fontSize: 8,
                        ),
                      ),
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

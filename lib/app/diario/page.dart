import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/diario/model.dart';
import 'package:coramdeo/app/diario/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiarioPage extends StatelessWidget {
  const DiarioPage({super.key});

  Future<void> _openForm(
    BuildContext context,
    DiarioProvider provider, {
    SpiritualJournalEntry? entry,
  }) async {
    await showDialog(
      context: context,
      builder: (ctx) => JournalEntryDialog(
        initialEntry: entry,
        onSave: (date, title, text) async {
          if (entry != null) {
            final updated = SpiritualJournalEntry(
              id: entry.id,
              date: date,
              title: title,
              text: text,
            );
            await provider.updateEntry(updated);
          } else {
            await provider.addEntry(date: date, title: title, text: text);
          }
        },
        onDelete: entry == null
            ? null
            : () async {
                await provider.deleteEntry(entry.id);
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fs = Provider.of<AppProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return ChangeNotifierProvider<DiarioProvider>(
      create: (_) => DiarioProvider(),
      child: Consumer<DiarioProvider>(
        builder: (context, provider, _) {
          final entries = provider.entries;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Luzes de Oração",
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: "Nova anotação espiritual",
                  onPressed: () => _openForm(context, provider),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _openForm(context, provider),
              icon: const Icon(Icons.edit_note),
              label: const Text("Nova Luz"),
            ),
            body: SafeArea(
              child: entries.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_note,
                              size: 64,
                              color: colorScheme.primary.withValues(alpha: 0.6),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Seu espaço privativo de oração",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fs.fontSize + 2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Registre inspirações, propósitos do Exame de Consciência e frutos da sua meditação diária.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fs.fontSize - 1,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        bottom: 88.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      itemCount: entries.length,
                      itemBuilder: (context, index) {
                        final item = entries[index];
                        return Card(
                          elevation: 0,
                          color: colorScheme.secondaryContainer,
                          margin: const EdgeInsets.only(bottom: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () =>
                                _openForm(context, provider, entry: item),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        size: 14,
                                        color: colorScheme.primary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        item.date,
                                        style: TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.edit_outlined,
                                        size: 16,
                                        color: colorScheme.onSecondaryContainer
                                            .withValues(alpha: 0.7),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: fs.fontSize + 1,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSecondaryContainer,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    item.text,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: fs.fontSize - 0.5,
                                      color: colorScheme.onSecondaryContainer,
                                      height: 1.35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}

class JournalEntryDialog extends StatefulWidget {
  final SpiritualJournalEntry? initialEntry;
  final String? defaultTitle;
  final Future<void> Function(String date, String title, String text) onSave;
  final Future<void> Function()? onDelete;

  const JournalEntryDialog({
    super.key,
    this.initialEntry,
    this.defaultTitle,
    required this.onSave,
    this.onDelete,
  });

  static Future<void> showQuickReflectionDialog(
    BuildContext context, {
    required String defaultTitle,
  }) async {
    final provider = DiarioProvider();
    await provider.reload();
    if (!context.mounted) return;

    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => JournalEntryDialog(
        defaultTitle: defaultTitle,
        onSave: (date, title, text) async {
          await provider.addEntry(date: date, title: title, text: text);
        },
      ),
    );

    if (saved == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Reflexão salva em Luzes de Oração",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  State<JournalEntryDialog> createState() => _JournalEntryDialogState();
}

class _JournalEntryDialogState extends State<JournalEntryDialog> {
  late final TextEditingController _dateController;
  late final TextEditingController _titleController;
  late final TextEditingController _textController;

  String? _titleError;
  String? _textError;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
      text: widget.initialEntry?.date ?? DiarioProvider.formatToday(),
    );
    _titleController = TextEditingController(
      text: widget.initialEntry?.title ?? widget.defaultTitle ?? '',
    );
    _textController = TextEditingController(
      text: widget.initialEntry?.text ?? '',
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final date = _dateController.text.trim();
    final title = _titleController.text.trim();
    final text = _textController.text.trim();

    if (title.isEmpty || text.isEmpty) {
      setState(() {
        _titleError = title.isEmpty ? "* Campo obrigatório" : null;
        _textError = text.isEmpty ? "* Campo obrigatório" : null;
      });
      return;
    }

    setState(() {
      _isSaving = true;
    });

    await widget.onSave(
      date.isEmpty ? DiarioProvider.formatToday() : date,
      title,
      text,
    );
    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialEntry != null;
    final errorColor = Theme.of(context).colorScheme.error;

    return AlertDialog(
      title: Text(
        isEdit ? "Anotação Espiritual" : "Nova Luz de Oração",
        style: const TextStyle(fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: double.maxFinite),
          TextField(
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: "Data",
              prefixIcon: Icon(Icons.calendar_today_outlined, size: 18),
            ),
          ),
          const Divider(height: 14, color: Colors.transparent),
          TextField(
            controller: _titleController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: "Título",
              errorText: _titleError,
              errorStyle: TextStyle(fontSize: 13, color: errorColor),
            ),
            onChanged: (_) {
              if (_titleError != null) {
                setState(() => _titleError = null);
              }
            },
          ),
          const Divider(height: 14, color: Colors.transparent),
          TextField(
            controller: _textController,
            textCapitalization: TextCapitalization.sentences,
            minLines: 4,
            maxLines: 8,
            decoration: InputDecoration(
              labelText: "Texto da Anotação",
              alignLabelWithHint: true,
              errorText: _textError,
              errorStyle: TextStyle(fontSize: 13, color: errorColor),
            ),
            onChanged: (_) {
              if (_textError != null) {
                setState(() => _textError = null);
              }
            },
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        if (isEdit && widget.onDelete != null)
          IconButton(
            icon: Icon(Icons.delete_outline, color: errorColor),
            tooltip: "Excluir anotação",
            onPressed: _isSaving
                ? null
                : () async {
                    await widget.onDelete!();
                    if (context.mounted) {
                      Navigator.pop(context, false);
                    }
                  },
          ),
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context, false),
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: _isSaving ? null : _submit,
          child: const Text("Salvar"),
        ),
      ],
    );
  }
}

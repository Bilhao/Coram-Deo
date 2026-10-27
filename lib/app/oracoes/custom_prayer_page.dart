import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/oracoes/custom_prayer_model.dart';
import 'package:coramdeo/app/oracoes/provider.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomPrayerPage extends StatefulWidget {
  final String prayerId;

  const CustomPrayerPage({
    super.key,
    required this.prayerId,
  });

  @override
  State<CustomPrayerPage> createState() => _CustomPrayerPageState();
}

class _CustomPrayerPageState extends State<CustomPrayerPage> {
  CustomPrayer? _prayer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrayer();
  }

  Future<void> _loadPrayer() async {
    final prefs = await SharedPreferences.getInstance();
    final list = CustomPrayer.decodeList(
      prefs.getString(AppConstants.customPrayersKey),
    );
    final match = list.where((p) => p.id == widget.prayerId).firstOrNull;
    if (mounted) {
      setState(() {
        _prayer = match;
        _isLoading = false;
      });
    }
  }

  Future<void> _editPrayer(BuildContext context) async {
    if (_prayer == null) return;
    final provider = OracoesProvider();
    await provider.reload();
    if (!context.mounted) return;
    final updated = await showDialog<CustomPrayer>(
      context: context,
      builder: (ctx) => CustomPrayerFormDialog(
        initialPrayer: _prayer,
        onSave: (title, subtitle, text) async {
          final edited = CustomPrayer(
            id: _prayer!.id,
            title: title.trim(),
            subtitle: subtitle.trim(),
            text: text.trim(),
          );
          await provider.updateCustomPrayer(edited);
          return edited;
        },
      ),
    );
    if (updated != null && mounted) {
      setState(() {
        _prayer = updated;
      });
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    if (_prayer == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Excluir oração",
          style: TextStyle(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Deseja realmente excluir "${_prayer!.title}"?',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              "Excluir",
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final provider = OracoesProvider();
      await provider.reload();
      await provider.deleteCustomPrayer(_prayer!.id);
      if (context.mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fs = Provider.of<AppProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Oração")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_prayer == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Oração")),
        body: const Center(child: Text("Oração não encontrada.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _prayer!.title,
          maxLines: 2,
          style: const TextStyle(fontSize: 19),
        ),
        actions: [
          IconButton(
            onPressed: () => _editPrayer(context),
            icon: const Icon(Icons.edit_outlined),
            tooltip: "Editar oração",
          ),
          IconButton(
            onPressed: () => _confirmDelete(context),
            icon: const Icon(Icons.delete_outline),
            tooltip: "Excluir oração",
          ),
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
              top: 12,
              bottom: 24,
              left: 15,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_prayer!.subtitle.isNotEmpty) ...[
                  Text(
                    _prayer!.subtitle,
                    style: TextStyle(
                      fontSize: fs.fontSize - 1,
                      fontStyle: FontStyle.italic,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Divider(height: 16, color: Colors.transparent),
                ],
                Text(
                  _prayer!.text,
                  style: TextStyle(
                    fontSize: fs.fontSize,
                    height: 1.45,
                  ),
                ),
                const Divider(height: 24, color: Colors.transparent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPrayerFormDialog extends StatefulWidget {
  final CustomPrayer? initialPrayer;
  final Future<CustomPrayer> Function(
    String title,
    String subtitle,
    String text,
  ) onSave;

  const CustomPrayerFormDialog({
    super.key,
    this.initialPrayer,
    required this.onSave,
  });

  @override
  State<CustomPrayerFormDialog> createState() => _CustomPrayerFormDialogState();
}

class _CustomPrayerFormDialogState extends State<CustomPrayerFormDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _subtitleController;
  late final TextEditingController _textController;

  String? _titleError;
  String? _textError;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.initialPrayer?.title ?? '',
    );
    _subtitleController = TextEditingController(
      text: widget.initialPrayer?.subtitle ?? '',
    );
    _textController = TextEditingController(
      text: widget.initialPrayer?.text ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final subtitle = _subtitleController.text.trim();
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

    final saved = await widget.onSave(title, subtitle, text);
    if (mounted) {
      Navigator.pop(context, saved);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialPrayer != null;
    final errorColor = Theme.of(context).colorScheme.error;

    return AlertDialog(
      title: Text(
        isEdit ? "Editar Oração" : "Nova Oração Pessoal",
        style: const TextStyle(fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: double.maxFinite),
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
            controller: _subtitleController,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: "Subtítulo (opcional)",
            ),
          ),
          const Divider(height: 14, color: Colors.transparent),
          TextField(
            controller: _textController,
            textCapitalization: TextCapitalization.sentences,
            minLines: 4,
            maxLines: 8,
            decoration: InputDecoration(
              labelText: "Texto da Oração",
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
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: _isSaving ? null : _submit,
          child: Text(isEdit ? "Salvar" : "Adicionar"),
        ),
      ],
    );
  }
}

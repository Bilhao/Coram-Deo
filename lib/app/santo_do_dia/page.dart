import 'dart:io';
import 'package:flutter/material.dart';
import 'package:coramdeo/app/santo_do_dia/provider.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/santo_do_dia/widgets/saint_image_viewer.dart';

class SantoDoDiaPage extends StatefulWidget {
  final DateTime? initialDate;

  const SantoDoDiaPage({super.key, this.initialDate});

  @override
  State<SantoDoDiaPage> createState() => _SantoDoDiaPageState();
}

class _SantoDoDiaPageState extends State<SantoDoDiaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final provider = Provider.of<SantoDoDiaProvider>(context, listen: false);
      final targetDate =
          widget.initialDate ??
          (ModalRoute.of(context)?.settings.arguments as DateTime?);
      if (targetDate != null) {
        if (provider.day != targetDate.day ||
            provider.month != targetDate.month) {
          provider.changeDate(targetDate.day, targetDate.month);
        }
      } else {
        provider.resetToToday();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SantoDoDiaProvider, AppProvider>(
      builder: (context, provider, fs, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (provider.error != null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Erro de Conexão"),
                content: const Text(
                  "Não foi possível carregar as informações do Santo do Dia.",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      provider.clearError();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          }
        });

        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (bool didPop, Object? result) {
            if (didPop) {
              provider.resetToToday();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                provider.displayHeaderTitle,
                maxLines: 2,
                style: const TextStyle(fontSize: 20),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => fs.decreaseFontSize(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => fs.increaseFontSize(),
                ),
              ],
              bottom: provider.isLoading
                  ? const PreferredSize(
                      preferredSize: Size.fromHeight(2.0),
                      child: LinearProgressIndicator(),
                    )
                  : null,
            ),
            body: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.name.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_off_rounded,
                            size: 56,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Não foi possível carregar as informações do Santo do Dia.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: fs.fontSize + 1),
                          ),
                          const SizedBox(height: 16),
                          FilledButton.tonalIcon(
                            onPressed: () {
                              provider.changeDate(provider.day, provider.month);
                            },
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text("Tentar novamente"),
                          ),
                        ],
                      ),
                    ),
                  )
                : SafeArea(
                    child: SelectionArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 20,
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.name,
                                        style: TextStyle(
                                          fontSize: fs.fontSize + 5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (provider.hasSubtitulo) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          provider.subtitulo,
                                          style: TextStyle(
                                            fontSize: fs.fontSize + 1,
                                            fontStyle: FontStyle.italic,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${provider.day.toString().padLeft(2, '0')}/${provider.month.toString().padLeft(2, '0')}",
                                      style: TextStyle(
                                        fontSize: fs.fontSize,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime(2030),
                                              initialDate: DateTime(
                                                DateTime.now().year,
                                                provider.month,
                                                provider.day,
                                              ),
                                            );
                                        if (pickedDate != null &&
                                            context.mounted) {
                                          provider.changeDate(
                                            pickedDate.day,
                                            pickedDate.month,
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.calendar_month),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (provider.hasAssetImage ||
                                provider.localImagePath.isNotEmpty ||
                                provider.portrait.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => SaintFullscreenViewer(
                                              name: provider.name,
                                              subtitulo: provider.subtitulo,
                                              heroTag:
                                                  'santo_image_${provider.day}_${provider.month}',
                                              assetPath: provider.hasAssetImage
                                                  ? provider.assetImagePath
                                                  : null,
                                              localPath:
                                                  provider
                                                      .localImagePath
                                                      .isNotEmpty
                                                  ? provider.localImagePath
                                                  : null,
                                              networkUrl:
                                                  provider.portrait.isNotEmpty
                                                  ? provider.portrait
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                      onLongPress: () {
                                        showSaintImageActionsSheet(
                                          context,
                                          name: provider.name,
                                          subtitulo: provider.subtitulo,
                                          heroTag:
                                              'santo_image_${provider.day}_${provider.month}',
                                          assetPath: provider.hasAssetImage
                                              ? provider.assetImagePath
                                              : null,
                                          localPath:
                                              provider.localImagePath.isNotEmpty
                                              ? provider.localImagePath
                                              : null,
                                          networkUrl:
                                              provider.portrait.isNotEmpty
                                              ? provider.portrait
                                              : null,
                                        );
                                      },
                                      child: Hero(
                                        tag:
                                            'santo_image_${provider.day}_${provider.month}',
                                        child: Container(
                                          constraints: const BoxConstraints(
                                            maxHeight: 300,
                                          ),
                                          child: provider.hasAssetImage
                                              ? Image.asset(
                                                  provider.assetImagePath,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, _, _) =>
                                                      const SizedBox.shrink(),
                                                )
                                              : provider
                                                        .localImagePath
                                                        .isNotEmpty &&
                                                    File(
                                                      provider.localImagePath,
                                                    ).existsSync()
                                              ? Image.file(
                                                  File(provider.localImagePath),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  provider.portrait,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, _, _) =>
                                                      const SizedBox.shrink(),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 20),
                            for (String text in provider.text)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14.0),
                                child: Text(
                                  text.trim(),
                                  style: TextStyle(
                                    fontSize: provider.boldText.contains(text)
                                        ? fs.fontSize + 4
                                        : fs.fontSize + 1,
                                    fontWeight: provider.boldText.contains(text)
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            if (provider.hasOracao) ...[
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 24.0,
                                ),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
                                      .withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outlineVariant
                                        .withValues(alpha: 0.4),
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.church_rounded,
                                          size: 18,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Oração",
                                          style: TextStyle(
                                            fontSize: fs.fontSize + 1,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      provider.oracao,
                                      style: TextStyle(
                                        fontSize: fs.fontSize + 1,
                                        fontStyle: FontStyle.italic,
                                        height: 1.45,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSecondaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              const SizedBox(height: 10),
                              const Text(
                                "Fonte: https://www.a12.com/reze-no-santuario/santo-do-dia",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

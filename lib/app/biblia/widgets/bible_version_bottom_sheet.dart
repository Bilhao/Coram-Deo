import 'package:coramdeo/app/biblia/data.dart';
import 'package:coramdeo/app/biblia/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BibleVersionBottomSheet extends StatelessWidget {
  const BibleVersionBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) => const BibleVersionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<BibleProvider>(
      builder: (context, provider, child) {
        final currentVersion = provider.currentVersion;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Versões da Sagrada Escritura",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Cânon Católico com 73 livros. A versão Ave Maria já está integrada offline. Baixe outras versões para estudo e oração.",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.availableBibleVersions.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, indent: 20, endIndent: 20),
                    itemBuilder: (context, index) {
                      final version = provider.availableBibleVersions[index];
                      final isSelected = currentVersion.id == version.id;
                      final isInstalled = provider.isVersionInstalled(version.id);
                      final isDownloading = provider.isDownloading(version.id);
                      final progress = provider.getDownloadProgress(version.id);

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                        title: Row(
                          children: [
                            Text(
                              version.name,
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                              ),
                            ),
                            if (version.isBundled) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "Padrão",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onSecondaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            Text(
                              "${version.language} • ${version.description}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            if (isDownloading) ...[
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: progress > 0 ? progress : null,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    progress > 0 ? "${(progress * 100).toInt()}%" : "Baixando...",
                                    style: TextStyle(fontSize: 11, color: colorScheme.primary),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                        trailing: _buildTrailingAction(
                          context,
                          version: version,
                          isSelected: isSelected,
                          isInstalled: isInstalled,
                          isDownloading: isDownloading,
                          provider: provider,
                          colorScheme: colorScheme,
                        ),
                        onTap: isInstalled && !isDownloading
                            ? () {
                                provider.setBibleVersion(version.id);
                                Navigator.pop(context);
                              }
                            : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrailingAction(
    BuildContext context, {
    required BibleVersion version,
    required bool isSelected,
    required bool isInstalled,
    required bool isDownloading,
    required BibleProvider provider,
    required ColorScheme colorScheme,
  }) {
    if (isDownloading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2.5),
      );
    }

    if (isSelected) {
      return Icon(
        Icons.check_circle_rounded,
        color: colorScheme.primary,
        size: 26,
      );
    }

    if (isInstalled) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.radio_button_unchecked, size: 24),
            tooltip: "Selecionar versão",
            onPressed: () {
              provider.setBibleVersion(version.id);
              Navigator.pop(context);
            },
          ),
          if (!version.isBundled)
            IconButton(
              icon: Icon(Icons.delete_outline, size: 20, color: colorScheme.error),
              tooltip: "Excluir versão baixada",
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Excluir versão"),
                    content: Text("Deseja remover ${version.name} para liberar espaço no aparelho?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: Text("Excluir", style: TextStyle(color: colorScheme.error)),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await provider.deleteVersion(version);
                }
              },
            ),
        ],
      );
    }

    return FilledButton.tonalIcon(
      onPressed: () async {
        final ok = await provider.downloadVersion(version);
        if (!ok && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Falha ao baixar versão da Bíblia. Verifique sua conexão."),
            ),
          );
        }
      },
      icon: const Icon(Icons.download_rounded, size: 16),
      label: Text(
        "Baixar (${version.sizeDescription})",
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

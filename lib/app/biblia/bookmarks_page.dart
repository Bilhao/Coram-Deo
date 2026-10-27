import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/biblia/annotation_model.dart';
import 'package:coramdeo/app/biblia/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class BibliaBookmarksPage extends StatefulWidget {
  const BibliaBookmarksPage({super.key});

  @override
  State<BibliaBookmarksPage> createState() => _BibliaBookmarksPageState();
}

class _BibliaBookmarksPageState extends State<BibliaBookmarksPage> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final fs = Provider.of<AppProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<BibleProvider>(
      builder: (context, provider, _) {
        final all = provider.allAnnotations;
        final filtered = all.where((item) {
          if (_selectedFilter == 'notes') {
            return item.note.trim().isNotEmpty;
          }
          if (_selectedFilter == 'highlights') {
            return item.colorKey != null && item.colorKey!.isNotEmpty;
          }
          return true;
        }).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Meus Versículos e Destaques",
              style: TextStyle(fontSize: 19),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text("Todos"),
                        selected: _selectedFilter == 'all',
                        onSelected: (_) =>
                            setState(() => _selectedFilter = 'all'),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text("Destaques"),
                        selected: _selectedFilter == 'highlights',
                        onSelected: (_) =>
                            setState(() => _selectedFilter = 'highlights'),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text("Com Nota"),
                        selected: _selectedFilter == 'notes',
                        onSelected: (_) =>
                            setState(() => _selectedFilter = 'notes'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bookmarks_outlined,
                                  size: 56,
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Nenhum versículo salvo ainda",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: fs.fontSize + 1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Toque em qualquer versículo durante a leitura bíblica para destacar com cores, adicionar notas ou compartilhar.",
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 8.0,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final item = filtered[index];
                            final highlightBg =
                                BibleVerseAnnotation.resolveHighlightColor(
                                  context,
                                  item.colorKey,
                                );

                            return Card(
                              elevation: 0,
                              color: colorScheme.secondaryContainer,
                              margin: const EdgeInsets.only(bottom: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10.0),
                                onTap: () async {
                                  if (provider.currentVersion.id !=
                                      item.versionId) {
                                    await provider.setBibleVersion(
                                      item.versionId,
                                    );
                                  }
                                  await provider.updateValues(
                                    testament: item.testament,
                                    book: item.book,
                                    chapter: item.chapter,
                                  );
                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                      context,
                                      '/biblia-page-2',
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${item.book} ${item.chapter}, ${item.verseId} • ${item.versionName}",
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.bold,
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            visualDensity:
                                                VisualDensity.compact,
                                            icon: const Icon(
                                              Icons.copy_outlined,
                                              size: 18,
                                            ),
                                            tooltip: "Copiar citação",
                                            onPressed: () {
                                              Clipboard.setData(
                                                ClipboardData(
                                                  text: item.formattedCitation,
                                                ),
                                              );
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Citação copiada para a área de transferência",
                                                    style: TextStyle(
                                                      color: colorScheme
                                                          .onSecondaryContainer,
                                                    ),
                                                  ),
                                                  backgroundColor: colorScheme
                                                      .secondaryContainer,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10.0,
                                                        ),
                                                  ),
                                                  duration: const Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            visualDensity:
                                                VisualDensity.compact,
                                            icon: const Icon(
                                              Icons.share_outlined,
                                              size: 18,
                                            ),
                                            tooltip: "Compartilhar",
                                            onPressed: () {
                                              Share.share(
                                                item.formattedCitation,
                                              );
                                            },
                                          ),
                                          IconButton(
                                            visualDensity:
                                                VisualDensity.compact,
                                            icon: Icon(
                                              Icons.delete_outline,
                                              size: 18,
                                              color: colorScheme.error,
                                            ),
                                            tooltip: "Remover marcação",
                                            onPressed: () {
                                              provider
                                                  .removeVerseAnnotationByKey(
                                                    item.key,
                                                  );
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        width: double.infinity,
                                        padding: highlightBg != null
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 6.0,
                                              )
                                            : EdgeInsets.zero,
                                        decoration: highlightBg != null
                                            ? BoxDecoration(
                                                color: highlightBg,
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              )
                                            : null,
                                        child: Text(
                                          item.verseText,
                                          style: TextStyle(
                                            fontSize: fs.fontSize,
                                            color: colorScheme
                                                .onSecondaryContainer,
                                          ),
                                        ),
                                      ),
                                      if (item.note.trim().isNotEmpty) ...[
                                        const SizedBox(height: 8),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: colorScheme.surface,
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.notes_rounded,
                                                size: 16,
                                                color: colorScheme.primary,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  item.note,
                                                  style: TextStyle(
                                                    fontSize:
                                                        fs.fontSize - 1.5,
                                                    fontStyle: FontStyle.italic,
                                                    color:
                                                        colorScheme.onSurface,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
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
}

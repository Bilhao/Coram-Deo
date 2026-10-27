import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/biblia/annotation_model.dart';
import 'package:coramdeo/app/biblia/data.dart';
import 'package:coramdeo/app/biblia/provider.dart';
import 'package:coramdeo/app/biblia/widgets/bible_version_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class BibliaPage2 extends StatefulWidget {
  const BibliaPage2({super.key});

  @override
  State<BibliaPage2> createState() => _BibliaPage2State();
}

class _BibliaPage2State extends State<BibliaPage2> {
  final Biblia dbHelper = Biblia();
  final ScrollController _scrollController = ScrollController();

  String _lastBook = '';
  int _lastChapter = -1;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _showVerseOptionsBottomSheet(
    BuildContext context,
    BibleProvider provider,
    String verseId,
    String verseText,
  ) async {
    final existing = provider.getAnnotationForCurrentVerse(verseId);
    String? selectedColor = existing?.colorKey;
    final noteController = TextEditingController(text: existing?.note ?? '');
    final citation =
        '"$verseText"\n— ${provider.book} ${provider.chapter}, $verseId (${provider.currentVersion.name})';

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            final colorScheme = Theme.of(ctx).colorScheme;
            final palette = <MapEntry<String, String>>[
              const MapEntry('yellow', 'Amarelo'),
              const MapEntry('green', 'Verde'),
              const MapEntry('blue', 'Azul'),
              const MapEntry('pink', 'Rosa'),
            ];

            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 4.0,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${provider.book} ${provider.chapter}, $verseId (${provider.currentVersion.name})",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      verseText,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Destaque (Marca-texto)",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (final entry in palette)
                          InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              setModalState(() {
                                selectedColor = selectedColor == entry.key
                                    ? null
                                    : entry.key;
                              });
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: BibleVerseAnnotation
                                    .resolveHighlightColor(
                                  ctx,
                                  entry.key,
                                  alpha: 0.75,
                                ),
                                border: Border.all(
                                  color: selectedColor == entry.key
                                      ? colorScheme.primary
                                      : colorScheme.outlineVariant,
                                  width: selectedColor == entry.key ? 2.5 : 1.0,
                                ),
                              ),
                              child: selectedColor == entry.key
                                  ? Icon(
                                      Icons.check,
                                      size: 20,
                                      color: colorScheme.onSurface,
                                    )
                                  : null,
                            ),
                          ),
                        TextButton.icon(
                          onPressed: () {
                            setModalState(() {
                              selectedColor = null;
                            });
                          },
                          icon: const Icon(Icons.format_color_reset, size: 18),
                          label: const Text("Limpar"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: noteController,
                      textCapitalization: TextCapitalization.sentences,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: "Nota pessoal sobre este versículo",
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: citation));
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Versículo copiado com citação",
                                    style: TextStyle(
                                      color: colorScheme.onSecondaryContainer,
                                    ),
                                  ),
                                  backgroundColor:
                                      colorScheme.secondaryContainer,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: const Icon(Icons.copy_outlined, size: 18),
                            label: const Text("Copiar"),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              Share.share(citation);
                            },
                            icon: const Icon(Icons.share_outlined, size: 18),
                            label: const Text("Compartilhar"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () async {
                          await provider.saveVerseAnnotation(
                            verseId: verseId,
                            verseText: verseText,
                            colorKey: selectedColor,
                            note: noteController.text,
                          );
                          if (ctx.mounted) {
                            Navigator.pop(ctx);
                          }
                        },
                        icon: const Icon(Icons.bookmark_added_outlined),
                        label: const Text("Salvar marcação"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BibleProvider, AppProvider>(
      builder: (context, provider, fs, child) {
        if (_lastBook != provider.book || _lastChapter != provider.chapter) {
          _lastBook = provider.book;
          _lastChapter = provider.chapter;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(0);
            }
          });
        }
        final colorScheme = Theme.of(context).colorScheme;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              provider.book,
              maxLines: 2,
              style: const TextStyle(fontSize: 20),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmarks_outlined),
                tooltip: 'Meus Versículos e Destaques',
                onPressed: () {
                  Navigator.pushNamed(context, '/biblia-marcacoes');
                },
              ),
              IconButton(
                icon: const Icon(Icons.translate),
                tooltip: 'Mudar Versão',
                onPressed: () {
                  BibleVersionBottomSheet.show(context);
                },
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
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                key: const GlobalObjectKey('chapter'),
                                "Capítulo ${provider.chapter}",
                                style: TextStyle(fontSize: fs.fontSize + 4),
                              ),
                            ),
                            const Divider(
                              height: 15,
                              color: Colors.transparent,
                            ),
                            for (int i = 0; i < provider.versesId.length; i++)
                              Builder(
                                builder: (context) {
                                  final vId = provider.versesId[i];
                                  final vText = provider.verses[i];
                                  final ann = provider
                                      .getAnnotationForCurrentVerse(vId);
                                  final highlightBg =
                                      BibleVerseAnnotation
                                          .resolveHighlightColor(
                                        context,
                                        ann?.colorKey,
                                      );
                                  final hasNote =
                                      ann != null && ann.note.trim().isNotEmpty;

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8.0),
                                      onTap: () => _showVerseOptionsBottomSheet(
                                        context,
                                        provider,
                                        vId,
                                        vText,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                          vertical: 4.0,
                                        ),
                                        decoration: highlightBg != null
                                            ? BoxDecoration(
                                                color: highlightBg,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              )
                                            : null,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "$vId.  ",
                                                    style: TextStyle(
                                                      fontSize: fs.fontSize - 4,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: vText,
                                                    style: TextStyle(
                                                      fontSize: fs.fontSize,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (hasNote) ...[
                                              const SizedBox(height: 6),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5.0,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: colorScheme
                                                      .secondaryContainer,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        6.0,
                                                      ),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.notes_rounded,
                                                      size: 15,
                                                      color:
                                                          colorScheme.primary,
                                                    ),
                                                    const SizedBox(width: 6),
                                                    Expanded(
                                                      child: Text(
                                                        ann.note,
                                                        style: TextStyle(
                                                          fontSize:
                                                              fs.fontSize - 2,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: colorScheme
                                                              .onSecondaryContainer,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      left: 8.0,
                      top: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      border: Border(
                        top: BorderSide(
                          color: colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed:
                              provider.bookId == 1 && provider.chapter == 1
                              ? null
                              : () {
                                  provider.goToPreviousChapter();
                                },
                          icon: const Icon(Icons.arrow_back),
                          color: colorScheme.primary,
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        Text(
                          "${provider.book} - ${provider.chapter}",
                          style: const TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                          onPressed:
                              provider.bookId == 73 && provider.chapter == 22
                              ? null
                              : () {
                                  provider.goToNextChapter();
                                },
                          icon: const Icon(Icons.arrow_forward),
                          color: colorScheme.primary,
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

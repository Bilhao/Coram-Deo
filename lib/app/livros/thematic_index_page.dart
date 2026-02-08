import 'package:coramdeo/app/livros/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ThematicIndexPage extends StatefulWidget {
  const ThematicIndexPage({super.key, required this.bookName});

  final String bookName;

  @override
  State<ThematicIndexPage> createState() => _ThematicIndexPageState();
}

class _ThematicIndexPageState extends State<ThematicIndexPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookIndexProvider(bookName: widget.bookName),
      child: Consumer<BookIndexProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.thematicIndex.isEmpty) {
            return const Center(child: Text("Índice temático indisponível."));
          }

          final keys = provider.thematicIndex.keys.toList()..sort();
          final Set<String> alphabetSet = {};
          for (var key in keys) {
            if (key.isNotEmpty) {
              alphabetSet.add(key[0].toUpperCase());
            }
          }
          final List<String> alphabet = alphabetSet.toList()..sort();

          return Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: alphabet.length,
                  itemBuilder: (context, index) {
                    final letter = alphabet[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        final indexToJump = keys.indexWhere((k) => k.toUpperCase().startsWith(letter));
                        if (indexToJump != -1) {
                          itemScrollController.scrollTo(index: indexToJump, duration: const Duration(milliseconds: 700), curve: Curves.decelerate);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Center(
                          child: Text(
                            letter,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final theme = keys[index];
                    final subthemes = provider.thematicIndex[theme]!;

                    // Sort subthemes: "Geral" first, then alphabetical
                    final subthemeKeys = subthemes.keys.toList()
                      ..sort((a, b) {
                        if (a == "Geral") return -1;
                        if (b == "Geral") return 1;
                        return a.compareTo(b);
                      });

                    return ExpansionTile(
                      title: Text(theme, style: const TextStyle(fontWeight: FontWeight.w600)),
                      children: subthemeKeys.map((subthemeKey) {
                        final points = subthemes[subthemeKey]!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (subthemeKey != "Geral")
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                                  child: Text(
                                    subthemeKey,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ),
                              Wrap(
                                spacing: 5.0,
                                children: points.map((point) {
                                  return FilledButton.tonal(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/book-reading',
                                        arguments: {
                                          'bookName': widget.bookName,
                                          'points': [point],
                                        },
                                      );
                                    },
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                      fixedSize: WidgetStateProperty.all<Size>(const Size(40, 40)),
                                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                                    ),
                                    child: Text(point.toString()),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

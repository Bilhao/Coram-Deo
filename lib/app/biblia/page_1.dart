import 'package:flutter/material.dart';
import 'package:coramdeo/app/biblia/provider.dart';
import 'package:coramdeo/app/biblia/version_selector.dart';
import 'package:provider/provider.dart';

class BibliaPage1 extends StatelessWidget {
  const BibliaPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BibleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Bíblia"),
            Text(
              provider.currentVersionInfo.name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.library_books),
            tooltip: 'Selecionar versão',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const BibleVersionDialog(),
              );
            },
          ),
          const BibleVersionSelector(),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ExpansionTile(
                    title: const Text("Antigo Testamento", style: TextStyle(fontSize: 18)),
                    children: [
                      for (String book in provider.oldBooks) ...{
                        ExpansionTile(
                          title: Text(book),
                          onExpansionChanged: (expanded) async {
                            if (expanded) {
                              await provider.updateBookChapters(book: book);
                            }
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                              child: Wrap(
                                spacing: 5,
                                children: [
                                  for (int chapter in provider.bookChapters[book] ?? [])
                                    FilledButton.tonal(
                                      onPressed: () {
                                        provider.updateValues(testament: "Old", book: book, chapter: chapter);
                                        Navigator.pushNamed(context, "/biblia-page-2");
                                      },
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                        ),
                                      ),
                                      child: Text("$chapter"),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      }
                    ],
                  ),
                  ExpansionTile(
                    title: const Text("Novo Testamento", style: TextStyle(fontSize: 18)),
                    children: [
                      for (String book in provider.newBooks)
                        ExpansionTile(
                          title: Text(book),
                          onExpansionChanged: (expanded) async {
                            if (expanded) {
                              await provider.updateBookChapters(book: book);
                            }
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                              child: Wrap(
                                spacing: 5,
                                children: [
                                  for (int chapter in provider.bookChapters[book] ?? [])
                                    FilledButton.tonal(
                                      onPressed: () {
                                        provider.updateValues(testament: "New", book: book, chapter: chapter);
                                        Navigator.pushNamed(context, "/biblia-page-2");
                                      },
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      child: Text("$chapter"),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
              child: FilledButton.tonal(
                onPressed: () {
                  Navigator.pushNamed(context, '/biblia-page-2');
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Text("Continuar última leitura", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

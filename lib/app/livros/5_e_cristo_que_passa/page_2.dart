import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/livros/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ECristoQuePassaReadingPage extends StatefulWidget {
  final String bookName;

  const ECristoQuePassaReadingPage({super.key, required this.bookName});

  @override
  State<ECristoQuePassaReadingPage> createState() => _ECristoQuePassaReadingPageState();
}

class _ECristoQuePassaReadingPageState extends State<ECristoQuePassaReadingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookIndexProvider(bookName: widget.bookName),
      child: Consumer2<BookIndexProvider, AppProvider>(
        builder: (context, provider, fs, child) => Scaffold(
          appBar: AppBar(
            title: Text(provider.currentChapterName),
            actions: [
              IconButton(onPressed: fs.decreaseFontSize, icon: const Icon(Icons.remove)),
              IconButton(onPressed: fs.increaseFontSize, icon: const Icon(Icons.add)),
            ],
          ),
          body: SafeArea(
            child: SelectionArea(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              provider.contentIds.length != 1
                                  ? ExpansionTile(
                                      title: const Text("Pontos do capítulo", style: TextStyle(fontSize: 18)),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Wrap(
                                            spacing: 5,
                                            children: [
                                              for (int id in provider.contentIds) ...[
                                                FilledButton.tonal(
                                                  onPressed: () => Scrollable.ensureVisible(GlobalObjectKey(id).currentContext!, duration: const Duration(milliseconds: 700), curve: Curves.decelerate),
                                                  style: ButtonStyle(
                                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text("$id"),
                                                )
                                              ]
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              for (int i = 0; i < provider.contentIds.length; i++) ...[
                                const Divider(height: 15, color: Colors.transparent),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Text.rich(
                                      key: GlobalObjectKey(provider.contentIds[i]),
                                      TextSpan(children: [
                                        TextSpan(text: provider.contentIds[i] == 0 ? "" : "${provider.contentIds[i]}\n", style: TextStyle(fontSize: fs.fontSize + 3, fontWeight: FontWeight.bold)),
                                        TextSpan(text: provider.content[i], style: TextStyle(fontSize: fs.fontSize)),
                                      ])),
                                ),
                              ],
                              const Divider(height: 15, color: Colors.transparent),
                            ],
                          )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: provider.currentChapterId == provider.fistChapterId
                                  ? null
                                  : () {
                                      provider.changeChapter(provider.currentChapterId - provider.fistChapterId - 1);
                                    },
                              icon: const Icon(Icons.arrow_back),
                              color: Theme.of(context).colorScheme.primary,
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
                                child: Text(
                                  "${provider.currentChapterId} - ${provider.currentChapterName}",
                                  style: const TextStyle(fontSize: 16.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: provider.currentChapterId == provider.chapterIds.length + provider.fistChapterId - 1
                                  ? null
                                  : () {
                                      setState(() {
                                        provider.changeChapter(provider.currentChapterId - provider.fistChapterId + 1);
                                      });
                                    },
                              icon: const Icon(Icons.arrow_forward),
                              color: Theme.of(context).colorScheme.primary,
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

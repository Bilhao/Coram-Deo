import 'package:flutter/material.dart';
import 'package:coramdeo/models/bible.dart';
import 'package:coramdeo/providers/bible_provider.dart';
import 'package:provider/provider.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final Biblia dbHelper = Biblia();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BibleProvider(),
      child: Consumer<BibleProvider>(
        builder: (context, provider, child) {
          bool isFirstBookAndChapter =
              provider.bookId == 1 && provider.chapter == 1;
          bool isLastBookAndChapter =
              provider.bookId == 66 && provider.chapter == 22;
          return Scaffold(
            appBar: AppBar(
              title: Text(provider.book),
              actions: [
                IconButton(
                  onPressed: provider.decreaseFontSize,
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: provider.increaseFontSize,
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
                        child: ListView(
                          controller: _scrollController,
                          children: [
                            Text(
                              "Capítulo ${provider.chapter}",
                              style: TextStyle(fontSize: provider.fontsize + 4),
                              textAlign: TextAlign.center,
                            ),
                            const Divider(height: 15, color: Colors.transparent),
                            ...provider.verses
                                .asMap()
                                .entries
                                .map((entry) => Container(
                                      padding: const EdgeInsets.only(bottom: 10.0),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "${entry.key + 1}.  ",
                                              style: TextStyle(
                                                  fontSize: provider.fontsize - 4,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                            TextSpan(
                                              text: entry.value,
                                              style: TextStyle(fontSize: provider.fontsize),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          ],
                        ),
                      ),
                    ),
                    NavigationControls(
                      isFirstBookAndChapter: isFirstBookAndChapter,
                      isLastBookAndChapter: isLastBookAndChapter,
                      provider: provider,
                      goToNextChapter: goToNextChapter,
                      goToPreviousChapter: goToPreviousChapter,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> goToNextChapter(BibleProvider provider) async {
    int lastChapter = await dbHelper.getLastChapterOfBook(provider.book);
    String testament = provider.bookId > 39 ? "New" : "Old";
    await provider.setTestament(testament);

    if (provider.chapter < lastChapter) {
      await updateProvider(provider, provider.bookId, provider.book, provider.chapter + 1);
    } else {
      String newBook = await dbHelper.getBookById(provider.bookId + 1);
      await updateProvider(provider, provider.bookId + 1, newBook, 1);
    }
    await provider.load();
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  Future<void> goToPreviousChapter(BibleProvider provider) async {
    String testament = provider.bookId > 39 ? "New" : "Old";
    await provider.setTestament(testament);

    if (provider.chapter > 1) {
      await updateProvider(provider, provider.bookId, provider.book, provider.chapter - 1);
    } else {
      String newBook = await dbHelper.getBookById(provider.bookId - 1);
      int lastChapter = await dbHelper.getLastChapterOfBook(newBook);
      await updateProvider(provider, provider.bookId - 1, newBook, lastChapter);
    }
    await provider.load();
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  Future<void> updateProvider(BibleProvider provider, int bookId, String book, int chapter) async {
    await provider.setBookId(bookId);
    await provider.setBook(book);
    await provider.setChapter(chapter);
    await provider.setVersesId(await dbHelper.getVersesId(book, chapter));
    await provider.setVerses(await dbHelper.getVerses(book, chapter));
  }
}

class NavigationControls extends StatelessWidget {
  final bool isFirstBookAndChapter;
  final bool isLastBookAndChapter;
  final BibleProvider provider;
  final Function(BibleProvider) goToNextChapter;
  final Function(BibleProvider) goToPreviousChapter;

  const NavigationControls({
    super.key,
    required this.isFirstBookAndChapter,
    required this.isLastBookAndChapter,
    required this.provider,
    required this.goToNextChapter,
    required this.goToPreviousChapter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: isFirstBookAndChapter ? null : () => goToPreviousChapter(provider),
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).colorScheme.primary,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        Text(
          "${provider.book} - ${provider.chapter}",
          style: const TextStyle(fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        IconButton(
          onPressed: isLastBookAndChapter ? null : () => goToNextChapter(provider),
          icon: const Icon(Icons.arrow_forward),
          color: Theme.of(context).colorScheme.primary,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      ],
    );
  }
}

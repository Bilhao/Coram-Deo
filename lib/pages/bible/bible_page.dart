import 'package:flutter/material.dart';
import 'package:coramdeo/models/bible.dart';
import 'package:coramdeo/providers/bible_provider.dart';

class BiblePage extends StatefulWidget {
  const BiblePage({super.key});

  @override
  State<BiblePage> createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  final Biblia dbHelper = Biblia();
  final BibleProvider bibleProvider = BibleProvider();

  List<String> oldTestamentBooks = [];
  List<String> newTestamentBooks = [];
  Map<String, List<int>> bookChapters = {};

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    final oldBooks = await dbHelper.getBooks('Old');
    final newBooks = await dbHelper.getBooks('New');

    setState(() {
      oldTestamentBooks = oldBooks;
      newTestamentBooks = newBooks;
    });
  }

  Future<void> getChapters(String book) async {
    if (!bookChapters.containsKey(book)) {
      final chapters = await dbHelper.getChapters(book);
      setState(() {
        bookChapters[book] = chapters;
      });
    }
  }

  Future<void> onChapterPressed(
      String testament, String book, int chapter) async {
    final bookId = await dbHelper.getBookId(book);
    await bibleProvider.setTestament(testament);
    await bibleProvider.setBookId(bookId);
    await bibleProvider.setBook(book);
    await bibleProvider.setChapter(chapter);
    await bibleProvider.setVersesId(await dbHelper.getVersesId(book, chapter));
    await bibleProvider.setVerses(await dbHelper.getVerses(book, chapter));
    await bibleProvider.load();
    Navigator.pushNamed(context, '/reading');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bíblia"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  TestamentExpansionTile(
                    title: "Antigo Testamento",
                    books: oldTestamentBooks,
                    onExpansionChanged: getChapters,
                    bookChapters: bookChapters,
                    onChapterPressed: (book, chapter) =>
                        onChapterPressed("Old", book, chapter),
                  ),
                  TestamentExpansionTile(
                    title: "Novo Testamento",
                    books: newTestamentBooks,
                    onExpansionChanged: getChapters,
                    bookChapters: bookChapters,
                    onChapterPressed: (book, chapter) =>
                        onChapterPressed("New", book, chapter),
                  ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
              child: FilledButton.tonal(
                onPressed: () {
                  Navigator.pushNamed(context, '/reading');
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

class TestamentExpansionTile extends StatelessWidget {
  final String title;
  final List<String> books;
  final ValueChanged<String> onExpansionChanged;
  final Map<String, List<int>> bookChapters;
  final Function(String, int) onChapterPressed;

  const TestamentExpansionTile({
    super.key,
    required this.title,
    required this.books,
    required this.onExpansionChanged,
    required this.bookChapters,
    required this.onChapterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontSize: 18)),
      children: [
        for (String book in books)
          ExpansionTile(
            title: Text(book),
            onExpansionChanged: (expanded) {
              if (expanded) {
                onExpansionChanged(book);
              }
            },
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0, left: 10.0, right: 10.0),
                child: Wrap(
                  spacing: 5,
                  children: [
                    for (int chapter in bookChapters[book] ?? [])
                      FilledButton.tonal(
                        onPressed: () => onChapterPressed(book, chapter),
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
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
    );
  }
}

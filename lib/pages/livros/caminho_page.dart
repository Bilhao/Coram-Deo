import 'package:coramdeo/providers/livros_providers/book_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaminhoPage extends StatefulWidget {
  const CaminhoPage({super.key});

  @override
  State<CaminhoPage> createState() => _CaminhoPageState();
}

class _CaminhoPageState extends State<CaminhoPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Caminho"),
          ),
          bottomNavigationBar: SafeArea(
            child: TabBar(
                onTap: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.format_list_numbered),
                    text: "Índice",
                  ),
                  Tab(
                    icon: Icon(Icons.format_list_bulleted),
                    text: "Índice Temático",
                  ),
                  Tab(
                    icon: Icon(Icons.info_outline),
                    text: "Sobre",
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              const Indice(),
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.watch_later_outlined, size: 80), Divider(height: 15, color: Colors.transparent), Text("Em desenvimento", style: TextStyle(fontSize: 18))],
                ),
              ),
              Container(),
            ],
          ),
          floatingActionButton: _selectedIndex == 0
              ? FloatingActionButton.extended(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/book-reading', arguments: {"bookName": "caminho"});
                  },
                  label: const Text("Continuar leitura"),
                  icon: const Icon(Icons.chevron_right),
                )
              : null),
    );
  }
}

class Indice extends StatefulWidget {
  const Indice({super.key});

  @override
  State<Indice> createState() => _IndiceState();
}

class _IndiceState extends State<Indice> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookIndexProvider(bookName: "caminho"),
      child: Consumer<BookIndexProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.chapterIds.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(provider.chapterNames[index], style: const TextStyle(fontSize: 18)),
              leading: Text("${provider.chapterIds[index]}", style: const TextStyle(fontSize: 18)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                provider.changeChapter(index);
                Navigator.pushNamed(context, '/book-reading', arguments: {"bookName": "caminho"});
              },
            );
          },
        ),
      ),
    );
  }
}

class IndiceTematico extends StatelessWidget {
  const IndiceTematico({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "L", "M", "N", "O", "P", "R", "S", "T", "U", "V"];

    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              key: const GlobalObjectKey("menu"),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Wrap(
                runSpacing: 5,
                children: [
                  for (String letter in letters) ...{
                    IconButton(
                        icon: Text(letter),
                        onPressed: () {
                          Scrollable.ensureVisible(GlobalObjectKey(letter).currentContext!, duration: const Duration(milliseconds: 500));
                        })
                  }
                ],
              ),
            ),
          ),
        ),
        const Divider(height: 15, color: Colors.transparent),
        const LetterTile(letter: "A"),
        const ClickableText(isTitle: true, text: "Abandono em Deus", points: [113, 389, 472, 498, 659, 691, 731, 732, 760, 766, 767, 768, 853, 864, 912]),
        const ClickableText(isTitle: false, text: "nas dificuldade econômicas", points: [363, 481, 487]),
        const ClickableText(isTitle: false, text: "por meio da luta confiada", points: [95, 314, 719, 721, 722, 729, 733]),
        const ClickableText(isTitle: false, text: "através de Nossa Senhora", points: [498]),
        const ClickableText(isTitle: true, text: "Abnegação", points: [498]),
      ]),
    );
  }
}

class ClickableText extends StatelessWidget {
  const ClickableText({super.key, required this.isTitle, required this.text, required this.points});

  final bool isTitle;
  final String text;
  final List<int> points;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookIndexProvider(bookName: "caminho"),
      child: Consumer<BookIndexProvider>(
        builder: (context, provider, child) => InkWell(
          onTap: () {
            provider.changeContentForThemeIndex(points, text);
            Navigator.pushNamed(context, '/book-reading', arguments: {"bookName": "caminho"});
          },
          child: Text(text, style: TextStyle(fontSize: isTitle ? 22 : 18, decoration: points.isNotEmpty ? TextDecoration.underline : TextDecoration.none)),
        ),
      ),
    );
  }
}

class LetterTile extends StatelessWidget {
  const LetterTile({super.key, required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text("A"),
      IconButton(
        onPressed: () => Scrollable.ensureVisible(const GlobalObjectKey("menu").currentContext!, duration: const Duration(milliseconds: 500)),
        icon: const Icon(Icons.move_up),
      )
    ]);
  }
}

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

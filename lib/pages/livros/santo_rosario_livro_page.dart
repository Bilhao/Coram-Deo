import 'package:coramdeo/providers/livros_providers/book_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SantoRosarioLivroPage extends StatefulWidget {
  const SantoRosarioLivroPage({super.key});

  @override
  State<SantoRosarioLivroPage> createState() => _SantoRosarioLivroPageState();
}

class _SantoRosarioLivroPageState extends State<SantoRosarioLivroPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Santo Rosário (Livro)"),
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
                    icon: Icon(Icons.info_outline),
                    text: "Sobre",
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              const Indice(),
              Container(),
            ],
          ),
          floatingActionButton: _selectedIndex == 0
              ? FloatingActionButton.extended(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/book-reading',
                        arguments: {"bookName": "santo_rosario_livro"});
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
      create: (context) => BookIndexProvider(bookName: "santo_rosario_livro"),
      child: Consumer<BookIndexProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.chapterIds.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(provider.chapterNames[index],
                  style: const TextStyle(fontSize: 18)),
              leading: Text("${provider.chapterIds[index]}",
                  style: const TextStyle(fontSize: 18)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                provider.changeChapter(index);
                Navigator.pushNamed(context, '/book-reading',
                    arguments: {"bookName": "santo_rosario_livro"});
              },
            );
          },
        ),
      ),
    );
  }
}

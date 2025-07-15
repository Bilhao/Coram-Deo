import 'package:coramdeo/app/livros/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViaSacraLivroPage extends StatefulWidget {
  const ViaSacraLivroPage({super.key});

  @override
  State<ViaSacraLivroPage> createState() => _ViaSacraLivroPageState();
}

class _ViaSacraLivroPageState extends State<ViaSacraLivroPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Via Sacra"),
            subtitle: const Text("Baseado nos ensinamentos de São Josemaría"),
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
                    Navigator.pushNamed(context, '/book-reading', arguments: {"bookName": "via_sacra_livro"});
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
      create: (context) => BookIndexProvider(bookName: "via_sacra_livro"),
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
                Navigator.pushNamed(context, '/book-reading', arguments: {"bookName": "via_sacra_livro"});
              },
            );
          },
        ),
      ),
    );
  }
}

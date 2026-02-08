import 'package:coramdeo/app/livros/provider.dart';
import 'package:coramdeo/app/livros/thematic_index_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ECristoQuePassaPage extends StatefulWidget {
  const ECristoQuePassaPage({super.key});

  @override
  State<ECristoQuePassaPage> createState() => _ECristoQuePassaPageState();
}

class _ECristoQuePassaPageState extends State<ECristoQuePassaPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(title: const Text("É Cristo Que Passa", maxLines: 2, style: TextStyle(fontSize: 20))),
        bottomNavigationBar: SafeArea(
          child: TabBar(
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(icon: Icon(Icons.format_list_numbered), text: "Índice"),
              Tab(icon: Icon(Icons.format_list_bulleted), text: "Índice Temático"),
              Tab(icon: Icon(Icons.info_outline), text: "Sobre"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Indice(),
            const ThematicIndexPage(bookName: "e_cristo_que_passa"),
            const Sobre(),
          ],
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton.extended(
                onPressed: () async {
                  Navigator.pushNamed(context, '/book-reading', arguments: {"bookName": "e_cristo_que_passa"});
                },
                label: const Text("Continuar leitura"),
                icon: const Icon(Icons.chevron_right),
              )
            : null,
      ),
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
      create: (context) => BookIndexProvider(bookName: "e_cristo_que_passa"),
      child: Consumer<BookIndexProvider>(
        builder: (context, provider, child) => ListView.builder(
          padding: EdgeInsets.only(bottom: 80.0),
          itemCount: provider.chapterIds.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(provider.chapterNames[index], style: const TextStyle(fontSize: 18)),
              leading: Text("${provider.chapterIds[index]}", style: const TextStyle(fontSize: 18)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                await provider.changeChapter(index);
                Navigator.pushNamed(context, '/book-reading', arguments: {"bookName": "e_cristo_que_passa"});
              },
            );
          },
        ),
      ),
    );
  }
}

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookIndexProvider(bookName: "e_cristo_que_passa"),
      child: Consumer<BookIndexProvider>(
        builder: (context, provider, child) => provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(image: AssetImage(provider.imagePath), width: 250, fit: BoxFit.cover),
                    ),
                    const Divider(height: 15, color: Colors.transparent),
                    Text(provider.aboutContent, style: const TextStyle(fontSize: 16, height: 1.6), textAlign: TextAlign.justify),
                  ],
                ),
              ),
      ),
    );
  }
}

import 'package:coramdeo/app/livros/provider.dart';
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
          appBar: AppBar(
            title: const Text("É Cristo Que Passa"),
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
                    Navigator.pushNamed(context, '/e-cristo-que-passa-reading', arguments: {"bookName": "e_cristo_que_passa"});
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
      create: (context) => BookIndexProvider(bookName: "e_cristo_que_passa"),
      child: Consumer<BookIndexProvider>(
        builder: (context, provider, child) => ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: provider.chapterIds.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(provider.chapterNames[index], style: const TextStyle(fontSize: 18)),
              leading: Text("${provider.chapterIds[index]}", style: const TextStyle(fontSize: 18)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                provider.changeChapter(index);
                Navigator.pushNamed(context, '/e-cristo-que-passa-reading', arguments: {"bookName": "e_cristo_que_passa"});
              },
            );
          },
        ),
      ),
    );
  }
}

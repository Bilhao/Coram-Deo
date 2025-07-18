import 'package:coramdeo/app/livros/7_via_sacra/provider.dart';
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
            title: const Text("Via Sacra (Livro)"),
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
                    Navigator.pushNamed(context, '/via-sacra-reading');
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
      create: (context) => ViaSacraProvider(),
      child: Consumer<ViaSacraProvider>(
        builder: (context, provider, child) => ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: provider.chapterIds.length,
          itemBuilder: (context, index) {
            final match = RegExp(r'^[IVXLCDM]+ Estação:').firstMatch(provider.chapterNames[index]);
            final leadingText = match?.group(0) ?? '';
            final titleText = leadingText.isNotEmpty ? provider.chapterNames[index].substring(leadingText.length).trim() : provider.chapterNames[index];

            return ListTile(
              leading: provider.chapterNames[index] == "Introdução" ? null : Text(leadingText, style: const TextStyle(fontSize: 17)),
              title: Text(titleText, style: const TextStyle(fontSize: 18)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                provider.changeChapter(index);
                Navigator.pushNamed(context, '/via-sacra-reading');
              },
            );
          },
        ),
      ),
    );
  }
}

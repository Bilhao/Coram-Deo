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
              const Sobre(),
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

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sobre a Via Sacra",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            "A Via Sacra é uma devoção cristã que comemora a paixão e morte de Jesus Cristo. É constituída por catorze estações que representam episódios da última jornada de Cristo, desde a sua condenação à morte por Pilatos até ao momento em que é colocado no sepulcro.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            "Esta versão da Via Sacra foi escrita por São Josemaria Escrivá, fundador do Opus Dei, e oferece uma meditação profunda sobre cada momento da Paixão de Cristo. Através de cada estação, somos convidados a acompanhar Jesus no seu caminho de sofrimento e amor, refletindo sobre o significado da Cruz em nossas vidas.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            "As meditações de São Josemaria nos ajudam a compreender melhor o amor de Deus por nós e nos inspiram a viver uma vida cristã mais intensa, seguindo o exemplo de Cristo em nossa jornada diária.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            "Cada estação inclui tanto a narrativa dos acontecimentos quanto pontos específicos de meditação que nos ajudam a aplicar os ensinamentos da Paixão de Cristo em nossa vida espiritual.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

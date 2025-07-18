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
            title: const Text("Via Sacra"),
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
          padding: EdgeInsets.only(bottom: 80.0),
          itemCount: provider.chapterIds.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(provider.chapterNames[index].split(': ').last, style: const TextStyle(fontSize: 18)),
              leading: provider.chapterIds[index] == 0 ? null : Text(provider.chapterNames[index].split(': ').first, style: const TextStyle(fontSize: 18)),
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

class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ViaSacraProvider(),
      child: Consumer<ViaSacraProvider>(
        builder: (context, provider, child) => provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        frameBuilder: (BuildContext context, Widget child, int? frame, bool? wasSynchronouslyLoaded) {
                          return child;
                        },
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                        image: AssetImage("assets/images/capas_livros/via-sacra.jpg"),
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Divider(height: 15, color: Colors.transparent),
                    Text(
                      provider.aboutContent,
                      style: const TextStyle(fontSize: 16, height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

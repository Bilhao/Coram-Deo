import 'package:flutter/material.dart';

class LivrosPage extends StatefulWidget {
  const LivrosPage({super.key});

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Livros'),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView(children: [
              ListTile(
                title: const Text("Caminho", style: TextStyle(fontSize: 18)),
                onTap: () => Navigator.pushNamed(context, '/caminho'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: const Text("Sulco", style: TextStyle(fontSize: 18)),
                onTap: () => Navigator.pushNamed(context, '/sulco'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: const Text("Forja", style: TextStyle(fontSize: 18)),
                onTap: () => Navigator.pushNamed(context, '/forja'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: const Text("Amigos de Deus",
                    style: TextStyle(fontSize: 18)),
                onTap: () => Navigator.pushNamed(context, '/amigos-de-deus'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: const Text("É Cristo que Passa",
                    style: TextStyle(fontSize: 18)),
                onTap: () =>
                    Navigator.pushNamed(context, '/e-cristo-que-passa'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: const Text("Santo Rosário (Livro)",
                    style: TextStyle(fontSize: 18)),
                onTap: () =>
                    Navigator.pushNamed(context, '/santo-rosario-livro'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: const Text("Via Sacra (Livro)",
                    style: TextStyle(fontSize: 18)),
                onTap: () => Navigator.pushNamed(context, '/via-sacra-livro'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ]))
          ],
        ));
  }
}

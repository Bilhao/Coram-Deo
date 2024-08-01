import 'package:flutter/material.dart';

class OracoesPage extends StatefulWidget {
  const OracoesPage({super.key});

  @override
  State<OracoesPage> createState() => _OracoesPageState();
}

class _OracoesPageState extends State<OracoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orações'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text("Meditação Diária do Falar com Deus", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/falar-com-deus'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
                ListTile(
                  title: const Text("Ângelus/Regina Cæli", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/angelus-regina-caeli'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
                ListTile(
                  title: const Text("Comentário do Evangelho do dia", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/comentario-do-evangelho-do-dia'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
                ListTile(
                  title: const Text("Credo Niceno-Constantinopolitano", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/credo'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
                ListTile(
                  title: const Text("Lembrai-vos", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/lembrai-vos'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
                ListTile(
                  title: const Text("Oferecimento de Obras", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/oferecimento-de-obras'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
                ListTile(
                  title: const Text("Preces", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/preces'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
                ListTile(
                  title: const Text("Santo Rosário", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/santo-rosario'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
                ListTile(
                  title: const Text("Te Deum", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/te-deum'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
                ListTile(
                  title: const Text("Via Sacra", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/via-sacra'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
                ListTile(
                  title: const Text("Visita ao Santíssimo", style: TextStyle(fontSize: 18)),
                  onTap: () => Navigator.pushNamed(context, '/visita-ao-santissimo'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 0),
              ]
            ),
          ),
        ],
      ),
    );
  }
}

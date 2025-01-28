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
        title: Text('Orações'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: [
              ListTile(
                title: Text("Oferecimento de Obras", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/oferecimento-de-obras'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Comentário do Evangelho do dia", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/comentario-do-evangelho-do-dia'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Meditação Diária do Falar com Deus", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/falar-com-deus'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Ângelus/Regina Cæli", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/angelus-regina-caeli'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Lembrai-vos", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/lembrai-vos'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Preces", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/preces'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Credo Niceno-Constantinopolitano", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/credo'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Santo Rosário", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/santo-rosario'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Te Deum", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/te-deum'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Visita ao Santíssimo", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/visita-ao-santissimo'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Adoro Te Devote", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/adoro-te-devote'),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Salmo 2", style: TextStyle(fontSize: 18.0)),
                onTap: () => Navigator.pushNamed(context, '/salmo-2'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

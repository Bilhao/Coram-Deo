import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/oracoes/provider.dart';

class OracoesPage extends StatefulWidget {
  const OracoesPage({super.key});

  @override
  State<OracoesPage> createState() => _OracoesPageState();
}

class _OracoesPageState extends State<OracoesPage> {

  final Map<String, String> routeToName = {
    "oferecimento-de-obras": "Oferecimento de Obras",
    "comentario-do-evangelho-do-dia": "Comentário do Evangelho do dia",
    "falar-com-deus": "Meditação Diária do Falar com Deus",
    "angelus-regina-caeli": "Angelus/Regina Cæli",
    "lembrai-vos": "Lembrai-Vos",
    "preces": "Preces",
    "credo": "Credo Niceno-Constantinopolitano",
    "santo-rosario": "Santo Rosário",
    "te-deum": "Te Deum",
    "visita-ao-santissimo": "Visita ao Santíssimo",
    "adoro-te-devote": "Adoro Te Devote",
    "salmo-2": "Salmo 2",
    "exame-de-consciencia-oracao": "Exame de Consciência",
    "estampa-josemaria": "Estampa de São Josemaría",
    "gratias-tibi-ago": "Gratias tibi ago",
  };

  Widget itembuild(String title, String route) {
    return Consumer<OracoesProvider>(
      builder: (context, provider, child) => ListTile(
        title: Text(title, style: const TextStyle(fontSize: 17.0)),
        onTap: () => Navigator.pushNamed(context, '/$route'),
        leading: const Icon(Icons.chevron_right),
        trailing: IconButton(
          onPressed: () {
            provider.toggleFavorita(route);
          },
          icon: provider.favoritas.contains(route)
              ? Icon(Icons.star, color: Theme.of(context).colorScheme.primary)
              : const Icon(Icons.star_border),
        )
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OracoesProvider>(
      create: (context) => OracoesProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Orações'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<OracoesProvider>(
                builder: (context, provider, child) {
                  return ExpansionTile(
                    title: Text("Favoritas", style: TextStyle(fontSize: 18.0)),
                    initiallyExpanded: true,
                    shape: const Border(),
                    children: [
                      for (String route in provider.favoritas)
                        itembuild(routeToName[route]!, route),
                    ],
                  );
                }
              ),
              
              ExpansionTile(
                title: const Text("Todas", style: TextStyle(fontSize: 18.0)),
                initiallyExpanded: false,
                shape: const Border(),
                children: [
                  for (String route in routeToName.keys)
                    itembuild(routeToName[route]!, route),
                ],
              ),
              const Divider(height: 40, color: Colors.transparent),
            ],
          ),
        ),
      )
    );
  }
}

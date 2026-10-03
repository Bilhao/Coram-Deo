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
    "adoracao-e-bencao-com-o-santissimo": "Adoração e Bênção com o Santíssimo",
    "adoro-te-devote": "Adoro Te Devote",
    "angelus-regina-caeli": "Angelus/Regina Cæli",
    "comentario-do-evangelho-do-dia": "Comentário do Evangelho do dia",
    "credo-atanasiano": "Credo Atanasiano",
    "credo": "Credo Niceno-Constantinopolitano",
    "estampa-josemaria": "Estampa de São Josemaría",
    "exame-de-consciencia-oracao": "Exame de Consciência",
    "gratias-tibi-ago": "Gratias tibi ago",
    "lembrai-vos": "Lembrai-Vos",
    "falar-com-deus": "Meditação Diária do Falar com Deus",
    "oferecimento-de-obras": "Oferecimento de Obras",
    "preces": "Preces",
    "responso": "Responso",
    "salmo-2": "Salmo 2",
    "santo-rosario": "Santo Rosário",
    "te-deum": "Te Deum",
    "visita-ao-santissimo": "Visita ao Santíssimo",
  };

  static String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[áàâãä]'), 'a')
        .replaceAll(RegExp(r'[éèêë]'), 'e')
        .replaceAll(RegExp(r'[íìîï]'), 'i')
        .replaceAll(RegExp(r'[óòôõö]'), 'o')
        .replaceAll(RegExp(r'[úùûü]'), 'u')
        .replaceAll(RegExp(r'[ç]'), 'c');
  }

  List<String> get _sortedRoutes {
    final list = routeToName.keys.toList();
    list.sort((a, b) =>
        _normalize(routeToName[a]!).compareTo(_normalize(routeToName[b]!)));
    return list;
  }

  List<String> _sortedFavoritas(List<String> favoritas) {
    final list = favoritas.where((r) => routeToName.containsKey(r)).toList();
    list.sort((a, b) =>
        _normalize(routeToName[a]!).compareTo(_normalize(routeToName[b]!)));
    return list;
  }

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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OracoesProvider>(
      create: (context) => OracoesProvider(),
      child: Scaffold(
        appBar: AppBar(title: Text('Orações', style: TextStyle(fontSize: 20))),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<OracoesProvider>(
                  builder: (context, provider, child) {
                    final favoritas = _sortedFavoritas(provider.favoritas);
                    return ExpansionTile(
                      title: Text(
                        "Favoritas",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      initiallyExpanded: true,
                      shape: const Border(),
                      children: [
                        for (String route in favoritas)
                          itembuild(routeToName[route]!, route),
                      ],
                    );
                  },
                ),
                ExpansionTile(
                  title: const Text("Todas", style: TextStyle(fontSize: 18.0)),
                  initiallyExpanded: false,
                  shape: const Border(),
                  children: [
                    for (String route in _sortedRoutes)
                      itembuild(routeToName[route]!, route),
                  ],
                ),
                const Divider(height: 40, color: Colors.transparent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

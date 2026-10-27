import 'package:coramdeo/app/oracoes/catalogo_oracoes/data.dart';
import 'package:coramdeo/app/oracoes/custom_prayer_page.dart';
import 'package:coramdeo/app/oracoes/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OracaoCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> routes;

  const OracaoCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.routes,
  });
}

class OracoesPage extends StatefulWidget {
  const OracoesPage({super.key});

  static Map<String, String> get officialRouteToName => {
    "adoracao-e-bencao-com-o-santissimo": "Adoração e Bênção com o Santíssimo",
    "adoro-te-devote": "Adoro Te Devote",
    "angelus-regina-caeli": "Angelus/Regina Cæli",
    "comentario-do-evangelho-do-dia": "Comentário do Evangelho do dia",
    "credo-atanasiano": "Credo Atanasiano",
    "credo": "Credo Niceno-Constantinopolitano",
    "estampa-josemaria": "Estampa de São Josemaría",
    "exame-de-consciencia-oracao": "Exame de Consciência",
    "gratias-tibi-ago": "Gratias tibi ago (São Tomás)",
    "lembrai-vos": "Lembrai-Vos",
    "falar-com-deus": "Meditação Diária do Falar com Deus",
    "oferecimento-de-obras": "Oferecimento de Obras",
    "preces": "Preces",
    "responso": "Responso",
    "salmo-2": "Salmo 2",
    "santo-rosario": "Santo Rosário",
    "te-deum": "Te Deum",
    "visita-ao-santissimo": "Visita ao Santíssimo",
    for (final entry in OfficialPrayersCatalog.byRoute.entries)
      entry.key: entry.value.title,
  };

  @override
  State<OracoesPage> createState() => _OracoesPageState();
}

class _OracoesPageState extends State<OracoesPage> {
  static const double _kPrayerItemExtent = 56.0;

  int _selectedTabIndex = 0;

  final Map<String, String> _baseRouteToName = OracoesPage.officialRouteToName;

  static const List<OracaoCategory> _categories = [
    OracaoCategory(
      title: "Orações do Dia",
      subtitle: "Manhã, Noite e Refeições",
      icon: Icons.wb_sunny_outlined,
      routes: [
        "oferecimento-de-obras",
        "preces",
        "atos-fe-esperanca-caridade",
        "anjo-da-guarda",
        "benedictus",
        "nunc-dimittis",
        "gratias-tibi-ago",
        "exame-de-consciencia-oracao",
      ],
    ),
    OracaoCategory(
      title: "Devoções Marianas",
      subtitle: "Nossa Senhora e Santo Rosário",
      icon: Icons.auto_awesome_outlined,
      routes: [
        "angelus-regina-caeli",
        "santo-rosario",
        "consagracao-nossa-senhora",
        "lembrai-vos",
        "sub-tuum-praesidium",
        "salve-regina",
        "alma-redemptoris-mater",
        "ave-regina-caelorum",
        "magnificat",
      ],
    ),
    OracaoCategory(
      title: "Ao Santíssimo Sacramento",
      subtitle: "Adoração, Visita e Hinos Eucarísticos",
      icon: Icons.church_outlined,
      routes: [
        "visita-ao-santissimo",
        "adoro-te-devote",
        "pange-lingua",
        "adoracao-e-bencao-com-o-santissimo",
      ],
    ),
    OracaoCategory(
      title: "Santa Missa (Antes e Depois)",
      subtitle: "Preparação e Ação de Graças",
      icon: Icons.volunteer_activism_outlined,
      routes: [
        "oracao-sao-tomas-antes-missa",
        "oracao-santo-ambrosio-antes-missa",
        "oracao-nossa-senhora-antes-missa",
        "oracao-sao-jose-antes-missa",
        "gratias-tibi-ago",
        "cantico-tres-jovens",
        "anima-christi",
        "oracao-jesus-crucificado",
        "oracao-sao-boaventura",
        "oracao-universal-clemente-xi",
        "oracao-nossa-senhora-depois-missa",
        "oracao-sao-jose-depois-missa",
        "oracao-sao-miguel-arcanjo",
      ],
    ),
    OracaoCategory(
      title: "Hinos e Símbolos da Fé",
      subtitle: "Credos, Salmos e Louvores",
      icon: Icons.menu_book_outlined,
      routes: [
        "credo",
        "credo-atanasiano",
        "trisagio-angelico",
        "vinde-espirito-santo",
        "veni-creator",
        "te-deum",
        "salmo-2",
        "salmo-50",
        "salve-santa-cruz",
      ],
    ),
    OracaoCategory(
      title: "Santos e Intercessores",
      subtitle: "São Josemaría, Arcanjos e Sufrágios",
      icon: Icons.people_outline,
      routes: [
        "estampa-josemaria",
        "oracao-sao-miguel-arcanjo",
        "anjo-da-guarda",
        "responso",
      ],
    ),
    OracaoCategory(
      title: "Meditações Diárias",
      subtitle: "Evangelho do Dia e Falar com Deus",
      icon: Icons.self_improvement_outlined,
      routes: [
        "comentario-do-evangelho-do-dia",
        "falar-com-deus",
      ],
    ),
  ];

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

  Map<String, String> _allRouteToName(OracoesProvider provider) {
    return {
      ..._baseRouteToName,
      for (final p in provider.customPrayers) p.route: p.title,
    };
  }

  List<String> _sortedRoutes(Map<String, String> routeMap) {
    final list = routeMap.keys.toList();
    list.sort(
      (a, b) => _normalize(routeMap[a]!).compareTo(_normalize(routeMap[b]!)),
    );
    return list;
  }

  List<String> _sortedFavoritas(
    List<String> favoritas,
    Map<String, String> routeMap,
  ) {
    final list = favoritas.where((r) => routeMap.containsKey(r)).toList();
    list.sort(
      (a, b) => _normalize(routeMap[a]!).compareTo(_normalize(routeMap[b]!)),
    );
    return list;
  }

  Future<void> _showAddCustomPrayerDialog(
    BuildContext context,
    OracoesProvider provider,
  ) async {
    await showDialog(
      context: context,
      builder: (ctx) => CustomPrayerFormDialog(
        onSave: (title, subtitle, text) {
          return provider.addCustomPrayer(
            title: title,
            subtitle: subtitle,
            text: text,
          );
        },
      ),
    );
  }

  Widget _buildPrayerItem(
    BuildContext context,
    OracoesProvider provider,
    Map<String, String> routeMap,
    String route,
  ) {
    final title = routeMap[route] ?? route;
    final isFav = provider.favoritas.contains(route);
    return ListTile(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 17.0),
      ),
      onTap: () async {
        await Navigator.pushNamed(context, '/$route');
        if (context.mounted) {
          await provider.reload();
        }
      },
      leading: const Icon(Icons.chevron_right),
      trailing: IconButton(
        onPressed: () {
          provider.toggleFavorita(route);
        },
        icon: isFav
            ? Icon(Icons.star, color: Theme.of(context).colorScheme.primary)
            : const Icon(Icons.star_border),
      ),
    );
  }

  Widget _buildTodasTab(BuildContext context, OracoesProvider provider) {
    final routeMap = _allRouteToName(provider);
    final favoritas = _sortedFavoritas(provider.favoritas, routeMap);
    final sortedAll = _sortedRoutes(routeMap);

    return SingleChildScrollView(
      child: Column(
        children: [
          ExpansionTile(
            title: const Text("Favoritas", style: TextStyle(fontSize: 18.0)),
            initiallyExpanded: true,
            shape: const Border(),
            children: [
              if (favoritas.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Text(
                    "Toque na estrela ao lado de uma oração para fixá-la aqui.",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: _kPrayerItemExtent,
                  itemCount: favoritas.length,
                  itemBuilder: (context, index) {
                    return _buildPrayerItem(
                      context,
                      provider,
                      routeMap,
                      favoritas[index],
                    );
                  },
                ),
            ],
          ),
          ExpansionTile(
            title: const Text("Todas", style: TextStyle(fontSize: 18.0)),
            initiallyExpanded: true,
            shape: const Border(),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemExtent: _kPrayerItemExtent,
                itemCount: sortedAll.length,
                itemBuilder: (context, index) {
                  return _buildPrayerItem(
                    context,
                    provider,
                    routeMap,
                    sortedAll[index],
                  );
                },
              ),
            ],
          ),
          const Divider(height: 40, color: Colors.transparent),
        ],
      ),
    );
  }

  Widget _buildCategoriasTab(BuildContext context, OracoesProvider provider) {
    final colorScheme = Theme.of(context).colorScheme;
    final cardBorderRadius = BorderRadius.circular(10.0);
    final routeMap = _allRouteToName(provider);

    final customRoutes = provider.customPrayers.map((p) => p.route).toList();
    final allCategories = [
      OracaoCategory(
        title: "Minhas Orações",
        subtitle: customRoutes.isEmpty
            ? "Cadastre suas orações pessoais no botão +"
            : "Orações pessoais (${customRoutes.length})",
        icon: Icons.person_outline,
        routes: customRoutes,
      ),
      ..._categories,
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      itemCount: allCategories.length,
      itemBuilder: (context, catIndex) {
        final category = allCategories[catIndex];
        final isCustomCategory = catIndex == 0;
        final validRoutes = category.routes
            .where((r) => routeMap.containsKey(r))
            .toList();

        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ExpansionTile(
            leading: Icon(
              category.icon,
              color: colorScheme.onSecondaryContainer,
            ),
            title: Text(
              category.title,
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
            subtitle: Text(
              category.subtitle,
              style: TextStyle(
                fontSize: 13.0,
                color: colorScheme.onSecondaryContainer.withValues(alpha: 0.8),
              ),
            ),
            collapsedBackgroundColor: colorScheme.secondaryContainer,
            backgroundColor: colorScheme.secondaryContainer,
            iconColor: colorScheme.onSecondaryContainer,
            collapsedIconColor: colorScheme.onSecondaryContainer,
            collapsedShape: RoundedRectangleBorder(
              borderRadius: cardBorderRadius,
            ),
            shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
            childrenPadding: const EdgeInsets.only(bottom: 8.0),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    if (validRoutes.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemExtent: _kPrayerItemExtent,
                        itemCount: validRoutes.length,
                        itemBuilder: (context, index) {
                          return _buildPrayerItem(
                            context,
                            provider,
                            routeMap,
                            validRoutes[index],
                          );
                        },
                      ),
                    if (isCustomCategory)
                      ListTile(
                        leading: Icon(
                          Icons.add_circle_outline,
                          color: colorScheme.primary,
                        ),
                        title: Text(
                          "Cadastrar nova oração pessoal",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                        onTap: () =>
                            _showAddCustomPrayerDialog(context, provider),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OracoesProvider>(
      create: (context) => OracoesProvider(),
      child: Consumer<OracoesProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Orações', style: TextStyle(fontSize: 20)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: "Nova oração pessoal",
                  onPressed: () =>
                      _showAddCustomPrayerDialog(context, provider),
                ),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedTabIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.format_list_bulleted),
                  selectedIcon: Icon(Icons.format_list_bulleted),
                  label: 'Todas',
                ),
                NavigationDestination(
                  icon: Icon(Icons.category_outlined),
                  selectedIcon: Icon(Icons.category),
                  label: 'Categorias',
                ),
              ],
            ),
            body: SafeArea(
              child: IndexedStack(
                index: _selectedTabIndex,
                children: [
                  _buildTodasTab(context, provider),
                  _buildCategoriasTab(context, provider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

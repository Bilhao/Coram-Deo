import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/provider.dart';
import 'package:coramdeo/app/liturgia_diaria/provider.dart';
import 'package:coramdeo/app/missal_romano/data.dart';
import 'package:coramdeo/app/oracoes/catalogo_oracoes/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MissalRomanoPage extends StatefulWidget {
  const MissalRomanoPage({super.key});

  @override
  State<MissalRomanoPage> createState() => _MissalRomanoPageState();
}

class _MissalRomanoPageState extends State<MissalRomanoPage> {
  int _selectedTabIndex = 0; // 0 = Ordo Missae, 1 = Próprio do Dia, 2 = Preparação & Ação de Graças
  bool _isBilingual = true;
  String _selectedSection = 'Completo';
  String _selectedPreface = 'Domingos do Tempo Comum';
  String _selectedEucharisticPrayer = 'I (Cânon Romano)';

  static const List<String> _ordoSections = [
    'Completo',
    'Ritos Iniciais',
    'Liturgia da Palavra',
    'Liturgia Eucarística',
    'Comunhão e Finais',
  ];

  Widget _buildRubric(BuildContext context, MissalBlock block, double fs) {
    final scheme = Theme.of(context).colorScheme;
    if (_isBilingual && block.rubricLa != null && block.rubricLa!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                block.rubricLa!,
                style: TextStyle(
                  fontSize: fs - 1.5,
                  fontStyle: FontStyle.italic,
                  color: scheme.error,
                  height: 1.35,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                block.rubricPt!,
                style: TextStyle(
                  fontSize: fs - 1.5,
                  fontStyle: FontStyle.italic,
                  color: scheme.error,
                  height: 1.35,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        block.rubricPt!,
        style: TextStyle(
          fontSize: fs - 1.5,
          fontStyle: FontStyle.italic,
          color: scheme.error,
          height: 1.35,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MissalBlock block, double fs) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (_isBilingual && block.titleLa != null) ...[
                Expanded(
                  child: Text(
                    block.titleLa!,
                    style: TextStyle(
                      fontSize: fs + 1,
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  block.titlePt!,
                  style: TextStyle(
                    fontSize: fs + 1,
                    fontWeight: FontWeight.bold,
                    color: scheme.primary,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: scheme.outlineVariant, height: 12),
        ],
      ),
    );
  }

  Widget _buildTextBlock(BuildContext context, MissalBlock block, double fs) {
    final scheme = Theme.of(context).colorScheme;
    final speakerBadge = block.speaker != null && block.speaker!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text(
              block.speaker!,
              style: TextStyle(
                fontSize: fs - 2,
                fontWeight: FontWeight.bold,
                color: scheme.error,
              ),
            ),
          )
        : const SizedBox.shrink();

    if (_isBilingual) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            speakerBadge,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SelectableText(
                    block.latin ?? '',
                    style: TextStyle(
                      fontSize: fs,
                      fontStyle: FontStyle.italic,
                      color: scheme.onSurface.withValues(alpha: 0.9),
                      height: 1.45,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SelectableText(
                    block.portuguese ?? '',
                    style: TextStyle(
                      fontSize: fs,
                      color: scheme.onSurface,
                      height: 1.45,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          speakerBadge,
          SelectableText(
            block.portuguese ?? '',
            style: TextStyle(
              fontSize: fs,
              color: scheme.onSurface,
              height: 1.45,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildBlockItem(BuildContext context, MissalBlock block, double fs) {
    if (block.isHeader) {
      return _buildHeader(context, block, fs);
    }
    if (block.isRubric) {
      return _buildRubric(context, block, fs);
    }
    return _buildTextBlock(context, block, fs);
  }

  Widget _buildOrdoMissaeTab(BuildContext context, double fs) {
    final scheme = Theme.of(context).colorScheme;
    final showIniciais =
        _selectedSection == 'Completo' || _selectedSection == 'Ritos Iniciais';
    final showPalavra =
        _selectedSection == 'Completo' ||
        _selectedSection == 'Liturgia da Palavra';
    final showEucaristica =
        _selectedSection == 'Completo' ||
        _selectedSection == 'Liturgia Eucarística';
    final showComunhao =
        _selectedSection == 'Completo' ||
        _selectedSection == 'Comunhão e Finais';

    final prefaceBlock =
        MissalRomanoData.prefacios[_selectedPreface] ??
        MissalRomanoData.prefacios.values.first;
    final eucharisticBlocks =
        MissalRomanoData.oracoesEucaristicas[_selectedEucharisticPrayer] ??
        MissalRomanoData.oracoesEucaristicas.values.first;

    return Column(
      children: [
        SizedBox(
          height: 48,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            scrollDirection: Axis.horizontal,
            itemCount: _ordoSections.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final sec = _ordoSections[index];
              final isSelected = _selectedSection == sec;
              return ChoiceChip(
                label: Text(sec),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedSection = sec),
              );
            },
          ),
        ),
        Expanded(
          child: SelectionArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 30),
              children: [
                if (_isBilingual)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ORDO MISSAE (LATIM)',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                              color: scheme.error,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'ORDINÁRIO DA MISSA (PORTUGUÊS)',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                              color: scheme.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (showIniciais)
                  ...MissalRomanoData.ritosIniciais.map(
                    (b) => _buildBlockItem(context, b, fs),
                  ),
                if (showPalavra)
                  ...MissalRomanoData.liturgiaDaPalavra.map(
                    (b) => _buildBlockItem(context, b, fs),
                  ),
                if (showEucaristica) ...[
                  ...MissalRomanoData.preparacaoOferendas.map(
                    (b) => _buildBlockItem(context, b, fs),
                  ),
                  ...MissalRomanoData.dialogoPrefacio.map(
                    (b) => _buildBlockItem(context, b, fs),
                  ),
                  // Seletor de Prefácio
                  Card(
                    color: scheme.secondaryContainer.withValues(alpha: 0.65),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.menu_book_outlined,
                            size: 18,
                            color: scheme.error,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Prefácio:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: scheme.error,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedPreface,
                                items: MissalRomanoData.prefacios.keys
                                    .map(
                                      (k) => DropdownMenuItem(
                                        value: k,
                                        child: Text(
                                          k,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() => _selectedPreface = val);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildBlockItem(context, prefaceBlock, fs),
                  _buildBlockItem(context, MissalRomanoData.sanctus, fs),
                  // Seletor de Oração Eucarística
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
                    child: Text(
                      'Selecione a Oração Eucarística:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: scheme.error,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    children: MissalRomanoData.oracoesEucaristicas.keys.map((k) {
                      return ChoiceChip(
                        label: Text('OE $k'),
                        selected: _selectedEucharisticPrayer == k,
                        onSelected: (_) =>
                            setState(() => _selectedEucharisticPrayer = k),
                      );
                    }).toList(),
                  ),
                  ...eucharisticBlocks.map(
                    (b) => _buildBlockItem(context, b, fs),
                  ),
                ],
                if (showComunhao)
                  ...MissalRomanoData.ritoComunhaoEFinais.map(
                    (b) => _buildBlockItem(context, b, fs),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProprioDoDiaTab(BuildContext context, double fs) {
    final scheme = Theme.of(context).colorScheme;
    final calProvider = Provider.of<CalendarioLiturgicoProvider>(context);
    final litProvider = Provider.of<LiturgiaDiariaProvider>(context);
    final todayDay = calProvider.todayDay;
    final proper = MissalRomanoData.getProperForDay(todayDay);

    return SelectionArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
        children: [
          Card(
            color: todayDay.color.containerColor(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: todayDay.color.dotDecoration(context),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${todayDay.season.displayName} • ${todayDay.rank.displayName} (${todayDay.color.displayName})',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: todayDay.color.onContainerColor(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    litProvider.todayLiturgia.isNotEmpty
                        ? litProvider.todayLiturgia
                        : todayDay.title,
                    style: TextStyle(
                      fontSize: fs + 1,
                      fontWeight: FontWeight.bold,
                      color: todayDay.color.onContainerColor(context),
                    ),
                  ),
                  if (todayDay.hasSaintOfTheDay) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Memória / Santo: ${todayDay.saintOfTheDay}',
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: todayDay.color.onContainerColor(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          _buildHeader(
            context,
            MissalBlock.header(proper.title, 'Proprium de Tempore'),
            fs,
          ),
          _buildTextBlock(
            context,
            MissalBlock.text(
              speaker: 'Antífona da Entrada (Introito)',
              latin: proper.introitLatin,
              portuguese: proper.introitPt,
            ),
            fs,
          ),
          _buildTextBlock(
            context,
            MissalBlock.text(
              speaker: 'Oração da Coleta (Collecta)',
              latin: proper.collectLatin,
              portuguese: proper.collectPt,
            ),
            fs,
          ),
          _buildTextBlock(
            context,
            MissalBlock.text(
              speaker: 'Oração sobre as Oferendas (Super Oblata)',
              latin: proper.offeringsLatin,
              portuguese: proper.offeringsPt,
            ),
            fs,
          ),
          _buildTextBlock(
            context,
            MissalBlock.text(
              speaker: 'Antífona da Comunhão (Communio)',
              latin: proper.communionAntiphonLatin,
              portuguese: proper.communionAntiphonPt,
            ),
            fs,
          ),
          _buildTextBlock(
            context,
            MissalBlock.text(
              speaker: 'Oração depois da Comunhão (Post Communionem)',
              latin: proper.postCommunionLatin,
              portuguese: proper.postCommunionPt,
            ),
            fs,
          ),
          const SizedBox(height: 12),
          Card(
            color: scheme.secondaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              shape: const Border(),
              collapsedShape: const Border(),
              leading: Icon(
                Icons.chrome_reader_mode_outlined,
                color: scheme.primary,
              ),
              title: Text(
                'Leituras da Missa de Hoje',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: scheme.onSecondaryContainer,
                ),
              ),
              subtitle: Text(
                litProvider.evangelhoReferencia.isNotEmpty
                    ? 'Evangelho: ${litProvider.evangelhoReferencia}'
                    : 'Toque para abrir as leituras do dia',
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSecondaryContainer.withValues(alpha: 0.8),
                ),
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                if (litProvider.primeiraLeituraText.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '1ª Leitura (${litProvider.primeiraLeituraReferencia})',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: scheme.error,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    litProvider.primeiraLeituraText,
                    style: TextStyle(fontSize: fs - 1),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 12),
                ],
                if (litProvider.salmoText.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Salmo Responsorial (${litProvider.salmoReferencia})',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: scheme.error,
                      ),
                    ),
                  ),
                  if (litProvider.salmoRefrao.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'R. ${litProvider.salmoRefrao}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: fs - 1,
                        ),
                      ),
                    ),
                  Text(
                    litProvider.salmoText,
                    style: TextStyle(fontSize: fs - 1),
                  ),
                  const SizedBox(height: 12),
                ],
                if (litProvider.evangelhoText.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Evangelho (${litProvider.evangelhoReferencia})',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: scheme.error,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    litProvider.evangelhoText,
                    style: TextStyle(fontSize: fs - 1),
                    textAlign: TextAlign.justify,
                  ),
                ],
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.tonalIcon(
                    onPressed: () => Navigator.pushNamed(context, '/liturgia'),
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: const Text('Ver Liturgia Completa'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreparacaoEAcaoDeGracasTab(BuildContext context, double fs) {
    final scheme = Theme.of(context).colorScheme;
    final santaMissaPrayers = OfficialPrayersCatalog.byRoute.values
        .where((p) => p.category == 'Santa Missa')
        .toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Orações tradicionais da Igreja para preparação antes da celebração eucarística (Praeparatio ad Missam) e ação de graças após a Sagrada Comunhão (Gratiarum Actio post Missam).',
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: scheme.error,
            ),
          ),
        ),
        ...santaMissaPrayers.map((prayer) {
          return Card(
            color: scheme.secondaryContainer,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              shape: const Border(),
              collapsedShape: const Border(),
              title: Text(
                prayer.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fs,
                  color: scheme.onSecondaryContainer,
                ),
              ),
              subtitle: prayer.subtitle != null
                  ? Text(
                      prayer.subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onSecondaryContainer.withValues(
                          alpha: 0.75,
                        ),
                      ),
                    )
                  : null,
              childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              children: [
                ...prayer.strophes.map((strophe) {
                  final la = strophe.lt;
                  final pt = strophe.pt;
                  if (_isBilingual && la.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SelectableText(
                              la,
                              style: TextStyle(
                                fontSize: fs - 1,
                                fontStyle: FontStyle.italic,
                                color: scheme.onSecondaryContainer.withValues(
                                  alpha: 0.9,
                                ),
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SelectableText(
                              pt,
                              style: TextStyle(
                                fontSize: fs - 1,
                                color: scheme.onSecondaryContainer,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: SelectableText(
                      pt,
                      style: TextStyle(
                        fontSize: fs - 1,
                        color: scheme.onSecondaryContainer,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  );
                }),
              ],
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final fs = appProvider.fontSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Missal Romano'),
        actions: [
          IconButton(
            icon: Icon(
              _isBilingual ? Icons.translate : Icons.language_outlined,
              color: _isBilingual
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
            tooltip: _isBilingual
                ? 'Modo Bilíngue (Latim / Português)'
                : 'Modo Vernáculo (Português)',
            onPressed: () => setState(() => _isBilingual = !_isBilingual),
          ),
          IconButton(
            onPressed: (fs <= 13)
                ? null
                : () => appProvider.saveFontSize(fs - 2),
            icon: const Text('-', style: TextStyle(fontSize: 24)),
          ),
          IconButton(
            onPressed: (fs >= 29)
                ? null
                : () => appProvider.saveFontSize(fs + 2),
            icon: const Text('+', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedTabIndex,
          children: [
            _buildOrdoMissaeTab(context, fs),
            _buildProprioDoDiaTab(context, fs),
            _buildPreparacaoEAcaoDeGracasTab(context, fs),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTabIndex,
        onDestinationSelected: (idx) => setState(() => _selectedTabIndex = idx),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Ordo Missae',
          ),
          NavigationDestination(
            icon: Icon(Icons.wb_sunny_outlined),
            selectedIcon: Icon(Icons.wb_sunny),
            label: 'Próprio do Dia',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Antes e Depois',
          ),
        ],
      ),
    );
  }
}

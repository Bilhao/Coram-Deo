import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/provider.dart';
import 'package:coramdeo/app/liturgia_diaria/provider.dart';
import 'package:coramdeo/app/santo_do_dia/provider.dart';
import 'package:coramdeo/app/calendario/widgets/opus_dei_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  late DateTime _displayMonth;

  final List<String> _monthNames = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CalendarioLiturgicoProvider>(
      context,
      listen: false,
    );
    _displayMonth = DateTime(
      provider.selectedDate.year,
      provider.selectedDate.month,
      1,
    );
  }

  void _previousMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 1);
    });
  }

  void _goToToday(CalendarioLiturgicoProvider provider) {
    final today = DateTime.now();
    setState(() {
      _displayMonth = DateTime(today.year, today.month, 1);
    });
    provider.resetToToday();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalendarioLiturgicoProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final selectedDay = provider.currentSelectedDay;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_monthNames[_displayMonth.month - 1]} ${_displayMonth.year}',
        ),
        actions: [
          IconButton(
            tooltip: 'Mês anterior',
            icon: const Icon(Icons.chevron_left),
            onPressed: _previousMonth,
          ),
          IconButton(
            tooltip: 'Próximo mês',
            icon: const Icon(Icons.chevron_right),
            onPressed: _nextMonth,
          ),
          TextButton(
            onPressed: () => _goToToday(provider),
            child: const Text('Hoje'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 4),

            // Grade do Mês
            _buildCalendarGrid(
              context,
              provider,
              appProvider.showOpusDeiCelebrations,
            ),

            const Divider(height: 1, thickness: 0.5),

            // Painel de Detalhes do Dia Selecionado
            Expanded(
              child: _buildDayDetailPanel(
                context,
                provider,
                selectedDay,
                appProvider.showOpusDeiCelebrations,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid(
    BuildContext context,
    CalendarioLiturgicoProvider provider,
    bool showOpusDei,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final now = DateTime.now();

    final firstDayOfMonth = DateTime(
      _displayMonth.year,
      _displayMonth.month,
      1,
    );
    final daysInMonth = DateTime(
      _displayMonth.year,
      _displayMonth.month + 1,
      0,
    ).day;
    final startWeekday = firstDayOfMonth.weekday % 7; // Domingo = 0

    final totalCells = ((startWeekday + daysInMonth) / 7).ceil() * 7;
    final weekdays = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Column(
        children: [
          // Cabeçalho dos dias da semana (D S T Q Q S S)
          Row(
            children: List.generate(7, (i) {
              return Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      weekdays[i],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: i == 0
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 2),

          // Grade 7 colunas
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalCells,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.05,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
            ),
            itemBuilder: (context, index) {
              final dayOffset = index - startWeekday + 1;
              if (dayOffset < 1 || dayOffset > daysInMonth) {
                return const SizedBox.shrink();
              }

              final cellDate = DateTime(
                _displayMonth.year,
                _displayMonth.month,
                dayOffset,
              );
              final dayData = provider.getDay(cellDate);
              final isSelected =
                  cellDate.year == provider.selectedDate.year &&
                  cellDate.month == provider.selectedDate.month &&
                  cellDate.day == provider.selectedDate.day;
              final isToday =
                  cellDate.year == now.year &&
                  cellDate.month == now.month &&
                  cellDate.day == now.day;

              return _buildDayCell(
                context,
                provider,
                cellDate,
                dayData,
                isToday,
                isSelected,
                showOpusDei,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDayCell(
    BuildContext context,
    CalendarioLiturgicoProvider provider,
    DateTime cellDate,
    LiturgicalDay dayData,
    bool isToday,
    bool isSelected,
    bool showOpusDei,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    BoxDecoration decoration;
    Color cellBg;
    if (isSelected) {
      cellBg = colorScheme.primary;
      decoration = BoxDecoration(
        color: cellBg,
        borderRadius: BorderRadius.circular(8),
      );
    } else if (isToday) {
      cellBg = colorScheme.primaryContainer.withValues(alpha: 0.5);
      decoration = BoxDecoration(
        color: cellBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.primary, width: 1.2),
      );
    } else {
      cellBg = colorScheme.surface;
      decoration = BoxDecoration(borderRadius: BorderRadius.circular(8));
    }

    final textColor = isSelected
        ? colorScheme.onPrimary
        : isToday
        ? colorScheme.primary
        : colorScheme.onSurface;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => provider.selectDate(cellDate),
      child: Container(
        decoration: decoration,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cellDate.day.toString(),
              style: TextStyle(
                fontSize: 13,
                fontWeight: isToday || isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: dayData.color.dotDecoration(
                    context,
                    backgroundColor: cellBg,
                  ),
                ),
                if (showOpusDei && dayData.hasOpusDeiCelebration) ...[
                  const SizedBox(width: 3),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayDetailPanel(
    BuildContext context,
    CalendarioLiturgicoProvider provider,
    LiturgicalDay day,
    bool showOpusDei,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateStr =
        '${_formatWeekday(day.date.weekday)}, ${day.date.day} de ${_monthNames[day.date.month - 1]} de ${day.date.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Data por extenso
                  Text(
                    dateStr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Título Litúrgico Principal
                  Text(
                    day.title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Badges: Cor Litúrgica + Tempo + Grau
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: day.color.containerColor(context),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: day.color.dotDecoration(
                                context,
                                backgroundColor: day.color.containerColor(
                                  context,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${day.color.displayName} • ${day.season.displayName}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: day.color.onContainerColor(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.6,
                          ),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.4,
                            ),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          day.rank.displayName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Santo do Dia Celebrado na Liturgia
                  if (day.hasSaintOfTheDay) ...[
                    const SizedBox(height: 10),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () {
                          final santoProvider = Provider.of<SantoDoDiaProvider>(
                            context,
                            listen: false,
                          );
                          santoProvider.changeDate(
                            day.date.day,
                            day.date.month,
                          );
                          Navigator.pushNamed(
                            context,
                            '/santo-do-dia',
                            arguments: day.date,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: colorScheme.outlineVariant.withValues(
                                alpha: 0.4,
                              ),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          SantoDoDiaProvider.computeHeaderIcon(
                                            day.saintOfTheDay!,
                                            day.rank.displayName,
                                          ),
                                          size: 16,
                                          color: colorScheme.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          SantoDoDiaProvider.computeHeaderTitle(
                                            day.saintOfTheDay!,
                                            day.rank.displayName,
                                          ),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      day.saintOfTheDay!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 18,
                                color: colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],

                  // Card Especial Opus Dei
                  if (showOpusDei && day.hasOpusDeiCelebration) ...[
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.45,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.4,
                          ),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              OpusDeiIcon(size: 16, color: colorScheme.primary),
                              const SizedBox(width: 8),
                              Text(
                                'Opus Dei',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: day.opusDeiCelebration!.classRank
                                      .badgeColor(context)
                                      .withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: day.opusDeiCelebration!.classRank
                                        .badgeColor(context)
                                        .withValues(alpha: 0.5),
                                    width: 0.8,
                                  ),
                                ),
                                child: Text(
                                  day.opusDeiCelebration!.classRank.letter,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: day.opusDeiCelebration!.classRank
                                        .badgeColor(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            day.opusDeiCelebration!.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            day.opusDeiCelebration!.description,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.35,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Card de Novena / Devoção Ativa
                  if (day.hasNovena) ...[
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.45,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.4,
                          ),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.event_note_rounded,
                                size: 16,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Novena / Devoção',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            day.novenaNotice!,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        // Botão para ver a Liturgia do Dia selecionado, fixado no rodapé e sem o ícone do livro
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
          child: FilledButton.tonal(
            onPressed: () {
              final liturgiaProvider = Provider.of<LiturgiaDiariaProvider>(
                context,
                listen: false,
              );
              liturgiaProvider.changeDate(
                day.date.day,
                day.date.month,
                year: day.date.year,
              );
              Navigator.pushNamed(context, '/liturgia', arguments: day.date);
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'Ver Liturgia do Dia',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  String _formatWeekday(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Segunda-feira';
      case DateTime.tuesday:
        return 'Terça-feira';
      case DateTime.wednesday:
        return 'Quarta-feira';
      case DateTime.thursday:
        return 'Quinta-feira';
      case DateTime.friday:
        return 'Sexta-feira';
      case DateTime.saturday:
        return 'Sábado';
      case DateTime.sunday:
        return 'Domingo';
      default:
        return '';
    }
  }
}

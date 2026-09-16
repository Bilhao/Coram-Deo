import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/provider.dart';
import 'package:coramdeo/app/liturgia_diaria/provider.dart';
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
    'Dezembro'
  ];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CalendarioLiturgicoProvider>(context, listen: false);
    _displayMonth = DateTime(provider.selectedDate.year, provider.selectedDate.month, 1);
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
    final selectedDay = provider.currentSelectedDay;

    return Scaffold(
      appBar: AppBar(
        title: Text('${_monthNames[_displayMonth.month - 1]} ${_displayMonth.year}'),
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
          children: [
            const SizedBox(height: 4),

            // Grade do Mês
            _buildCalendarGrid(context, provider),

            const Divider(height: 1, thickness: 0.5),

            // Painel de Detalhes do Dia Selecionado
            Expanded(
              child: _buildDayDetailPanel(context, provider, selectedDay),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid(BuildContext context, CalendarioLiturgicoProvider provider) {
    final colorScheme = Theme.of(context).colorScheme;
    final now = DateTime.now();

    final firstDayOfMonth = DateTime(_displayMonth.year, _displayMonth.month, 1);
    final daysInMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 0).day;
    final startWeekday = firstDayOfMonth.weekday % 7; // Domingo = 0

    final totalCells = ((startWeekday + daysInMonth) / 7).ceil() * 7;
    final weekdays = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Column(
        children: [
          // Cabeçalho dos dias da semana
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays.map((day) {
              return SizedBox(
                width: 38,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 6),
          // Células dos dias
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalCells,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (context, index) {
              final dayNum = index - startWeekday + 1;
              if (dayNum < 1 || dayNum > daysInMonth) {
                return const SizedBox.shrink();
              }

              final cellDate = DateTime(_displayMonth.year, _displayMonth.month, dayNum);
              final dayData = provider.getDay(cellDate);

              final isToday = cellDate.year == now.year && cellDate.month == now.month && cellDate.day == now.day;
              final isSelected = cellDate.year == provider.selectedDate.year &&
                  cellDate.month == provider.selectedDate.month &&
                  cellDate.day == provider.selectedDate.day;

              return _buildDayCell(context, provider, cellDate, dayData, isToday, isSelected);
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
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    BoxDecoration decoration;
    if (isSelected) {
      decoration = BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      );
    } else if (isToday) {
      decoration = BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.primary, width: 1.2),
      );
    } else {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      );
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
                fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.normal,
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
                  decoration: BoxDecoration(
                    color: isSelected ? colorScheme.onPrimary : dayData.color.colorValue,
                    shape: BoxShape.circle,
                  ),
                ),
                if (dayData.hasOpusDeiCelebration) ...[
                  const SizedBox(width: 2),
                  Icon(
                    Icons.star_rounded,
                    size: 10,
                    color: isSelected
                        ? colorScheme.onPrimary
                        : dayData.opusDeiCelebration!.classRank.badgeColor(context),
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
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateStr = '${_formatWeekday(day.date.weekday)}, ${day.date.day} de ${_monthNames[day.date.month - 1]} de ${day.date.year}';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Data por extenso
          Text(
            dateStr,
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
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                      decoration: BoxDecoration(
                        color: day.color.colorValue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Cor: ${day.color.displayName}',
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  day.season.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  day.rank.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),

          // Santo do Dia Celebrado na Liturgia
          if (day.hasSaintOfTheDay) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.person_pin_rounded, size: 20, color: colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Santo / Memória da Liturgia:',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
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
                ],
              ),
            ),
          ],

          // Card Especial Opus Dei
          if (day.hasOpusDeiCelebration) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: day.opusDeiCelebration!.classRank.badgeColor(context).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: day.opusDeiCelebration!.classRank.badgeColor(context).withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.stars_rounded,
                        size: 18,
                        color: day.opusDeiCelebration!.classRank.badgeColor(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        day.opusDeiCelebration!.classRank.badgeLabel, // Opus Dei - A / B / C
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: day.opusDeiCelebration!.classRank.badgeColor(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    day.opusDeiCelebration!.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    day.opusDeiCelebration!.description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: colorScheme.onSurface,
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.event_note_rounded, size: 16, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      day.novenaNotice!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Botão para ver a Liturgia do Dia selecionado
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.tonalIcon(
              onPressed: () {
                final liturgiaProvider = Provider.of<LiturgiaDiariaProvider>(context, listen: false);
                liturgiaProvider.changeDate(day.date.day, day.date.month, year: day.date.year);
                Navigator.pushNamed(context, '/liturgia', arguments: day.date);
              },
              icon: const Icon(Icons.menu_book_rounded),
              label: const Text('Ver Liturgia do Dia', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
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

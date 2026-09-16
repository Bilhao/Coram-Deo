import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarioHomeCard extends StatelessWidget {
  const CalendarioHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalendarioLiturgicoProvider>(context);
    final today = provider.todayDay;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.secondaryContainer,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          provider.resetToToday();
          Navigator.pushNamed(context, '/calendario');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho: Título + Seletor de Modo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: today.color.colorValue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: today.color.colorValue.withValues(alpha: 0.5),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Calendário Litúrgico',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                  _buildModeSelector(context, provider),
                ],
              ),
              const SizedBox(height: 6),
              const Divider(height: 1, thickness: 0.5),
              const SizedBox(height: 6),

              // Conteúdo Dinâmico conforme o Modo
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: provider.viewMode == 'semanal'
                      ? _buildSemanalView(context, provider)
                      : provider.viewMode == 'mensal'
                          ? _buildMensalView(context, provider)
                          : _buildDiariaView(context, today),
                ),
              ),

              // Rodapé: Atalho
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (today.hasNovena)
                    Expanded(
                      child: Text(
                        today.novenaNotice!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  else
                    const Spacer(),
                  Row(
                    children: [
                      Text(
                        'Abrir calendário',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeSelector(BuildContext context, CalendarioLiturgicoProvider provider) {
    final modes = [
      ('diaria', 'Dia'),
      ('semanal', 'Semana'),
      ('mensal', 'Mês'),
    ];

    return Container(
      height: 26,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: modes.map((mode) {
          final isSelected = provider.viewMode == mode.$1;
          return GestureDetector(
            onTap: () => provider.setViewMode(mode.$1),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                mode.$2,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Visão Diária
  Widget _buildDiariaView(BuildContext context, LiturgicalDay day) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      key: const ValueKey('diaria'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                  const SizedBox(width: 5),
                  Text(
                    '${day.color.displayName} • ${day.season.displayName}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: day.color.onContainerColor(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                day.rank.displayName,
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          day.title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (day.hasOpusDeiCelebration) ...[
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: day.opusDeiCelebration!.classRank.badgeColor(context).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: day.opusDeiCelebration!.classRank.badgeColor(context).withValues(alpha: 0.5),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.stars_rounded,
                  size: 14,
                  color: day.opusDeiCelebration!.classRank.badgeColor(context),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    '${day.opusDeiCelebration!.classRank.badgeLabel}: ${day.opusDeiCelebration!.name}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: day.opusDeiCelebration!.classRank.badgeColor(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // Visão Semanal
  Widget _buildSemanalView(BuildContext context, CalendarioLiturgicoProvider provider) {
    final now = DateTime.now();
    final week = provider.getWeek(now);
    final dayLetters = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      key: const ValueKey('semanal'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (index) {
            final day = week[index];
            final isToday = day.date.year == now.year && day.date.month == now.month && day.date.day == now.day;

            return Column(
              children: [
                Text(
                  dayLetters[index],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: isToday ? colorScheme.primary : colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isToday
                        ? colorScheme.primary
                        : day.color.containerColor(context),
                    shape: BoxShape.circle,
                    border: isToday
                        ? Border.all(color: colorScheme.onPrimary, width: 1.5)
                        : Border.all(color: day.color.colorValue, width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    day.date.day.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isToday
                          ? colorScheme.onPrimary
                          : day.color.onContainerColor(context),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                if (day.hasOpusDeiCelebration)
                  Icon(
                    Icons.star_rounded,
                    size: 10,
                    color: day.opusDeiCelebration!.classRank.badgeColor(context),
                  )
                else
                  const SizedBox(height: 10),
              ],
            );
          }),
        ),
        const SizedBox(height: 4),
        Text(
          provider.todayDay.title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Visão Mensal
  Widget _buildMensalView(BuildContext context, CalendarioLiturgicoProvider provider) {
    final now = DateTime.now();
    final monthDays = provider.getMonth(now);
    final firstWeekday = DateTime(now.year, now.month, 1).weekday % 7; // Dom=0
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      key: const ValueKey('mensal'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Cabeçalho dos dias da semana
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'].map((l) {
            return SizedBox(
              width: 18,
              child: Text(
                l,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 4),
        // Grade simplificada (4 semanas)
        for (int weekIndex = 0; weekIndex < 4; weekIndex++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int dayIndex = 0; dayIndex < 7; dayIndex++) ...[
                  Builder(builder: (context) {
                    final cellIndex = weekIndex * 7 + dayIndex;
                    final dayNum = cellIndex - firstWeekday + 1;

                    if (dayNum < 1 || dayNum > monthDays.length) {
                      return const SizedBox(width: 18, height: 14);
                    }

                    final day = monthDays[dayNum - 1];
                    final isToday = day.date.day == now.day;

                    return Container(
                      width: 18,
                      height: 14,
                      decoration: BoxDecoration(
                        color: isToday ? colorScheme.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: isToday ? colorScheme.onPrimary : day.color.colorValue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 1),
                          Text(
                            dayNum.toString(),
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                              color: isToday ? colorScheme.onPrimary : colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/provider.dart';
import 'package:coramdeo/app/calendario/widgets/opus_dei_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarioHomeCard extends StatelessWidget {
  const CalendarioHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalendarioLiturgicoProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final showOpusDei = appProvider.showOpusDeiCelebrations;
    final today = provider.todayDay;
    final now = DateTime.now();
    final week = provider.getWeek(now);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dayLetters = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

    return Card(
      color: colorScheme.secondaryContainer,
      child: InkWell(
        radius: 100,
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          provider.resetToToday();
          Navigator.pushNamed(context, '/calendario');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cabeçalho padronizado
              const Text(
                'Calendário Litúrgico',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 16,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                color: colorScheme.onSecondaryContainer,
              ),

              const SizedBox(height: 6),

              // Régua Semanal Litúrgica Compacta (D S T Q Q S S)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    final day = week[index];
                    final isToday =
                        day.date.year == now.year &&
                        day.date.month == now.month &&
                        day.date.day == now.day;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          dayLetters[index],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isToday
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isToday
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isToday
                                ? colorScheme.primary
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: isToday
                                ? null
                                : Border.all(
                                    color: colorScheme.outlineVariant
                                        .withValues(alpha: 0.4),
                                    width: 0.8,
                                  ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            day.date.day.toString(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isToday
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isToday
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: day.color.dotDecoration(
                                context,
                                isSelected: isToday,
                                backgroundColor: isToday
                                    ? colorScheme.primary
                                    : colorScheme.secondaryContainer,
                              ),
                            ),
                            if (showOpusDei && day.hasOpusDeiCelebration) ...[
                              const SizedBox(width: 2),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),

              // Informações Canônicas do Dia de Hoje
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Linha 1: Badges de Cor e Tempo
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: today.color.containerColor(context),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: today.color.dotDecoration(
                                  context,
                                  backgroundColor: today.color.containerColor(
                                    context,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${today.color.displayName} • ${today.season.displayName}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: today.color.onContainerColor(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: colorScheme.outlineVariant.withValues(
                                alpha: 0.4,
                              ),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            today.rank.displayName,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Linha 2: Título Litúrgico
                    Text(
                      today.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Linha 3: Celebração Opus Dei (se houver)
                    if (showOpusDei && today.hasOpusDeiCelebration) ...[
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: today.opusDeiCelebration!.classRank
                                  .badgeColor(context)
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: today.opusDeiCelebration!.classRank
                                    .badgeColor(context)
                                    .withValues(alpha: 0.5),
                                width: 0.8,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OpusDeiIcon(
                                  size: 10,
                                  color: today.opusDeiCelebration!.classRank
                                      .badgeColor(context),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  today
                                      .opusDeiCelebration!
                                      .classRank
                                      .badgeLabel, // "Opus Dei - A" / "Opus Dei - B" / "Opus Dei - C"
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: today.opusDeiCelebration!.classRank
                                        .badgeColor(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              today.opusDeiCelebration!.name,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: today.opusDeiCelebration!.classRank
                                    .badgeColor(context),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // Linha 5: Novena ativa (se houver)
                    if (today.hasNovena) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.event_note_rounded,
                            size: 12,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
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
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Rodapé padronizado
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ver mais',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

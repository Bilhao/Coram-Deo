import 'package:flutter/material.dart';

/// Cabeçalho que exibe os títulos das colunas ("LATIM" e "PORTUGUÊS") no modo bilíngue
class BilingualPrayerHeader extends StatelessWidget {
  final String latinTitle;
  final String portugueseTitle;

  const BilingualPrayerHeader({
    super.key,
    this.latinTitle = 'LATIM',
    this.portugueseTitle = 'PORTUGUÊS',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final headerStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      color: colorScheme.primary,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              latinTitle,
              textAlign: TextAlign.center,
              style: headerStyle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              portugueseTitle,
              textAlign: TextAlign.center,
              style: headerStyle,
            ),
          ),
        ],
      ),
    );
  }
}

/// Linha que alinha perfeitamente a estrofe em latim e a tradução em português lado a lado
class BilingualPrayerRow extends StatelessWidget {
  final Widget latin;
  final Widget portuguese;
  final EdgeInsetsGeometry padding;

  const BilingualPrayerRow({
    super.key,
    required this.latin,
    required this.portuguese,
    this.padding = const EdgeInsets.symmetric(vertical: 6.0),
  });

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4);

    return Padding(
      padding: padding,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: latin),
            VerticalDivider(
              width: 16,
              thickness: 1,
              color: dividerColor,
            ),
            Expanded(child: portuguese),
          ],
        ),
      ),
    );
  }
}

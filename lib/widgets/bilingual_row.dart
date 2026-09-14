import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';

/// Cabeçalho que exibe os títulos das colunas ("LATIM" e "PORTUGUÊS") no modo bilíngue,
/// respeitando dinamicamente a ordem configurada nas preferências do usuário.
class BilingualPrayerHeader extends StatelessWidget {
  final String latinTitle;
  final String portugueseTitle;
  final bool? isLatinFirst;

  const BilingualPrayerHeader({
    super.key,
    this.latinTitle = 'LATIM',
    this.portugueseTitle = 'PORTUGUÊS',
    this.isLatinFirst,
  });

  bool _resolveLatinFirst(BuildContext context) {
    if (isLatinFirst != null) return isLatinFirst!;
    try {
      return Provider.of<AppProvider>(context, listen: true).isLatinFirst;
    } catch (_) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final headerStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      color: colorScheme.primary,
    );

    final bool latinFirst = _resolveLatinFirst(context);
    final String firstTitle = latinFirst ? latinTitle : portugueseTitle;
    final String secondTitle = latinFirst ? portugueseTitle : latinTitle;

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
              firstTitle,
              textAlign: TextAlign.center,
              style: headerStyle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              secondTitle,
              textAlign: TextAlign.center,
              style: headerStyle,
            ),
          ),
        ],
      ),
    );
  }
}

/// Linha que alinha perfeitamente a estrofe em latim e a tradução em português lado a lado,
/// respeitando dinamicamente a ordem configurada nas preferências do usuário.
class BilingualPrayerRow extends StatelessWidget {
  final Widget latin;
  final Widget portuguese;
  final EdgeInsetsGeometry padding;
  final bool? isLatinFirst;

  const BilingualPrayerRow({
    super.key,
    required this.latin,
    required this.portuguese,
    this.padding = const EdgeInsets.symmetric(vertical: 6.0),
    this.isLatinFirst,
  });

  bool _resolveLatinFirst(BuildContext context) {
    if (isLatinFirst != null) return isLatinFirst!;
    try {
      return Provider.of<AppProvider>(context, listen: true).isLatinFirst;
    } catch (_) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4);
    final bool latinFirst = _resolveLatinFirst(context);

    final Widget firstChild = latinFirst ? latin : portuguese;
    final Widget secondChild = latinFirst ? portuguese : latin;

    return Padding(
      padding: padding,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: firstChild),
            VerticalDivider(
              width: 16,
              thickness: 1,
              color: dividerColor,
            ),
            Expanded(child: secondChild),
          ],
        ),
      ),
    );
  }
}

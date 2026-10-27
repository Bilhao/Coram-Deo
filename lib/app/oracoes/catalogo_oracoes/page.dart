import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/oracoes/catalogo_oracoes/data.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfficialCatalogPrayerPage extends StatelessWidget {
  final OfficialPrayerData prayer;

  const OfficialCatalogPrayerPage({
    super.key,
    required this.prayer,
  });

  Widget _buildStropheText(
    BuildContext context,
    PrayerStrophe strophe,
    String text,
    double fontSize,
  ) {
    final rubricColor = Theme.of(context).colorScheme.error;

    if (strophe.isRubric) {
      return Padding(
        padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: rubricColor,
          ),
        ),
      );
    }

    return Text.rich(
      TextSpan(
        children: [
          if (strophe.prefix != null && strophe.prefix!.isNotEmpty)
            TextSpan(
              text: strophe.prefix!,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: rubricColor,
              ),
            ),
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: strophe.isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fs = Provider.of<AppProvider>(context);
    final bool isBilingual = fs.bilingualMode;
    final String language = fs.prayerLanguage;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          prayer.title,
          maxLines: 2,
          style: const TextStyle(fontSize: 19),
        ),
        actions: [
          IconButton(
            onPressed: fs.toggleBilingualMode,
            icon: Icon(
              isBilingual
                  ? Icons.vertical_split
                  : Icons.vertical_split_outlined,
            ),
            tooltip: isBilingual
                ? "Modo coluna única"
                : "Modo bilíngue lado a lado",
          ),
          IconButton(
            onPressed: fs.decreaseFontSize,
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: fs.increaseFontSize,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 24,
              left: 15,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (prayer.subtitle != null && prayer.subtitle!.isNotEmpty) ...[
                  Text(
                    prayer.subtitle!,
                    style: TextStyle(
                      fontSize: fs.fontSize - 1,
                      fontStyle: FontStyle.italic,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Divider(height: 16, color: Colors.transparent),
                ] else
                  const Divider(height: 10, color: Colors.transparent),
                if (isBilingual) ...[
                  const BilingualPrayerHeader(),
                  for (final s in prayer.strophes)
                    BilingualPrayerRow(
                      latin: _buildStropheText(
                        context,
                        s,
                        s.lt,
                        fs.fontSize,
                      ),
                      portuguese: _buildStropheText(
                        context,
                        s,
                        s.pt,
                        fs.fontSize,
                      ),
                    ),
                  if (prayer.showAmen)
                    BilingualPrayerRow(
                      latin: Center(
                        child: Text(
                          "Amen",
                          style: TextStyle(
                            fontSize: fs.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      portuguese: Center(
                        child: Text(
                          "Amém",
                          style: TextStyle(
                            fontSize: fs.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ] else ...[
                  for (final s in prayer.strophes)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildStropheText(
                        context,
                        s,
                        language == "pt" ? s.pt : s.lt,
                        fs.fontSize,
                      ),
                    ),
                  if (prayer.showAmen)
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        language == "pt" ? "Amém" : "Amen",
                        style: TextStyle(
                          fontSize: fs.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
                if (prayer.scoreAsset != null) ...[
                  const Divider(height: 24, color: Colors.transparent),
                  ExpansionTile(
                    title: Text(
                      "Partitura Gregoriana",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                    leading: Icon(
                      Icons.music_note_outlined,
                      color: colorScheme.onSecondaryContainer,
                    ),
                    collapsedBackgroundColor: colorScheme.secondaryContainer,
                    backgroundColor: colorScheme.secondaryContainer,
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    childrenPadding: const EdgeInsets.all(10.0),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          prayer.scoreAsset!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ],
                const Divider(height: 20, color: Colors.transparent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

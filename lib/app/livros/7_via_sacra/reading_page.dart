import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/livros/7_via_sacra/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViaSacraReadingPage extends StatefulWidget {
  const ViaSacraReadingPage({super.key});

  @override
  State<ViaSacraReadingPage> createState() => _ViaSacraReadingPageState();
}

class _ViaSacraReadingPageState extends State<ViaSacraReadingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ViaSacraProvider(),
      child: Consumer2<ViaSacraProvider, AppProvider>(
        builder: (context, provider, fs, child) => Scaffold(
          appBar: AppBar(
            title: Text("Via Sacra"),
            actions: [
              IconButton(onPressed: fs.decreaseFontSize, icon: const Icon(Icons.remove)),
              IconButton(onPressed: fs.increaseFontSize, icon: const Icon(Icons.add)),
            ],
          ),
          body: SafeArea(
            child: SelectionArea(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: provider.showingMeditation ? _buildMeditationContent(provider, fs) : _buildStationContent(provider, fs),
                          ),
                        ),
                        _buildNavigationControls(provider, context),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStationContent(ViaSacraProvider provider, AppProvider fs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            provider.currentChapterName,
            style: TextStyle(
              fontSize: fs.fontSize + 4,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        provider.currentChapterId == 0
            ? Container()
            : Text.rich(TextSpan(children: [
                TextSpan(text: "℣.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                TextSpan(text: "Nós vos adoramos, ó Jesus, e vos bendizemos.", style: TextStyle(fontSize: fs.fontSize)),
                TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                TextSpan(text: "Porque pela vossa Santa Cruz remistes o mundo.", style: TextStyle(fontSize: fs.fontSize)),
              ])),
        provider.currentChapterId == 0 ? Container() : const SizedBox(height: 20),
        Text(
          provider.stationContent,
          style: TextStyle(fontSize: fs.fontSize, height: 1.6),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        provider.currentChapterId == 0
            ? Container()
            : Text(
                "Pai-Nosso, Ave-Maria, Glória ao Pai.",
                style: TextStyle(fontSize: fs.fontSize, fontStyle: FontStyle.italic),
              ),
        provider.currentChapterId == 0 ? Container() : const SizedBox(height: 20),
        provider.currentChapterId == 0
            ? Container()
            : Text.rich(TextSpan(children: [
                TextSpan(text: "℣.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                TextSpan(text: "Senhor, pequei.", style: TextStyle(fontSize: fs.fontSize)),
                TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                TextSpan(text: "Tende piedade e misericórdia de mim.", style: TextStyle(fontSize: fs.fontSize)),
              ])),
      ],
    );
  }

  Widget _buildMeditationContent(ViaSacraProvider provider, AppProvider fs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < provider.meditationContent.length; i++) ...[
          if (i > 0) const SizedBox(height: 20),
          Text(
            provider.meditationNames[i],
            style: TextStyle(
              fontSize: fs.fontSize + 2,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            provider.meditationContent[i],
            style: TextStyle(fontSize: fs.fontSize, height: 1.6),
            textAlign: TextAlign.justify,
          ),
        ],
      ],
    );
  }

  Widget _buildNavigationControls(ViaSacraProvider provider, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: provider.canGoToPrevious ? provider.goToPrevious : null,
            icon: const Icon(Icons.arrow_back),
            color: Theme.of(context).colorScheme.primary,
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FilledButton.tonal(
                onPressed: provider.meditationContent.isNotEmpty ? provider.toggleMeditationView : null,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                child: Text(
                  provider.showingMeditation ? "Texto da Estação" : "Pontos para Meditação",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: provider.canGoToNext ? provider.goToNext : null,
            icon: const Icon(Icons.arrow_forward),
            color: Theme.of(context).colorScheme.primary,
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ],
      ),
    );
  }
}

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
            title: Text(provider.currentChapterName),
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
                              child: provider.showingMeditation
                                  ? _buildMeditationContent(provider, fs)
                                  : _buildStationContent(provider, fs),
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
        Text(
          provider.stationContent,
          style: TextStyle(fontSize: fs.fontSize, height: 1.6),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget _buildMeditationContent(ViaSacraProvider provider, AppProvider fs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pontos para Meditação",
          style: TextStyle(
            fontSize: fs.fontSize + 4,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
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
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              IconButton(
                onPressed: provider.canGoToPrevious ? provider.goToPrevious : null,
                icon: const Icon(Icons.arrow_back),
                style: IconButton.styleFrom(
                  backgroundColor: provider.canGoToPrevious 
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  foregroundColor: provider.canGoToPrevious 
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : null,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              
              // Meditation toggle button
              FilledButton.tonal(
                onPressed: provider.meditationContent.isNotEmpty 
                    ? provider.toggleMeditationView 
                    : null,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                child: Text(
                  provider.showingMeditation ? "Estação" : "Meditação",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              
              // Next button
              IconButton(
                onPressed: provider.canGoToNext ? provider.goToNext : null,
                icon: const Icon(Icons.arrow_forward),
                style: IconButton.styleFrom(
                  backgroundColor: provider.canGoToNext 
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  foregroundColor: provider.canGoToNext 
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : null,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "${provider.currentChapterId} - ${provider.currentChapterName}",
            style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
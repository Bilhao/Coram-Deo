import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/livros/provider.dart';
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
      create: (context) => ViaSacraProvider(bookName: "via_sacra_livro"),
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15),
                                    Text(
                                      provider.showingMeditation ? "Pontos de Meditação" : "Estação",
                                      style: TextStyle(
                                        fontSize: fs.fontSize + 3, 
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      provider.showingMeditation 
                                        ? provider.currentMeditationContent 
                                        : provider.currentStationContent,
                                      style: TextStyle(fontSize: fs.fontSize),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: provider.currentChapterId == provider.fistChapterId
                                  ? null
                                  : () {
                                      provider.changeChapter(provider.currentChapterId - provider.fistChapterId - 1);
                                    },
                              icon: const Icon(Icons.arrow_back),
                              color: Theme.of(context).colorScheme.primary,
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ),
                            // Meditation/Station toggle button (only show for stations with meditation)
                            if (provider.hasMeditation)
                              TextButton(
                                onPressed: () {
                                  provider.toggleContent();
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                ),
                                child: Text(
                                  provider.showingMeditation ? "Estação" : "Meditação",
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ),
                            if (!provider.hasMeditation)
                              const SizedBox(width: 80), // Spacer for alignment
                            IconButton(
                              onPressed: provider.currentChapterId == provider.chapterIds.length + provider.fistChapterId - 1
                                  ? null
                                  : () {
                                      provider.changeChapter(provider.currentChapterId - provider.fistChapterId + 1);
                                    },
                              icon: const Icon(Icons.arrow_forward),
                              color: Theme.of(context).colorScheme.primary,
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ),
                          ],
                        ),
                        // Chapter info row
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
                          child: Text(
                            "${provider.currentChapterId} - ${provider.currentChapterName}",
                            style: const TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
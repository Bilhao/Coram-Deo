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
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
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
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
                                child: TextButton(
                                  child: Text(""),
                                  onPressed: () => provider.toggleContent(),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: provider.currentChapterId == provider.chapterIds.length + provider.fistChapterId - 1
                                  ? null
                                  : () {
                                      setState(() {
                                        provider.changeChapter(provider.currentChapterId - provider.fistChapterId + 1);
                                      });
                                    },
                              icon: const Icon(Icons.arrow_forward),
                              color: Theme.of(context).colorScheme.primary,
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ),
                          ],
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

import 'package:flutter/material.dart';
import 'package:coramdeo/app/biblia/data.dart';
import 'package:coramdeo/app/biblia/provider.dart';
import 'package:provider/provider.dart';

class BibliaPage2 extends StatefulWidget {
  const BibliaPage2({super.key});

  @override
  State<BibliaPage2> createState() => _BibliaPage2State();
}

class _BibliaPage2State extends State<BibliaPage2> {
  final Biblia dbHelper = Biblia();
  double fontSize = 18.0;

  void decreaseFontSize() {
    setState(() {
      fontSize--;
    });
  }

  void increaseFontSize() {
    setState(() {
      fontSize++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BibleProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.book),
            actions: [
              IconButton(
                onPressed: decreaseFontSize,
                icon: const Icon(Icons.remove),
              ),
              IconButton(
                onPressed: increaseFontSize,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: SafeArea(
            child: SelectionArea(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                key: const GlobalObjectKey('chapter'),
                                "Capítulo ${provider.chapter}",
                                style: TextStyle(fontSize: fontSize + 4),
                              ),
                            ),
                            const Divider(height: 15, color: Colors.transparent),
                            for (int i = 0; i < provider.versesId.length; i++)
                              Container(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${provider.versesId[i]}.  ",
                                        style: TextStyle(fontSize: fontSize - 4, fontWeight: FontWeight.w200),
                                      ),
                                      TextSpan(
                                        text: provider.verses[i],
                                        style: TextStyle(fontSize: fontSize),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: provider.bookId == 1 && provider.chapter == 1
                            ? null
                            : () {
                                provider.goToPreviousChapter();
                                Scrollable.ensureVisible(const GlobalObjectKey('chapter').currentContext!, duration: const Duration(milliseconds: 500));
                              },
                        icon: const Icon(Icons.arrow_back),
                        color: Theme.of(context).colorScheme.primary,
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      Text(
                        "${provider.book} - ${provider.chapter}",
                        style: const TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        onPressed: provider.bookId == 66 && provider.chapter == 22
                            ? null
                            : () {
                                provider.goToNextChapter();
                                Scrollable.ensureVisible(const GlobalObjectKey('chapter').currentContext!, duration: const Duration(milliseconds: 500));
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
        );
      },
    );
  }
}

import 'package:coramdeo/app/biblia/widgets/bible_version_bottom_sheet.dart';
import 'package:coramdeo/app/app_provider.dart';
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
  final ScrollController _scrollController = ScrollController();

  String _lastBook = '';
  int _lastChapter = -1;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BibleProvider, AppProvider>(
      builder: (context, provider, fs, child) {
        if (_lastBook != provider.book || _lastChapter != provider.chapter) {
          _lastBook = provider.book;
          _lastChapter = provider.chapter;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(0);
            }
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              provider.book,
              maxLines: 2,
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.translate),
                tooltip: 'Mudar Versão',
                onPressed: () {
                  BibleVersionBottomSheet.show(context);
                },
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
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                key: const GlobalObjectKey('chapter'),
                                "Capítulo ${provider.chapter}",
                                style: TextStyle(fontSize: fs.fontSize + 4),
                              ),
                            ),
                            const Divider(
                              height: 15,
                              color: Colors.transparent,
                            ),
                            for (int i = 0; i < provider.versesId.length; i++)
                              Container(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${provider.versesId[i]}.  ",
                                        style: TextStyle(
                                          fontSize: fs.fontSize - 4,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                      TextSpan(
                                        text: provider.verses[i],
                                        style: TextStyle(fontSize: fs.fontSize),
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
                  Container(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      left: 8.0,
                      top: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed:
                              provider.bookId == 1 && provider.chapter == 1
                              ? null
                              : () {
                                  provider.goToPreviousChapter();
                                },
                          icon: const Icon(Icons.arrow_back),
                          color: Theme.of(context).colorScheme.primary,
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        Text(
                          "${provider.book} - ${provider.chapter}",
                          style: const TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                          onPressed:
                              provider.bookId == 73 && provider.chapter == 22
                              ? null
                              : () {
                                  provider.goToNextChapter();
                                },
                          icon: const Icon(Icons.arrow_forward),
                          color: Theme.of(context).colorScheme.primary,
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
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

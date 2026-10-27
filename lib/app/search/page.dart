import 'dart:async';
import 'package:coramdeo/app/biblia/provider.dart';
import 'package:coramdeo/app/livros/point_book_reading_page.dart';
import 'package:coramdeo/app/search/model.dart';
import 'package:coramdeo/app/search/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalSearchPage extends StatefulWidget {
  const GlobalSearchPage({super.key});

  @override
  State<GlobalSearchPage> createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onQueryChanged(SearchProvider provider, String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 280), () {
      if (mounted) {
        provider.search(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: Consumer<SearchProvider>(
        builder: (context, provider, child) {
          final filters = const <MapEntry<String, String>>[
            MapEntry('Todos', 'Todos'),
            MapEntry('Oração', 'Orações'),
            MapEntry('Livro', 'Livros'),
            MapEntry('Bíblia', 'Bíblia'),
            MapEntry('Santo', 'Santos & Calendário'),
          ];

          return Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Orações, Caminho 28, João 3:16, Santos...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
                style: TextStyle(color: colorScheme.onSurface, fontSize: 17),
                onChanged: (value) => _onQueryChanged(provider, value),
                onSubmitted: (value) {
                  _debounce?.cancel();
                  provider.search(value);
                },
              ),
              actions: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    tooltip: "Limpar",
                    onPressed: () {
                      _searchController.clear();
                      provider.search('');
                      setState(() {});
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _debounce?.cancel();
                    provider.search(_searchController.text);
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Row(
                    children: [
                      for (final f in filters)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(f.value),
                            selected: provider.selectedTypeFilter == f.key,
                            onSelected: (_) => provider.setTypeFilter(f.key),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : provider.results.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              _searchController.text.trim().length < 2
                                  ? "Pesquise em Orações, Livros (ex: Caminho 28), Bíblia e Santos."
                                  : "Nenhum resultado encontrado.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.results.length,
                          itemBuilder: (context, index) {
                            final result = provider.results[index];
                            return ListTile(
                              leading: Icon(
                                _getIconForType(result.type),
                                color: colorScheme.primary,
                              ),
                              title: Text(
                                result.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                result.subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                _handleNavigation(context, result);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Bíblia':
        return Icons.menu_book;
      case 'Livro':
        return Icons.book;
      case 'Oração':
        return Icons.volunteer_activism_outlined;
      case 'Santo':
        return Icons.church_outlined;
      default:
        return Icons.article;
    }
  }

  void _handleNavigation(BuildContext context, SearchResult result) {
    final data = result.data;

    if (result.type == 'Bíblia') {
      final bibleProvider = Provider.of<BibleProvider>(context, listen: false);
      bibleProvider.updateValues(
        testament: data['testament'] ?? 'New',
        book: data['book'],
        chapter: data['chapter'],
      );
      Navigator.pushNamed(context, '/biblia-page-2');
    } else if (result.type == 'Livro') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookReadingPage(
            bookName: data['bookName'],
            points: [data['contentId']],
            title: data['title'],
          ),
        ),
      );
    } else if (result.type == 'Oração') {
      Navigator.pushNamed(context, '/${data['route']}');
    } else if (result.type == 'Santo') {
      if (data['isCalendar'] == true) {
        Navigator.pushNamed(context, '/calendario');
      } else {
        final int day = (data['day'] as int?) ?? DateTime.now().day;
        final int month = (data['month'] as int?) ?? DateTime.now().month;
        Navigator.pushNamed(
          context,
          '/santo-do-dia',
          arguments: DateTime(DateTime.now().year, month, day),
        );
      }
    }
  }
}

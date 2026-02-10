import 'package:coramdeo/app/biblia/provider.dart';
import 'package:coramdeo/app/livros/point_book_reading_page.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: Consumer<SearchProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Pesquisar...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                onSubmitted: (value) {
                  provider.search(value);
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    provider.search(_searchController.text);
                  },
                ),
              ],
            ),
            body: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.results.isEmpty
                ? const Center(child: Text("Nenhum resultado encontrado"))
                : ListView.builder(
                    itemCount: provider.results.length,
                    itemBuilder: (context, index) {
                      final result = provider.results[index];
                      return ListTile(
                        leading: Icon(_getIconForType(result.type)),
                        title: Text(result.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(result.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
                        onTap: () {
                          _handleNavigation(context, result);
                        },
                      );
                    },
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
        return Icons.article;
      default:
        return Icons.article;
    }
  }

  void _handleNavigation(BuildContext context, result) {
    // result is SearchResult (dynamic here because imported in provider but not explicitly cast in list builder without generic)
    // clearer to use dynamic or cast

    if (result.type == 'Bíblia') {
      final data = result.data;
      // Update Bible Provider context then navigate
      final bibleProvider = Provider.of<BibleProvider>(context, listen: false);
      bibleProvider.updateValues(
        testament: data['testament'] ?? 'New', // Default fallback
        book: data['book'],
        chapter: data['chapter'],
      );
      Navigator.pushNamed(context, '/biblia-page-2'); // Verify route name
    } else if (result.type == 'Livro') {
      final data = result.data;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookReadingPage(
            bookName: data['bookName'],
            points: [data['contentId']], // Pass as list
            title: data['title'],
          ),
        ),
      );
    } else if (result.type == 'Oração') {
      final data = result.data;
      Navigator.pushNamed(context, '/${data['route']}');
    }
  }
}

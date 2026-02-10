import 'package:coramdeo/app/biblia/data.dart';
import 'package:coramdeo/app/livros/data.dart';
import 'package:coramdeo/app/search/model.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:flutter/foundation.dart';

class SearchProvider extends BaseProvider {
  List<SearchResult> _results = [];
  List<SearchResult> get results => _results;

  final Biblia _bibleDb = Biblia();

  // List of books to search
  final List<String> _bookNames = ["caminho", "sulco", "forja", "amigos_de_deus", "e_cristo_que_passa", "santo_rosario_livro", "via_sacra_livro"];

  // Map of prayers (Route -> Title) - Copied from OracoesPage
  final Map<String, String> _prayers = {
    "oferecimento-de-obras": "Oferecimento de Obras",
    "comentario-do-evangelho-do-dia": "Comentário do Evangelho do dia",
    "falar-com-deus": "Meditação Diária do Falar com Deus",
    "angelus-regina-caeli": "Angelus/Regina Cæli",
    "lembrai-vos": "Lembrai-Vos",
    "preces": "Preces",
    "credo": "Credo Niceno-Constantinopolitano",
    "credo-atanasiano": "Credo Atanasiano",
    "santo-rosario": "Santo Rosário",
    "te-deum": "Te Deum",
    "visita-ao-santissimo": "Visita ao Santíssimo",
    "adoro-te-devote": "Adoro Te Devote",
    "salmo-2": "Salmo 2",
    "exame-de-consciencia-oracao": "Exame de Consciência",
    "estampa-josemaria": "Estampa de São Josemaría",
    "gratias-tibi-ago": "Gratias tibi ago",
  };

  Future<void> search(String query) async {
    if (query.length < 3) {
      _results = [];
      notifyListeners();
      return;
    }

    setLoading(true);
    _results = [];

    // Run searches in parallel
    await Future.wait([_searchBible(query), _searchBooks(query), _searchPrayers(query)]);

    setLoading(false);
  }

  Future<void> _searchBible(String query) async {
    try {
      final prefs = await BaseProvider.getPrefs();
      String version = prefs.getString(AppConstants.bibleVersionKey) ?? AppConstants.defaultBibleVersion;

      _bibleDb.setVersion(version);
      final db = await _bibleDb.initDb();
      // Adjust column names based on verified schema
      final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT book, chapter, verse_id, verse, book_id FROM bible WHERE verse LIKE ? OR book LIKE ? LIMIT 20', ['%$query%', '%$query%']);

      for (var map in maps) {
        _results.add(
          SearchResult(
            title: "${map['book']} ${map['chapter']}:${map['verse_id']}",
            subtitle: map['verse'],
            type: 'Bíblia',
            data: {
              'book': map['book'],
              'chapter': map['chapter'],
              'verse_id': map['verse_id'],
              'testament': (map['book_id'] ?? 1) <= 39 ? 'Old' : 'New',
              // book_id logic might be approximate if not explicitly in result
            },
          ),
        );
      }
    } catch (e) {
      debugPrint("Error searching Bible: $e");
    }
  }

  Future<void> _searchBooks(String query) async {
    for (String bookName in _bookNames) {
      try {
        final bookDb = Livros(bookName: bookName);
        final db = await bookDb.initDb();

        // Convert bookName to Display Title
        String displayTitle = _formatBookName(bookName);

        // Search content
        final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT content_id, content FROM book WHERE content LIKE ? LIMIT 5', ['%\$query%']);

        for (var map in maps) {
          String snippet = map['content'].toString().replaceAll('\n', ' ');
          if (snippet.length > 100) snippet = "\${snippet.substring(0, 100)}...";

          _results.add(SearchResult(title: "\$displayTitle - Ponto \${map['content_id']}", subtitle: snippet, type: 'Livro', data: {'bookName': bookName, 'contentId': map['content_id'], 'title': displayTitle}));
        }
      } catch (e) {
        debugPrint("Error searching book \$bookName: \$e");
      }
    }
  }

  Future<void> _searchPrayers(String query) async {
    _prayers.forEach((route, title) {
      if (title.toLowerCase().contains(query.toLowerCase())) {
        _results.add(SearchResult(title: title, subtitle: "Oração", type: 'Oração', data: {'route': route}));
      }
    });
  }

  String _formatBookName(String name) {
    switch (name) {
      case "caminho":
        return "Caminho";
      case "sulco":
        return "Sulco";
      case "forja":
        return "Forja";
      case "amigos_de_deus":
        return "Amigos de Deus";
      case "e_cristo_que_passa":
        return "É Cristo que passa";
      case "santo_rosario_livro":
        return "Santo Rosário";
      case "via_sacra_livro":
        return "Via Sacra";
      default:
        return name;
    }
  }
}

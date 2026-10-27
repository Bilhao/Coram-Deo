import 'package:coramdeo/app/biblia/data.dart';
import 'package:coramdeo/app/calendario/models/liturgical_day.dart';
import 'package:coramdeo/app/calendario/services/opus_dei_calendar_data.dart';
import 'package:coramdeo/app/livros/data.dart';
import 'package:coramdeo/app/oracoes/catalogo_oracoes/data.dart';
import 'package:coramdeo/app/oracoes/custom_prayer_model.dart';
import 'package:coramdeo/app/santo_do_dia/repository.dart';
import 'package:coramdeo/app/search/model.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:flutter/foundation.dart';

class SearchProvider extends BaseProvider {
  List<SearchResult> _results = [];
  String _selectedTypeFilter = 'Todos';

  List<SearchResult> get results {
    if (_selectedTypeFilter == 'Todos') return _results;
    return _results.where((r) => r.type == _selectedTypeFilter).toList();
  }

  List<SearchResult> get allResults => _results;
  String get selectedTypeFilter => _selectedTypeFilter;

  void setTypeFilter(String filter) {
    if (_selectedTypeFilter != filter) {
      _selectedTypeFilter = filter;
      notifyListeners();
    }
  }

  final Biblia _bibleDb = Biblia();
  final SantoDoDiaRepository _santosRepo = SantoDoDiaRepository();

  final List<String> _bookNames = const [
    "caminho",
    "sulco",
    "forja",
    "amigos_de_deus",
    "e_cristo_que_passa",
    "santo_rosario_livro",
    "via_sacra_livro",
  ];

  Map<String, String> get prayers => Map.unmodifiable(_prayers);

  late final Map<String, String> _prayers = {
    "adoracao-e-bencao-com-o-santissimo": "Adoração e Bênção com o Santíssimo",
    "adoro-te-devote": "Adoro Te Devote",
    "angelus-regina-caeli": "Angelus/Regina Cæli",
    "comentario-do-evangelho-do-dia": "Comentário do Evangelho do dia",
    "credo-atanasiano": "Credo Atanasiano",
    "credo": "Credo Niceno-Constantinopolitano",
    "estampa-josemaria": "Estampa de São Josemaría",
    "exame-de-consciencia-oracao": "Exame de Consciência",
    "gratias-tibi-ago": "Gratias tibi ago (São Tomás)",
    "lembrai-vos": "Lembrai-Vos",
    "falar-com-deus": "Meditação Diária do Falar com Deus",
    "oferecimento-de-obras": "Oferecimento de Obras",
    "preces": "Preces",
    "responso": "Responso",
    "salmo-2": "Salmo 2",
    "santo-rosario": "Santo Rosário",
    "te-deum": "Te Deum",
    "visita-ao-santissimo": "Visita ao Santíssimo",
    for (final entry in OfficialPrayersCatalog.byRoute.entries)
      entry.key: entry.value.title,
  };

  static const Map<String, String> _builtinPrayerKeywords = {
    "adoracao-e-bencao-com-o-santissimo":
        "tantum ergo sacramentum pange lingua laudate dominum bendito seja deus",
    "adoro-te-devote":
        "adoro te com amor deus escondido latens deitas pie pellicane",
    "angelus-regina-caeli":
        "o anjo do senhor anunciou a maria rainha do ceu alegrai-vos",
    "credo-atanasiano":
        "quicunque vult salvus esse todo aquele que quiser salvar-se",
    "credo": "creio em um so deus pai todo-poderoso niceno constantinopolitano",
    "estampa-josemaria":
        " o deus que por meio da bem-aventurada virgem maria concedestes inumeras gracas ao vosso sacerdote josemaria",
    "exame-de-consciencia-oracao":
        "meu deus dai-me luz para conhecer os pecados que hoje cometi deveres",
    "gratias-tibi-ago":
        "dou-vos gracas senhor santo pai todo-poderoso deus eterno",
    "lembrai-vos":
        "lembrai-vos o piissima virgem maria que nunca se ouviu dizer sao bernardo memorare",
    "oferecimento-de-obras":
        "serviam oferecimento de obras senhor meu e deus meu",
    "preces":
        "veni sancte spiritus serviam preces da obra sao josemaria",
    "responso": "fidelium animae requiescant in pace fieis defuntos",
    "salmo-2": "quare fremuerunt gentes por que se amotinam as nacoes",
    "santo-rosario":
        "misterios gozosos dolorosos gloriosos luminosos terco ave maria",
    "te-deum": "a vos o deus louvamos a vos senhor cantamos te deum laudamus",
    "visita-ao-santissimo":
        "viva jesus sacramentado comunhao espiritual visita ao santissimo",
  };

  static String _normalize(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[áàâãä]'), 'a')
        .replaceAll(RegExp(r'[éèêë]'), 'e')
        .replaceAll(RegExp(r'[íìîï]'), 'i')
        .replaceAll(RegExp(r'[óòôõö]'), 'o')
        .replaceAll(RegExp(r'[úùûü]'), 'u')
        .replaceAll(RegExp(r'[ç]'), 'c')
        .replaceAll('æ', 'ae')
        .replaceAll('ǽ', 'ae')
        .replaceAll('œ', 'oe');
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.length < 2) {
      _results = [];
      notifyListeners();
      return;
    }

    setLoading(true);
    final collected = <SearchResult>[];

    await Future.wait([
      _searchPrayers(trimmed, collected),
      _searchBooks(trimmed, collected),
      _searchBible(trimmed, collected),
      _searchSaintsAndCalendar(trimmed, collected),
    ]);

    _results = collected;
    setLoading(false);
  }

  Future<void> _searchPrayers(String query, List<SearchResult> out) async {
    final qNorm = _normalize(query);

    _prayers.forEach((route, title) {
      final titleNorm = _normalize(title);
      final catalogEntry = OfficialPrayersCatalog.byRoute[route];
      String matchedSnippet = "Oração Oficial";
      bool matches = titleNorm.contains(qNorm);

      if (!matches && catalogEntry != null) {
        if (catalogEntry.subtitle != null &&
            _normalize(catalogEntry.subtitle!).contains(qNorm)) {
          matches = true;
          matchedSnippet = catalogEntry.subtitle!;
        } else {
          for (final s in catalogEntry.strophes) {
            if (_normalize(s.pt).contains(qNorm)) {
              matches = true;
              matchedSnippet = s.pt;
              break;
            } else if (_normalize(s.lt).contains(qNorm)) {
              matches = true;
              matchedSnippet = s.lt;
              break;
            }
          }
        }
      } else if (!matches && _builtinPrayerKeywords.containsKey(route)) {
        if (_builtinPrayerKeywords[route]!.contains(qNorm)) {
          matches = true;
        }
      } else if (matches && catalogEntry?.subtitle != null) {
        matchedSnippet = catalogEntry!.subtitle!;
      }

      if (matches) {
        out.add(
          SearchResult(
            title: title,
            subtitle: matchedSnippet,
            type: 'Oração',
            data: {'route': route},
          ),
        );
      }
    });

    try {
      final prefs = await BaseProvider.getPrefs();
      final customList = CustomPrayer.decodeList(
        prefs.getString(AppConstants.customPrayersKey),
      );
      for (final p in customList) {
        if (_normalize(p.title).contains(qNorm) ||
            _normalize(p.subtitle).contains(qNorm) ||
            _normalize(p.text).contains(qNorm)) {
          out.add(
            SearchResult(
              title: p.title,
              subtitle: p.subtitle.isNotEmpty
                  ? p.subtitle
                  : p.text.replaceAll('\n', ' '),
              type: 'Oração',
              data: {'route': p.route},
            ),
          );
        }
      }
    } catch (_) {}
  }

  Future<void> _searchBooks(String query, List<SearchResult> out) async {
    final qNorm = _normalize(query);

    // Check for "<Livro> <Ponto>" pattern, e.g., "Caminho 28", "Sulco 150", "Forja 1"
    final pointRegex = RegExp(
      r'^(caminho|sulco|forja|amigos de deus|e cristo que passa|santo rosario|via sacra)\s+(\d+)$',
    );
    final match = pointRegex.firstMatch(qNorm);

    if (match != null) {
      final bookAlias = match.group(1)!;
      final pointNumber = int.tryParse(match.group(2)!);
      final targetBook = _resolveBookKey(bookAlias);
      if (targetBook != null && pointNumber != null) {
        await _queryBookByPointId(targetBook, pointNumber, out);
        return;
      }
    }

    // If user typed just a number (e.g. "28"), search that point number in Caminho, Sulco, Forja
    final directPoint = int.tryParse(trimmedNumber(query));
    if (directPoint != null) {
      for (final bookName in const ["caminho", "sulco", "forja"]) {
        await _queryBookByPointId(bookName, directPoint, out);
      }
      return;
    }

    for (final String bookName in _bookNames) {
      try {
        final bookDb = Livros(bookName: bookName);
        final db = await bookDb.initDb();
        final String displayTitle = _formatBookName(bookName);

        final List<Map<String, dynamic>> maps = await db.rawQuery(
          'SELECT content_id, content FROM book WHERE content LIKE ? LIMIT 8',
          ['%$query%'],
        );

        for (final map in maps) {
          String snippet = map['content'].toString().replaceAll('\n', ' ');
          if (snippet.length > 120) {
            snippet = "${snippet.substring(0, 120)}...";
          }

          out.add(
            SearchResult(
              title: "$displayTitle - Ponto ${map['content_id']}",
              subtitle: snippet,
              type: 'Livro',
              data: {
                'bookName': bookName,
                'contentId': map['content_id'],
                'title': displayTitle,
              },
            ),
          );
        }
      } catch (e) {
        debugPrint("Error searching book $bookName: $e");
      }
    }
  }

  String trimmedNumber(String input) =>
      input.trim().replaceFirst(RegExp(r'^ponto\s+', caseSensitive: false), '');

  String? _resolveBookKey(String normalizedAlias) {
    switch (normalizedAlias) {
      case 'caminho':
        return 'caminho';
      case 'sulco':
        return 'sulco';
      case 'forja':
        return 'forja';
      case 'amigos de deus':
        return 'amigos_de_deus';
      case 'e cristo que passa':
        return 'e_cristo_que_passa';
      case 'santo rosario':
        return 'santo_rosario_livro';
      case 'via sacra':
        return 'via_sacra_livro';
      default:
        return null;
    }
  }

  Future<void> _queryBookByPointId(
    String bookName,
    int pointId,
    List<SearchResult> out,
  ) async {
    try {
      final bookDb = Livros(bookName: bookName);
      final db = await bookDb.initDb();
      final displayTitle = _formatBookName(bookName);
      final maps = await db.rawQuery(
        'SELECT content_id, content FROM book WHERE content_id = ? LIMIT 1',
        [pointId],
      );
      for (final map in maps) {
        String snippet = map['content'].toString().replaceAll('\n', ' ');
        if (snippet.length > 120) {
          snippet = "${snippet.substring(0, 120)}...";
        }
        out.add(
          SearchResult(
            title: "$displayTitle - Ponto ${map['content_id']}",
            subtitle: snippet,
            type: 'Livro',
            data: {
              'bookName': bookName,
              'contentId': map['content_id'],
              'title': displayTitle,
            },
          ),
        );
      }
    } catch (_) {}
  }

  Future<void> _searchBible(String query, List<SearchResult> out) async {
    try {
      final prefs = await BaseProvider.getPrefs();
      final String version =
          prefs.getString(AppConstants.bibleVersionKey) ??
          AppConstants.defaultBibleVersion;

      _bibleDb.setVersion(version);
      final db = await _bibleDb.initDb();

      // Check for reference pattern like "João 3:16" or "Gênesis 1, 1" or "Salmos 23"
      final refRegex = RegExp(r'^([1-3]?\s*[a-zA-ZÀ-ÿ\s]+?)\s+(\d+)(?:[:.,]\s*(\d+))?$');
      final refMatch = refRegex.firstMatch(query.trim());

      List<Map<String, dynamic>> maps;
      if (refMatch != null) {
        final bookPart = refMatch.group(1)!.trim();
        final chPart = int.tryParse(refMatch.group(2)!);
        final vPart = refMatch.group(3);
        if (chPart != null && vPart != null) {
          maps = await db.rawQuery(
            'SELECT book, chapter, verse_id, verse, book_id, testament FROM bible WHERE book LIKE ? AND chapter = ? AND verse_id = ? LIMIT 15',
            ['%$bookPart%', chPart, vPart],
          );
        } else if (chPart != null) {
          maps = await db.rawQuery(
            'SELECT book, chapter, verse_id, verse, book_id, testament FROM bible WHERE book LIKE ? AND chapter = ? LIMIT 15',
            ['%$bookPart%', chPart],
          );
        } else {
          maps = [];
        }
      } else {
        maps = await db.rawQuery(
          'SELECT book, chapter, verse_id, verse, book_id, testament FROM bible WHERE verse LIKE ? OR book LIKE ? LIMIT 25',
          ['%$query%', '%$query%'],
        );
      }

      for (final map in maps) {
        out.add(
          SearchResult(
            title: "${map['book']} ${map['chapter']}:${map['verse_id']}",
            subtitle: map['verse'].toString(),
            type: 'Bíblia',
            data: {
              'book': map['book'],
              'chapter': map['chapter'],
              'verse_id': map['verse_id'],
              'testament':
                  map['testament'] ??
                  ((map['book_id'] ?? 1) <= 46 ? 'Old' : 'New'),
            },
          ),
        );
      }
    } catch (e) {
      debugPrint("Error searching Bible: $e");
    }
  }

  Future<void> _searchSaintsAndCalendar(
    String query,
    List<SearchResult> out,
  ) async {
    try {
      final saints = await _santosRepo.search(query);
      for (final s in saints) {
        final dayStr = s.dia.toString().padLeft(2, '0');
        final monthStr = s.mes.toString().padLeft(2, '0');
        out.add(
          SearchResult(
            title: "${s.nome} ($dayStr/$monthStr)",
            subtitle: (s.subtitulo != null && s.subtitulo!.isNotEmpty)
                ? s.subtitulo!
                : s.biografia,
            type: 'Santo',
            data: {'day': s.dia, 'month': s.mes},
          ),
        );
      }
    } catch (e) {
      debugPrint("Error searching Saints: $e");
    }

    final qNorm = _normalize(query);
    OpusDeiCalendarData.celebrations.forEach((mmDd, cel) {
      if (_normalize(cel.name).contains(qNorm) ||
          _normalize(cel.description).contains(qNorm)) {
        final parts = mmDd.split('-');
        final month = int.tryParse(parts[0]) ?? 1;
        final day = int.tryParse(parts[1]) ?? 1;
        out.add(
          SearchResult(
            title:
                "${cel.name} (${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')})",
            subtitle: "${cel.classRank.fullTitle} • ${cel.description}",
            type: 'Santo',
            data: {'day': day, 'month': month, 'isCalendar': true},
          ),
        );
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

import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class ComentarioDoEvangelho {
  Document? data;

  Future<void> initCDE() async {
    try {
      var response = await http.get(
        Uri.parse('https://opusdei.org/pt-br/gospel/'),
        headers: {
          'User-Agent': 'CoramDeo/1.0.1 (Android)',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Language': 'pt-BR,pt;q=0.9,en;q=0.8',
        },
      );
      if (response.statusCode == 200) {
        data = parse(response.body);
      } else {
        throw Exception('Status code: ${response.statusCode}');
      }
    } catch (_) {
      data = null;
    }
  }

  // Alias for initCDE to match usage in provider
  Future<void> initCE() async {
    await initCDE();
  }

  String getEvangelho() {
    String title = data?.querySelector('.imperavi-body strong, #content strong')?.text.trim() ?? '';
    if (title.isEmpty) {
      final paragraphs = data?.querySelectorAll('.imperavi-body p') ?? [];
      for (final p in paragraphs) {
        final text = p.text.trim();
        if (text.startsWith('Evangelho')) {
          title = text;
          break;
        }
      }
    }
    return title.isNotEmpty ? title : 'Evangelho';
  }

  String getComentario() {
    String title = data?.querySelector('h1.title, article h1, #content h1:not(.hidden-label)')?.text.trim() ?? '';
    return title.isNotEmpty ? title : 'Comentário ao Evangelho';
  }

  List<String> getEvangelhoText() {
    final body = data?.querySelector('.imperavi-body');
    if (body == null) return [];

    final evangelhoTitle = getEvangelho();
    final List<String> verses = [];
    final children = body.children;

    final hasHr = children.any((c) => c.localName == 'hr');
    if (hasHr) {
      for (final child in children) {
        if (child.localName == 'hr') {
          break; // Stop at first HR (start of commentary)
        }
        final text = child.text.trim();
        if (text.isEmpty) continue;
        if (text == evangelhoTitle || (evangelhoTitle.isNotEmpty && text.startsWith(evangelhoTitle))) {
          continue;
        }
        verses.add(text);
      }
    } else {
      final paragraphs = body.querySelectorAll('p').map((e) => e.text.trim()).where((e) => e.isNotEmpty).toList();
      for (final p in paragraphs) {
        if (p == evangelhoTitle || p.startsWith('Evangelho (')) continue;
        if (verses.length < 3 || p.contains('“') || p.contains('"')) {
          verses.add(p);
          if (p.endsWith('”') || p.endsWith('"')) break;
        } else {
          break;
        }
      }
    }
    return verses;
  }

  List<String> getCommentsText() {
    final body = data?.querySelector('.imperavi-body');
    if (body == null) return [];

    final List<String> comments = [];
    final children = body.children;

    final hasHr = children.any((c) => c.localName == 'hr');
    if (hasHr) {
      bool inCommentary = false;
      for (final child in children) {
        if (child.localName == 'hr') {
          inCommentary = true;
          continue;
        }
        if (inCommentary) {
          final text = child.text.trim();
          if (text.isNotEmpty) {
            comments.add(text);
          }
        }
      }
    } else {
      final evangelhoVerses = getEvangelhoText();
      final evangelhoTitle = getEvangelho();
      final paragraphs = body.querySelectorAll('p').map((e) => e.text.trim()).where((e) => e.isNotEmpty).toList();
      for (final p in paragraphs) {
        if (p == evangelhoTitle || evangelhoVerses.contains(p)) continue;
        comments.add(p);
      }
    }
    return comments;
  }

  // Alias for getCommentsText to match usage in provider
  List<String> getComentarioText() {
    return getCommentsText();
  }
}

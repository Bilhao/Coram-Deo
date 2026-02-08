import 'dart:math';
import 'package:coramdeo/app/livros/data.dart';
import 'package:coramdeo/utils/base_provider.dart';

class RandomPointProvider extends BaseProvider {
  RandomPointProvider() {
    loadRandomPoint();
  }

  String _bookName = "";
  String _bookTitle = "";
  String _content = "";
  String _title = "";
  int _chapterId = 0;
  int _contentId = 0;

  String get bookName => _bookName;
  String get bookTitle => _bookTitle;
  String get content => _content;
  String get title => _title;
  int get chapterId => _chapterId;
  int get contentId => _contentId;

  final List<String> _targetBooks = ['caminho', 'sulco', 'forja'];
  final Map<String, String> _bookTitles = {'caminho': 'Caminho', 'sulco': 'Sulco', 'forja': 'Forja'};

  Future<void> loadRandomPoint() async {
    setLoading(true);
    await safeAsync(() async {
      final random = Random();
      _bookName = _targetBooks[random.nextInt(_targetBooks.length)];
      _bookTitle = _bookTitles[_bookName] ?? _bookName;

      Livros book = Livros(bookName: _bookName);
      final data = await book.getRandomContent();

      if (data.isNotEmpty) {
        _content = data['content'] as String;
        _title = (data['title'] as String?) ?? "";
        _chapterId = (data['chapter_id'] as int?) ?? 0;
        _contentId = (data['content_id'] as int?) ?? 0;

      }
      return true;
    }, errorContext: 'Loading random point');
    setLoading(false);
  }
}

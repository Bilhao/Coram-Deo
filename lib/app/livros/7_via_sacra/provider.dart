import 'package:coramdeo/app/livros/7_via_sacra/data.dart';
import 'package:coramdeo/utils/base_provider.dart';

class ViaSacraProvider extends BaseProvider {
  ViaSacraProvider() {
    _initialize();
  }

  List<int> _chapterIds = [];
  List<String> _chapterNames = [];
  int _fistChapterId = 0;
  int _currentChapterId = 0;
  String _currentChapterName = "";
  String _stationContent = "";
  List<String> _meditationContent = [];
  List<String> _meditationNames = [];
  bool _showingMeditation = false;
  String _aboutContent = "";

  List<int> get chapterIds => _chapterIds;
  List<String> get chapterNames => _chapterNames;
  int get fistChapterId => _fistChapterId;
  int get currentChapterId => _currentChapterId;
  String get currentChapterName => _currentChapterName;
  String get stationContent => _stationContent;
  List<String> get meditationContent => _meditationContent;
  List<String> get meditationNames => _meditationNames;
  bool get showingMeditation => _showingMeditation;
  String get aboutContent => _aboutContent;

  Future<void> _initialize() async {
    setLoading(true);
    
    await safeAsync(() async {
      ViaSacraData data = ViaSacraData();
      _chapterIds = await data.getChapterIds();
      _chapterNames = await data.getChapterNames();
      _fistChapterId = await data.getFirstChapter();
      _aboutContent = await data.getAboutContent();
      
      return true;
    }, errorContext: 'Loading Via Sacra structure');

    await safePrefOperation((prefs) async {
      ViaSacraData data = ViaSacraData();
      _currentChapterId = prefs.getInt('livros.via_sacra_livro.currentChapterId') ?? await data.getFirstChapter();
      _currentChapterName = prefs.getString('livros.via_sacra_livro.currentChapterName') ?? await data.getFirstChapterName();
      
      return true;
    }, errorContext: 'Loading Via Sacra preferences');

    await safeAsync(() async {
      ViaSacraData data = ViaSacraData();
      _stationContent = await data.getStationContent(chapterId: _currentChapterId);
      _meditationContent = await data.getMeditationContent(chapterId: _currentChapterId);
      _meditationNames = await data.getMeditationNames(chapterId: _currentChapterId);
      
      return true;
    }, errorContext: 'Loading Via Sacra content');
    
    setLoading(false);
  }

  Future<void> changeChapter(int chapterIndex) async {
    setLoading(true);
    
    await safePrefOperation((prefs) async {
      await prefs.setInt('livros.via_sacra_livro.currentChapterId', chapterIndex + _fistChapterId);
      await prefs.setString('livros.via_sacra_livro.currentChapterName', _chapterNames[chapterIndex]);
      return true;
    }, errorContext: 'Saving chapter change');

    await safeAsync(() async {
      ViaSacraData data = ViaSacraData();
      _currentChapterId = chapterIndex + _fistChapterId;
      _currentChapterName = _chapterNames[chapterIndex];
      _stationContent = await data.getStationContent(chapterId: _currentChapterId);
      _meditationContent = await data.getMeditationContent(chapterId: _currentChapterId);
      _meditationNames = await data.getMeditationNames(chapterId: _currentChapterId);
      _showingMeditation = false; // Reset to station view when changing chapters
      return true;
    }, errorContext: 'Loading new chapter content');
    
    setLoading(false);
  }

  void toggleMeditationView() {
    _showingMeditation = !_showingMeditation;
    notifyListeners();
  }

  bool get canGoToPrevious => _currentChapterId > _fistChapterId;
  bool get canGoToNext => _currentChapterId < _chapterIds.length + _fistChapterId - 1;

  Future<void> goToPrevious() async {
    if (canGoToPrevious) {
      await changeChapter(_currentChapterId - _fistChapterId - 1);
    }
  }

  Future<void> goToNext() async {
    if (canGoToNext) {
      await changeChapter(_currentChapterId - _fistChapterId + 1);
    }
  }
}
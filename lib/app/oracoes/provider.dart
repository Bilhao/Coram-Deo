import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';

class OracoesProvider extends BaseProvider {
  OracoesProvider() {
    _initialize();
  }

  List<String> _favoritas = [];

  List<String> get favoritas => _favoritas;

  Future<void> _initialize() async {
    await safePrefOperation((prefs) async {
      _favoritas = prefs.getStringList(AppConstants.favoritePrayersKey) ?? [];
      notifyListeners();
      return true;
    }, errorContext: 'Loading favorite prayers');
  }

  Future<void> toggleFavorita(String oracao) async {
    await safePrefOperation((prefs) async {
      if (_favoritas.contains(oracao)) {
        _favoritas.remove(oracao);
      } else {
        _favoritas.add(oracao);
      }
      await prefs.setStringList(AppConstants.favoritePrayersKey, _favoritas);
      notifyListeners();
      return true;
    }, errorContext: 'Toggling favorite prayer');
  }
}
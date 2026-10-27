import 'package:coramdeo/app/oracoes/custom_prayer_model.dart';
import 'package:coramdeo/services/cloud_sync_service.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';

class OracoesProvider extends BaseProvider {
  OracoesProvider() {
    _initialize();
    CloudSyncService.onDataRestored.addListener(_onDataRestored);
  }

  List<String> _favoritas = [];
  List<CustomPrayer> _customPrayers = [];

  List<String> get favoritas => _favoritas;
  List<CustomPrayer> get customPrayers => List.unmodifiable(_customPrayers);

  void _onDataRestored() {
    _initialize();
  }

  @override
  void dispose() {
    CloudSyncService.onDataRestored.removeListener(_onDataRestored);
    super.dispose();
  }

  Future<void> _initialize() async {
    await safePrefOperation((prefs) async {
      _favoritas = prefs.getStringList(AppConstants.favoritePrayersKey) ?? [];
      final rawCustom = prefs.getString(AppConstants.customPrayersKey);
      _customPrayers = CustomPrayer.decodeList(rawCustom);
      notifyListeners();
      return true;
    }, errorContext: 'Loading prayers');
  }

  Future<void> reload() => _initialize();

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

  Future<CustomPrayer> addCustomPrayer({
    required String title,
    String subtitle = '',
    required String text,
  }) async {
    final prayer = CustomPrayer(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      subtitle: subtitle.trim(),
      text: text.trim(),
    );
    await safePrefOperation((prefs) async {
      _customPrayers.add(prayer);
      await prefs.setString(
        AppConstants.customPrayersKey,
        CustomPrayer.encodeList(_customPrayers),
      );
      notifyListeners();
      return true;
    }, errorContext: 'Adding custom prayer');
    CloudSyncService().syncInBackground();
    return prayer;
  }

  Future<void> updateCustomPrayer(CustomPrayer updated) async {
    await safePrefOperation((prefs) async {
      final index = _customPrayers.indexWhere((p) => p.id == updated.id);
      if (index != -1) {
        _customPrayers[index] = updated;
        await prefs.setString(
          AppConstants.customPrayersKey,
          CustomPrayer.encodeList(_customPrayers),
        );
        notifyListeners();
      }
      return true;
    }, errorContext: 'Updating custom prayer');
    CloudSyncService().syncInBackground();
  }

  Future<void> deleteCustomPrayer(String id) async {
    final routeKey = 'custom-oracao:$id';
    await safePrefOperation((prefs) async {
      _customPrayers.removeWhere((p) => p.id == id);
      await prefs.setString(
        AppConstants.customPrayersKey,
        CustomPrayer.encodeList(_customPrayers),
      );
      if (_favoritas.remove(routeKey)) {
        await prefs.setStringList(AppConstants.favoritePrayersKey, _favoritas);
      }
      notifyListeners();
      return true;
    }, errorContext: 'Deleting custom prayer');
    CloudSyncService().syncInBackground();
  }
}

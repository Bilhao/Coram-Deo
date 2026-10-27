import 'package:coramdeo/app/diario/model.dart';
import 'package:coramdeo/services/cloud_sync_service.dart';
import 'package:coramdeo/utils/base_provider.dart';
import 'package:coramdeo/utils/constants.dart';
import 'package:intl/intl.dart';

class DiarioProvider extends BaseProvider {
  DiarioProvider() {
    _initialize();
    CloudSyncService.onDataRestored.addListener(_onDataRestored);
  }

  List<SpiritualJournalEntry> _entries = [];

  List<SpiritualJournalEntry> get entries => List.unmodifiable(_entries);

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
      final raw = prefs.getString(AppConstants.spiritualJournalKey);
      _entries = SpiritualJournalEntry.decodeEncryptedList(raw);
      notifyListeners();
      return true;
    }, errorContext: 'Loading spiritual journal');
  }

  Future<void> reload() => _initialize();

  static String formatToday() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<SpiritualJournalEntry> addEntry({
    String? date,
    required String title,
    required String text,
  }) async {
    final entry = SpiritualJournalEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: (date != null && date.trim().isNotEmpty)
          ? date.trim()
          : formatToday(),
      title: title.trim(),
      text: text.trim(),
    );

    await safePrefOperation((prefs) async {
      _entries.insert(0, entry);
      await prefs.setString(
        AppConstants.spiritualJournalKey,
        SpiritualJournalEntry.encodeEncryptedList(_entries),
      );
      notifyListeners();
      return true;
    }, errorContext: 'Adding journal entry');
    CloudSyncService().syncInBackground();
    return entry;
  }

  Future<void> updateEntry(SpiritualJournalEntry updated) async {
    await safePrefOperation((prefs) async {
      final idx = _entries.indexWhere((e) => e.id == updated.id);
      if (idx != -1) {
        _entries[idx] = updated;
        await prefs.setString(
          AppConstants.spiritualJournalKey,
          SpiritualJournalEntry.encodeEncryptedList(_entries),
        );
        notifyListeners();
      }
      return true;
    }, errorContext: 'Updating journal entry');
    CloudSyncService().syncInBackground();
  }

  Future<void> deleteEntry(String id) async {
    await safePrefOperation((prefs) async {
      _entries.removeWhere((e) => e.id == id);
      await prefs.setString(
        AppConstants.spiritualJournalKey,
        SpiritualJournalEntry.encodeEncryptedList(_entries),
      );
      notifyListeners();
      return true;
    }, errorContext: 'Deleting journal entry');
    CloudSyncService().syncInBackground();
  }
}

import 'dart:convert';
import 'dart:typed_data';

class SpiritualJournalEntry {
  final String id;
  final String date;
  final String title;
  final String text;

  const SpiritualJournalEntry({
    required this.id,
    required this.date,
    required this.title,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'text': text,
    };
  }

  factory SpiritualJournalEntry.fromMap(Map<String, dynamic> map) {
    return SpiritualJournalEntry(
      id: map['id']?.toString() ?? '',
      date: map['date']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      text: map['text']?.toString() ?? '',
    );
  }

  static const String _prefix = 'ENC1:';
  static const String _secretSalt = 'CoramDeo-LuzesDeOracao-v1-Key';

  static Uint8List _deriveKeyStream(int length) {
    final seedBytes = utf8.encode(_secretSalt);
    final out = Uint8List(length);
    int state = 0x811C9DC5;
    for (final b in seedBytes) {
      state ^= b;
      state = (state * 0x01000193) & 0xFFFFFFFF;
    }
    for (int i = 0; i < length; i++) {
      state ^= (i & 0xFF) ^ seedBytes[i % seedBytes.length];
      state = (state * 0x01000193) & 0xFFFFFFFF;
      out[i] = ((state >> 16) ^ state) & 0xFF;
    }
    return out;
  }

  static String _encryptString(String plainText) {
    final plainBytes = utf8.encode(plainText);
    final keyStream = _deriveKeyStream(plainBytes.length);
    final cipherBytes = Uint8List(plainBytes.length);
    for (int i = 0; i < plainBytes.length; i++) {
      cipherBytes[i] = plainBytes[i] ^ keyStream[i];
    }
    return '$_prefix${base64Encode(cipherBytes)}';
  }

  static String _decryptString(String payload) {
    if (!payload.startsWith(_prefix)) {
      return payload;
    }
    final b64 = payload.substring(_prefix.length);
    final cipherBytes = base64Decode(b64);
    final keyStream = _deriveKeyStream(cipherBytes.length);
    final plainBytes = Uint8List(cipherBytes.length);
    for (int i = 0; i < cipherBytes.length; i++) {
      plainBytes[i] = cipherBytes[i] ^ keyStream[i];
    }
    return utf8.decode(plainBytes);
  }

  static String encodeEncryptedList(List<SpiritualJournalEntry> entries) {
    final rawJson = json.encode(entries.map((e) => e.toMap()).toList());
    return _encryptString(rawJson);
  }

  static List<SpiritualJournalEntry> decodeEncryptedList(String? stored) {
    if (stored == null || stored.trim().isEmpty) return [];
    try {
      final rawJson = _decryptString(stored.trim());
      final decoded = json.decode(rawJson);
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map((e) =>
                SpiritualJournalEntry.fromMap(Map<String, dynamic>.from(e)))
            .where((e) => e.id.isNotEmpty)
            .toList();
      }
    } catch (_) {}
    return [];
  }
}

import 'dart:convert';

class CustomPrayer {
  final String id;
  final String title;
  final String subtitle;
  final String text;

  const CustomPrayer({
    required this.id,
    required this.title,
    this.subtitle = '',
    required this.text,
  });

  String get route => 'custom-oracao:$id';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'text': text,
    };
  }

  factory CustomPrayer.fromMap(Map<String, dynamic> map) {
    return CustomPrayer(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      subtitle: map['subtitle']?.toString() ?? '',
      text: map['text']?.toString() ?? '',
    );
  }

  static List<CustomPrayer> decodeList(String? rawJson) {
    if (rawJson == null || rawJson.trim().isEmpty) return [];
    try {
      final decoded = json.decode(rawJson);
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map((e) => CustomPrayer.fromMap(Map<String, dynamic>.from(e)))
            .where((p) => p.id.isNotEmpty && p.title.isNotEmpty)
            .toList();
      }
    } catch (_) {}
    return [];
  }

  static String encodeList(List<CustomPrayer> list) {
    return json.encode(list.map((e) => e.toMap()).toList());
  }
}

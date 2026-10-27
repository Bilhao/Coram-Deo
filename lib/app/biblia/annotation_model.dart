import 'dart:convert';
import 'package:flutter/material.dart';

class BibleVerseAnnotation {
  final String versionId;
  final String versionName;
  final String testament;
  final String book;
  final int chapter;
  final String verseId;
  final String verseText;
  final String? colorKey; // 'yellow', 'green', 'blue', 'pink'
  final String note;
  final String updatedAt;

  const BibleVerseAnnotation({
    required this.versionId,
    required this.versionName,
    required this.testament,
    required this.book,
    required this.chapter,
    required this.verseId,
    required this.verseText,
    this.colorKey,
    this.note = '',
    required this.updatedAt,
  });

  static String buildKey(
    String versionId,
    String book,
    int chapter,
    String verseId,
  ) {
    return '$versionId|$book|$chapter|$verseId';
  }

  String get key => buildKey(versionId, book, chapter, verseId);

  String get formattedCitation =>
      '"$verseText"\n— $book $chapter, $verseId ($versionName)';

  Map<String, dynamic> toMap() {
    return {
      'versionId': versionId,
      'versionName': versionName,
      'testament': testament,
      'book': book,
      'chapter': chapter,
      'verseId': verseId,
      'verseText': verseText,
      'colorKey': colorKey,
      'note': note,
      'updatedAt': updatedAt,
    };
  }

  factory BibleVerseAnnotation.fromMap(Map<String, dynamic> map) {
    return BibleVerseAnnotation(
      versionId: map['versionId']?.toString() ?? 'ave_maria',
      versionName: map['versionName']?.toString() ?? 'Bíblia Ave Maria',
      testament: map['testament']?.toString() ?? 'Old',
      book: map['book']?.toString() ?? 'Gênesis',
      chapter: (map['chapter'] is num) ? (map['chapter'] as num).toInt() : 1,
      verseId: map['verseId']?.toString() ?? '1',
      verseText: map['verseText']?.toString() ?? '',
      colorKey: map['colorKey']?.toString(),
      note: map['note']?.toString() ?? '',
      updatedAt:
          map['updatedAt']?.toString() ?? DateTime.now().toIso8601String(),
    );
  }

  static Map<String, BibleVerseAnnotation> decodeMap(String? rawJson) {
    if (rawJson == null || rawJson.trim().isEmpty) return {};
    try {
      final decoded = json.decode(rawJson);
      if (decoded is List) {
        final result = <String, BibleVerseAnnotation>{};
        for (final item in decoded) {
          if (item is Map) {
            final ann = BibleVerseAnnotation.fromMap(
              Map<String, dynamic>.from(item),
            );
            result[ann.key] = ann;
          }
        }
        return result;
      }
    } catch (_) {}
    return {};
  }

  static String encodeMap(Map<String, BibleVerseAnnotation> map) {
    return json.encode(map.values.map((e) => e.toMap()).toList());
  }

  static Color? resolveHighlightColor(
    BuildContext context,
    String? colorKey, {
    double? alpha,
  }) {
    if (colorKey == null || colorKey.isEmpty) return null;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveAlpha = alpha ?? (isDark ? 0.28 : 0.35);

    switch (colorKey) {
      case 'yellow':
        return const Color(0xFFFBC02D).withValues(alpha: effectiveAlpha);
      case 'green':
        return const Color(0xFF66BB6A).withValues(alpha: effectiveAlpha);
      case 'blue':
        return const Color(0xFF42A5F5).withValues(alpha: effectiveAlpha);
      case 'pink':
        return const Color(0xFFEC407A).withValues(alpha: effectiveAlpha);
      default:
        return null;
    }
  }
}

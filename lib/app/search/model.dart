class SearchResult {
  final String title;
  final String subtitle;
  final String type; // 'Bíblia', 'Livro', 'Oração'
  final dynamic data; // Flexible data for navigation

  SearchResult({required this.title, required this.subtitle, required this.type, required this.data});
}

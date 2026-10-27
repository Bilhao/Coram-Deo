class SantoModel {
  final int? id;
  final int mes;
  final int dia;
  final String nome;
  final String? subtitulo;
  final String biografia;
  final String? oracao;
  final String? imagemUrl;

  const SantoModel({
    this.id,
    required this.mes,
    required this.dia,
    required this.nome,
    this.subtitulo,
    required this.biografia,
    this.oracao,
    this.imagemUrl,
  });

  bool get isAssetImage =>
      imagemUrl != null && imagemUrl!.startsWith('assets/');

  static String cleanBiographicalText(String raw) {
    var text = raw;
    const replacements = <String, String>{
      'veterotestamentárias': 'do Antigo Testamento',
      'veterotestamentária': 'do Antigo Testamento',
      'veterotestamentários': 'do Antigo Testamento',
      'veterotestamentário': 'do Antigo Testamento',
      'neotestamentárias': 'do Novo Testamento',
      'neotestamentária': 'do Novo Testamento',
      'no ano da graça de ': 'no ano de ',
      'da era cristã': '',
    };
    replacements.forEach((oldStr, newStr) {
      text = text.replaceAll(oldStr, newStr);
    });
    text = text.replaceAll(RegExp(r' +([,.;:])'), r'$1');
    text = text.replaceAll(RegExp(r' {2,}'), ' ');
    return text.trim();
  }

  List<String> get paragraphs {
    return cleanBiographicalText(biografia)
        .split(RegExp(r'\n\s*\n'))
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
  }

  factory SantoModel.fromMap(Map<String, dynamic> map) {
    return SantoModel(
      id: map['id'] as int?,
      mes: map['mes'] as int,
      dia: map['dia'] as int,
      nome: map['nome'] as String,
      subtitulo: map['subtitulo'] as String?,
      biografia: map['biografia'] as String,
      oracao: map['oracao'] as String?,
      imagemUrl: map['imagem_url'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'mes': mes,
      'dia': dia,
      'nome': nome,
      'subtitulo': subtitulo,
      'biografia': biografia,
      'oracao': oracao,
      'imagem_url': imagemUrl,
    };
  }
}


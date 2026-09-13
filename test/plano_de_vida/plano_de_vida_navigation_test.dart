import 'package:flutter_test/flutter_test.dart';
import 'package:coramdeo/app/plano_de_vida/page.dart';

void main() {
  group('Selecionados.getRouteForNorm tests', () {
    test('Mapeia normas clássicas para as rotas corretas', () {
      expect(Selecionados.getRouteForNorm('Oferecimento de Obras'), '/oferecimento-de-obras');
      expect(Selecionados.getRouteForNorm('Oração da manhã'), '/oferecimento-de-obras');
      expect(Selecionados.getRouteForNorm('Ângelus/Regina Cæli'), '/angelus-regina-caeli');
      expect(Selecionados.getRouteForNorm('Angelus'), '/angelus-regina-caeli');
      expect(Selecionados.getRouteForNorm('Terço'), '/santo-rosario');
      expect(Selecionados.getRouteForNorm('Santo Rosário'), '/santo-rosario');
      expect(Selecionados.getRouteForNorm('Contemplar o Santo Rosário'), '/santo-rosario');
      expect(Selecionados.getRouteForNorm('Visita ao Santíssimo'), '/visita-ao-santissimo');
      expect(Selecionados.getRouteForNorm('Exame de Consciência'), '/exame-de-consciencia-oracao');
      expect(Selecionados.getRouteForNorm('Salmo 2'), '/salmo-2');
      expect(Selecionados.getRouteForNorm('Preces'), '/preces');
      expect(Selecionados.getRouteForNorm('Leitura Espiritual'), '/livros');
      expect(Selecionados.getRouteForNorm('Leitura do Novo Testamento'), '/biblia-page-1');
      expect(Selecionados.getRouteForNorm('Santa Missa'), '/liturgia');
      expect(Selecionados.getRouteForNorm('Lembrai-vos'), '/lembrai-vos');
      expect(Selecionados.getRouteForNorm('Via Sacra'), '/via-sacra-reading');
      expect(Selecionados.getRouteForNorm('Falar com Deus'), '/falar-com-deus');
      expect(Selecionados.getRouteForNorm('Comentário do Evangelho'), '/comentario-do-evangelho-do-dia');
    });

    test('Retorna null para itens personalizados sem oração correspondente', () {
      expect(Selecionados.getRouteForNorm('Ligar para os pais'), isNull);
      expect(Selecionados.getRouteForNorm('Fazer caminhada'), isNull);
      expect(Selecionados.getRouteForNorm('Arrumar o quarto'), isNull);
    });
  });
}

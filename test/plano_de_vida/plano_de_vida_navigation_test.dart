import 'package:flutter_test/flutter_test.dart';
import 'package:coramdeo/app/plano_de_vida/page.dart';

void main() {
  group('Selecionados.getRouteForNorm tests', () {
    test('Mapeia normas com oração correspondente exata', () {
      expect(Selecionados.getRouteForNorm('Oferecimento de Obras'), '/oferecimento-de-obras');
      expect(Selecionados.getRouteForNorm('Ângelus/Regina Cæli'), '/angelus-regina-caeli');
      expect(Selecionados.getRouteForNorm('Angelus/Regina Cæli'), '/angelus-regina-caeli');
      expect(Selecionados.getRouteForNorm('Terço'), '/santo-rosario');
      expect(Selecionados.getRouteForNorm('Santo Rosário'), '/santo-rosario');
      expect(Selecionados.getRouteForNorm('Contemplar o Santo Rosário'), '/santo-rosario-livro');
      expect(Selecionados.getRouteForNorm('Visita ao Santíssimo'), '/visita-ao-santissimo');
      expect(Selecionados.getRouteForNorm('Preces'), '/preces');
      expect(Selecionados.getRouteForNorm('Exame de Consciência'), '/exame-de-consciencia-oracao');
      expect(Selecionados.getRouteForNorm('Lembrai-vos'), '/lembrai-vos');
      expect(Selecionados.getRouteForNorm('Lembrai-Vos'), '/lembrai-vos');
      expect(Selecionados.getRouteForNorm('Via Sacra'), '/via-sacra-reading');
      expect(Selecionados.getRouteForNorm('Leitura Espiritual'), '/livros');
      expect(Selecionados.getRouteForNorm('Salmo 2'), '/salmo-2');
    });

    test('Retorna null para normas genéricas sem oração exata correspondente', () {
      expect(Selecionados.getRouteForNorm('Oração da manhã'), isNull);
      expect(Selecionados.getRouteForNorm('Oração da tarde'), isNull);
      expect(Selecionados.getRouteForNorm('Santa Missa'), isNull);
      expect(Selecionados.getRouteForNorm('Leitura do Novo Testamento'), isNull);
      expect(Selecionados.getRouteForNorm('Três Ave-Marias para a pureza'), isNull);
    });

    test('Retorna null para itens personalizados ou não catalogados', () {
      expect(Selecionados.getRouteForNorm('Ligar para os pais'), isNull);
      expect(Selecionados.getRouteForNorm('Fazer caminhada'), isNull);
      expect(Selecionados.getRouteForNorm('Arrumar o quarto'), isNull);
    });
  });
}

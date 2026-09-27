import 'dart:io';
import 'package:coramdeo/app/santo_do_dia/model.dart';
import 'package:coramdeo/app/santo_do_dia/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SantoModel Unit Tests', () {
    test('Cria modelo corretamente e separa os parágrafos da biografia', () {
      const bio =
          'Primeiro parágrafo.\n\nSegundo parágrafo.\n\nTerceiro parágrafo.';
      const santo = SantoModel(
        id: 1,
        mes: 9,
        dia: 17,
        nome: 'São Roberto Belarmino',
        subtitulo: 'Bispo e Doutor da Igreja',
        biografia: bio,
        oracao: 'Oração final.',
        imagemUrl: 'https://example.com/roberto.webp',
      );

      expect(santo.nome, 'São Roberto Belarmino');
      expect(santo.subtitulo, 'Bispo e Doutor da Igreja');
      expect(santo.paragraphs.length, 3);
      expect(santo.paragraphs[0], 'Primeiro parágrafo.');
      expect(santo.paragraphs[1], 'Segundo parágrafo.');
      expect(santo.paragraphs[2], 'Terceiro parágrafo.');
      expect(santo.oracao, 'Oração final.');
      expect(santo.isAssetImage, isFalse);

      const santoAsset = SantoModel(
        id: 1,
        mes: 9,
        dia: 17,
        nome: 'São Roberto Belarmino',
        biografia: bio,
        imagemUrl: 'assets/images/santos/santo_09_17.webp',
      );
      expect(santoAsset.isAssetImage, isTrue);
    });

    test('Serialização e desserialização via Map', () {
      final map = {
        'id': 2,
        'mes': 9,
        'dia': 18,
        'nome': 'São José de Cupertino',
        'subtitulo': 'Presbítero',
        'biografia': 'Parágrafo 1.\n\nParágrafo 2.\n\nParágrafo 3.',
        'oracao': 'Deus eterno...',
        'imagem_url': 'https://example.com/jose.webp',
      };

      final santo = SantoModel.fromMap(map);
      expect(santo.id, 2);
      expect(santo.dia, 18);
      expect(santo.mes, 9);
      expect(santo.nome, 'São José de Cupertino');
      expect(santo.paragraphs.length, 3);

      final exported = santo.toMap();
      expect(exported['nome'], 'São José de Cupertino');
      expect(exported['dia'], 18);
      expect(exported['mes'], 9);
    });
  });

  group('santos.db SQLite Schema & Integrity Tests', () {
    const dbPath = 'assets/santos.db';

    test('Arquivo assets/santos.db existe e tem integridade válida', () {
      final file = File(dbPath);
      expect(file.existsSync(), isTrue);

      final integrity = Process.runSync('sqlite3', [
        dbPath,
        'PRAGMA integrity_check;',
      ]);
      expect(integrity.exitCode, 0);
      expect(integrity.stdout.toString().trim(), 'ok');
    });

    test('Tabela santos possui as colunas necessárias e índice de data', () {
      final tableInfo = Process.runSync('sqlite3', [
        dbPath,
        'PRAGMA table_info(santos);',
      ]);
      expect(tableInfo.exitCode, 0);
      final output = tableInfo.stdout.toString();
      expect(output, contains('mes'));
      expect(output, contains('dia'));
      expect(output, contains('nome'));
      expect(output, contains('subtitulo'));
      expect(output, contains('biografia'));
      expect(output, contains('oracao'));
      expect(output, contains('imagem_url'));

      final indexList = Process.runSync('sqlite3', [
        dbPath,
        'PRAGMA index_list(santos);',
      ]);
      expect(indexList.stdout.toString(), contains('idx_santos_data'));
    });

    test(
      'Contém entrada estruturada para 17 de Setembro (São Roberto Belarmino)',
      () {
        final query = Process.runSync('sqlite3', [
          dbPath,
          "SELECT nome, subtitulo FROM santos WHERE mes = 9 AND dia = 17;",
        ]);
        expect(query.exitCode, 0);
        expect(
          query.stdout.toString().trim(),
          'São Roberto Belarmino|Bispo e Doutor da Igreja',
        );
      },
    );

    test(
      'Contém entrada estruturada para 18 de Setembro (São José de Cupertino)',
      () {
        final query = Process.runSync('sqlite3', [
          dbPath,
          "SELECT nome FROM santos WHERE mes = 9 AND dia = 18;",
        ]);
        expect(query.exitCode, 0);
        expect(query.stdout.toString().trim(), 'São José de Cupertino');
      },
    );

    test(
      'Todas as entradas em santos.db são profissionais e não contêm emojis',
      () {
        final query = Process.runSync('sqlite3', [
          dbPath,
          "SELECT nome, subtitulo, biografia, oracao FROM santos;",
        ]);
        expect(query.exitCode, 0);
        final content = query.stdout.toString();
        expect(content, isNotEmpty);

        // Regex para emojis comuns
        final emojiRegex = RegExp(
          r'[\u{1F300}-\u{1F9FF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}]',
          unicode: true,
        );
        expect(emojiRegex.hasMatch(content), isFalse);
      },
    );

    test('santos.db possui exatamente 366 dias (ano bissexto completo)', () {
      final countQuery = Process.runSync('sqlite3', [
        dbPath,
        "SELECT COUNT(*) FROM santos;",
      ]);
      expect(countQuery.exitCode, 0);
      expect(countQuery.stdout.toString().trim(), '366');

      final monthDistribution = Process.runSync('sqlite3', [
        dbPath,
        "SELECT mes, COUNT(*) FROM santos GROUP BY mes ORDER BY mes;",
      ]);
      expect(monthDistribution.exitCode, 0);
      final expected =
          '1|31\n2|29\n3|31\n4|30\n5|31\n6|30\n7|31\n8|31\n9|30\n10|31\n11|30\n12|31';
      expect(monthDistribution.stdout.toString().trim(), expected);
    });

    test(
      'santos.db possui IDs estritamente ordenados de 1 a 366 (1 de Jan a 31 de Dez)',
      () {
        final firstRow = Process.runSync('sqlite3', [
          dbPath,
          "SELECT id, mes, dia, nome FROM santos WHERE id = 1;",
        ]);
        expect(firstRow.exitCode, 0);
        expect(
          firstRow.stdout.toString().trim(),
          '1|1|1|Santa Maria, Mãe de Deus',
        );

        final lastRow = Process.runSync('sqlite3', [
          dbPath,
          "SELECT id, mes, dia, nome FROM santos WHERE id = 366;",
        ]);
        expect(lastRow.exitCode, 0);
        expect(lastRow.stdout.toString().trim(), '366|12|31|São Silvestre I');

        final minMaxQuery = Process.runSync('sqlite3', [
          dbPath,
          "SELECT MIN(id), MAX(id), COUNT(DISTINCT id) FROM santos;",
        ]);
        expect(minMaxQuery.exitCode, 0);
        expect(minMaxQuery.stdout.toString().trim(), '1|366|366');
      },
    );
  });

  group('SantoDoDiaProvider Dynamic Header Title Tests', () {
    test('Calcula título padrão como "Santo do Dia" para santos comuns', () {
      expect(
        SantoDoDiaProvider.computeHeaderTitle(
          'São Roberto Belarmino',
          'Bispo e Doutor da Igreja',
        ),
        'Santo do Dia',
      );
      expect(
        SantoDoDiaProvider.computeHeaderTitle(
          'São Bento',
          'Abade, Patriarca dos Monges do Ocidente',
        ),
        'Santo do Dia',
      );
      expect(
        SantoDoDiaProvider.computeHeaderTitle('São Francisco de Assis'),
        'Santo do Dia',
      );
    });

    test('Calcula "Festa do Dia" para festas litúrgicas da Igreja', () {
      expect(
        SantoDoDiaProvider.computeHeaderTitle(
          'Exaltação da Santa Cruz',
          'Festa',
        ),
        'Festa do Dia',
      );
      expect(
        SantoDoDiaProvider.computeHeaderTitle(
          'Transfiguração do Senhor',
          'Festa',
        ),
        'Festa do Dia',
      );
      expect(
        SantoDoDiaProvider.computeHeaderTitle(
          'Apresentação do Senhor',
          'Festa',
        ),
        'Festa do Dia',
      );
      expect(
        SantoDoDiaProvider.computeHeaderTitle(
          'Cátedra de São Pedro',
          'Festa do Apóstolo',
        ),
        'Festa do Dia',
      );
    });

    test(
      'Calcula "Solenidade do Dia" para solenidades do Senhor e da Virgem Maria',
      () {
        expect(
          SantoDoDiaProvider.computeHeaderTitle(
            'Natal de Nosso Senhor Jesus Cristo',
            'Solenidade',
          ),
          'Solenidade do Dia',
        );
        expect(
          SantoDoDiaProvider.computeHeaderTitle(
            'Anunciação do Senhor',
            'Solenidade',
          ),
          'Solenidade do Dia',
        );
        expect(
          SantoDoDiaProvider.computeHeaderTitle(
            'Nossa Senhora da Conceição Aparecida',
            'Padroeira do Brasil - Solenidade',
          ),
          'Solenidade do Dia',
        );
        expect(
          SantoDoDiaProvider.computeHeaderTitle(
            'Todos os Santos',
            'Solenidade',
          ),
          'Solenidade do Dia',
        );
      },
    );

    test('Calcula "Solenidade do Dia" para Fiéis Defuntos', () {
      expect(
        SantoDoDiaProvider.computeHeaderTitle(
          'Comemoração de Todos os Fiéis Defuntos',
          '',
        ),
        'Solenidade do Dia',
      );
    });

    test('Calcula título corretamente mesmo passando apenas o nome', () {
      expect(
        SantoDoDiaProvider.computeHeaderTitle('Exaltação da Santa Cruz'),
        'Festa do Dia',
      );
      expect(
        SantoDoDiaProvider.computeHeaderTitle('Santíssimo Nome de Maria'),
        'Festa do Dia',
      );
      expect(
        SantoDoDiaProvider.computeHeaderTitle('Todos os Santos'),
        'Solenidade do Dia',
      );
      expect(
        SantoDoDiaProvider.computeHeaderTitle(
          'Comemoração de Todos os Fiéis Defuntos',
        ),
        'Solenidade do Dia',
      );
      expect(
        SantoDoDiaProvider.computeHeaderTitle('São Januário'),
        'Santo do Dia',
      );
    });

    test('Retorna ícones dinâmicos adequados para cada celebração', () {
      expect(
        SantoDoDiaProvider.computeHeaderIcon('São Januário'),
        Icons.person_rounded,
      );
      expect(
        SantoDoDiaProvider.computeHeaderIcon('Exaltação da Santa Cruz'),
        Icons.church_rounded,
      );
      expect(
        SantoDoDiaProvider.computeHeaderIcon('Todos os Santos'),
        Icons.auto_awesome_rounded,
      );
      expect(
        SantoDoDiaProvider.computeHeaderIcon(
          'Comemoração de Todos os Fiéis Defuntos',
        ),
        Icons.auto_awesome_rounded,
      );
    });
  });
}

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Livros {
  Livros({required this.bookName}) {
    initDb();
  }

  String bookName;

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'books/$bookName.db');

    final exist = await databaseExists(path);

    if (exist) {
      return await openDatabase(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "books/$bookName.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

      return await openDatabase(path);
    }
  }

  Future<int> getFirstChapter() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter_id FROM book');
    return maps[0]['chapter_id'];
  }

  Future<List<int>> getChapterIds() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter_id FROM book');
    return List.generate(maps.length, (i) {
      return maps[i]['chapter_id'];
    });
  }

  Future<String> getFirstChapterName() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter FROM book');
    return maps[0]['chapter'];
  }

  Future<List<String>> getChapterNames() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT chapter FROM book');
    return List.generate(maps.length, (i) {
      return maps[i]['chapter'];
    });
  }

  Future<List<int>> getContentIds({required int chapterId}) async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT content_id FROM book WHERE chapter_id = ?', [chapterId]);
    return List.generate(maps.length, (i) {
      return maps[i]['content_id'];
    });
  }

  Future<List<String>> getContentByIds({required List<int> contentIds}) async {
    final db = await initDb();
    List<String> contents = [];
    for (int id in contentIds) {
      final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT content FROM book WHERE content_id = ?', [id]);
      contents.add(maps[0]['content']);
    }
    return contents;
  }

  Future<List<Map<String, dynamic>>> getFullContentByIds({required List<int> contentIds, int? chapterId}) async {
    final db = await initDb();
    List<Map<String, dynamic>> results = [];

    // Check if title column exists
    var columns = await db.rawQuery("PRAGMA table_info(book)");
    bool hasTitle = columns.any((col) => col['name'] == 'title');

    for (int id in contentIds) {
      String query;
      List<dynamic> args = [id];

      if (chapterId != null) {
        if (hasTitle) {
          query = 'SELECT title, content FROM book WHERE content_id = ? AND chapter_id = ?';
        } else {
          query = 'SELECT content FROM book WHERE content_id = ? AND chapter_id = ?';
        }
        args.add(chapterId);
      } else {
        if (hasTitle) {
          query = 'SELECT title, content FROM book WHERE content_id = ?';
        } else {
          query = 'SELECT content FROM book WHERE content_id = ?';
        }
      }

      final List<Map<String, dynamic>> maps = await db.rawQuery(query, args);

      if (maps.isNotEmpty) {
        if (hasTitle) {
          results.add({'title': maps[0]['title'], 'content': maps[0]['content']});
        } else {
          results.add({'title': null, 'content': maps[0]['content']});
        }
      }
    }
    return results;
  }

  Future<String> getAboutContent() async {
    switch (bookName) {
      case "caminho":
        return "Caminho (The Way), uma obra de São Josemaría Escrivá, é um livro de pontos para meditação espiritual. A primeira edição surgiu em 1934 com o título 'Considerações espirituais', e a versão definitiva, 'Caminho', foi publicada em 1939.\n\nA obra se caracteriza por um estilo direto, que estabelece um diálogo sereno com o leitor. Nela, o leitor é confrontado com as exigências divinas em um ambiente de confiança e amizade.";
      case "sulco":
        return "Sulco é uma obra de São Josemaría Escrivá, fundador do Opus Dei, que se apresenta como um fruto da sua vida interior e da sua experiência espiritual com muitas almas. O livro é composto por mil pontos de meditação breves e diretos, destinados a fomentar e facilitar a oração pessoal.\n\nA obra não é um tratado teológico sistemático, mas possui uma rica e profunda espiritualidade. O seu objetivo é alcançar a pessoa cristã em sua totalidade — corpo e alma, natureza e graça.";
      case "forja":
        return "Forja é uma obra de Josemaría Escrivá, publicada em 1987, que integra uma trilogia de livros de espiritualidade, complementando Caminho e Sulco. O livro é composto por 1055 pontos de meditação.\n\nDescrita como um 'livro de fogo', Forja tem como objetivo conduzir as almas à 'fornalha do Amor divino', estimulando nelas o anseio por santidade e apostolado. A obra traça um percurso interior de crescente identificação com Cristo.";
      case "amigos_de_deus":
        return "Amigos de Deus é a primeira obra póstuma de São Josemaría Escrivá, publicada originalmente em 1977. O livro é uma compilação de 18 homilias proferidas por Escrivá entre 1941 e 1968.\n\nO objetivo principal da obra é orientar os leitores a cultivarem uma amizade com um 'Deus próximo', utilizando como referência diversas virtudes humanas e sobrenaturais. As homilias exploram virtudes cristãs como fio condutor para um diálogo filial com Deus.";
      case "e_cristo_que_passa":
        return "É Cristo que passa reune 18 homilias proferidas por São Josemaría Escrivá entre 1951 e 1971. Essas homilias estão organizadas de acordo com o ano litúrgico e oferecem uma visão profunda sobre a vida de oração, o amor a Deus e ao próximo, e a busca da santidade.\n\nO fio condutor da obra é a filiação divina, destacando a llamada universal à santidade, a santificação do trabalho ordinário, a contemplação no meio do mundo e a unidade de vida.";
      case "santo_rosario_livro":
        return "Santo Rosário contém comentários de São Josemaría Escrivá sobre os mistérios do terço. Segundo São Josemaría, o Rosário é um 'foco de amor', e serve para glorificar o Pai, o Filho e o Espírito Santo.\n\nAo fixarem o olhar em Jesus, os membros da família podem recuperar a capacidade de comunicação, solidariedade, perdão mútuo e renovação de um pacto de amor, auxiliando a superar problemas de comunicação nas famílias contemporâneas.";
      default:
        return "";
    }
  }

  Future<Map<String, dynamic>> getRandomContent() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM book ORDER BY RANDOM() LIMIT 1');
    if (maps.isNotEmpty) {
      var columns = await db.rawQuery("PRAGMA table_info(book)");
      bool hasTitle = columns.any((col) => col['name'] == 'title');

      Map<String, dynamic> result = Map<String, dynamic>.from(maps.first);
      if (!hasTitle) {
        result['title'] = null;
      }
      return result;
    }
    return {};
  }
}

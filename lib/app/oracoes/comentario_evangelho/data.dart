import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class ComentarioDoEvangelho {
  Document? data;

  Future<void> initCDE() async {
    try {
      var response = await http.get(Uri.parse('https://opusdei.org/pt-br/gospel/'));
      if (response.statusCode == 200) {
        data = parse(response.body);
      } else {
        throw Exception();
      }
    } catch (_) {
      data = null;
    }
  }

  String getEvangelho() {
    List<String> strongContent = data?.querySelectorAll('#content strong').map((element) => element.text).toList() ?? [];
    return strongContent[0];
  }

  String getComentario() {
    List<String> strongContent = data?.querySelectorAll('#content strong').map((element) => element.text).toList() ?? [];
    return strongContent[1];
  }

  List<String> getEvangelhoText() {
    List<String> allText = data?.querySelectorAll('.imperavi-body p').map((element) => element.text).toList() ?? [];
    return allText.join("\n").split("Comentário")[0].split('\n').sublist(1);
  }

  List<String> getCommentsText() {
    List<String> allText = data?.querySelectorAll('.imperavi-body p').map((element) => element.text).toList() ?? [];
    return allText.join("\n").split("Comentário")[1].split('\n').sublist(1);
  }
}

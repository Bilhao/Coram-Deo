import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class FalarComDeus {
  Document? data;

  Future<void> initFCD() async {
    try {
      var response = await http.get(Uri.parse('https://www.hablarcondios.org/pt/meditacaodiaria.aspx'));
      if (response.statusCode == 200) {
        data = parse(response.body);
      } else {
        throw Exception();
      }
    } catch (_) {
      data = null;
    }
  }

  List<String> getDay() {
    return data?.querySelectorAll('.DiaLiturgico').map((element) => element.text).toList() ?? [];
  }

  List<String> getTitle() {
    return data?.querySelectorAll('.Titulo').map((element) => element.text).toList() ?? [];
  }

  List<String> getSubtitle() {
    return data?.querySelectorAll('.Subtitulo').map((element) => element.text).toList() ?? [];
  }

  List<String> getNote() {
    return data?.querySelectorAll('.Nota').map((element) => element.text).toList() ?? [];
  }

  List<String> getContent() {
    return data?.querySelectorAll('.Normal').map((element) => element.text).toList() ?? [];
  }

  List<String> getReference() {
    return data?.querySelectorAll('.Cfr').map((element) => element.text).toList() ?? [];
  }
}

import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class SantoDoDia {
  Document? data;

  Future<void> initSDD({required int day, required int month}) async {
    try {
      var response = await http.get(Uri.parse('https://www.a12.com/reze-no-santuario/santo-do-dia?day=$day&month=$month'));
      if (response.statusCode == 200) {
        data = parse(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      data = null;
    }
  }

  String getPortrait() {
    return "https://www.a12.com${data?.querySelector('.feature__portrait')?.attributes['src']}";
  }

  String getName() {
    return data?.querySelector('.feature__name')?.text ?? "";
  }

  List<String> getText() {
    return data?.querySelectorAll('.wg-text p')
        .map((element) => element.text)
        .where((text) => text.trim().isNotEmpty)
        .toList() ?? [];
  }

  List<String> getBoldText() {
    return data?.querySelectorAll('.wg-text b').map((element) => element.text).toList() ?? [];
  }

  List<String> getItalicText() {
    return data?.querySelectorAll('.wg-text i').map((element) => element.text).toList() ?? [];
  }
}

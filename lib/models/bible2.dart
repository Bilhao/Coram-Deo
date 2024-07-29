import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;


class Bible {
  Document? data;

  Future<void> initBible({required String language, required int bookid, required int chapter}) async {
    try {
      var baseurl = "https://beblia.com/";
      var response = await http.get(Uri.parse('$baseurl/Bible?Language=$language&Book=$bookid&Chapter=$chapter'));
      if (response.statusCode == 200) {
        data = parse(response.body);
      } else {
        throw Exception();
      }
    } catch (_) {
      data = null;
    }
  }

  Map<String, String> getAvailableLanguagesAndLinks() {
    Map<String, String> result = {};
    List<String> langs = data?.querySelectorAll('.subNav_Versions_Button').map((element) => element.attributes['title'].toString()).toList() ?? [];
    List<String> link = data?.querySelectorAll('.subNav_Versions_Button').map((element) => element.attributes['href'].toString()).toList() ?? [];
    RegExp regExp = RegExp(r"Language=([^&]+)");
    for (String lang in langs) {
      result.addAll({lang: regExp.firstMatch(link[langs.indexOf(lang)])?.group(1) ?? ""});
    }
    return result;
  }

  String getCurrentLanguage() {
    return data?.querySelectorAll('#regions_Sub_Lang_Button')[0].text ?? "Portugues";
  }

  Map<int, String> getBookIdAndNames() {
    Map<int, String> result = {};
    List<String> names = data?.querySelectorAll('#old_New_Testament_Div a').map((element) => element.text).toList() ?? [];
    for (int i = 0; i < names.length; i++) {
      result.addAll({i + 1: names[i]});
    }
    return result;
  }

  List<int> getNumberOfChapters() {
    List<int> chapters = data?.querySelectorAll('.subNav_Versions_Button').map((element) => int.parse(element.text)).toList() ?? [];
    return chapters;
  }

  List<String> getVersesId() {
    return data?.querySelectorAll('.verseTextButton').map((element) => element.text).toList() ?? [];
  }
  List<String> getVersesText() {
    return data?.querySelectorAll('.verseTextText').map((element) => element.text).toList() ?? [];
  }
}



import 'dart:convert';
import 'package:http/http.dart' as http;

class LiturgiaDiaria {
  dynamic data;
  RegExp regExp = RegExp(r'\d+');

  Future<void> initLD({required int day, required int month}) async {
    String formatedDay = day.toString().padLeft(2, "0");
    String formatedMonth = month.toString().padLeft(2, "0");
    String formatedYear = DateTime.now().year.toString();
    try {
      var response = await http.get(Uri.parse('https://liturgia.up.railway.app/$formatedDay-$formatedMonth-$formatedYear'));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        if (data.containsKey('error')) {
          data = null;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      data = null;
    }
  }

  String getDate() {
    return data['data'];
  }

  String getLiturgia() {
    return data['liturgia'];
  }

  String getPrimeiraLeituraTitulo() {
    return data['primeiraLeitura']['titulo'];
  }

  String getPrimeiraLeituraReferencia() {
    return data['primeiraLeitura']['referencia'];
  }

  String getPrimeiraLeituraTexto() {
    return data['primeiraLeitura']['texto'].replaceAll(regExp, '');
  }

  String getSalmoReferencia() {
    return data['salmo']['referencia'];
  }

  String getSalmoRefrao() {
    return data['salmo']['refrao'];
  }

  String getSalmoTexto() {
    return data['salmo']['texto'];
  }

  String getSegundaLeituraTitulo() {
    if (data['segundaLeitura'] == "Não há segunda leitura hoje!") {
      return '';
    }
    return data['segundaLeitura']['titulo'];
  }

  String getSegundaLeituraReferencia() {
    if (data['segundaLeitura'] == "Não há segunda leitura hoje!") {
      return '';
    }
    return data['segundaLeitura']['referencia'];
  }

  String getSegundaLeituraTexto() {
    if (data['segundaLeitura'] == "Não há segunda leitura hoje!") {
      return '';
    }
    return data['segundaLeitura']['texto'].replaceAll(regExp, '');
  }

  String getEvangelhoTitulo() {
    return data['evangelho']['titulo'];
  }

  String getEvangelhoReferencia() {
    return data['evangelho']['referencia'];
  }

  String getEvangelhoTexto() {
    return data['evangelho']['texto'].replaceAll(regExp, '');
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';


class EstampaJosemariaPage extends StatefulWidget {
  const EstampaJosemariaPage({super.key});

  @override
  State<EstampaJosemariaPage> createState() => _EstampaJosemariaPageState();
}

class _EstampaJosemariaPageState extends State<EstampaJosemariaPage> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estampa de São Josemaría"),
        actions: [
          IconButton(onPressed: appProvider.decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: appProvider.increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 15, color: Colors.transparent),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      frameBuilder: (BuildContext context, Widget child, int? frame, bool? wasSynchronouslyLoaded) {
                        return child;
                      },
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                      image: AssetImage("assets/images/oracoes/estampajosemaria.png"),
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Divider(height: 5, color: Colors.transparent),
                  Align(
                    alignment: Alignment.center,
                    child: Text("São Josemaria Escrivá", style: TextStyle(fontSize: appProvider.fontSize, fontWeight: FontWeight.bold)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Fundador do Opus Dei", style: TextStyle(fontSize: appProvider.fontSize - 3)),
                  ),
                  const Divider(height: 15, color: Colors.transparent),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Oração", style: TextStyle(fontSize: appProvider.fontSize + 3, fontWeight: FontWeight.bold))
                  ),
                  const Divider(height: 15, color: Colors.transparent),
                  Text(
                    "Ó Deus, que, por mediação da Santíssima Virgem Maria, concedestes inumeráveis graças a São Josemaria, sacerdote, escolhendo-o como "
                    "instrumento fidelíssimo para fundar o Opus Dei caminho de santificação no trabalho profissional e no "
                    "cumprimento dos deveres cotidianos do cristão, fazei que eu saiba também converter todos os momentos "
                    "e circunstâncias da minha vida em ocasião de vos amar, e de servir com alegria e com simplicidade a "
                    "Igreja, o Romano Pontífice e as almas, iluminando os caminhos da terra com o resplendor da fé e do amor. "
                    "Concedei-me por intercessão de São Josemaria o favor que vos peço... (peça-se). Amém.",
                    style: TextStyle(fontSize: appProvider.fontSize)),
                  Align(
                    alignment: Alignment.center,
                    child: Text("\nPai Nosso, Ave-Maria e Glória\n", style: TextStyle(fontSize: appProvider.fontSize - 1, fontStyle: FontStyle.italic))
                  ),
                  Text(
                    "\"Aí onde estão as nossas aspirações, o nosso trabalho, os nossos amores – aí está o lugar do nosso encontro cotidiano com Cristo. "
                    "É no meio das coisas mais materiais da terra que nos devemos santificar, servindo a Deus e a todos os homens. "
                    "Na linha do horizonte, meus filhos, parecem unir-se o céu e a terra. Mas não: onde de verdade se juntam é no coração, quando se vive santamente a vida diária...\"",
                    style: TextStyle(fontSize: appProvider.fontSize - 1, fontStyle: FontStyle.italic),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "São Josemaria Escrivá, homilia \"Amar o mundo apaixonadamente\", 8-10-1967.",
                      style: TextStyle(fontSize: appProvider.fontSize - 1, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.end)
                  ),
                  const Divider(height: 15, color: Colors.transparent),
                  Text(
                    "São Josemaria Escrivá nasceu em Barbastro (Espanha) em 9-1-1902. Recebeu a ordenação sacerdotal em Saragoça no "
                    "dia 28-3-1925. A 2-10-1928 fundou, por inspiração divina, o Opus Dei. Em 26-6-1975 faleceu repentinamente em Roma, "
                    "logo após ter olhado com imenso carinho uma imagem de Nossa Senhora que presidia ao seu quarto de trabalho. "
                    "Naquele momento, o Opus Dei estava estendido pelos cinco continentes e contava mais de 60.000 membros de 80 "
                    "nacionalidades, a serviço da Igreja com o mesmo espírito de plena união com o Papa e os Bispos que São Josemaria "
                    "Escrivá sempre viveu. O Santo Padre João Paulo II canonizou o Fundador do Opus Dei em Roma, no dia 6-10-2002. A sua "
                    "festa litúrgica celebra-se no dia 26 de junho. O corpo de São Josemaria Escrivá repousa na igreja prelatícia de Santa Maria "
                    "da Paz (Viale Bruno Buozzi, 75, Roma).",
                    style: TextStyle(fontSize: appProvider.fontSize),
                  ),
                  const Divider(height: 15, color: Colors.transparent),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Mais informações sobre São Josemaria Escrivá em:", style: TextStyle(fontSize: appProvider.fontSize - 3))
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(
                            text: "www.josemariaescriva.org.br",
                            style: TextStyle(fontSize: appProvider.fontSize - 3, color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launchUrlString("https://opusdei.org/pt-br/saint-josemaria/")
                          )
                      )
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(
                            text: "www.escrivaworks.org",
                            style: TextStyle(fontSize: appProvider.fontSize - 3, color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launchUrlString("https://escriva.org/pt-br/")
                          )
                      )
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "www.opusdei.org.br",
                          style: TextStyle(fontSize: appProvider.fontSize - 3, color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrlString("https://opusdei.org/pt-br/")
                        )
                      )
                  ),
                ]),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';

class TeDeumPage extends StatefulWidget {
  const TeDeumPage({super.key});

  @override
  State<TeDeumPage> createState() => _TeDeumPageState();
}

class _TeDeumPageState extends State<TeDeumPage> {
  String language = "pt";

  void toggleLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Te Deum"),
        actions: [
          IconButton(onPressed: () => toggleLanguage(language == "pt" ? "lt" : "pt"), icon: Text(language == "pt" ? "lt".toUpperCase() : "pt".toUpperCase()), tooltip: language == "pt" ? "Mudar para Latim" : "Mudar para Português"),
          IconButton(onPressed: fs.decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: fs.increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Divider(height: 15, color: Colors.transparent),
                Text(
                    language == "pt"
                        ? """
A Vós, ó Deus, louvamos; a Vós, Senhor, bendizemos.
A Vós, ó eterno Pai, adora toda a terra.
A Vós, todos os Anjos, os Céus e todas as Potestades.
A Vós, os Querubins e Serafins proclamam com incessantes vozes:
Santo, Santo, Santo, sois Vós, Senhor, Deus dos exércitos! 
Cheios estão os céus e a terra da majestade da vossa glória. 
A Vós, o glorioso coro dos Apóstolos, a Vós, o louvável número dos Profetas, a Vós vos louva o brilhante exército dos Mártires. 
A Vós confessa a Santa Igreja por toda a redondeza da terra. 
Pai de imensa majestade, ao vosso adorável Filho, verdadeiro e único e também ao Espírito Santo Consolador.  
Vós, ó Cristo, sois o Rei da glória. Vós sois o Filho eterno do Pai. 
Vós, para libertar o homem cuja carne havíeis de tomar, não rejeitastes o seio da Virgem. 
Vós, vencido o aguilhão da morte, abristes aos fiéis o Reino dos céus. 
Vós estais sentado à mão direita de Deus, na glória do Pai. 
Cremos que haveis de vir como Juiz."""
                        : """
Te Deum laudámus: te Dóminum confitémur.
Te æternum Patrem omnis terra venerátur.
Tibi omnes Angeli, tibi cæli et univérsæ potestátes;
Tibi Chérubim et Séraphim incessábili voce proclámant:
Sanctus, Sanctus, Sanctus Dóminus Deus Sábaoth. 
Pleni sunt cæli et terra maiestátis glóriæ tuæ.  
Te gloriósus Apostolórum chorus, Te Prophetárum laudábilis númerus, Te Mártyrum candidátus laudat exércitus.  
Te per orbem terrárum sancta confitétur Ecclésia.  
Patrem imménsæ maiestátis; 
Venerándum tuum verum et únicum Fílium; Sanctum quoque Paráclitum Spíritum. 
Tu, Rex glóriæ, Christe, Tu Patris sempiternus es Fílius. 
Tu, ad liberándum susceptúrus hóminem, non horruíste Vírginis úterum. 
Tu, devícto mortis acúleo, aperuísti credéntibus regna cælórum. 
Tu ad déxteram Dei sedes in glória Pátris.  
Iudex créderis esse ventúrus.""",
                    style: TextStyle(fontSize: fs.fontSize)),
                Text(
                  language == "pt" ? "\nO seguinte versículo diz-se de joelhos:\n" : "\nSequens versus dícitur flexis génibus:\n",
                  style: TextStyle(fontSize: fs.fontSize - 1, color: Colors.red, fontStyle: FontStyle.italic),
                ),
                Text(
                    language == "pt"
                        ? """
Por isso Vos rogamos: socorrei os vossos servos, que remistes com o vosso precioso Sangue. 
Permiti que sejamos do número dos vossos Santos na glória eterna. 
Salvai, Senhor, o vosso povo, e abençoai a vossa herança. 
Governai-os e exaltai-os eternamente. 
Todos os dias vos bendizemos. E louvamos sempre o vosso Nome, por todos os séculos dos séculos. 
Dignai-Vos, Senhor, preservar-nos neste dia de todo o pecado. 
Tende piedade de nós, Senhor; tende piedade de nós. 
Faça-se, Senhor, a vossa misericórdia sobre nós, conforme esperamos em Vós. 
Em Vós, Senhor, esperei; não serei confundido eternamente."""
                        : """
Te ergo quaésumus tuis fámulis súbveni, quos pretioso sánguine redemísti.
Ætérna fac cum Sanctis tuis in glória numerári.
Salvum fac pópulum tuum, Dómine, et bénedic hæreditáti tuæ.
Et rege eos, et extólle illos usque in ætérnum.
Per síngulos dies benedícimos te. Et laudámus nomem tuum in saéculum, et in saéculum saéculi.
Dignare, Dómine, die isto sine peccáto nos custodire.
Miseréri nostri, Dómine, miserére nostri.
Fiat misericórdia tua, Dómine, super nos, quæmadmodum sperávimus in te.
In te, Dómine, sperávi: non confúndar in ætérnum.""",
                    style: TextStyle(fontSize: fs.fontSize)),
                Text.rich(TextSpan(children: [
                  TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(text: language == "pt" ? "Bendito sois, Senhor, Deus de nossos pais!" : "Benedicámus Patrem, et Filium, cum Sancto Spíritu.", style: TextStyle(fontSize: fs.fontSize)),
                ])),
                Text.rich(TextSpan(children: [
                  TextSpan(text: "℟.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(text: language == "pt" ? "E digno de louvor e glorioso eternamente." : "Laudémus, et superexaltémus eum in sæcula.", style: TextStyle(fontSize: fs.fontSize)),
                ])),
                Text.rich(TextSpan(children: [
                  TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(text: language == "pt" ? "Bendigamos ao Pai, e o Filho, e o Espírito Santo." : "Benedíctus es, Dómine, in firmaménto cæli.", style: TextStyle(fontSize: fs.fontSize)),
                ])),
                Text.rich(TextSpan(children: [
                  TextSpan(text: "℟.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(text: language == "pt" ? "Louvemos e por todos os séculos O exaltemos." : "Et laudábilis, et gloriósus, et superexaltátus in sæcula.", style: TextStyle(fontSize: fs.fontSize)),
                ])),
                Text.rich(TextSpan(children: [
                  TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(text: language == "pt" ? "Bendito sois, Senhor, Deus, no firmamento do céu." : "Dómine, exáudi oratiónem meam.", style: TextStyle(fontSize: fs.fontSize)),
                ])),
                Text.rich(TextSpan(children: [
                  TextSpan(text: "℟.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(text: language == "pt" ? "Louvável, glorioso e soberanamente exaltado por todos os séculos." : "Et clamor meus ad te véniat.", style: TextStyle(fontSize: fs.fontSize)),
                ])),
                language == "pt"
                    ? Text.rich(TextSpan(children: [
                  TextSpan(text: "\n℣.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(text: "Ouvi, Senhor, a minha oração.", style: TextStyle(fontSize: fs.fontSize)),
                ]))
                    : Container(),
                language == "pt"
                    ? Text.rich(TextSpan(children: [
                  TextSpan(text: "℟.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(text: "E o meu clamor chegue até Vós.", style: TextStyle(fontSize: fs.fontSize)),
                ]))
                    : Container(),
                Text(language == "pt" ? "\nOremos" : "\nOrémus", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                Text(
                  language == "pt"
                      ? "\nÓ Deus, cuja misericórdia é sem limite e cuja bondade é um tesouro inesgotável, prostrados ante a vossa piíssima Majestade, nós Vos rendemos graças pelos benefícios que nos haveis feito, suplicando sempre a vossa clemência, para que não desampareis nunca aqueles a quem concedestes o que vos pediram, e os disponhais para receber os prêmios eternos. Por Nosso Senhor Jesus Cristo, Vosso Filho, na unidade do Espírito Santo."
                      : "\nDeus, cuius misericórdiæ non est númerus, et bonitátis infinítus est thesáurus; piíssimæ Maiestáti tuæ pro collátis donis grátias ágimus, tuam semper cleméntiam exorántes; ut, qui peténtibus postuláta concédis, eósdem non déserens, ad præmia futúra dispónas. Per Christum Dóminum nostrum.",
                  style: TextStyle(fontSize: fs.fontSize),
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(text: "\n℟.  ", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(text: language == "pt" ? "Amém." : "Amen.", style: TextStyle(fontSize: fs.fontSize)),
                ])),
                const Divider(height: 15, color: Colors.transparent),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

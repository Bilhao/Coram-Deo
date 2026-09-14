import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';

class TeDeumPage extends StatefulWidget {
  const TeDeumPage({super.key});

  @override
  State<TeDeumPage> createState() => _TeDeumPageState();
}

class _TeDeumPageState extends State<TeDeumPage> {
  String language = "pt";

  static const List<Map<String, String>> _part1Lines = [
    {
      "pt": "A Vós, ó Deus, louvamos; a Vós, Senhor, bendizemos.\nA Vós, ó eterno Pai, adora toda a terra.",
      "lt": "Te Deum laudámus: te Dóminum confitémur.\nTe æternum Patrem omnis terra venerátur.",
    },
    {
      "pt": "A Vós, todos os Anjos, os Céus e todas as Potestades.\nA Vós, os Querubins e Serafins proclamam com incessantes vozes:\nSanto, Santo, Santo, sois Vós, Senhor, Deus dos exércitos!\nCheios estão os céus e a terra da majestade da vossa glória.",
      "lt": "Tibi omnes Angeli, tibi cæli et univérsæ potestátes;\nTibi Chérubim et Séraphim incessábili voce proclámant:\nSanctus, Sanctus, Sanctus Dóminus Deus Sábaoth.\nPleni sunt cæli et terra maiestátis glóriæ tuæ.",
    },
    {
      "pt": "A Vós, o glorioso coro dos Apóstolos, a Vós, o louvável número dos Profetas, a Vós vos louva o brilhante exército dos Mártires.\nA Vós confessa a Santa Igreja por toda a redondeza da terra.\nPai de imensa majestade, ao vosso adorável Filho, verdadeiro e único e também ao Espírito Santo Consolador.",
      "lt": "Te gloriósus Apostolórum chorus, Te Prophetárum laudábilis númerus, Te Mártyrum candidátus laudat exércitus.\nTe per orbem terrárum sancta confitétur Ecclésia.\nPatrem imménsæ maiestátis;\nVenerándum tuum verum et únicum Fílium; Sanctum quoque Paráclitum Spíritum.",
    },
    {
      "pt": "Vós, ó Cristo, sois o Rei da glória. Vós sois o Filho eterno do Pai.\nVós, para libertar o homem cuja carne havíeis de tomar, não rejeitastes o seio da Virgem.\nVós, vencido o aguilhão da morte, abristes aos fiéis o Reino dos céus.\nVós estais sentado à mão direita de Deus, na glória do Pai.\nCremos que haveis de vir como Juiz.",
      "lt": "Tu, Rex glóriæ, Christe, Tu Patris sempiternus es Fílius.\nTu, ad liberándum susceptúrus hóminem, non horruíste Vírginis úterum.\nTu, devícto mortis acúleo, aperuísti credéntibus regna cælórum.\nTu ad déxteram Dei sedes in glória Pátris.\nIudex créderis esse ventúrus.",
    },
  ];

  static const List<Map<String, String>> _part2Lines = [
    {
      "pt": "Por isso Vos rogamos: socorrei os vossos servos, que remistes com o vosso precioso Sangue.\nPermiti que sejamos do número dos vossos Santos na glória eterna.",
      "lt": "Te ergo quaésumus tuis fámulis súbveni, quos pretioso sánguine redemísti.\nÆtérna fac cum Sanctis tuis in glória numerári.",
    },
    {
      "pt": "Salvai, Senhor, o vosso povo, e abençoai a vossa herança.\nGovernai-os e exaltai-os eternamente.\nTodos os dias vos bendizemos. E louvamos sempre o vosso Nome, por todos os séculos dos séculos.",
      "lt": "Salvum fac pópulum tuum, Dómine, et bénedic hæreditáti tuæ.\nEt rege eos, et extólle illos usque in ætérnum.\nPer síngulos dies benedícimos te. Et laudámus nomem tuum in saéculum, et in saéculum saéculi.",
    },
    {
      "pt": "Dignai-Vos, Senhor, preservar-nos neste dia de todo o pecado.\nTende piedade de nós, Senhor; tende piedade de nós.\nFaça-se, Senhor, a vossa misericórdia sobre nós, conforme esperamos em Vós.\nEm Vós, Senhor, esperei; não serei confundido eternamente.",
      "lt": "Dignare, Dómine, die isto sine peccáto nos custodire.\nMiseréri nostri, Dómine, miserére nostri.\nFiat misericórdia tua, Dómine, super nos, quæmadmodum sperávimus in te.\nIn te, Dómine, sperávi: non confúndar in ætérnum.",
    },
  ];

  void toggleLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  Widget _buildVersicle(String prefix, String text, double fontSize) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$prefix  ",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          TextSpan(text: text, style: TextStyle(fontSize: fontSize)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    final bool isBilingual = fs.bilingualMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Te Deum", maxLines: 2, style: TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            onPressed: fs.toggleBilingualMode,
            icon: Icon(isBilingual ? Icons.vertical_split : Icons.vertical_split_outlined),
            tooltip: isBilingual ? "Modo coluna única" : "Modo bilíngue lado a lado",
          ),
          if (!isBilingual)
            IconButton(
              onPressed: () => toggleLanguage(language == "pt" ? "lt" : "pt"),
              icon: Text(language == "pt" ? "LT" : "PT"),
              tooltip: language == "pt" ? "Mudar para Latim" : "Mudar para Português",
            ),
          IconButton(onPressed: fs.decreaseFontSize, icon: const Icon(Icons.remove)),
          IconButton(onPressed: fs.increaseFontSize, icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 15, color: Colors.transparent),
                if (isBilingual) ...[
                  const BilingualPrayerHeader(),
                  for (final st in _part1Lines)
                    BilingualPrayerRow(
                      latin: Text(st["lt"]!, style: TextStyle(fontSize: fs.fontSize)),
                      portuguese: Text(st["pt"]!, style: TextStyle(fontSize: fs.fontSize)),
                    ),
                  BilingualPrayerRow(
                    latin: Text(
                      "Sequens versus dícitur flexis génibus:",
                      style: TextStyle(fontSize: fs.fontSize - 1, color: Colors.red, fontStyle: FontStyle.italic),
                    ),
                    portuguese: Text(
                      "O seguinte versículo diz-se de joelhos:",
                      style: TextStyle(fontSize: fs.fontSize - 1, color: Colors.red, fontStyle: FontStyle.italic),
                    ),
                  ),
                  for (final st in _part2Lines)
                    BilingualPrayerRow(
                      latin: Text(st["lt"]!, style: TextStyle(fontSize: fs.fontSize)),
                      portuguese: Text(st["pt"]!, style: TextStyle(fontSize: fs.fontSize)),
                    ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℣.", "Benedicámus Patrem, et Filium, cum Sancto Spíritu.", fs.fontSize),
                    portuguese: _buildVersicle("℣.", "Bendigamos ao Pai, e o Filho, e o Espírito Santo.", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℟.", "Laudémus, et superexaltémus eum in sæcula.", fs.fontSize),
                    portuguese: _buildVersicle("℟.", "Louvemos e por todos os séculos O exaltemos.", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℣.", "Benedíctus es, Dómine, in firmaménto cæli.", fs.fontSize),
                    portuguese: _buildVersicle("℣.", "Bendito sois, Senhor, Deus de nossos pais no firmamento do céu.", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℟.", "Et laudábilis, et gloriósus, et superexaltátus in sæcula.", fs.fontSize),
                    portuguese: _buildVersicle("℟.", "E digno de louvor e glorioso eternamente.", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℣.", "Dómine, exáudi oratiónem meam.", fs.fontSize),
                    portuguese: _buildVersicle("℣.", "Ouvi, Senhor, a minha oração.", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℟.", "Et clamor meus ad te véniat.", fs.fontSize),
                    portuguese: _buildVersicle("℟.", "E o meu clamor chegue até Vós.", fs.fontSize),
                  ),
                  BilingualPrayerRow(
                    latin: Text("Orémus", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                    portuguese: Text("Oremos", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                  ),
                  BilingualPrayerRow(
                    latin: Text(
                      "Deus, cuius misericórdiæ non est númerus, et bonitátis infinítus est thesáurus; piíssimæ Maiestáti tuæ pro collátis donis grátias ágimus, tuam semper cleméntiam exorántes; ut, qui peténtibus postuláta concédis, eósdem non déserens, ad præmia futúra dispónas. Per Christum Dóminum nostrum.",
                      style: TextStyle(fontSize: fs.fontSize),
                    ),
                    portuguese: Text(
                      "Ó Deus, cuja misericórdia é sem limite e cuja bondade é um tesouro inesgotável, prostrados ante a vossa piíssima Majestade, nós Vos rendemos graças pelos benefícios que nos haveis feito, suplicando sempre a vossa clemência, para que não desampareis nunca aqueles a quem concedestes o que vos pediram, e os disponhais para receber os prêmios eternos. Por Nosso Senhor Jesus Cristo, Vosso Filho, na unidade do Espírito Santo.",
                      style: TextStyle(fontSize: fs.fontSize),
                    ),
                  ),
                  BilingualPrayerRow(
                    latin: _buildVersicle("℟.", "Amen.", fs.fontSize),
                    portuguese: _buildVersicle("℟.", "Amém.", fs.fontSize),
                  ),
                ] else ...[
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
                    style: TextStyle(fontSize: fs.fontSize),
                  ),
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
                    style: TextStyle(fontSize: fs.fontSize),
                  ),
                  const SizedBox(height: 10),
                  _buildVersicle("℣.", language == "pt" ? "Bendito sois, Senhor, Deus de nossos pais!" : "Benedicámus Patrem, et Filium, cum Sancto Spíritu.", fs.fontSize),
                  _buildVersicle("℟.", language == "pt" ? "E digno de louvor e glorioso eternamente." : "Laudémus, et superexaltémus eum in sæcula.", fs.fontSize),
                  const SizedBox(height: 10),
                  _buildVersicle("℣.", language == "pt" ? "Bendigamos ao Pai, e o Filho, e o Espírito Santo." : "Benedíctus es, Dómine, in firmaménto cæli.", fs.fontSize),
                  _buildVersicle("℟.", language == "pt" ? "Louvemos e por todos os séculos O exaltemos." : "Et laudábilis, et gloriósus, et superexaltátus in sæcula.", fs.fontSize),
                  const SizedBox(height: 10),
                  _buildVersicle("℣.", language == "pt" ? "Bendito sois, Senhor, Deus, no firmamento do céu." : "Dómine, exáudi oratiónem meam.", fs.fontSize),
                  _buildVersicle("℟.", language == "pt" ? "Louvável, glorioso e soberanamente exaltado por todos os séculos." : "Et clamor meus ad te véniat.", fs.fontSize),
                  if (language == "pt") ...[
                    const SizedBox(height: 10),
                    _buildVersicle("℣.", "Ouvi, Senhor, a minha oração.", fs.fontSize),
                    _buildVersicle("℟.", "E o meu clamor chegue até Vós.", fs.fontSize),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
                    child: Text(
                      language == "pt" ? "Oremos" : "Orémus",
                      style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    language == "pt"
                        ? "Ó Deus, cuja misericórdia é sem limite e cuja bondade é um tesouro inesgotável, prostrados ante a vossa piíssima Majestade, nós Vos rendemos graças pelos benefícios que nos haveis feito, suplicando sempre a vossa clemência, para que não desampareis nunca aqueles a quem concedestes o que vos pediram, e os disponhais para receber os prêmios eternos. Por Nosso Senhor Jesus Cristo, Vosso Filho, na unidade do Espírito Santo."
                        : "Deus, cuius misericórdiæ non est númerus, et bonitátis infinítus est thesáurus; piíssimæ Maiestáti tuæ pro collátis donis grátias ágimus, tuam semper cleméntiam exorántes; ut, qui peténtibus postuláta concédis, eósdem non déserens, ad præmia futúra dispónas. Per Christum Dóminum nostrum.",
                    style: TextStyle(fontSize: fs.fontSize),
                  ),
                  const SizedBox(height: 6),
                  _buildVersicle("℟.", language == "pt" ? "Amém." : "Amen.", fs.fontSize),
                ],
                const Divider(height: 15, color: Colors.transparent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SantoRosarioPage extends StatefulWidget {
  const SantoRosarioPage({super.key});

  @override
  State<SantoRosarioPage> createState() => _SantoRosarioPageState();
}

class _SantoRosarioPageState extends State<SantoRosarioPage> {
  double fontSize = 16.0;
  int weekday = DateTime.now().weekday;
  String? selectedMisterio;
  ExpansionTileController expansionTileController = ExpansionTileController();

  @override
  void initState() {
    super.initState();
    selectedMisterio = getMisterio(weekday);
  }

  void decreaseFontSize() {
    setState(() {
      fontSize--;
    });
  }

  void increaseFontSize() {
    setState(() {
      fontSize++;
    });
  }

  String? getMisterio(int weekday) {
    Map<int, String> misterio = {
      1: 'Mistérios Gozosos',
      2: 'Mistérios Dolorosos',
      3: 'Mistérios Gloriosos',
      4: 'Mistérios Luminosos',
      5: 'Mistérios Dolorosos',
      6: 'Mistérios Gozosos',
      7: 'Mistérios Gloriosos',
    };
    return misterio[weekday];
  }

  Widget _prayline(String prefix, String text) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$prefix  ",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          TextSpan(
            text: text,
            style: TextStyle(fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Santo Rosário"),
        actions: [
          IconButton(
            onPressed: decreaseFontSize,
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: increaseFontSize,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 15, color: Colors.transparent),
                  ExpansionTile(
                    title: Text("Visita ao Santíssimo"),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    collapsedBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    children: [
                      for (int i = 0; i < 3; i++) ...[
                        _prayline("℣.", "Graças e louvores sejam dadas a todo o momento,"),
                        _prayline("℟.", "ao Santíssimo e diviníssimo Sacramento."),
                        Text("\nPai nosso, Ave Maria e Glória\n", style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
                      ],
                      _prayline("℣.", "Graças e louvores sejam dadas a todo o momento,"),
                      _prayline("℟.", "ao Santíssimo e diviníssimo Sacramento."),
                      Text("\nComunhão espiritual", style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.bold)),
                      Text(
                        "\nEu quisera, Senhor, receber-Vos com aquela pureza, humildade e devoção com que Vos recebeu a Vossa Santíssima Mãe, com o espírito e o fervor dos Santos.",
                        style: TextStyle(fontSize: fontSize),
                      )
                    ],
                  ),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Pelo Sinal da Santa Cruz, livre-nos Deus Nosso Senhor, dos nossos inimigos. Em nome do Pai e do Filho e do Espírito Santo. Ámen."),
                  const Divider(height: 15, color: Colors.transparent),
                  ExpansionTile(
                    title: Text(selectedMisterio!),
                    controller: expansionTileController,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    collapsedBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    children: [
                      ListTile(
                        title: Text("Mistérios Gozosos"),
                        subtitle: Text("Segunda-feira e Sábado"),
                        selected: selectedMisterio == "Mistérios Gozosos",
                        onLongPress: () {},
                        onTap: () {
                          setState(() {
                            selectedMisterio = "Mistérios Gozosos";
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Mistérios Dolorosos"),
                        subtitle: Text("Terça-feira e Sexta-feira"),
                        selected: selectedMisterio == "Mistérios Dolorosos",
                        onLongPress: () {},
                        onTap: () {
                          setState(() {
                            selectedMisterio = "Mistérios Dolorosos";
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Mistérios Gloriosos"),
                        subtitle: Text("Quarta-feira e Domingo"),
                        selected: selectedMisterio == "Mistérios Gloriosos",
                        onLongPress: () {},
                        onTap: () {
                          setState(() {
                            selectedMisterio = "Mistérios Gloriosos";
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Mistérios Luminosos"),
                        subtitle: Text("Quinta-feira"),
                        selected: selectedMisterio == "Mistérios Luminosos",
                        onLongPress: () {},
                        onTap: () {
                          setState(() {
                            selectedMisterio = "Mistérios Luminosos";
                          });
                        },
                      ),
                    ]
                  ),
                  const Divider(height: 15, color: Colors.transparent),
                  ...() {
                    switch (selectedMisterio) {
                      case "Mistérios Gozosos":
                        return [
                          Text("1°. A Anunciação do Anjo à Virgem Nossa Senhora.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("2°. A Visita de Nossa Senhora à Sua prima Santa Isabel.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("3°. O Nascimento do Filho de Deus em Belém.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("4°. A Apresentação de Jesus no Templo.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("5°. O Menino Deus perdido e achado no Templo.", style: TextStyle(fontSize: fontSize - 2)),
                        ];
                      case "Mistérios Dolorosos":
                        return [
                          Text("1°. A Oração de Jesus no Horto.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("2°. A Flagelação.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("3°. A Coroação de Espinhos.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("4°. Jesus com a Cruz às costas.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("5°. Jesus morre na Cruz.", style: TextStyle(fontSize: fontSize - 2)),
                        ];
                      case "Mistérios Gloriosos":
                        return [
                          Text("1°. A Ressurreição do Senhor.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("2°. A Ascensão de Jesus ao Céu.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("3°. A Vinda do Espírito Santo.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("4°. A Assunção de Nossa Senhora.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("5°. A Coroação de Maria Santíssima.", style: TextStyle(fontSize: fontSize - 2)),
                        ];
                      case "Mistérios Luminosos":
                        return [
                          Text("1º. O Batismo de Jesus no Jordão.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("2º. A Auto-revelação do Senhor nas bodas de Caná.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("3º. O Anúncio do Reino de Deus, convidando à conversão.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("4º. A Transfiguração do Senhor.", style: TextStyle(fontSize: fontSize - 2)),
                          Text("5º. A Instituição da Eucaristia.", style: TextStyle(fontSize: fontSize - 2)),
                        ];
                      default:
                        return [];
                    }
                  }(),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("Depois de cada mistério:", style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic, color: Colors.red)),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("Glória...", style: TextStyle(fontSize: fontSize)),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Ó Maria concebida sem pecado,"),
                  _prayline("℟.", "Rogai por nós, que recorremos a vós."),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Ó meu Jesus, perdoai-nos e livrai-nos do fogo do inferno,"),
                  _prayline("℟.", "Levai as almas todas para o céu e socorrei principalmente as que mais precisarem."),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("Ao terminar os cinco mistérios:", style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic, color: Colors.red)),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("Ave Maria, Filha de Deus Pai, cheia de graça, ...", style: TextStyle(fontSize: fontSize - 1)),
                  Text("Ave Maria, Mãe de Deus Filho, cheia de graça, ...", style: TextStyle(fontSize: fontSize - 1)),
                  Text("Ave Maria, Esposa de Deus Espírito Santo, cheia de graça, ...", style: TextStyle(fontSize: fontSize - 1)),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("Salve Rainha, Mãe de misericórdia, vida, doçura e esperança nossa, salve! A Vós bradamos os degredados filhos de Eva; a Vós suspiramos gemendo e chorando neste vale de lágrimas. Eia, pois, Advogada nossa, esses Vossos olhos misericordiosos a nós volvei. E depois deste desterro mostrai nos Jesus, bendito fruto do Vosso ventre. Ó clemente, ó piedosa, ó doce Virgem Maria. Rogai por nós, Santa Mãe de Deus, para que sejamos dignos das promessas de Cristo.", style: TextStyle(fontSize: fontSize)),
                  const Divider(height: 15, color: Colors.transparent),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Ladaínha de Nossa Senhora", style: TextStyle(fontSize: fontSize + 2, fontWeight: FontWeight.bold))
                  ),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Senhor, tende piedade de nós"),
                  _prayline("℟.", "Senhor, tende piedade de nós"),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Cristo, tende piedade de nós"),
                  _prayline("℟.", "Cristo, tende piedade de nós"),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Senhor, tende piedade de nós"),
                  _prayline("℟.", "Senhor, tende piedade de nós"),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Jesus Cristo, ouvi-nos"),
                  _prayline("℟.", "Jesus Cristo, ouvi-nos"),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Jesus Cristo, atendei-nos"),
                  _prayline("℟.", "Jesus Cristo, atendei-nos"),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Deus Pai do céu"),
                  _prayline("℟.", "Tende piedade de nós"),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Deus Filho Redentor do mundo"),
                  _prayline("℟.", "Tende piedade de nós"),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Deus Espírito Santo"),
                  _prayline("℟.", "Tende piedade de nós"),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Santíssima Trindade, que sois um só Deus"),
                  _prayline("℟.", "Tende piedade de nós"),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Santa Maria,"),
                  _prayline("℟.", "Rogai por nós"),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Santa Mãe de Deus,"),
                  _prayline("℣.", "Santa Virgem das virgens,"),
                  _prayline("℣.", "Mãe de Cristo,"),
                  _prayline("℣.", "Mãe da Igreja"),
                  _prayline("℣.", "Mãe da Misericórdia"),
                  _prayline("℣.", "Mãe da divina graça,"),
                  _prayline("℣.", "Mãe da Esperança"),
                  _prayline("℣.", "Mãe puríssima,"),
                  _prayline("℣.", "Mãe castíssima,"),
                  _prayline("℣.", "Mãe sempre virgem,"),
                  _prayline("℣.", "Mãe imaculada,"),
                  _prayline("℣.", "Mãe amável,"),
                  _prayline("℣.", "Mãe admirável,"),
                  _prayline("℣.", "Mãe do bom conselho,"),
                  _prayline("℣.", "Mãe do Criador,"),
                  _prayline("℣.", "Mãe do Salvador,"),
                  _prayline("℣.", "Virgem prudentíssima,"),
                  _prayline("℣.", "Virgem venerável,"),
                  _prayline("℣.", "Virgem louvável,"),
                  _prayline("℣.", "Virgem poderosa,"),
                  _prayline("℣.", "Virgem clemente,"),
                  _prayline("℣.", "Virgem fiel,"),
                  _prayline("℣.", "Espelho de justiça,"),
                  _prayline("℣.", "Sede da Sabedoria,"),
                  _prayline("℣.", "Causa da nossa alegria,"),
                  _prayline("℣.", "Vaso espiritual,"),
                  _prayline("℣.", "Vaso honorífico"),
                  _prayline("℣.", "Vaso insigne de devoção,"),
                  _prayline("℣.", "Rosa mística,"),
                  _prayline("℣.", "Torre de David,"),
                  _prayline("℣.", "Torre de marfim,"),
                  _prayline("℣.", "Casa de ouro,"),
                  _prayline("℣.", "Arca da aliança,"),
                  _prayline("℣.", "Porta do céu,"),
                  _prayline("℣.", "Estrela da manhã,"),
                  _prayline("℣.", "Saúde dos enfermos,"),
                  _prayline("℣.", "Refúgio dos pecadores,"),
                  _prayline("℣.", "Conforto dos Migrantes"),
                  _prayline("℣.", "Consoladora dos aflitos,"),
                  _prayline("℣.", "Auxílio dos cristãos,"),
                  _prayline("℣.", "Rainha dos Anjos,"),
                  _prayline("℣.", "Rainha dos Patriarcas,"),
                  _prayline("℣.", "Rainha dos Profetas,"),
                  _prayline("℣.", "Rainha dos Apóstolos,"),
                  _prayline("℣.", "Rainha dos Mártires,"),
                  _prayline("℣.", "Rainha dos confessores,"),
                  _prayline("℣.", "Rainha das Virgens,"),
                  _prayline("℣.", "Rainha de todos os Santos,"),
                  _prayline("℣.", "Rainha concebida sem pecado original,"),
                  _prayline("℣.", "Rainha assunta ao céu,"),
                  _prayline("℣.", "Rainha do santíssimo Rosário,"),
                  _prayline("℣.", "Rainha da família,"),
                  _prayline("℣.", "Rainha da paz."),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Cordeiro de Deus, que tirais o pecado do mundo."),
                  _prayline("℟.", "Perdoai-nos, Senhor."),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Cordeiro de Deus, que tirais o pecado do mundo."),
                  _prayline("℟.", "Ouvi-nos, Senhor."),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Cordeiro de Deus, que tirais o pecado do mundo."),
                  _prayline("℟.", "Tende piedade de nós"),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("À vossa proteção nos acolhemos, Santa Mãe de Deus, não desprezeis as nossas súplicas nas necessidades: mas livrai-nos sempre de todos os perigos, ó Virgem gloriosa e bendita.", style: TextStyle(fontSize: fontSize)),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Rogai por nós, Santa Mãe de Deus,"),
                  _prayline("℟.", "Para que sejamos dignos das promessas de Cristo."),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("Oremos", style: TextStyle(fontSize: fontSize + 2, fontWeight: FontWeight.bold)),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("Concedei, Senhor, aos vossos servos a perfeita saúde da alma e do corpo e, por intercessão da Virgem Santa Maria, livrai-nos das tristezas do tempo presente e dai-nos as alegrias eternas. Por Nosso Senhor Jesus Cristo, Vosso Filho, que é Deus convosco na unidade do Espírito Santo", style: TextStyle(fontSize: fontSize)),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℟.", "Amen."),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("— Pelas necessidades da Igreja e do Estado: ", style: TextStyle(fontSize: fontSize)),
                  Text("Pai Nosso, Avé Maria, Glória.", style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("— Pela pessoa e intenções do Sr. Bispo desta diocese: ", style: TextStyle(fontSize: fontSize)),
                  Text("Pai Nosso, Avé Maria, Glória.", style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
                  const Divider(height: 15, color: Colors.transparent),
                  Text("— Pelas benditas almas do Purgatório: ", style: TextStyle(fontSize: fontSize)),
                  Text("Pai Nosso, Avé Maria", style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.italic)),
                  const Divider(height: 15, color: Colors.transparent),
                  _prayline("℣.", "Descansem em paz."),
                  _prayline("℟.", "Amen.")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

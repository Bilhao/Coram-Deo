import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';

class CredoAtanPage extends StatefulWidget {
  const CredoAtanPage({super.key});

  @override
  State<CredoAtanPage> createState() => _CredoAtanPageState();
}

class _CredoAtanPageState extends State<CredoAtanPage> {
  String language = "pt";

  static const List<Map<String, String>> _paragraphs = [
    {
      "pt": "Quem quiser salvar-se deve antes de tudo professar a fé católica.",
      "lt": "Quicumque vult salvus esse, ante omnia opus est, ut teneat catholicam fidem:",
    },
    {
      "pt": "Porque aquele que não a professar, integral e inviolavelmente, perecerá sem dúvida por toda a eternidade.",
      "lt": "Quam nisi quisque integram inviolatamque servaverit, absque dubio in aeternum peribit.",
    },
    {
      "pt": "Ora, isto é a fé católica: nós cultuamos um só Deus na Trindade, e a Trindade na unidade.",
      "lt": "Fides autem catholica haec est: ut unum Deum in Trinitate, et Trinitatem in unitate veneremur.",
    },
    {
      "pt": "Sem confundir as Pessoas nem dividir a substância. Porque uma só é a Pessoa do Pai, outra a do Filho, outra a do Espírito Santo:",
      "lt": "Neque confundentes personas, neque substantiam separantes. Alia est enim persona Patris alia Filii, alia Spiritus Sancti:",
    },
    {
      "pt": "Mas uma é a divindade do Pai, do Filho, e do Espírito Santo; a Sua glória é igual; a Sua majestade co-eterna.",
      "lt": "Sed Patris, et Filii, et Spiritus Sancti una est divinitas, aequalis gloria, coaeterna maiestas.",
    },
    {
      "pt": "Tal como é o Pai, tal é o Filho, tal é o Espírito Santo. O Pai é não-criado, o Filho é não-criado, o Espírito Santo é não-criado.",
      "lt": "Qualis Pater, talis Filius, talis Spiritus Sanctus. Increatus Pater, increatus Filius, increatus Spiritus Sanctus.",
    },
    {
      "pt": "O Pai é ilimitado, o Filho é ilimitado, o Espírito Santo é ilimitado. O Pai é eterno, o Filho é eterno, o Espírito Santo é eterno.",
      "lt": "Immensus Pater, immensus Filius, immensus Spiritus Sanctus. Aeternus Pater, aeternus Filius, aeternus Spiritus Sanctus.",
    },
    {
      "pt": "E contudo não são três eternos, mas um só eterno. Assim como não são três não-criados, nem três ilimitados, mas um só não-criado e um só ilimitado.",
      "lt": "Et tamen non tres aeterni, sed unus aeternus. Sicut non tres increati, nec tres immensi, sed unus increatus, et unus immensus.",
    },
    {
      "pt": "Da mesma forma, o Pai é omnipotente, o Filho é omnipotente, o Espírito Santo é omnipotente. E contudo não são três omnipotentes, mas um só omnipotente.",
      "lt": "Similiter omnipotens Pater, omnipotens Filius, omnipotens Spiritus Sanctus. Et tamen non tres omnipotentes, sed unus omnipotens.",
    },
    {
      "pt": "Assim o Pai é Deus, o Filho é Deus, o Espírito Santo é Deus. E contudo não são três deuses, mas um só Deus.",
      "lt": "Ita Deus Pater, Deus Filius, Deus Spiritus Sanctus. Et tamen non tres dii, sed unus est Deus.",
    },
    {
      "pt": "Do mesmo modo, o Pai é Senhor, o Filho é Senhor, o Espírito Santo é Senhor. E contudo não são três Senhores, mas um só Senhor.",
      "lt": "Ita Dominus Pater, Dominus Filius, Dominus Spiritus Sanctus. Et tamen non tres Domini, sed unus est Dominus.",
    },
    {
      "pt": "Porque, assim como nos obriga a verdade cristã a confessar que cada uma das Pessoas é Deus e Senhor, do mesmo modo a religião católica nos proíbe dizer que há três Deuses ou Senhores.",
      "lt": "Quia, sicut singillatim unamquamque personam Deum ac Dominum confiteri christiana veritate compellimur: ita tres Deos aut Dominos dicere catholica religione prohibemur.",
    },
    {
      "pt": "O Pai não foi feito, nem criado, nem gerado por alguém. O Filho procede do Pai somente: não é feito, nem criado, mas gerado. O Espírito Santo procede do Pai e do Filho: não é feito, nem criado, nem gerado.",
      "lt": "Pater a nullo est factus: nec creatus, nec genitus. Filius a Patre solo est: non factus, nec creatus, sed genitus. Spiritus Sanctus a Patre et Filio: non factus, nec creatus, nec genitus, sed procedens.",
    },
    {
      "pt": "Não há, pois, senão um só Pai, e não três Pais; um só Filho, e não três Filhos; um só Espírito Santo, e não três Espíritos Santos. E nesta Trindade, nada é primeiro ou último, nada maior ou menor, mas são as três pessoas coeternas e coiguais umas com as outras.",
      "lt": "Unus ergo Pater, non tres Patres: unus Filius, non tres Filii: unus Spiritus Sanctus, non tres Spiritus Sancti. Et in hac Trinitate nihil prius aut posterius, nihil maius aut minus: sed totae tres personae coaeternae sibi sunt et coaequales.",
    },
    {
      "pt": "De forma que, como foi dito acima, em tudo deve ser cultuada tanto a Unidade na Trindade quanto a Trindade na Unidade. Quem, pois, quiser salvar-se, deve pensar assim a respeito da Trindade.",
      "lt": "Ita, ut per omnia, sicut iam supra dictum est, et unitas in Trinitate, et Trinitas in unitate veneranda sit. Qui vult ergo salvus esse, ita de Trinitate sentiat.",
    },
    {
      "pt": "Mas é necessário para a salvação eterna crer fielmente também na Encarnação de Nosso Senhor Jesus Cristo. Porque a fé imaculada é que creiamos e confessemos que Nosso Senhor Jesus Cristo, o Filho de Deus, é Deus e homem.",
      "lt": "Sed necessarium est ad aeternam salutem, ut incarnationem quoque Domini nostri Iesu Christi fideliter credat. Est ergo fides recta ut credamus et confiteamur, quia Dominus noster Iesus Christus, Dei Filius, Deus [pariter] et homo est.",
    },
    {
      "pt": "É Deus, gerado na substância do Pai desde toda a eternidade; é homem porque nasceu, no tempo, da substância da Sua Mãe. Deus perfeito e homem perfeito, com alma racional e carne humana.",
      "lt": "Deus [est] ex substantia Patris ante saecula genitus: et homo est ex substantia matris in saeculo natus. Perfectus Deus, perfectus homo: ex anima rationali et humana carne subsistens.",
    },
    {
      "pt": "Igual ao Pai segundo a divindade; menor que o Pai segundo a humanidade. Embora seja Deus e homem, no entanto não são dois, mas um só Cristo.",
      "lt": "Aequalis Patri secundum divinitatem: minor Patre secundum humanitatem. Qui licet Deus sit et homo, non duo tamen, sed unus est Christus.",
    },
    {
      "pt": "É um, não porque a divindade se tenha convertido em humanidade, mas porque Deus assumiu a humanidade. Um, não por confusão de substâncias, mas pela unidade da Pessoa.",
      "lt": "Unus autem non conversione divinitatis in carnem, sed assumptione humanitatis in Deum. Unus omnino, non confusione substantiae, sed unitate personae.",
    },
    {
      "pt": "Porque, assim como a alma racional e o corpo formam um só homem, assim também a divindade e a humanidade formam um só Cristo. Que sofreu por nossa salvação, desceu aos infernos e ao terceiro dia ressuscitou dos mortos.",
      "lt": "Nam sicut anima rationalis et caro unus est homo: ita Deus et homo unus est Christus. Qui passus est pro salute nostra: descendit ad inferos: tertia die resurrexit a mortuis.",
    },
    {
      "pt": "Ascendeu aos Céus e está sentado à mão direita de Deus Pai todo-poderoso, de onde há de vir a julgar os vivos e os mortos. E quando vier, todos os homens ressuscitarão com os seus corpos, para prestar conta dos seus próprios atos.",
      "lt": "Ascendit ad caelos, sedet ad dexteram Dei Patris omnipotentis: inde venturus est iudicare vivos et mortuos. Ad cuius adventum omnes homines resurgere habent cum corporibus suis: et reddituri sunt de factis propriis rationem.",
    },
    {
      "pt": "E os que tiverem praticado o bem irão para a vida eterna, e os maus para o fogo eterno. Esta é a fé católica, e a não ser que cada um a professe fiel e firmemente, não poderá ser salvo.",
      "lt": "Et qui bona egerunt, ibunt in vitam aeternam: qui vero mala, in ignem aeternum. Haec est fides catholica, quam nisi quisque fideliter firmiterque crediderit, salvus esse non poterit.",
    },
  ];

  void toggleLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    final bool isBilingual = fs.bilingualMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Credo Atanasiano", maxLines: 2, style: TextStyle(fontSize: 20)),
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
                if (isBilingual) ...[
                  const BilingualPrayerHeader(),
                  for (final p in _paragraphs)
                    BilingualPrayerRow(
                      latin: Text(p["lt"]!, style: TextStyle(fontSize: fs.fontSize)),
                      portuguese: Text(p["pt"]!, style: TextStyle(fontSize: fs.fontSize)),
                    ),
                  BilingualPrayerRow(
                    latin: Center(
                      child: Text("Amen.", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold)),
                    ),
                    portuguese: Center(
                      child: Text("Amém.", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ] else ...[
                  for (final p in _paragraphs)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        language == "pt" ? p["pt"]! : p["lt"]!,
                        style: TextStyle(fontSize: fs.fontSize),
                      ),
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      language == "pt" ? "Amém." : "Amen.",
                      style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

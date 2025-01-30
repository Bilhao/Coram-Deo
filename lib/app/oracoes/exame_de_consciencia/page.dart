import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';

class ExameDeConscienciaOracaoPage extends StatefulWidget {
  const ExameDeConscienciaOracaoPage({super.key});

  @override
  State<ExameDeConscienciaOracaoPage> createState() => _ExameDeConscienciaOracaoPageState();
}

class _ExameDeConscienciaOracaoPageState extends State<ExameDeConscienciaOracaoPage> {
  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exame de Consciência"),
        actions: [
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
                Text("Ato de presença de Deus:", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                Text("Meu Deus, dai-me luz para conhecer os pecados que hoje cometi, as causas deles e os meios de os evitar.", style: TextStyle(fontSize: fs.fontSize)),
                const Divider(height: 15, color: Colors.transparent),
                ExpansionTile(
                  title: Text("Exame Diário", style: TextStyle(fontSize: 17.0)),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  childrenPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  collapsedBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  children: [
                    Text("Deveres para com Deus:\n", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                    Text("Lembrei-me de Deus durante o dia oferecendo-Lhe o meu trabalho, dando-Lhe graças, recorrendo a Ele com confiança de filho?\nDeixei-me vencer pelos respeitos humanos em algum momento?\nFiz as minhas orações pausadamente com atenção e devoção?", style: TextStyle(fontSize: fs.fontSize)),
                    Text("\nDeveres para com o próximo:\n", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                    Text("Tratei com dureza ou desprezo os demais?\nTive a preocupação de ajudar os que me rodeiam, fazendo-lhes, além disso, a vida mais agradável?\nPreocupa-me também a sua vida religiosa?\nFiz algum apostolado?\nCaí na murmuração?\nSei perdoar?\nRezei pelas pessoas que de algum modo me preocupam?", style: TextStyle(fontSize: fs.fontSize)),
                    Text("\nDeveres para comigo mesmo:\n", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                    Text("Lutei pela minha própria santificação?\nDeixei-me levar por sentimentos de orgulho, vaidade, sensualidade?\nEsforcei-me por arrancar o meu defeito dominante?\nRecorri a Deus para que aumente em mim todas as virtudes e, especialmente, a fé, a esperança e a caridade?", style: TextStyle(fontSize: fs.fontSize)),
                    const Divider(height: 15, color: Colors.transparent),
                  ],
                ),
                const Divider(height: 15, color: Colors.transparent),
                ExpansionTile(
                  title: Text("Exame para Confissão", style: TextStyle(fontSize: 17.0)),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  childrenPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  collapsedBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  children: [
                    Text(
                        """
Neguei ou abandonei a minha fé?\nTenho a preocupação de conhecê-la melhor?\nRecusei-me a defender a minha fé ou fiquei envergonhado dela?\nExiste algum aspecto da minha fé que eu ainda não aceito?\n
Disse o nome de Deus em vão?\nPratiquei o espiritismo ou coloquei a minha confiança em adivinhos ou horóscopos?\nManifestei falta de respeito pelas pessoas, lugares ou coisas santas?\n
Faltei voluntariamente à Missa nos domingos ou dias de preceito?\n
Recebi a Sagrada Comunhão tendo algum pecado grave não confessado?\nRecebi a Comunhão sem agradecimento ou sem a devida reverência?\n
Fui impaciente, fiquei irritado ou fui invejoso?\n
Guardei ressentimentos ou relutei em perdoar?\n
Fui violento nas palavras ou ações com outros?\n
Colaborei ou encorajei alguém a fazer um aborto ou a destruir embriões humanos, a praticar a eutanásia ou qualquer outro meio de acabar com a vida?\n
Tive ódio ou juízos críticos, em pensamentos ou ações?\nOlhei os outros com desprezo?\n
Falei mal dos outros, transformando o assunto em fofoca?\n
Abusei de bebidas alcoólicas?\nUsei drogas?\n
Fiquei vendo vídeos ou sites pornográficos?\nCometi atos impuros, sozinho ou com outras pessoas?\nEstou morando com alguém como se fosse casado, sem que o seja?\n
Se sou casado, procuro amar o meu cônjuge mais do que a qualquer outra pessoa?\nColoco meu casamento em primeiro lugar?\nE os meus filhos?\nTenho uma atitude aberta para novos filhos?\n
Trabalho de modo desordenado, ocupando tempo e energias que deveria dedicar à minha família e aos amigos?\n
Fui orgulhoso ou egoísta em meus pensamentos e ações?\nDeixei de ajudar os pobres e os necessitados?\nGastei dinheiro com o meu conforto e luxo pessoal, esquecendo as minhas responsabilidades para com os outros e para com a Igreja?\n
Disse mentiras?\nFui honesto e diligente no meu trabalho?\nRoubei ou enganei alguém no trabalho?\n
Cedi à preguiça?\nPreferi a comodidade ao invés do serviço aos demais?\n
Descuidei a minha responsabilidade de aproximar de Deus os outros, com o meu exemplo e a minha palavra?""",
                        style: TextStyle(fontSize: fs.fontSize)),
                    const Divider(height: 15, color: Colors.transparent),
                  ],
                ),
                Text("\nAto de contrição:", style: TextStyle(fontSize: fs.fontSize + 1, fontWeight: FontWeight.bold)),
                Text("Meu Deus, porque sois tão bom, tenho muita pena de vos ter ofendido. Ajudai-me a não tornar a pecar.", style: TextStyle(fontSize: fs.fontSize)),
                Align(alignment: Alignment.center, child: Text("\nAmém", style: TextStyle(fontSize: fs.fontSize, fontWeight: FontWeight.bold))),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

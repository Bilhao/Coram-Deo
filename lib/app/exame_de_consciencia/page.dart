import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/exame_de_consciencia/provider.dart';
import 'package:coramdeo/app/app_provider.dart';



class ExameDeConscienciaPage extends StatefulWidget {
  const ExameDeConscienciaPage({super.key});

  @override
  State<ExameDeConscienciaPage> createState() => _ExameDeConscienciaPageState();
}

class _ExameDeConscienciaPageState extends State<ExameDeConscienciaPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => ExameDeConscienciaProvider(),
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Builder(
          builder: (context) {
            final TabController tabController = DefaultTabController.of(context);
            tabController.addListener(() {
              setState(() {
                _selectedIndex = tabController.index;
              });
            });
            return Scaffold(
              appBar: AppBar(
                title: const Text("Exame de Consciência"),
                actions: _selectedIndex == 0 ? [] : [
                  IconButton(onPressed: fs.decreaseFontSize, icon: const Icon(Icons.remove)),
                  IconButton(onPressed: fs.increaseFontSize, icon: const Icon(Icons.add)),
                ],
              ),
              bottomNavigationBar: SafeArea(
                child: TabBar(
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: "Itens do Exame", icon: Icon(Icons.format_list_bulleted)),
                    Tab(text: "Exame de Consciência", icon: Icon(Icons.text_snippet)),
                  ],
                )
              ),
              body: TabBarView(
                children: [
                  ItensExame(),
                  TextoParaExame(),
                ]
              ),
            );
          }
        ),
      ),
    );
  }
}

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key, required this.provider});

  final ExameDeConscienciaProvider provider;

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? titleErrorText;
  String? descriptionErrorText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Adicionar item", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(width: double.maxFinite),
          TextFormField(
            controller: titleController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              filled: true,
              labelText: "Título",
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(8))),
              errorStyle: const TextStyle(fontSize: 13, color: Colors.red),
              errorText: titleErrorText,
            ),
            onTap: () {
              setState(() {
                titleErrorText = null;
              });
            },
          ),
          const Divider(height: 15, color: Colors.transparent),
          TextFormField(
            controller: descriptionController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              filled: true,
              labelText: "Descrição",
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(8))),
              errorStyle: const TextStyle(fontSize: 13, color: Colors.red),
              errorText: descriptionErrorText,
            ),
            maxLines: null,
            onTap: () {
              setState(() {
                descriptionErrorText = null;
              });
            },
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
            onPressed: () {
              titleController.clear();
              descriptionController.clear();
              Navigator.pop(context);
            },
            child: const Text("Cancelar")
        ),
        TextButton(
            onPressed: () {
              if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
                setState(() {
                  if (titleController.text.isEmpty) {
                    titleErrorText = "* Campo obrigatório";
                  }
                  if (descriptionController.text.isEmpty) {
                    descriptionErrorText = "* Campo obrigatório";
                  }
                });
              }
              else {
                if (widget.provider.itensExame.containsKey(titleController.text)) {
                  setState(() {
                    titleErrorText = "* Título já usado";
                  });
                }
                else {
                  widget.provider.addItem(titleController.text, descriptionController.text);
                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                }
              }
            },
            child: const Text("Adicionar")
        ),
      ],
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key, required this.provider});

  final ExameDeConscienciaProvider provider;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Tem certeza que deseja excluir todos os itens?", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Não")
        ),
        TextButton(
            onPressed: () {
              provider.clearItems();
              Navigator.pop(context);
            },
            child: const Text("Sim")
        ),
      ],
    );
  }
}

class EditItemDialog extends StatefulWidget {
  const EditItemDialog({super.key, required this.provider, required this.title, required this.description});

  final ExameDeConscienciaProvider provider;
  final String title;
  final String description;

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? titleErrorText;
  String? descriptionErrorText;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Editar item", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(width: double.maxFinite),
          TextFormField(
            controller: titleController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              filled: true,
              labelText: "Título",
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(8))),
              errorStyle: const TextStyle(fontSize: 13, color: Colors.red),
              errorText: titleErrorText,
            ),
            onTap: () {
              setState(() {
                titleErrorText = null;
              });
            },
          ),
          const Divider(height: 15, color: Colors.transparent),
          TextFormField(
            controller: descriptionController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              filled: true,
              labelText: "Descrição",
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(8))),
              errorStyle: const TextStyle(fontSize: 13, color: Colors.red),
              errorText: descriptionErrorText,
            ),
            maxLines: null,
            onTap: () {
              setState(() {
                descriptionErrorText = null;
              });
            },
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            titleController.clear();
            descriptionController.clear();
            Navigator.pop(context);
          },
          child: const Text("Cancelar")
        ),
        TextButton(
          onPressed: () {
            if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
              setState(() {
                if (titleController.text.isEmpty) {
                  titleErrorText = "* Campo obrigatório";
                }
                if (descriptionController.text.isEmpty) {
                  descriptionErrorText = "* Campo obrigatório";
                }
              });
            }
            else {
              if (widget.provider.itensExame.containsKey(titleController.text) && titleController.text != widget.title) {
                setState(() {
                  titleErrorText = "* Título já usado";
                });
              }
              else {
                widget.provider.removeItem(widget.title);
                widget.provider.addItem(titleController.text, descriptionController.text);
                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              }
            }
          },
          child: const Text("Salvar")
        ),
      ],
    );
  }
}



class ItensExame extends StatefulWidget {
  const ItensExame({super.key});

  @override
  State<ItensExame> createState() => _ItensExameState();
}

class _ItensExameState extends State<ItensExame> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ExameDeConscienciaProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.tonalIcon(
                  label: const Text("Limpar itens"),
                  icon: const Icon(Icons.clear_all),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    fixedSize: WidgetStateProperty.all(const Size(160, 40)),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => ConfirmDialog(provider: provider)
                    );
                  },
                ),
                FilledButton.tonalIcon(
                  label: const Text("Adicionar item"),
                  icon: const Icon(Icons.add),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    fixedSize: WidgetStateProperty.all(const Size(160, 40)),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AddItemDialog(provider: provider)
                    );
                  },
                ),
              ]
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.itensExame.entries.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(provider.itensExame.keys.toList()[index]),
                    subtitle: Text(provider.itensExame.values.toList()[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        provider.removeItem(provider.itensExame.keys.toList()[index]);
                      },
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => EditItemDialog(provider: provider, title: provider.itensExame.keys.toList()[index], description: provider.itensExame.values.toList()[index])
                      );
                    }
                  );
                },
              ),
            ),
          ]
        );
      }
    );
  }
}


class TextoParaExame extends StatefulWidget {
  const TextoParaExame({super.key});

  @override
  State<TextoParaExame> createState() => _TextoParaExameState();
}

class _TextoParaExameState extends State<TextoParaExame>  with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Divider(height: 15, color: Colors.transparent),
            Text("Ato de presença de Deus:", style: TextStyle(fontSize: appProvider.fontSize + 1, fontWeight: FontWeight.bold)),
            Text("Meu Deus, dai-me luz para conhecer os pecados que hoje cometi, as causas deles e os meios de os evitar.", style: TextStyle(fontSize: appProvider.fontSize)),
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
                Text("Deveres para com Deus:\n", style: TextStyle(fontSize: appProvider.fontSize + 1, fontWeight: FontWeight.bold)),
                Text("Lembrei-me de Deus durante o dia oferecendo-Lhe o meu trabalho, dando-Lhe graças, recorrendo a Ele com confiança de filho?\nDeixei-me vencer pelos respeitos humanos em algum momento?\nFiz as minhas orações pausadamente com atenção e devoção?", style: TextStyle(fontSize: appProvider.fontSize)),
                Text("\nDeveres para com o próximo:\n", style: TextStyle(fontSize: appProvider.fontSize + 1, fontWeight: FontWeight.bold)),
                Text("Tratei com dureza ou desprezo os demais?\nTive a preocupação de ajudar os que me rodeiam, fazendo-lhes, além disso, a vida mais agradável?\nPreocupa-me também a sua vida religiosa?\nFiz algum apostolado?\nCaí na murmuração?\nSei perdoar?\nRezei pelas pessoas que de algum modo me preocupam?", style: TextStyle(fontSize: appProvider.fontSize)),
                Text("\nDeveres para comigo mesmo:\n", style: TextStyle(fontSize: appProvider.fontSize + 1, fontWeight: FontWeight.bold)),
                Text("Lutei pela minha própria santificação?\nDeixei-me levar por sentimentos de orgulho, vaidade, sensualidade?\nEsforcei-me por arrancar o meu defeito dominante?\nRecorri a Deus para que aumente em mim todas as virtudes e, especialmente, a fé, a esperança e a caridade?", style: TextStyle(fontSize: appProvider.fontSize)),
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
                    style: TextStyle(fontSize: appProvider.fontSize)),
                const Divider(height: 15, color: Colors.transparent),
              ],
            ),
            Text("\nAto de contrição:", style: TextStyle(fontSize: appProvider.fontSize + 1, fontWeight: FontWeight.bold)),
            Text("Meu Deus, porque sois tão bom, tenho muita pena de vos ter ofendido. Ajudai-me a não tornar a pecar.", style: TextStyle(fontSize: appProvider.fontSize)),
            Align(alignment: Alignment.center, child: Text("\nAmém", style: TextStyle(fontSize: appProvider.fontSize, fontWeight: FontWeight.bold))),
          ]),
        ),
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/widgets/bilingual_row.dart';

class ResponsoPage extends StatefulWidget {
  const ResponsoPage({super.key});

  @override
  State<ResponsoPage> createState() => _ResponsoPageState();
}

class _ResponsoPageState extends State<ResponsoPage> {
  Widget _prayline(
    String prefix,
    String text,
    double fontSize, {
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 3.0),
  }) {
    return Padding(
      padding: padding,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "$prefix  ",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            TextSpan(
              text: text,
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bilingualPrayline(
    String prefix,
    String lt,
    String pt,
    double fontSize,
  ) {
    return BilingualPrayerRow(
      latin: _prayline(prefix, lt, fontSize, padding: EdgeInsets.zero),
      portuguese: _prayline(prefix, pt, fontSize, padding: EdgeInsets.zero),
    );
  }

  Widget _rubric(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize - 1,
          color: Colors.red,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  // --- Textos do Responso ---
  static const Map<String, String> _antiphona = {
    "lt":
        "Ego sum resurréctio et vita: qui credit in me, etiam si mórtuus fúerit, vivet; et omnis qui vivit et credit in me, non moriétur in ætérnum.",
    "pt":
        "Eu sou a ressurreição e a vida. Quem crê em Mim, ainda que esteja morto, viverá; e todo aquele que vive e crê em Mim, não morrerá eternamente.",
  };

  static const Map<String, String> _oratio = {
    "lt":
        "Absólve, quaésumus, Dómine, ánimam fámuli tui N. (fámulæ tuæ N. / ánimas famulórum famularúmque tuárum) ab omni vínculo delictórum: ut, in resurrectiónis glória, inter Sanctos et eléctos tuos resuscitátus (resuscitáta / resuscitáti) respíret. Per Christum Dóminum nostrum.",
    "pt":
        "Absolvei, Senhor, nós Vos pedimos, a alma do vosso servo N. (da vossa serva N. / as almas dos vossos servos e servas) de todos os laços do pecado, para que, na glória da ressurreição, descanse renovado(a/s) entre os vossos Santos e eleitos. Por Cristo, nosso Senhor.",
  };

  @override
  Widget build(BuildContext context) {
    AppProvider fs = Provider.of<AppProvider>(context);
    final bool isBilingual = fs.bilingualMode;
    final String language = fs.prayerLanguage;
    final double fSize = fs.fontSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Responso",
          maxLines: 2,
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: fs.toggleBilingualMode,
            icon: Icon(
              isBilingual
                  ? Icons.vertical_split
                  : Icons.vertical_split_outlined,
            ),
            tooltip: isBilingual
                ? "Modo coluna única"
                : "Modo bilíngue lado a lado",
          ),
          IconButton(
            onPressed: fs.decreaseFontSize,
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: fs.increaseFontSize,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SelectionArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20,
              left: 15,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 10, color: Colors.transparent),
                if (isBilingual) ...[
                  const BilingualPrayerHeader(),
                  ..._buildBilingualResponso(fs, fSize),
                ] else ...[
                  ..._buildSingleLanguageResponso(fs, language, fSize),
                ],
                const Divider(height: 25, color: Colors.transparent),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =================== MODO BILÍNGUE ===================
  List<Widget> _buildBilingualResponso(AppProvider fs, double fSize) {
    return [
      // Antífona
      _rubric("Antífona:", fSize),
      BilingualPrayerRow(
        latin: Text(_antiphona["lt"]!, style: TextStyle(fontSize: fSize)),
        portuguese: Text(_antiphona["pt"]!, style: TextStyle(fontSize: fSize)),
      ),

      const Divider(height: 15, color: Colors.transparent),

      // Invocações
      _rubric("Invocações:", fSize),
      _bilingualPrayline(
        "℣.",
        "Subveníte, Sancti Dei, occúrrite, Angeli Dómini.",
        "Santos de Deus, vinde em seu auxílio; Anjos do Senhor, vinde-lhe ao encontro.",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Suscipiéntes ánimam eius (ánimas eórum): Offeréntes eam (eas) in conspéctu Altíssimi.",
        "Acolhei a sua alma (as suas almas) e apresentai-a(s) na presença do Altíssimo.",
        fSize,
      ),
      _bilingualPrayline(
        "℣.",
        "Suscípiat te Christus, qui vocávit te: et in sinum Abrahæ Angeli dedúcant te.",
        "Receba-te Cristo, que te chamou, e os Anjos te conduzam ao seio de Abraão.",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Suscipiéntes ánimam eius (ánimas eórum): Offeréntes eam (eas) in conspéctu Altíssimi.",
        "Acolhei a sua alma (as suas almas) e apresentai-a(s) na presença do Altíssimo.",
        fSize,
      ),
      _bilingualPrayline(
        "℣.",
        "Réquiem ætérnam dona ei (eis), Dómine: et lux perpétua lúceat ei (eis).",
        "Dai-lhe(s), Senhor, o descanso eterno, e a luz perpétua o(s) ilumine.",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Offeréntes eam (eas) in conspéctu Altíssimi.",
        "Apresentai-a(s) na presença do Altíssimo.",
        fSize,
      ),

      const Divider(height: 15, color: Colors.transparent),

      // Preces e Kyrie
      _bilingualPrayline(
        "℣.",
        "Kýrie, eléison.",
        "Senhor, tende piedade de nós.",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Christe, eléison.",
        "Cristo, tende piedade de nós.",
        fSize,
      ),
      _bilingualPrayline(
        "℣.",
        "Kýrie, eléison.",
        "Senhor, tende piedade de nós.",
        fSize,
      ),

      const Divider(height: 15, color: Colors.transparent),

      _rubric("Pai Nosso (em silêncio até:)", fSize),
      _bilingualPrayline(
        "℣.",
        "Et ne nos indúcas in tentatiónem.",
        "E não nos deixeis cair em tentação.",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Sed líbera nos a malo.",
        "Mas livrai-nos do mal.",
        fSize,
      ),

      _bilingualPrayline(
        "℣.",
        "A porta ínferi.",
        "Das portas do inferno.",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Érue, Dómine, ánimam eius (ánimas eórum).",
        "Livrai, Senhor, a sua alma (as suas almas).",
        fSize,
      ),
      _bilingualPrayline(
        "℣.",
        "Requiéscat (requiéscant) in pace.",
        "Descanse (descansem) em paz.",
        fSize,
      ),
      _bilingualPrayline("℟.", "Amen.", "Amém.", fSize),

      _bilingualPrayline(
        "℣.",
        "Dómine, exáudi oratiónem meam.",
        "Senhor, ouvi a minha oração.",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Et clamor meus ad te véniat.",
        "E chegue a Vós o meu clamor.",
        fSize,
      ),
      _bilingualPrayline(
        "℣.",
        "Dóminus vobíscum.",
        "O Senhor esteja convosco.",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Et cum spíritu tuo.",
        "E com o vosso espírito.",
        fSize,
      ),

      const Divider(height: 15, color: Colors.transparent),

      // Oração
      _bilingualPrayline("℣.", "Orémus.", "Oremos.", fSize),
      BilingualPrayerRow(
        latin: Text(_oratio["lt"]!, style: TextStyle(fontSize: fSize)),
        portuguese: Text(_oratio["pt"]!, style: TextStyle(fontSize: fSize)),
      ),
      _bilingualPrayline("℟.", "Amen.", "Amém.", fSize),

      const Divider(height: 15, color: Colors.transparent),

      // Conclusão
      _rubric("Conclusão:", fSize),
      _bilingualPrayline(
        "℣.",
        "Réquiem ætérnam dona ei (eis), Dómine.",
        "Dai-lhe(s), Senhor, o descanso eterno.",
        fSize,
      ),
      _bilingualPrayline(
        "℟.",
        "Et lux perpétua lúceat ei (eis).",
        "E a luz perpétua o(s) ilumine.",
        fSize,
      ),
      _bilingualPrayline(
        "℣.",
        "Requiéscat (requiéscant) in pace.",
        "Descanse (descansem) em paz.",
        fSize,
      ),
      _bilingualPrayline("℟.", "Amen.", "Amém.", fSize),
      _bilingualPrayline(
        "℣.",
        "Anima eius (ánimæ eórum), et ánimæ ómnium fidélium defunctórum, per misericórdiam Dei requiéscant in pace.",
        "A sua alma (as suas almas) e as almas de todos os fiéis defuntos, pela misericórdia de Deus, descansem em paz.",
        fSize,
      ),
      _bilingualPrayline("℟.", "Amen.", "Amém.", fSize),

      const Divider(height: 15, color: Colors.transparent),

      // Repetição da antífona
      _rubric("Repete-se a antífona:", fSize),
      BilingualPrayerRow(
        latin: Text(_antiphona["lt"]!, style: TextStyle(fontSize: fSize)),
        portuguese: Text(_antiphona["pt"]!, style: TextStyle(fontSize: fSize)),
      ),
    ];
  }

  // =================== MODO COLUNA ÚNICA ===================
  List<Widget> _buildSingleLanguageResponso(
    AppProvider fs,
    String language,
    double fSize,
  ) {
    final bool isPt = language == "pt";

    return [
      // Antífona
      _rubric(isPt ? "Antífona:" : "Antíphona:", fSize),
      Text(
        isPt ? _antiphona["pt"]! : _antiphona["lt"]!,
        style: TextStyle(fontSize: fSize),
      ),

      const Divider(height: 15, color: Colors.transparent),

      // Invocações
      _rubric(isPt ? "Invocações:" : "Invocatiónes:", fSize),
      _prayline(
        "℣.",
        isPt
            ? "Santos de Deus, vinde em seu auxílio; Anjos do Senhor, vinde-lhe ao encontro."
            : "Subveníte, Sancti Dei, occúrrite, Angeli Dómini.",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt
            ? "Acolhei a sua alma (as suas almas) e apresentai-a(s) na presença do Altíssimo."
            : "Suscipiéntes ánimam eius (ánimas eórum): Offeréntes eam (eas) in conspéctu Altíssimi.",
        fSize,
      ),
      _prayline(
        "℣.",
        isPt
            ? "Receba-te Cristo, que te chamou, e os Anjos te conduzam ao seio de Abraão."
            : "Suscípiat te Christus, qui vocávit te: et in sinum Abrahæ Angeli dedúcant te.",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt
            ? "Acolhei a sua alma (as suas almas) e apresentai-a(s) na presença do Altíssimo."
            : "Suscipiéntes ánimam eius (ánimas eórum): Offeréntes eam (eas) in conspéctu Altíssimi.",
        fSize,
      ),
      _prayline(
        "℣.",
        isPt
            ? "Dai-lhe(s), Senhor, o descanso eterno, e a luz perpétua o(s) ilumine."
            : "Réquiem ætérnam dona ei (eis), Dómine: et lux perpétua lúceat ei (eis).",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt
            ? "Apresentai-a(s) na presença do Altíssimo."
            : "Offeréntes eam (eas) in conspéctu Altíssimi.",
        fSize,
      ),

      const Divider(height: 15, color: Colors.transparent),

      // Preces e Kyrie
      _prayline(
        "℣.",
        isPt ? "Senhor, tende piedade de nós." : "Kýrie, eléison.",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt ? "Cristo, tende piedade de nós." : "Christe, eléison.",
        fSize,
      ),
      _prayline(
        "℣.",
        isPt ? "Senhor, tende piedade de nós." : "Kýrie, eléison.",
        fSize,
      ),

      const Divider(height: 15, color: Colors.transparent),

      _rubric(
        isPt
            ? "Pai Nosso (em silêncio até:)"
            : "Pater noster (secreto usque ad:)",
        fSize,
      ),
      _prayline(
        "℣.",
        isPt
            ? "E não nos deixeis cair em tentação."
            : "Et ne nos indúcas in tentatiónem.",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt ? "Mas livrai-nos do mal." : "Sed líbera nos a malo.",
        fSize,
      ),

      _prayline(
        "℣.",
        isPt ? "Das portas do inferno." : "A porta ínferi.",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt
            ? "Livrai, Senhor, a sua alma (as suas almas)."
            : "Érue, Dómine, ánimam eius (ánimas eórum).",
        fSize,
      ),
      _prayline(
        "℣.",
        isPt
            ? "Descanse (descansem) em paz."
            : "Requiéscat (requiéscant) in pace.",
        fSize,
      ),
      _prayline("℟.", isPt ? "Amém." : "Amen.", fSize),

      _prayline(
        "℣.",
        isPt
            ? "Senhor, ouvi a minha oração."
            : "Dómine, exáudi oratiónem meam.",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt ? "E chegue a Vós o meu clamor." : "Et clamor meus ad te véniat.",
        fSize,
      ),
      _prayline(
        "℣.",
        isPt ? "O Senhor esteja convosco." : "Dóminus vobíscum.",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt ? "E com o vosso espírito." : "Et cum spíritu tuo.",
        fSize,
      ),

      const Divider(height: 15, color: Colors.transparent),

      // Oração
      _prayline("℣.", isPt ? "Oremos." : "Orémus.", fSize),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Text(
          isPt ? _oratio["pt"]! : _oratio["lt"]!,
          style: TextStyle(fontSize: fSize),
        ),
      ),
      _prayline("℟.", isPt ? "Amém." : "Amen.", fSize),

      const Divider(height: 15, color: Colors.transparent),

      // Conclusão
      _rubric(isPt ? "Conclusão:" : "Conclúsio:", fSize),
      _prayline(
        "℣.",
        isPt
            ? "Dai-lhe(s), Senhor, o descanso eterno."
            : "Réquiem ætérnam dona ei (eis), Dómine.",
        fSize,
      ),
      _prayline(
        "℟.",
        isPt
            ? "E a luz perpétua o(s) ilumine."
            : "Et lux perpétua lúceat ei (eis).",
        fSize,
      ),
      _prayline(
        "℣.",
        isPt
            ? "Descanse (descansem) em paz."
            : "Requiéscat (requiéscant) in pace.",
        fSize,
      ),
      _prayline("℟.", isPt ? "Amém." : "Amen.", fSize),
      _prayline(
        "℣.",
        isPt
            ? "A sua alma (as suas almas) e as almas de todos os fiéis defuntos, pela misericórdia de Deus, descansem em paz."
            : "Anima eius (ánimæ eórum), et ánimæ ómnium fidélium defunctórum, per misericórdiam Dei requiéscant in pace.",
        fSize,
      ),
      _prayline("℟.", isPt ? "Amém." : "Amen.", fSize),

      const Divider(height: 15, color: Colors.transparent),

      // Repetição da antífona
      _rubric(isPt ? "Repete-se a antífona:" : "Repetítur antíphona:", fSize),
      Text(
        isPt ? _antiphona["pt"]! : _antiphona["lt"]!,
        style: TextStyle(fontSize: fSize),
      ),
    ];
  }
}

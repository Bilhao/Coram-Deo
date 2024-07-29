import 'package:coramdeo/pages/oracoes/credo_page.dart';
import 'package:coramdeo/pages/oracoes/lembrai_vos_page.dart';
import 'package:flutter/material.dart';
import 'package:coramdeo/pages/bible/bible_page.dart';
import 'package:coramdeo/pages/bible/reading_page.dart';
import 'package:coramdeo/pages/home_page.dart';
import 'package:coramdeo/pages/liturgia_diaria_page.dart';
import 'package:coramdeo/pages/livros_page.dart';
import 'package:coramdeo/pages/oracoes/angelus_regina_caeli_page.dart';
import 'package:coramdeo/pages/oracoes/comentario_do_evangelho_page.dart';
import 'package:coramdeo/pages/oracoes/falar_com_deus_page.dart';
import 'package:coramdeo/pages/oracoes/oracoes_page.dart';
import 'package:coramdeo/pages/plano_de_vida_page.dart';
import 'package:coramdeo/pages/santo_do_dia_page.dart';
import 'package:coramdeo/pages/settings_page.dart';



class Routes {
  static Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder> {
    '/': (context) => const HomePage(),
    '/settings': (context) => const SettingsPage(),
    '/bible': (context) => const BiblePage(),
    '/reading': (context) => const ReadingPage(),
    '/livros': (context) => const LivrosPage(),
    '/oracoes': (context) => const OracoesPage(),
    '/santo-do-dia': (context) => const SantoDoDiaPage(),
    '/liturgia': (context) => const LiturgiaDiariaPage(),
    '/plano-de-vida': (context) => const PlanoDeVidaPage(),

    // orações
    '/falar-com-deus': (context) => const FalarComDeusPage(),
    '/angelus-regina-caeli': (context) => const AngelusReginaCaeliPage(),
    '/comentario-do-evangelho-do-dia': (context) => const ComentarioDoEvangelhoPage(),
    '/credo': (context) => const CredoPage(),
    '/lembrai-vos': (context) => const LembraiVosPage(),
    // '/oferecimento-de-obras': (context) => const OferecimentoDeObrasPage(),
    // 'preces': (context) => const PrecesPage(),
    // 'terco': (context) => const TercoPage(),
    // 'te-deum': (context) => const TeDeumPage(),
    // 'via-sacra': (context) => const ViaSacraPage(),
    // 'visita-ao-santissimo': (context) => const VisitaAoSantissimoPage(),
  };

  static String initial = '/';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
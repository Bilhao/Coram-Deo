import 'package:coramdeo/app/oracoes/adorote_devote/page.dart';
import 'package:coramdeo/app/oracoes/exame_de_consciencia/page.dart';
import 'package:coramdeo/app/oracoes/salmo_2/page.dart';
import 'package:flutter/material.dart';
import 'package:coramdeo/app/livros/4_amigos_de_deus/page.dart';
import 'package:coramdeo/app/livros/point_book_reading_page.dart';
import 'package:coramdeo/app/livros/1_caminho/page.dart';
import 'package:coramdeo/app/livros/5_e_cristo_que_passa/page.dart';
import 'package:coramdeo/app/livros/3_forja/page.dart';
import 'package:coramdeo/app/livros/6_santo_rosario/page.dart';
import 'package:coramdeo/app/livros/2_sulco/page.dart';
import 'package:coramdeo/app/livros/7_via_sacra/page.dart';
import 'package:coramdeo/app/oracoes/credo/page.dart';
import 'package:coramdeo/app/oracoes/lembrai_vos/page.dart';
import 'package:coramdeo/app/oracoes/oferecimento_de_obras/page.dart';
import 'package:coramdeo/app/oracoes/preces/page.dart';
import 'package:coramdeo/app/oracoes/santo_rosario/page.dart';
import 'package:coramdeo/app/biblia/page_1.dart';
import 'package:coramdeo/app/biblia/page_2.dart';
import 'package:coramdeo/app/home_page.dart';
import 'package:coramdeo/app/liturgia_diaria/page.dart';
import 'package:coramdeo/app/livros/livros_page.dart';
import 'package:coramdeo/app/oracoes/angelus_regina_caeli/page.dart';
import 'package:coramdeo/app/oracoes/comentario_evangelho/page.dart';
import 'package:coramdeo/app/oracoes/falar_com_deus/page.dart';
import 'package:coramdeo/app/oracoes/page.dart';
import 'package:coramdeo/app/oracoes/te_deum/page.dart';
import 'package:coramdeo/app/oracoes/visita_ao_santissimo/page.dart';
import 'package:coramdeo/app/oracoes/estampa_josemaria/page.dart';
import 'package:coramdeo/app/plano_de_vida/page.dart';
import 'package:coramdeo/app/santo_do_dia/page.dart';
import 'package:coramdeo/app/exame_de_consciencia/page.dart';
import 'package:coramdeo/app/settings_page.dart';


class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const HomePage());

      case "/settings":
        return MaterialPageRoute(builder: (context) => const SettingsPage());

      case "/biblia-page-1":
        return MaterialPageRoute(builder: (context) => const BibliaPage1());

      case "/biblia-page-2":
        return MaterialPageRoute(builder: (context) => const BibliaPage2());

      case "/livros":
        return MaterialPageRoute(builder: (context) => const LivrosPage());

      case "/oracoes":
        return MaterialPageRoute(builder: (context) => const OracoesPage());

      case "/santo-do-dia":
        return MaterialPageRoute(builder: (context) => const SantoDoDiaPage());

      case "/liturgia":
        return MaterialPageRoute(builder: (context) => const LiturgiaDiariaPage());

      case "/plano-de-vida":
        return MaterialPageRoute(builder: (context) => const PlanoDeVidaPage());

      case "/exame-de-consciencia":
        return MaterialPageRoute(builder: (context) => const ExameDeConscienciaPage());

      // oracoes
      case "/falar-com-deus":
        return MaterialPageRoute(builder: (context) => const FalarComDeusPage());

      case "/angelus-regina-caeli":
        return MaterialPageRoute(builder: (context) => const AngelusReginaCaeliPage());

      case "/comentario-do-evangelho-do-dia":
        return MaterialPageRoute(builder: (context) => const ComentarioDoEvangelhoPage());

      case "/credo":
        return MaterialPageRoute(builder: (context) => const CredoPage());

      case "/lembrai-vos":
        return MaterialPageRoute(builder: (context) => const LembraiVosPage());

      case "/oferecimento-de-obras":
        return MaterialPageRoute(builder: (context) => const OferecimentoDeObrasPage());

      case "/preces":
        return MaterialPageRoute(builder: (context) => const PrecesPage());

      case "/santo-rosario":
        return MaterialPageRoute(builder: (context) => const SantoRosarioPage());

      case "/te-deum":
        return MaterialPageRoute(builder: (context) => const TeDeumPage());

      case '/visita-ao-santissimo':
        return MaterialPageRoute(builder: (context) => const VisitaAoSantissimoPage());

      case '/adoro-te-devote':
        return MaterialPageRoute(builder: (context) => const AdoroTeDevotePage());

      case '/salmo-2':
        return MaterialPageRoute(builder: (context) => const Salmo2Page());

      case '/exame-de-consciencia-oracao':
        return MaterialPageRoute(builder: (context) => const ExameDeConscienciaOracaoPage());

      case '/estampa-josemaria':
        return MaterialPageRoute(builder: (context) => const EstampaJosemariaPage());

      // livros
      case "/book-reading":
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) => BookReadingPage(bookName: args['bookName']));

      case "/caminho":
        return MaterialPageRoute(builder: (context) => const CaminhoPage());

      case "/sulco":
        return MaterialPageRoute(builder: (context) => const SulcoPage());

      case "/forja":
        return MaterialPageRoute(builder: (context) => const ForjaPage());

      case "/amigos-de-deus":
        return MaterialPageRoute(builder: (context) => const AmigosDeDeusPage());

      case "/e-cristo-que-passa":
        return MaterialPageRoute(builder: (context) => const ECristoQuePassaPage());

      case "/santo-rosario-livro":
        return MaterialPageRoute(builder: (context) => const SantoRosarioLivroPage());

      case "/via-sacra-livro":
        return MaterialPageRoute(builder: (context) => const ViaSacraLivroPage());

      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }

  static String initial = '/';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

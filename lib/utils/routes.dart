import 'package:flutter/material.dart';

// Core app pages
import 'package:coramdeo/app/home_page.dart';
import 'package:coramdeo/app/settings_page.dart';

// Bible pages
import 'package:coramdeo/app/biblia/page_1.dart';
import 'package:coramdeo/app/biblia/page_2.dart';

// Books pages
import 'package:coramdeo/app/livros/livros_page.dart';
import 'package:coramdeo/app/livros/1_caminho/page_1.dart';
import 'package:coramdeo/app/livros/1_caminho/page_2.dart';
import 'package:coramdeo/app/livros/2_sulco/page_1.dart';
import 'package:coramdeo/app/livros/2_sulco/page_2.dart';
import 'package:coramdeo/app/livros/3_forja/page_1.dart';
import 'package:coramdeo/app/livros/3_forja/page_2.dart';
import 'package:coramdeo/app/livros/4_amigos_de_deus/page_1.dart';
import 'package:coramdeo/app/livros/4_amigos_de_deus/page_2.dart';
import 'package:coramdeo/app/livros/5_e_cristo_que_passa/page_1.dart';
import 'package:coramdeo/app/livros/5_e_cristo_que_passa/page_2.dart';
import 'package:coramdeo/app/livros/6_santo_rosario/page.dart';
import 'package:coramdeo/app/livros/7_via_sacra/page_1.dart';
import 'package:coramdeo/app/livros/7_via_sacra/page_2.dart';

// Prayer pages
import 'package:coramdeo/app/oracoes/page.dart';
import 'package:coramdeo/app/oracoes/adorote_devote/page.dart';
import 'package:coramdeo/app/oracoes/angelus_regina_caeli/page.dart';
import 'package:coramdeo/app/oracoes/comentario_evangelho/page.dart';
import 'package:coramdeo/app/oracoes/credo/page.dart';
import 'package:coramdeo/app/oracoes/estampa_josemaria/page.dart';
import 'package:coramdeo/app/oracoes/exame_de_consciencia/page.dart';
import 'package:coramdeo/app/oracoes/falar_com_deus/page.dart';
import 'package:coramdeo/app/oracoes/gratias_tibi_ago/page.dart';
import 'package:coramdeo/app/oracoes/lembrai_vos/page.dart';
import 'package:coramdeo/app/oracoes/oferecimento_de_obras/page.dart';
import 'package:coramdeo/app/oracoes/preces/page.dart';
import 'package:coramdeo/app/oracoes/salmo_2/page.dart';
import 'package:coramdeo/app/oracoes/santo_rosario/page.dart';
import 'package:coramdeo/app/oracoes/te_deum/page.dart';
import 'package:coramdeo/app/oracoes/visita_ao_santissimo/page.dart';

// Other feature pages
import 'package:coramdeo/app/liturgia_diaria/page.dart';
import 'package:coramdeo/app/plano_de_vida/page.dart';
import 'package:coramdeo/app/santo_do_dia/page.dart';
import 'package:coramdeo/app/exame_de_consciencia/page.dart';


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

      case '/gratias-tibi-ago':
        return MaterialPageRoute(builder: (context) => const GratiasTibiAgoPage());

      // livros
      case "/caminho":
        return MaterialPageRoute(builder: (context) => const CaminhoPage());

      case "/caminho-reading":
        try {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (context) => CaminhoReadingPage(bookName: args['bookName']));
        } catch (e) {
          // If arguments are invalid, redirect to Caminho page
          return MaterialPageRoute(builder: (context) => const CaminhoPage());
        }

      case "/sulco":
        return MaterialPageRoute(builder: (context) => const SulcoPage());
      
      case "/sulco-reading":
        try {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (context) => SulcoReadingPage(bookName: args['bookName']));
        } catch (e) {
          // If arguments are invalid, redirect to Sulco page
          return MaterialPageRoute(builder: (context) => const SulcoPage());
        }

      case "/forja":
        return MaterialPageRoute(builder: (context) => const ForjaPage());
      
      case "/forja-reading":
        try {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (context) => ForjaReadingPage(bookName: args['bookName']));
        } catch (e) {
          // If arguments are invalid, redirect to Forja page
          return MaterialPageRoute(builder: (context) => const ForjaPage());
        }

      case "/amigos-de-deus":
        return MaterialPageRoute(builder: (context) => const AmigosDeDeusPage());
      
      case "/amigos-de-deus-reading":
        try {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (context) => AmigosDeDeusReadingPage(bookName: args['bookName']));
        } catch (e) {
          // If arguments are invalid, redirect to Amigos de Deus page
          return MaterialPageRoute(builder: (context) => const AmigosDeDeusPage());
        }

      case "/e-cristo-que-passa":
        return MaterialPageRoute(builder: (context) => const ECristoQuePassaPage());
      
      case "/e-cristo-que-passa-reading":
        try {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (context) => ECristoQuePassaReadingPage(bookName: args['bookName']));
        } catch (e) {
          // If arguments are invalid, redirect to E Cristo Que Passa page
          return MaterialPageRoute(builder: (context) => const ECristoQuePassaPage());
        }

      case "/santo-rosario-livro":
        return MaterialPageRoute(builder: (context) => const SantoRosarioLivroPage());

      case "/via-sacra-livro":
        return MaterialPageRoute(builder: (context) => const ViaSacraLivroPage());
      
      case "/via-sacra-reading":
        return MaterialPageRoute(builder: (context) => const ViaSacraReadingPage());

      default:
        // Return home page for any unrecognized route
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }

  static String initial = '/';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

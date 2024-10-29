import 'package:coramdeo/pages/livros/amigos_de_deus_page.dart';
import 'package:coramdeo/pages/livros/point_book_reading_page.dart';
import 'package:coramdeo/pages/livros/caminho_page.dart';
import 'package:coramdeo/pages/livros/e_cristo_que_passa_page.dart';
import 'package:coramdeo/pages/livros/forja_page.dart';
import 'package:coramdeo/pages/livros/santo_rosario_livro_page.dart';
import 'package:coramdeo/pages/livros/sulco_page.dart';
import 'package:coramdeo/pages/livros/via_sacra_page.dart';
import 'package:coramdeo/pages/oracoes/credo_page.dart';
import 'package:coramdeo/pages/oracoes/lembrai_vos_page.dart';
import 'package:coramdeo/pages/oracoes/oferecimento_de_obras_page.dart';
import 'package:coramdeo/pages/oracoes/preces_page.dart';
import 'package:coramdeo/pages/oracoes/santo_rosario_page.dart';
import 'package:flutter/material.dart';
import 'package:coramdeo/pages/bible/bible_page.dart';
import 'package:coramdeo/pages/bible/reading_page.dart';
import 'package:coramdeo/pages/home_page.dart';
import 'package:coramdeo/pages/liturgia_diaria_page.dart';
import 'package:coramdeo/pages/livros/livros_page.dart';
import 'package:coramdeo/pages/oracoes/angelus_regina_caeli_page.dart';
import 'package:coramdeo/pages/oracoes/comentario_do_evangelho_page.dart';
import 'package:coramdeo/pages/oracoes/falar_com_deus_page.dart';
import 'package:coramdeo/pages/oracoes/oracoes_page.dart';
import 'package:coramdeo/pages/plano_de_vida_page.dart';
import 'package:coramdeo/pages/santo_do_dia_page.dart';
import 'package:coramdeo/pages/settings_page.dart';
import 'package:coramdeo/pages/oracoes/te_deum_page.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const HomePage());

      case "/settings":
        return MaterialPageRoute(builder: (context) => const SettingsPage());

      case "/bible":
        return MaterialPageRoute(builder: (context) => const BiblePage());

      case "/reading":
        return MaterialPageRoute(builder: (context) => const ReadingPage());

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
      // 'via-sacra':
      // 'visita-ao-santissimo':

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

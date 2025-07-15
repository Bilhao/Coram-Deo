/// Application constants and configuration values
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // App information
  static const String appName = 'Coram Deo';
  static const String version = '0.1.8';

  // Route names
  static const String homeRoute = '/';
  static const String settingsRoute = '/settings';
  
  // Bible routes
  static const String bibliaPage1Route = '/biblia-page-1';
  static const String bibliaPage2Route = '/biblia-page-2';
  
  // Books routes
  static const String livrosRoute = '/livros';
  static const String bookReadingRoute = '/book-reading';
  static const String caminhoRoute = '/caminho';
  static const String sulcoRoute = '/sulco';
  static const String forjaRoute = '/forja';
  static const String amigosDeDeusRoute = '/amigos-de-deus';
  static const String eCristoQuePassaRoute = '/e-cristo-que-passa';
  static const String santoRosarioLivroRoute = '/santo-rosario-livro';
  static const String viaSacraLivroRoute = '/via-sacra-livro';
  
  // Prayer routes
  static const String oracoesRoute = '/oracoes';
  static const String falarComDeusRoute = '/falar-com-deus';
  static const String angelusReginaCaeliRoute = '/angelus-regina-caeli';
  static const String comentarioEvangelhoRoute = '/comentario-do-evangelho-do-dia';
  static const String credoRoute = '/credo';
  static const String lembraiVosRoute = '/lembrai-vos';
  static const String oferecimentoObrasRoute = '/oferecimento-de-obras';
  static const String precesRoute = '/preces';
  static const String santoRosarioRoute = '/santo-rosario';
  static const String teDeumRoute = '/te-deum';
  static const String visitaAoSantissimoRoute = '/visita-ao-santissimo';
  static const String adoroTeDevoteRoute = '/adoro-te-devote';
  static const String salmo2Route = '/salmo-2';
  static const String exameConscienciaOracaoRoute = '/exame-de-consciencia-oracao';
  static const String estampaJosemariaRoute = '/estampa-josemaria';
  static const String gratiasTibiAgoRoute = '/gratias-tibi-ago';
  
  // Other feature routes
  static const String liturgiaRoute = '/liturgia';
  static const String planoDeVidaRoute = '/plano-de-vida';
  static const String santoDoDiaRoute = '/santo-do-dia';
  static const String exameConscienciaRoute = '/exame-de-consciencia';

  // Preferences keys
  static const String fontSizeKey = 'fontSize';
  static const String themeKey = 'theme.theme';
  static const String dynamicColorKey = 'theme.dynamiccolor';
  static const String colorSeedKey = 'theme.colorseed';
  static const String blockExameKey = 'exame.block';
  static const String biometricKey = 'exame.biometric';
  
  // Bible preferences keys
  static const String bibleVersionKey = 'bible.version';
  static const String bibleTestamentKey = 'bible.testament';
  static const String bibleBookIdKey = 'bible.book_id';
  static const String bibleBookKey = 'bible.book';
  static const String bibleChapterKey = 'bible.chapter';
  static const String bibleVersesIdKey = 'bible.verses_id';
  static const String bibleVersesKey = 'bible.verses';
  static const String bibleAudioEnabledKey = 'bible.audio_enabled';
  static const String bibleAutoPlayKey = 'bible.auto_play';
  static const String biblePlaybackSpeedKey = 'bible.playback_speed';
  
  // Prayer preferences
  static const String favoritePrayersKey = 'oracoes.favoritas';

  // Default values
  static const double defaultFontSize = 16.0;
  static const double minFontSize = 12.0;
  static const double maxFontSize = 30.0;
  static const String defaultTheme = 'system';
  static const bool defaultDynamicColor = false;
  static const int defaultColorSeed = 0xFF004B8D;
  static const bool defaultBlockExame = true;
  static const bool defaultUseBiometric = true;
  static const String defaultBibleVersion = 'nvi_pt';
  static const String defaultTestament = 'Old';
  static const int defaultBookId = 1;
  static const String defaultBook = 'Gênesis';
  static const int defaultChapter = 1;
  static const bool defaultAudioEnabled = false;
  static const bool defaultAutoPlay = false;
  static const double defaultPlaybackSpeed = 1.0;

  // Notification settings
  static const String notificationChannelId = 'lembretes';
  static const String notificationChannelName = 'Lembretes';

  // Error messages
  static const String genericErrorMessage = 'Ocorreu um erro inesperado';
  static const String networkErrorMessage = 'Erro de conexão. Verifique sua internet.';
  static const String loadingErrorMessage = 'Erro ao carregar dados';
  static const String saveErrorMessage = 'Erro ao salvar dados';
}
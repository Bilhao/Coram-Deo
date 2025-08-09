/// Application constants and configuration values
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // Preferences keys
  static const String fontSizeKey = 'fontSize';
  static const String themeKey = 'theme.theme';
  static const String dynamicColorKey = 'theme.dynamiccolor';
  static const String colorSeedKey = 'theme.colorseed';
  static const String blockExameKey = 'exame.block';
  static const String biometricKey = 'exame.biometric';

  // Bible preferences keys
  static const String bibleTestamentKey = 'bible.testament';
  static const String bibleBookIdKey = 'bible.book_id';
  static const String bibleBookKey = 'bible.book';
  static const String bibleChapterKey = 'bible.chapter';
  static const String bibleVersesIdKey = 'bible.verses_id';
  static const String bibleVersesKey = 'bible.verses';

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
  static const String defaultTestament = 'Old';
  static const int defaultBookId = 1;
  static const String defaultBook = 'Gênesis';
  static const int defaultChapter = 1;

  // Notification settings
  static const String notificationChannelId = 'lembretes';
  static const String notificationChannelName = 'Lembretes';

  // Error messages
  static const String genericErrorMessage = 'Ocorreu um erro inesperado';
  static const String networkErrorMessage = 'Erro de conexão. Verifique sua internet.';
  static const String loadingErrorMessage = 'Erro ao carregar dados';
  static const String saveErrorMessage = 'Erro ao salvar dados';
}

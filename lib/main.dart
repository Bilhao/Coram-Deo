import 'package:coramdeo/app/biblia/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/santo_do_dia/provider.dart';
import 'package:coramdeo/app/liturgia_diaria/provider.dart';
import 'package:coramdeo/app/livros/random_provider.dart';
import 'package:coramdeo/app/calendario/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'utils/notification.dart';
import 'utils/routes.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Carrega o splashscreen
  if (!kIsWeb) {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  } else {
    databaseFactory = databaseFactoryFfiWeb;
  }

  // Inicializa o Firebase com tratamento de erro resiliente
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init info: $e");
  }

  // Carrega as notificações
  await Notifier.init();

  // Ajuste das configurações de tela
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
    ),
  );

  runApp(const CoramDeoApp());
}

class CoramDeoApp extends StatelessWidget {
  const CoramDeoApp({super.key});

  static InputDecorationTheme _buildInputDecorationTheme(
    ColorScheme colorScheme,
  ) {
    final borderRadius = BorderRadius.circular(10.0);
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest,
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colorScheme.error, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => SantoDoDiaProvider()),
        ChangeNotifierProvider(create: (context) => BibleProvider()),
        ChangeNotifierProvider(create: (context) => LiturgiaDiariaProvider()),
        ChangeNotifierProvider(create: (context) => RandomPointProvider()),
        ChangeNotifierProvider(
          create: (context) => CalendarioLiturgicoProvider(),
        ),
      ],
      child: Consumer<AppProvider>(
        builder: (context, provider, _) {
          return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
              if (provider.isLoading) {
                // Return empty container while loading preferences
                // FlutterNativeSplash handles the visual splash screen
                return const Directionality(
                  textDirection: TextDirection.ltr,
                  child: SizedBox.shrink(),
                );
              }

              final lightColorScheme =
                  provider.dynamicColor && lightDynamic != null
                  ? lightDynamic.harmonized()
                  : ColorScheme.fromSeed(
                      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
                      seedColor: Color(provider.colorSeed),
                      primary: Color(provider.colorSeed),
                      brightness: Brightness.light,
                    );

              final darkColorScheme =
                  provider.dynamicColor && darkDynamic != null
                  ? darkDynamic.harmonized()
                  : (provider.dynamicColor && lightDynamic != null
                        ? ColorScheme.fromSeed(
                            seedColor: lightDynamic.primary,
                            brightness: Brightness.dark,
                          )
                        : ColorScheme.fromSeed(
                            dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
                            seedColor: Color(provider.colorSeed),
                            brightness: Brightness.dark,
                          ));

              MaterialApp app = MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: provider.themeMode,
                theme: ThemeData(
                  colorScheme: lightColorScheme,
                  inputDecorationTheme: _buildInputDecorationTheme(
                    lightColorScheme,
                  ),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  colorScheme: darkColorScheme,
                  inputDecorationTheme: _buildInputDecorationTheme(
                    darkColorScheme,
                  ),
                  useMaterial3: true,
                ),
                initialRoute: provider.showOnboarding
                    ? '/onboarding'
                    : Routes.initial,
                onGenerateRoute: Routes.onGenerateRoute,
                navigatorKey: Routes.navigatorKey,
              );

              if (!kIsWeb) {
                FlutterNativeSplash.remove();
              }

              return app;
            },
          );
        },
      ),
    );
  }
}

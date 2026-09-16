import 'package:coramdeo/app/biblia/provider.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/santo_do_dia/provider.dart';
import 'package:coramdeo/app/liturgia_diaria/provider.dart';
import 'package:coramdeo/app/livros/random_provider.dart';
import 'package:coramdeo/app/calendario/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'utils/notification.dart';
import 'utils/routes.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Carrega o splashscreen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent, systemNavigationBarContrastEnforced: false));

  runApp(const CoramDeoApp());
}

class CoramDeoApp extends StatelessWidget {
  const CoramDeoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => SantoDoDiaProvider()),
        ChangeNotifierProvider(create: (context) => BibleProvider()),
        ChangeNotifierProvider(create: (context) => LiturgiaDiariaProvider()),
        ChangeNotifierProvider(create: (context) => RandomPointProvider()),
        ChangeNotifierProvider(create: (context) => CalendarioLiturgicoProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, provider, _) {
          return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
              if (provider.isLoading) {
                // Return empty container while loading preferences
                // FlutterNativeSplash handles the visual splash screen
                return const Directionality(textDirection: TextDirection.ltr, child: SizedBox.shrink());
              }

              MaterialApp app = MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: provider.themeMode,
                theme: ThemeData(
                  colorScheme: provider.dynamicColor && lightDynamic != null
                      ? lightDynamic.harmonized()
                      : ColorScheme.fromSeed(
                          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
                          seedColor: Color(provider.colorSeed),
                          primary: Color(provider.colorSeed),
                          brightness: Brightness.light,
                        ),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  colorScheme: provider.dynamicColor && darkDynamic != null
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
                            )),
                  useMaterial3: true,
                ),
                initialRoute: provider.showOnboarding ? '/onboarding' : Routes.initial,
                onGenerateRoute: Routes.onGenerateRoute,
                navigatorKey: Routes.navigatorKey,
              );

              FlutterNativeSplash.remove();

              return app;
            },
          );
        },
      ),
    );
  }
}

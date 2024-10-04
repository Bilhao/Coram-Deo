import 'package:coramdeo/providers/bible_provider.dart';
import 'package:coramdeo/providers/santo_do_dia_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'utils/notification.dart';
import 'utils/routes.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Carrega o splashscreen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Carrega as notificações
  Notifier.init();

  // Ajuste das configurações de tela
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  runApp(
    const OracaoApp(),
  );
}

// TESTE


//TESTE2

class OracaoApp extends StatelessWidget {
  const OracaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SantoDoDiaProvider()),
        ChangeNotifierProvider(create: (context) => BibleProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, _) {
          return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
              MaterialApp app = MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: provider.themeMode,
                theme: ThemeData(
                  colorScheme: provider.dynamicColor && lightDynamic != null
                      ? ColorScheme.fromSeed(
                          seedColor: lightDynamic.harmonized().primary,
                          brightness: Brightness.light,
                        )
                      : ColorScheme.fromSeed(
                          seedColor: Color(provider.colorSeed),
                          brightness: Brightness.light,
                        ),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  colorScheme: provider.dynamicColor && darkDynamic != null
                      ? ColorScheme.fromSeed(
                          seedColor: darkDynamic.harmonized().primary,
                          brightness: Brightness.dark,
                      )
                      : ColorScheme.fromSeed(
                          seedColor: Color(provider.colorSeed),
                          brightness: Brightness.dark,
                        ),
                  useMaterial3: true,
                ),
                initialRoute: Routes.initial,
                onGenerateRoute: Routes.onGenerateRoute,
                navigatorKey: Routes.navigatorKey,
              );
              lightDynamic == null || darkDynamic == null
                  ? ()
                  : FlutterNativeSplash.remove();
              return app;
            },
          );
        },
      ),
    );
  }
}

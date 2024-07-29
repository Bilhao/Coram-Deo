import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/theme_provider.dart';
import 'utils/notification.dart';
import 'utils/routes.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Notifier.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  // Carregar preferências de tema antes de iniciar o aplicativo
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentTheme = prefs.getString('theme.theme') ?? "system";
  bool dynamicColor = prefs.getBool('theme.dynamiccolor') ?? false;
  int colorSeed = prefs.getInt('theme.colorseed') ?? 0xFF004B8D;

  runApp(
    OracaoApp(
      initialTheme: currentTheme,
      initialDynamicColor: dynamicColor,
      initialColorSeed: colorSeed,
    ),
  );
}

class OracaoApp extends StatelessWidget {
  final String initialTheme;
  final bool initialDynamicColor;
  final int initialColorSeed;

  const OracaoApp({
    super.key,
    required this.initialTheme,
    required this.initialDynamicColor,
    required this.initialColorSeed,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(
        initialTheme: initialTheme,
        initialDynamicColor: initialDynamicColor,
        initialColorSeed: initialColorSeed,
      ),
      child: Consumer<ThemeProvider>(
        builder: (context, provider, _) {
          return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
              MaterialApp app = MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: provider.themeMode,
                theme: ThemeData(
                  colorScheme: provider.dynamicColor 
                    ? lightDynamic
                    : ColorScheme.fromSeed(
                      seedColor: Color(provider.colorSeed),
                      brightness: Brightness.light,
                    ),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  colorScheme: provider.dynamicColor 
                    ? darkDynamic
                    : ColorScheme.fromSeed(
                      seedColor: Color(provider.colorSeed),
                      brightness: Brightness.dark,
                    ),
                  useMaterial3: true,
                ),
                initialRoute: Routes.initial,
                routes: Routes.routes,
                navigatorKey: Routes.navigatorKey,
              );
              lightDynamic == null || darkDynamic == null ? () : FlutterNativeSplash.remove();
              return app;
            },
          );
        },
      ),
    );
  }
}

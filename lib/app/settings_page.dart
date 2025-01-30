import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    int newcolorSeed = 0;
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10.0),
              child: Text("Aparência", style: TextStyle(fontSize: 15.0, color: Theme.of(context).colorScheme.primary)),
            ),
            ListTile(
              title: Text('Tema', style: TextStyle(fontSize: 16.0)),
              subtitle: Text('Alternar entre temas', style: TextStyle(fontSize: 14.0)),
              trailing: SegmentedButton(
                selected: {appProvider.currentTheme},
                showSelectedIcon: false,
                emptySelectionAllowed: false,
                multiSelectionEnabled: false,
                segments: [
                  ButtonSegment(
                    value: "light",
                    icon: Icon(appProvider.currentTheme == "light" ? Icons.light_mode : Icons.light_mode_outlined),
                  ),
                  const ButtonSegment(
                    value: "system",
                    icon: Icon(Icons.contrast),
                  ),
                  ButtonSegment(
                    value: "dark",
                    icon: Icon(appProvider.currentTheme == "dark" ? Icons.dark_mode : Icons.dark_mode_outlined),
                  ),
                ],
                onSelectionChanged: (segment) => appProvider.changeTheme(segment.first.toString()),
              ),
            ),
            SwitchListTile(
              title: Text('Cores dinâmicas', style: TextStyle(fontSize: 16.0)),
              subtitle: Text('Utilizar cores baseadas no sistema', style: TextStyle(fontSize: 14)),
              value: appProvider.dynamicColor,
              secondary: const Icon(Icons.color_lens),
              onChanged: (value) {
                setState(() {
                  appProvider.toggleDynamicColor();
                });
              },
            ),
            if (!appProvider.dynamicColor)
              ListTile(
                title: Text('Cor principal', style: TextStyle(fontSize: 16.0)),
                trailing: ColorIndicator(
                  width: 35,
                  height: 35,
                  borderRadius: 8,
                  color: Color(appProvider.colorSeed),
                  onSelectFocus: false,
                  onSelect: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Selecione uma cor'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            color: Color(appProvider.colorSeed),
                            subheading: const Text("Tonalidade"),
                            wheelSubheading: const Text("Tonalidade"),
                            wheelSquarePadding: 10,
                            pickersEnabled: const <ColorPickerType, bool>{
                              ColorPickerType.both: false,
                              ColorPickerType.primary: true,
                              ColorPickerType.accent: false,
                              ColorPickerType.wheel: true,
                            },
                            onColorChanged: (Color value) {
                              newcolorSeed = value.value32bit;
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Confirmar'),
                            onPressed: () {
                              setState(() {
                                appProvider.changeColorSeed(newcolorSeed);
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ListTile(
              title: Text('Tamanho da fonte', style: TextStyle(fontSize: 16.0)),
              subtitle: Text("Padrão 16", style: TextStyle(fontSize: 14.0)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      appProvider.decreaseFontSize();
                    },
                  ),
                  Text(appProvider.fontSize.toString(), style: TextStyle(fontSize: 16)),
                  IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                          appProvider.increaseFontSize();
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10.0),
              child: Text("Segurança", style: TextStyle(fontSize: 15.0, color: Theme.of(context).colorScheme.primary)),
            ),
            SwitchListTile(
              title: Text('Bloquear Exame de Consciência', style: TextStyle(fontSize: 16.0)),
              subtitle: Text('Pedir autenticação ao abrir exame de consciência', style: TextStyle(fontSize: 14)),
              value: appProvider.blockExame,
              secondary: const Icon(Icons.lock),
              onChanged: (value) {
                setState(() {
                  appProvider.toggleBlockExame();
                });
              },
            ),
            if (appProvider.blockExame && appProvider.canAuthenticate)
              SwitchListTile(
                title: Text('Usar autenticação biométrica', style: TextStyle(fontSize: 16.0)),
                value: appProvider.useBiometric,
                secondary: const Icon(Icons.fingerprint),
                onChanged: (value) {
                  setState(() {
                    appProvider.toggleUseBiometric();
                  });
                },
              ),
          ],
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:coramdeo/app/theme_provider.dart';
import 'package:coramdeo/app/fontsize_provider.dart';
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
    return Consumer2<ThemeProvider, FontSizeProvider>(builder: (context, themeprovider, fontsizeprovider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15.0),
              child: Text("Aparência", style: TextStyle(fontSize: 15.0, color: Theme.of(context).colorScheme.primary)),
            ),
            ListTile(
              title: Text('Tema', style: TextStyle(fontSize: 16.0)),
              subtitle: Text('Alternar entre temas', style: TextStyle(fontSize: 14.0)),
              trailing: SegmentedButton(
                selected: {themeprovider.currentTheme},
                showSelectedIcon: false,
                emptySelectionAllowed: false,
                multiSelectionEnabled: false,
                segments: [
                  ButtonSegment(
                    value: "light",
                    icon: Icon(themeprovider.currentTheme == "light" ? Icons.light_mode : Icons.light_mode_outlined),
                  ),
                  const ButtonSegment(
                    value: "system",
                    icon: Icon(Icons.contrast),
                  ),
                  ButtonSegment(
                    value: "dark",
                    icon: Icon(themeprovider.currentTheme == "dark" ? Icons.dark_mode : Icons.dark_mode_outlined),
                  ),
                ],
                onSelectionChanged: (segment) => themeprovider.changeTheme(segment.first.toString()),
              ),
            ),
            SwitchListTile(
              title: Text('Cores dinâmicas', style: TextStyle(fontSize: 16.0)),
              subtitle: Text('Utilizar cores baseadas no sistema', style: TextStyle(fontSize: 14)),
              value: themeprovider.dynamicColor,
              secondary: const Icon(Icons.color_lens),
              onChanged: (value) {
                setState(() {
                  themeprovider.toggleDynamicColor();
                });
              },
            ),
            if (!themeprovider.dynamicColor)
              ListTile(
                title: Text('Cor principal', style: TextStyle(fontSize: 16.0)),
                trailing: ColorIndicator(
                  width: 35,
                  height: 35,
                  borderRadius: 8,
                  color: Color(themeprovider.colorSeed),
                  onSelectFocus: false,
                  onSelect: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Selecione uma cor'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            color: Color(themeprovider.colorSeed),
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
                                themeprovider.changeColorSeed(newcolorSeed);
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
                      setState(() {
                        fontsizeprovider.saveFontSize(fontsizeprovider.fontSize - 1);
                      });
                    },
                  ),
                  Text(fontsizeprovider.fontSize.toString(), style: TextStyle(fontSize: 16)),
                  IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          fontsizeprovider.saveFontSize(fontsizeprovider.fontSize + 1);
                        });
                      })
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

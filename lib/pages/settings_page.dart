import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:coramdeo/providers/theme_provider.dart';
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
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15.0),
              child: Text("Aparência", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
            ListTile(
              title: const Text('Tema'),
              subtitle: const Text('Alternar entre temas'),
              trailing: SegmentedButton(
                selected: {provider.currentTheme},
                showSelectedIcon: false,
                emptySelectionAllowed: false,
                multiSelectionEnabled: false,
                segments: [
                  ButtonSegment(
                    value: "light",
                    icon: Icon(provider.currentTheme == "light" ? Icons.light_mode : Icons.light_mode_outlined),
                  ),
                  const ButtonSegment(
                    value: "system",
                    icon: Icon(Icons.contrast),
                  ),
                  ButtonSegment(
                    value: "dark",
                    icon: Icon(provider.currentTheme == "dark" ? Icons.dark_mode : Icons.dark_mode_outlined),
                  ),
                ],
                onSelectionChanged: (segment) => provider.changeTheme(segment.first.toString()),
              ),
            ),
            SwitchListTile(
              title: const Text('Cores dinâmicas'),
              subtitle: const Text('Utilizar cores baseadas no sistema'),
              value: provider.dynamicColor,
              secondary: const Icon(Icons.color_lens),
              onChanged: (value) {
                setState(() {
                  provider.toggleDynamicColor();
                });
              },
            ),
            if (!provider.dynamicColor)
              ListTile(
                title: const Text('Cor principal'),
                trailing: ColorIndicator(
                  width: 35,
                  height: 35,
                  borderRadius: 8,
                  color: Color(provider.colorSeed),
                  onSelectFocus: false,
                  onSelect: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Selecione uma cor'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            color: Color(provider.colorSeed),
                            // enableShadesSelection: false,
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
                              newcolorSeed = value.value;
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Confirmar'),
                            onPressed: () {
                              setState(() {
                                provider.changeColorSeed(newcolorSeed);
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
          ],
        ),
      );
    });
  }
}

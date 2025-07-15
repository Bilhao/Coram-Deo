import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/biblia/provider.dart';
import 'package:coramdeo/app/biblia/data.dart';

class BibleVersionSelector extends StatelessWidget {
  const BibleVersionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BibleProvider>(
      builder: (context, provider, child) {
        return PopupMenuButton<String>(
          icon: const Icon(Icons.translate),
          tooltip: 'Selecionar versão da Bíblia',
          onSelected: (String versionId) {
            provider.switchVersion(versionId);
          },
          itemBuilder: (BuildContext context) {
            return provider.availableVersions.map((BibleVersion version) {
              return PopupMenuItem<String>(
                value: version.id,
                child: ListTile(
                  leading: Icon(
                    version.hasAudio ? Icons.volume_up : Icons.text_fields,
                    color: version.id == provider.currentVersion 
                        ? Theme.of(context).colorScheme.primary 
                        : null,
                  ),
                  title: Text(
                    version.name,
                    style: TextStyle(
                      fontWeight: version.id == provider.currentVersion 
                          ? FontWeight.bold 
                          : FontWeight.normal,
                      color: version.id == provider.currentVersion 
                          ? Theme.of(context).colorScheme.primary 
                          : null,
                    ),
                  ),
                  subtitle: Text(
                    version.language,
                    style: TextStyle(
                      color: version.id == provider.currentVersion 
                          ? Theme.of(context).colorScheme.primary 
                          : Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  trailing: version.id == provider.currentVersion 
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                ),
              );
            }).toList();
          },
        );
      },
    );
  }
}

class BibleVersionDialog extends StatelessWidget {
  const BibleVersionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BibleProvider>(
      builder: (context, provider, child) {
        return AlertDialog(
          title: const Text('Selecionar Versão da Bíblia'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: provider.availableVersions.length,
              itemBuilder: (context, index) {
                final version = provider.availableVersions[index];
                final isSelected = version.id == provider.currentVersion;
                
                return Card(
                  elevation: isSelected ? 4 : 1,
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  child: ListTile(
                    leading: Icon(
                      version.hasAudio ? Icons.volume_up : Icons.text_fields,
                      color: isSelected 
                          ? Theme.of(context).colorScheme.primary 
                          : null,
                    ),
                    title: Text(
                      version.name,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(version.language),
                        if (version.hasAudio)
                          const Text(
                            'Com áudio disponível',
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                    trailing: isSelected 
                        ? Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : null,
                    onTap: () {
                      provider.switchVersion(version.id);
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
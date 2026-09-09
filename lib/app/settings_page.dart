import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/services/auth_service.dart';
import 'package:coramdeo/services/cloud_sync_service.dart';
import 'package:coramdeo/widgets/auth_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService _authService = AuthService();
  final CloudSyncService _cloudSyncService = CloudSyncService();

  bool _isSyncing = false;
  Map<String, dynamic>? _lastBackupInfo;

  @override
  void initState() {
    super.initState();
    _loadLastBackupInfo();
  }

  Future<void> _loadLastBackupInfo() async {
    if (_authService.currentUser != null) {
      final info = await _cloudSyncService.getLastBackupInfo();
      if (mounted) {
        setState(() {
          _lastBackupInfo = info;
        });
      }
    }
  }

  String _formatTimestamp(String? isoString) {
    if (isoString == null) return 'Desconhecido';
    try {
      final date = DateTime.parse(isoString).toLocal();
      return DateFormat('dd/MM/yyyy HH:mm').format(date);
    } catch (_) {
      return isoString;
    }
  }

  Future<void> _handleCloudBackup() async {
    setState(() {
      _isSyncing = true;
    });

    try {
      await _cloudSyncService.uploadBackup();
      await _loadLastBackupInfo();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Backup na nuvem realizado com sucesso!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      final errorMsg = e.toString().contains('permission-denied')
          ? 'Permissão negada no Firestore. Verifique as regras de segurança no Firebase Console.'
          : 'Erro ao fazer backup: $e';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMsg,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
      }
    }
  }

  void _confirmRestore(AppProvider appProvider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restaurar Backup da Nuvem?'),
        content: const Text(
          'Isso substituirá seus dados e preferências locais pelos salvos na nuvem. Deseja continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              setState(() {
                _isSyncing = true;
              });

              try {
                final restored = await _cloudSyncService.restoreBackup();
                if (restored && mounted) {
                  await appProvider.reload();
                  await _loadLastBackupInfo();

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Dados restaurados com sucesso!',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSecondaryContainer,
                          ),
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondaryContainer,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Erro ao restaurar dados: $e',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.errorContainer,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              } finally {
                if (mounted) {
                  setState(() {
                    _isSyncing = false;
                  });
                }
              }
            },
            child: const Text('Restaurar'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Conta e Dados?'),
        content: const Text(
          'Esta ação excluirá permanentemente sua conta e todos os dados de backup salvos na nuvem. Os dados locais não serão apagados.\n\nDeseja continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              setState(() {
                _isSyncing = true;
              });

              try {
                await _authService.deleteAccount();
                if (mounted) {
                  setState(() {
                    _lastBackupInfo = null;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Conta e dados na nuvem excluídos com sucesso.',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                        ),
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Erro ao excluir conta: $e',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.errorContainer,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              } finally {
                if (mounted) {
                  setState(() {
                    _isSyncing = false;
                  });
                }
              }
            },
            child: const Text('Excluir Definitivamente'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int newcolorSeed = 0;
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Configurações')),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Seção Aparência
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      top: 15.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      "Aparência",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Tema', style: TextStyle(fontSize: 16.0)),
                    subtitle: const Text(
                      'Alternar entre temas',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    trailing: SegmentedButton(
                      selected: {appProvider.currentTheme},
                      showSelectedIcon: false,
                      emptySelectionAllowed: false,
                      multiSelectionEnabled: false,
                      segments: [
                        ButtonSegment(
                          value: "light",
                          icon: Icon(
                            appProvider.currentTheme == "light"
                                ? Icons.light_mode
                                : Icons.light_mode_outlined,
                          ),
                        ),
                        const ButtonSegment(
                          value: "system",
                          icon: Icon(Icons.contrast),
                        ),
                        ButtonSegment(
                          value: "dark",
                          icon: Icon(
                            appProvider.currentTheme == "dark"
                                ? Icons.dark_mode
                                : Icons.dark_mode_outlined,
                          ),
                        ),
                      ],
                      onSelectionChanged: (segment) =>
                          appProvider.changeTheme(segment.first.toString()),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text(
                      'Cores dinâmicas',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: const Text(
                      'Utilizar cores baseadas no sistema',
                      style: TextStyle(fontSize: 14),
                    ),
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
                      title: const Text(
                        'Cor principal',
                        style: TextStyle(fontSize: 16.0),
                      ),
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
                    title: const Text(
                      'Tamanho da fonte',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: const Text(
                      "Padrão 16",
                      style: TextStyle(fontSize: 14.0),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            appProvider.decreaseFontSize();
                          },
                        ),
                        Text(
                          appProvider.fontSize.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            appProvider.increaseFontSize();
                          },
                        ),
                      ],
                    ),
                  ),

                  // Seção Sincronização em Nuvem (Substituindo Backup Manual)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      top: 15.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      "Sincronização em Nuvem",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  StreamBuilder<User?>(
                    stream: _authService.authStateChanges,
                    builder: (context, snapshot) {
                      final user = snapshot.data ?? _authService.currentUser;

                      if (user == null) {
                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 4.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.cloud_outlined,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      size: 26,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Conta e Backup em Nuvem',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Conecte com o Google ou crie uma conta para sincronizar seu Plano de Vida e configurações entre dispositivos com segurança.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                FilledButton.tonalIcon(
                                  onPressed: () => AuthBottomSheet.show(
                                    context,
                                    onSuccess: () {
                                      _loadLastBackupInfo();
                                      setState(() {});
                                    },
                                  ),
                                  icon: const Icon(Icons.login_rounded),
                                  label: const Text('Entrar ou Cadastrar'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 4.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    child: Icon(
                                      Icons.person_rounded,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.displayName ?? 'Conta Conectada',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          user.email ?? '',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'Sair da conta',
                                    icon: const Icon(Icons.logout_rounded),
                                    onPressed: () async {
                                      await _authService.signOut();
                                      setState(() {
                                        _lastBackupInfo = null;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    tooltip: 'Excluir conta e dados',
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ),
                                    onPressed: _isSyncing
                                        ? null
                                        : _confirmDeleteAccount,
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
                              if (_lastBackupInfo != null &&
                                  _lastBackupInfo!['timestamp'] != null) ...[
                                Text(
                                  'Último backup salvo: ${_formatTimestamp(_lastBackupInfo!['timestamp'])}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                              Row(
                                children: [
                                  Expanded(
                                    child: FilledButton.icon(
                                      onPressed: _isSyncing
                                          ? null
                                          : _handleCloudBackup,
                                      icon: const Icon(
                                        Icons.cloud_upload_rounded,
                                      ),
                                      label: const Text('Fazer Backup'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _isSyncing
                                          ? null
                                          : () => _confirmRestore(appProvider),
                                      icon: const Icon(
                                        Icons.cloud_download_rounded,
                                      ),
                                      label: const Text('Restaurar'),
                                    ),
                                  ),
                                ],
                              ),
                              if (_isSyncing)
                                const Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                  child: LinearProgressIndicator(),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Seção Apoio e Contribuição (Acessível APENAS por aqui)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      top: 15.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      "Apoio e Contribuição",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.volunteer_activism_rounded),
                    title: const Text(
                      'Apoiar o Coram Deo',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: const Text(
                      'Ajude a manter o projeto gratuito via PIX',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      Navigator.pushNamed(context, '/contribuicao');
                    },
                  ),

                  // Seção Segurança
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      top: 15.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      "Segurança",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text(
                      'Bloquear Exame de Consciência',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: const Text(
                      'Pedir autenticação ao abrir exame de consciência',
                      style: TextStyle(fontSize: 14),
                    ),
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
                      title: const Text(
                        'Usar autenticação biométrica',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      value: appProvider.useBiometric,
                      secondary: const Icon(Icons.fingerprint),
                      onChanged: (value) {
                        setState(() {
                          appProvider.toggleUseBiometric();
                        });
                      },
                    ),
                  // Seção Sobre e Privacidade
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      top: 15.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      "Sobre e Privacidade",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: const Text(
                      'Política de Privacidade',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: const Text(
                      'Saiba como seus dados são protegidos',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    trailing: const Icon(Icons.open_in_new_rounded, size: 20),
                    onTap: () async {
                      final uri = Uri.parse(
                        'https://github.com/Bilhao/Coram-Deo/blob/main/PRIVACY.md',
                      );
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

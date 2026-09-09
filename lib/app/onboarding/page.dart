import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/services/auth_service.dart';
import 'package:coramdeo/services/cloud_sync_service.dart';
import 'package:coramdeo/utils/notification.dart';
import 'package:coramdeo/widgets/auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with WidgetsBindingObserver {
  final FlutterCarouselController _controller = FlutterCarouselController();
  final AuthService _authService = AuthService();
  final CloudSyncService _cloudSyncService = CloudSyncService();

  int _current = 0;
  bool _hasPermission = false;
  bool _isRestoring = false;
  bool _backupChecked = false;
  Map<String, dynamic>? _cloudBackupInfo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
    _checkCloudBackup();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    bool granted = await Notifier.checkNotificationPermission();
    if (granted) {
      if (mounted) {
        setState(() {
          _hasPermission = true;
        });
      }
    }
  }

  Future<void> _checkCloudBackup() async {
    if (_authService.currentUser != null) {
      final info = await _cloudSyncService.getLastBackupInfo();
      if (mounted) {
        setState(() {
          _cloudBackupInfo = info;
          _backupChecked = true;
        });
      }
    }
  }

  Future<void> _restoreFromCloud() async {
    setState(() {
      _isRestoring = true;
    });

    try {
      final restored = await _cloudSyncService.restoreBackup();
      if (restored && mounted) {
        await Provider.of<AppProvider>(context, listen: false).reload();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Dados da nuvem restaurados com sucesso!'),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao restaurar: $e'),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRestoring = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;

        if (_current > 0) {
          _controller.previousPage();
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Stack(
          children: [
            // Background Gradient decoration (subtle)
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.secondaryContainer.withValues(alpha: 0.3),
                ),
              ),
            ),

            Positioned.fill(
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: FlutterCarousel(
                        options: FlutterCarouselOptions(
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                          showIndicator: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                          controller: _controller,
                        ),
                        items: [
                          _buildSlide(
                            context,
                            imagePath: 'assets/images/complete_logo.png',
                            title: "Bem-vindo ao Coram Deo",
                            description: "Seu companheiro diário para uma vida de oração, leitura e crescimento espiritual.",
                            isFirst: true,
                          ),
                          _buildSlide(
                            context,
                            icon: Icons.auto_stories,
                            title: "Liturgia e Espiritualidade",
                            description: "Acompanhe a Liturgia Diária, Santo do Dia e diversas orações clássicas da Igreja.",
                          ),
                          _buildSlide(
                            context,
                            icon: Icons.menu_book,
                            title: "Sagrada Escritura",
                            description: "Leia a Sagrada Escritura em diversas versões (NVI, ACF, KJV e RVR) com leitura fluida e personalizada.",
                          ),
                          _buildSlide(
                            context,
                            icon: Icons.checklist,
                            title: "Ferramentas Espirituais",
                            description: "Organize seu Plano de Vida e faça seu Exame de Consciência diário com facilidade.",
                          ),
                          _buildPermissionSlide(context),
                          _buildCloudSyncSlide(context),
                        ],
                      ),
                    ),

                    // Bottom Controls
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          // Back Button
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: _current > 0
                                  ? FilledButton.tonal(
                                      onPressed: () => _controller.previousPage(),
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                        ),
                                      ),
                                      child: const Icon(Icons.arrow_back),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),

                          // Indicators (Center)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(6, (entry) {
                              return GestureDetector(
                                onTap: () => _controller.animateToPage(entry),
                                child: Container(
                                  width: 10.0,
                                  height: 10.0,
                                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (_current == entry ? colorScheme.primary : colorScheme.surfaceContainerHighest)
                                        .withValues(alpha: _current == entry ? 0.9 : 0.4),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Next/Done Button
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: _current == 5
                                  ? FilledButton(
                                      onPressed: () async {
                                        final appProvider = Provider.of<AppProvider>(context, listen: false);
                                        await appProvider.completeOnboarding();
                                        if (context.mounted) {
                                          Navigator.of(context).pushReplacementNamed('/');
                                        }
                                      },
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                        ),
                                      ),
                                      child: const Text("Começar", style: TextStyle(fontWeight: FontWeight.bold)),
                                    )
                                  : FilledButton.tonal(
                                      onPressed: (_current == 4 && !_hasPermission) ? null : () => _controller.nextPage(),
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                        ),
                                      ),
                                      child: const Icon(Icons.arrow_forward),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(
    BuildContext context, {
    String? imagePath,
    IconData? icon,
    required String title,
    required String description,
    bool isFirst = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null)
            Image.asset(imagePath, height: 200)
          else
            Icon(icon, size: 120, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 48),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionSlide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _hasPermission ? Icons.notifications_active : Icons.notifications_none,
            size: 120,
            color: _hasPermission ? Colors.green : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 48),
          Text(
            _hasPermission ? "Notificações Ativadas!" : "Fique Conectado",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Para aproveitar ao máximo o Plano de Vida e os lembretes de oração, precisamos da sua permissão para enviar notificações.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          if (_hasPermission)
            const Icon(Icons.check_circle, color: Colors.green, size: 48)
          else
            FilledButton.tonal(
              onPressed: () async {
                bool? granted = await Notifier.verifyNotificationPermission();
                if (granted == true) {
                  setState(() {
                    _hasPermission = true;
                  });
                }
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              child: const Text("Permitir Notificações"),
            ),
        ],
      ),
    );
  }

  Widget _buildCloudSyncSlide(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentUser = _authService.currentUser;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            currentUser != null ? Icons.cloud_done_rounded : Icons.cloud_sync_rounded,
            size: 100,
            color: currentUser != null ? Colors.green : colorScheme.primary,
          ),
          const SizedBox(height: 32),
          Text(
            currentUser != null ? "Conta Conectada!" : "Backup em Nuvem",
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          Text(
            currentUser != null
                ? "Conectado como:\n${currentUser.email}"
                : "Entre com sua conta Google ou e-mail para salvar e sincronizar seu Plano de Vida e configurações em nuvem.",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          if (currentUser == null) ...[
            FilledButton.tonalIcon(
              onPressed: () => AuthBottomSheet.show(
                context,
                onSuccess: () {
                  setState(() {});
                  _checkCloudBackup();
                },
              ),
              icon: const Icon(Icons.login_rounded),
              label: const Text("Entrar ou Criar Conta"),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Você também pode continuar sem conta e entrar depois pelas Configurações.",
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            if (_cloudBackupInfo != null) ...[
              Text(
                "Encontramos um backup na nuvem para sua conta.",
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _isRestoring ? null : _restoreFromCloud,
                icon: const Icon(Icons.cloud_download_rounded),
                label: _isRestoring
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Restaurar Dados da Nuvem"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ] else if (_backupChecked) ...[
              Text(
                "Nenhum backup anterior encontrado. Seus novos dados serão sincronizados.",
                style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ],
      ),
    );
  }
}

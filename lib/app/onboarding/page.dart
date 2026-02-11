import 'package:coramdeo/app/app_provider.dart';
import 'package:coramdeo/app/backup/service.dart';
import 'package:coramdeo/utils/notification.dart';
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
  int _current = 0;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
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
                decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.primaryContainer.withValues(alpha: 0.3)),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.secondaryContainer.withValues(alpha: 0.3)),
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
                          _buildSlide(context, imagePath: 'assets/images/complete_logo.png', title: "Bem-vindo ao Coram Deo", description: "Seu companheiro diário para uma vida de oração, leitura e crescimento espiritual.", isFirst: true),
                          _buildSlide(context, icon: Icons.auto_stories, title: "Liturgia e Espiritualidade", description: "Acompanhe a Liturgia Diária, Santo do Dia e diversas orações clássicas da Igreja."),
                          _buildSlide(context, icon: Icons.record_voice_over, title: "Bíblia em Áudio", description: "Leia e ouça a Sagrada Escritura em diversas versões, com controle de velocidade e voz."),
                          _buildSlide(context, icon: Icons.checklist, title: "Ferramentas Espirituais", description: "Organize seu Plano de Vida e faça seu Exame de Consciência diário com facilidade."),
                          _buildPermissionSlide(context),
                          _buildBackupSlide(context),
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
                                      style: ButtonStyle(shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
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
                                    color: (_current == entry ? colorScheme.primary : colorScheme.surfaceContainerHighest).withValues(alpha: _current == entry ? 0.9 : 0.4),
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
                                      onPressed: _hasPermission
                                          ? () async {
                                              final appProvider = Provider.of<AppProvider>(context, listen: false);
                                              await appProvider.completeOnboarding();
                                              if (context.mounted) {
                                                Navigator.of(context).pushReplacementNamed('/');
                                              }
                                            }
                                          : null,
                                      style: ButtonStyle(shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
                                      child: const Text("Começar", style: TextStyle(fontWeight: FontWeight.bold)),
                                    )
                                  : FilledButton.tonal(
                                      onPressed: (_current == 4 && !_hasPermission) ? null : () => _controller.nextPage(),
                                      style: ButtonStyle(shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
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

  Widget _buildSlide(BuildContext context, {String? imagePath, IconData? icon, required String title, required String description, bool isFirst = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null) Image.asset(imagePath, height: 200) else Icon(icon, size: 120, color: Theme.of(context).colorScheme.primary),

          const SizedBox(height: 48),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
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
          Icon(_hasPermission ? Icons.notifications_active : Icons.notifications_none, size: 120, color: _hasPermission ? Colors.green : Theme.of(context).colorScheme.primary),
          const SizedBox(height: 48),
          Text(
            _hasPermission ? "Notificações Ativadas!" : "Fique Conectado",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Para aproveitar ao máximo o Plano de Vida e os lembretes de oração, precisamos da sua permissão para enviar notificações.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
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
              style: ButtonStyle(shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
              child: const Text("Permitir Notificações"),
            ),
        ],
      ),
    );
  }

  Widget _buildBackupSlide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.backup, size: 120, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 48),
          Text(
            "Restaurar Dados",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Já utilizava o Coram Deo? Você pode restaurar seus dados de um backup anterior.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          FilledButton.tonal(
            onPressed: () async {
              try {
                bool imported = await BackupService().importBackup();
                if (imported && context.mounted) {
                  // Reload app state (theme, preferences)
                  await Provider.of<AppProvider>(context, listen: false).reload();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Dados restaurados com sucesso!', style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao restaurar: $e', style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                }
              }
            },
            style: ButtonStyle(shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
            child: const Text("Restaurar Backup"),
          ),
        ],
      ),
    );
  }
}

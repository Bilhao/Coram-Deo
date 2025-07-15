import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coramdeo/app/biblia/provider.dart';
import 'package:coramdeo/utils/audio_service.dart';

class AudioControls extends StatelessWidget {
  const AudioControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BibleProvider>(
      builder: (context, provider, child) {
        if (!provider.currentVersionInfo.hasAudio) {
          return const SizedBox.shrink();
        }

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Áudio da Bíblia',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () => _showAudioSettings(context, provider),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AnimatedBuilder(
                  animation: provider.audioService,
                  builder: (context, child) {
                    return Column(
                      children: [
                        // Progress slider
                        if (provider.audioService.duration.inSeconds > 0)
                          Slider(
                            value: provider.audioService.position.inSeconds.toDouble(),
                            min: 0,
                            max: provider.audioService.duration.inSeconds.toDouble(),
                            onChanged: (value) {
                              provider.audioService.seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        
                        // Time display
                        if (provider.audioService.duration.inSeconds > 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(provider.audioService.formatDuration(provider.audioService.position)),
                              Text(provider.audioService.formatDuration(provider.audioService.duration)),
                            ],
                          ),
                        
                        const SizedBox(height: 8),
                        
                        // Control buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.skip_previous),
                              onPressed: () => provider.goToPreviousChapter(),
                            ),
                            const SizedBox(width: 8),
                            if (provider.audioService.isLoading)
                              const CircularProgressIndicator()
                            else
                              IconButton(
                                icon: Icon(
                                  provider.audioService.isPlaying 
                                      ? Icons.pause_circle_filled 
                                      : Icons.play_circle_filled,
                                ),
                                iconSize: 48,
                                onPressed: () {
                                  if (provider.audioService.isPlaying) {
                                    provider.pauseAudio();
                                  } else if (provider.audioService.state == AudioState.paused) {
                                    provider.resumeAudio();
                                  } else {
                                    provider.playChapterAudio();
                                  }
                                },
                              ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.stop),
                              onPressed: () => provider.stopAudio(),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.skip_next),
                              onPressed: () => provider.goToNextChapter(),
                            ),
                          ],
                        ),
                        
                        // Error message
                        if (provider.audioService.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              provider.audioService.errorMessage,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAudioSettings(BuildContext context, BibleProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configurações de Áudio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Áudio habilitado'),
              subtitle: const Text('Ativar controles de áudio'),
              value: provider.audioEnabled,
              onChanged: (value) => provider.toggleAudioEnabled(),
            ),
            SwitchListTile(
              title: const Text('Reprodução automática'),
              subtitle: const Text('Reproduzir automaticamente ao trocar de capítulo'),
              value: provider.autoPlay,
              onChanged: (value) => provider.toggleAutoPlay(),
            ),
            const SizedBox(height: 16),
            Text('Velocidade de reprodução: ${provider.playbackSpeed.toStringAsFixed(1)}x'),
            Slider(
              value: provider.playbackSpeed,
              min: 0.5,
              max: 2.0,
              divisions: 6,
              label: '${provider.playbackSpeed.toStringAsFixed(1)}x',
              onChanged: (value) => provider.setPlaybackSpeed(value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}

class SimpleAudioButton extends StatelessWidget {
  const SimpleAudioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BibleProvider>(
      builder: (context, provider, child) {
        if (!provider.currentVersionInfo.hasAudio || !provider.audioEnabled) {
          return const SizedBox.shrink();
        }

        return AnimatedBuilder(
          animation: provider.audioService,
          builder: (context, child) {
            return IconButton(
              icon: Icon(
                provider.audioService.isPlaying 
                    ? Icons.pause_circle_outlined 
                    : provider.audioService.isLoading
                        ? Icons.hourglass_empty
                        : Icons.play_circle_outlined,
              ),
              tooltip: provider.audioService.isPlaying 
                  ? 'Pausar áudio' 
                  : 'Reproduzir áudio do capítulo',
              onPressed: provider.audioService.isLoading ? null : () {
                if (provider.audioService.isPlaying) {
                  provider.pauseAudio();
                } else if (provider.audioService.state == AudioState.paused) {
                  provider.resumeAudio();
                } else {
                  provider.playChapterAudio();
                }
              },
            );
          },
        );
      },
    );
  }
}
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

enum AudioState {
  stopped,
  loading,
  playing,
  paused,
  error,
}

class AudioService extends ChangeNotifier {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  AudioState _state = AudioState.stopped;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _speed = 1.0;
  String? _currentUrl;
  String _errorMessage = '';

  // Getters
  AudioState get state => _state;
  Duration get duration => _duration;
  Duration get position => _position;
  double get speed => _speed;
  String? get currentUrl => _currentUrl;
  String get errorMessage => _errorMessage;
  bool get isPlaying => _state == AudioState.playing;
  bool get isLoading => _state == AudioState.loading;
  bool get hasError => _state == AudioState.error;

  AudioService() {
    _initializePlayer();
  }

  void _initializePlayer() {
    _player.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      notifyListeners();
    });

    _player.positionStream.listen((position) {
      _position = position;
      notifyListeners();
    });

    _player.playerStateStream.listen((playerState) {
      switch (playerState.processingState) {
        case ProcessingState.idle:
          _state = AudioState.stopped;
          break;
        case ProcessingState.loading:
        case ProcessingState.buffering:
          _state = AudioState.loading;
          break;
        case ProcessingState.ready:
          _state = playerState.playing ? AudioState.playing : AudioState.paused;
          break;
        case ProcessingState.completed:
          _state = AudioState.stopped;
          _position = Duration.zero;
          break;
      }
      notifyListeners();
    });
  }

  Future<void> playUrl(String url) async {
    try {
      if (_currentUrl == url && _state == AudioState.paused) {
        await resume();
        return;
      }

      _state = AudioState.loading;
      _errorMessage = '';
      _currentUrl = url;
      notifyListeners();

      await _player.setUrl(url);
      await _player.setSpeed(_speed);
      await _player.play();
    } catch (e) {
      _state = AudioState.error;
      _errorMessage = 'Erro ao carregar áudio: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.play();
  }

  Future<void> stop() async {
    await _player.stop();
    _currentUrl = null;
    _position = Duration.zero;
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Future<void> setSpeed(double speed) async {
    _speed = speed;
    await _player.setSpeed(speed);
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
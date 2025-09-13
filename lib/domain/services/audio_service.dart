import 'dart:async';

import 'package:audio_session/audio_session.dart' show AudioSession, AudioSessionConfiguration;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_audio/just_audio.dart' show AudioPlayer, AudioSource, LoopMode;

class AppAudioService {
  AppAudioService(this._player);
  final AudioPlayer _player;

  Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  Future<void> playUrl(String url) async {
    await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    await _player.setVolume(0.0);
    await _player.play();
    _fadeIn(duration: 2.seconds);
  }

  Future<void> playAsset(String asset, {bool loop = false}) async {
    await _player.setAudioSource(AudioSource.asset('assets/audio/$asset'));
    _player.setLoopMode(loop ? LoopMode.one : LoopMode.off);
    await _fadeIn(duration: 2.seconds, targetVolume: .6);
  }

  Future<void> pause() async {
    await _fadeOut(duration: 800.ms);
  }

  Future<void> _fadeIn({
    Duration duration = const Duration(seconds: 3),
    double targetVolume = 1.0,
    int steps = 50,
  }) async {
    // Start playing at volume 0
    await _player.setVolume(0.0);
    if (!_player.playing) {
      _player.play();
    }

    // Calculate step values
    final stepDuration = duration.inMilliseconds / steps;
    final volumeStep = targetVolume / steps;

    // Gradually increase volume
    for (int i = 1; i <= steps; i++) {
      final volume = (volumeStep * i).clamp(0.0, 1.0);
      await _player.setVolume(volume);
      await Future.delayed(Duration(milliseconds: stepDuration.round()));
    }
  }

  Future<void> _fadeOut({
    Duration duration = const Duration(seconds: 3),
    int steps = 50,
    bool pauseAfterFade = true,
  }) async {
    final currentVolume = _player.volume;

    // Calculate step values
    final stepDuration = duration.inMilliseconds / steps;
    final volumeStep = currentVolume / steps;

    // Gradually decrease volume
    for (int i = 1; i <= steps; i++) {
      final volume = (currentVolume - (volumeStep * i)).clamp(0.0, 1.0);
      await _player.setVolume(volume);
      await Future.delayed(Duration(milliseconds: stepDuration.round()));
    }

    if (pauseAfterFade) {
      await _player.pause();
    }
  }

  void dispose() {
    _player.dispose();
  }
}

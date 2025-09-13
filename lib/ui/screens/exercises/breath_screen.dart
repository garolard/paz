import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:paz/domain/services/audio_service.dart';
import 'package:paz/ui/widgets/breath_pulse.dart';
import 'package:watch_it/watch_it.dart';

class BreathScreen extends StatefulWidget {
  const BreathScreen({super.key});

  @override
  State<BreathScreen> createState() => _BreathScreenState();
}

class _BreathScreenState extends State<BreathScreen> {
  late final audio = di<AppAudioService>();

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  @override
  void dispose() {
    pauseAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: AnimatedMeshGradient(
        colors: [
          const Color(0xff506da0),
          const Color(0xffa2d6db),
          const Color(0xfff9f9ff),
          const Color(0xffe7d0f5),
        ],
        options: AnimatedMeshGradientOptions(),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 84.0),
                  child:
                      Text(
                            'Respira \n4 segundos',
                            style: textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          )
                          .animate(delay: 1.seconds, onPlay: (c) => c.repeat())
                          .fadeIn(duration: 600.ms)
                          .then(delay: 4.seconds)
                          .swap(
                            builder: (_, _) => Text(
                              'Mantén \n7 segundos',
                              style: textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ).animate().fadeIn(duration: 1.seconds),
                          )
                          .then(delay: 6.seconds)
                          .swap(
                            builder: (_, _) => Text(
                              'Exhala \n8 segundos',
                              style: textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ).animate().fadeIn(duration: 1.seconds),
                          )
                          .fade(duration: 8.seconds, begin: 1.0, end: 1.0),
                ),
              ),
              const Center(child: BreathPulse()),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Finalizar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initAudio() async {
    await audio.playAsset('meditation-music-322801.mp3', loop: true);
  }

  Future<void> pauseAudio() async {
    await audio.pause();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:paz/domain/services/audio_service.dart';
import 'package:paz/ui/navigation/custom_page_route.dart';
import 'package:paz/ui/screens/home/home_screen.dart';
import 'package:paz/ui/utils/color_extensions.dart';
import 'package:watch_it/watch_it.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late final audio = di<AppAudioService>();
  late final dismissController = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  @override
  void dispose() {
    pauseAudio();
    dismissController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

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
                alignment: Alignment.center,
                child:
                    Text(
                          'Paz',
                          style: textTheme.displayLarge!.copyWith(
                            letterSpacing: 12,
                            color: colorTheme.onPrimary,
                            shadows: [
                              Shadow(
                                color: colorTheme.surfaceTint.withOpacity2(.5),
                                offset: const Offset(0, 5),
                                blurRadius: 24,
                              ),
                              Shadow(
                                color: colorTheme.primary.withOpacity2(.35),
                                offset: const Offset(0, 7),
                                blurRadius: 48,
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 2.seconds)
                        .blur(begin: const Offset(2.0, 2.0), end: const Offset(0, 0))
                        .then(delay: 1.seconds)
                        .slideY(end: -3.0, curve: Curves.easeInOutCubic),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 48),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:
                      ElevatedButton(
                            onPressed: navigateToHome,
                            child: const Row(
                              spacing: 24,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Relájate...'), Icon(Icons.arrow_forward)],
                            ),
                          )
                          .animate(delay: 4500.ms)
                          .fadeIn(duration: 1500.ms)
                          .animate(controller: dismissController, autoPlay: false)
                          .fadeOut(duration: 300.ms)
                          .blur(begin: const Offset(0, 0), end: const Offset(2.0, 2.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initAudio() async {
    await audio.init();
    await audio.playAsset('uplifting-pad-texture-113842.mp3');
  }

  Future<void> pauseAudio() async {
    await audio.pause();
  }

  Future<void> navigateToHome() async {
    audio.playSoundEffect('water-drop.mp3');
    dismissController.addListener(() async {
      if (dismissController.isCompleted && context.mounted) {
        Navigator.of(context).pushReplacement(CustomPageRoute(const HomeScreen()));
      }
    });
    dismissController.forward();
    await pauseAudio();
  }
}

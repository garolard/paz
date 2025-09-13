import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:paz/ui/utils/color_extensions.dart';

class BreathPulse extends StatefulWidget {
  const BreathPulse({
    super.key,
    this.period = const Duration(seconds: 8),
    this.inhaleDuration = const Duration(seconds: 4),
    this.retainDuration = const Duration(seconds: 7),
    this.exhaleDuration = const Duration(seconds: 8),
  });
  final Duration period;
  final Duration inhaleDuration;
  final Duration retainDuration;
  final Duration exhaleDuration;

  @override
  State<BreathPulse> createState() => _BreathPulseState();
}

class _BreathPulseState extends State<BreathPulse> {
  @override
  Widget build(BuildContext context) {
    return Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // Colores calmados; usa opacidades
            gradient: RadialGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity2(.25),
                Theme.of(context).colorScheme.primary.withOpacity2(.10),
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 40,
                spreadRadius: 15,
                color: Theme.of(context).colorScheme.primary.withOpacity2(.25),
              ),
            ],
          ),
        )
        .animate(
          delay: 2.seconds,
          onComplete: (controller) => controller.repeat(),
        )
        .scaleXY(
          duration: widget.inhaleDuration,
          begin: .45,
          end: 1.0,
          curve: Curves.easeInOutCubic,
        )
        .saturate(begin: .45, end: 1.0)
        .then(delay: widget.retainDuration)
        .scaleXY(
          duration: widget.exhaleDuration,
          end: .45,
          curve: Curves.easeInOutSine,
        )
        .desaturate(begin: 1.0, end: .45);
  }
}

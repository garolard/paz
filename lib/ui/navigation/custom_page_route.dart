import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute(this.child);

  @override
  Color? get barrierColor => const Color(0xff133665);

  @override
  String? get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => 600.ms;
}

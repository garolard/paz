import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  Color withOpacity2(double opacity) => withAlpha((255 * opacity).toInt());
}

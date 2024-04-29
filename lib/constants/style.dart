import 'package:flutter/material.dart';

class AppColors {
  static Color light = _convert('FF6200EE');
  static Color dark = _convert('0b151d');
  static Color primary = _convert('703410');
  static Color secondary = _convert('fce5c3');
  static Color accent1 = _convert('c8d8e5');
  static Color accent2 = _convert('dacee6');
  static Color heading = _convert('3d3b3b');
  static Color body = _convert('868484');

  /// Converts a hex color string to a Color object.
  static Color _convert(String colorString) {
    if (colorString.startsWith("#")) colorString = colorString.substring(1);
    final color = int.parse(colorString, radix: 16);
    return Color(color);
  }
}

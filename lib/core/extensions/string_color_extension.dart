import 'package:flutter/material.dart';

extension StringColorExtension on String {
  Color toColor() {
    int hash = 0;

    // Create a simple hash from the string
    for (int i = 0; i < length; i++) {
      hash = codeUnitAt(i) + ((hash << 5) - hash);
    }

    // Use the hash to generate an RGB color
    final int red = (hash & 0xFF0000) >> 16;
    final int green = (hash & 0x00FF00) >> 8;
    final int blue = hash & 0x0000FF;

    return Color.fromRGBO(red, green, blue, 1.0);
  }
}

extension ColorContrastExtension on Color {
  Color fontColor() {
    // Calculate the brightness (luminance) of the color
    double brightness = (299 * red + 587 * green + 114 * blue) / 1000;

    // Return white for dark backgrounds, black for light backgrounds
    return brightness > 128 ? Colors.black : Colors.white;
  }
}

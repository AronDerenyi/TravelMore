import 'package:flutter/material.dart';

class AppColors {
  static ColorScheme get colorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.green,
        secondary: Colors.brown,
        error: Colors.red,
        background: Color.fromARGB(255, 240, 240, 240),
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
      );
}

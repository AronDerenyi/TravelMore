import 'package:flutter/material.dart';

class AppColors {
  static ColorScheme get colorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 75, 139, 59),
        secondary: Colors.brown,
        error: Colors.red,
        background: Color.fromARGB(255, 250, 250, 250),
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
        onSurfaceVariant: Color.fromARGB(255, 95, 95, 95),
      );
}

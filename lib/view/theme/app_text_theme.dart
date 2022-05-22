import 'package:flutter/material.dart';
import 'package:travel_more/view/theme/app_colors.dart';

class AppTextTheme {
  static TextTheme get theme => const TextTheme(
        displayLarge: TextStyle(fontWeight: FontWeight.w500),
        displayMedium: TextStyle(fontWeight: FontWeight.w500),
        displaySmall: TextStyle(fontWeight: FontWeight.w500),
        headlineLarge: TextStyle(fontWeight: FontWeight.w500),
        headlineMedium: TextStyle(fontWeight: FontWeight.w500),
        headlineSmall: TextStyle(fontWeight: FontWeight.w500),
        titleLarge: TextStyle(fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        labelLarge: TextStyle(),
        labelMedium: TextStyle(),
        labelSmall: TextStyle(),
      ).apply(
        displayColor: AppColors.colorScheme.onSurface,
        bodyColor: AppColors.colorScheme.onSurface,
      );

  static TextTheme get primaryTheme => theme.apply(
        displayColor: AppColors.colorScheme.onPrimary,
        bodyColor: AppColors.colorScheme.onPrimary,
      );
}

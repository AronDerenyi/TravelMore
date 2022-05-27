import 'package:flutter/material.dart';
import 'package:travel_more/view/theme/app_colors.dart';

class AppTextTheme {
  static TextTheme get theme => const TextTheme()
      .merge(const TextTheme(
        headlineLarge: TextStyle(fontWeight: FontWeight.w500),
        headlineMedium: TextStyle(fontWeight: FontWeight.w500),
        headlineSmall: TextStyle(fontWeight: FontWeight.w500),
      ))
      .merge(const TextTheme(
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
      ))
      .merge(const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
      ))
      .apply(
        displayColor: AppColors.colorScheme.onSurface,
        bodyColor: AppColors.colorScheme.onSurface,
      )
      .merge(const TextTheme(
        labelLarge: TextStyle(),
        labelMedium: TextStyle(),
        labelSmall: TextStyle(),
      ).apply(
        displayColor: AppColors.colorScheme.onSurfaceVariant,
        bodyColor: AppColors.colorScheme.onSurfaceVariant,
      ));

  static TextTheme get primaryTheme => theme.apply(
        displayColor: AppColors.colorScheme.onPrimary,
        bodyColor: AppColors.colorScheme.onPrimary,
      );
}

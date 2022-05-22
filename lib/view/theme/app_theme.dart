import 'package:flutter/material.dart';
import 'package:travel_more/view/theme/app_colors.dart';
import 'package:travel_more/view/theme/app_text_theme.dart';

class AppTheme {
  static ThemeData get data =>
      ThemeData.from(colorScheme: AppColors.colorScheme).copyWith(
        textTheme: AppTextTheme.theme,
        primaryTextTheme: AppTextTheme.primaryTheme,
      );
}

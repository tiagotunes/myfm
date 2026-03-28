import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';

class AppTextTheme {
  static const defaultFont = 'Roboto';

  static const textTheme = TextTheme(
    // Headline XL (Upper)
    headlineLarge: TextStyle(
      fontFamily: 'Roboto Condensed',
      fontWeight: FontWeight.w900,
      fontSize: 80,
      height: 0.95,
      color: AppColors.white,
    ),

    // Subhead L
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: 30,
      height: 1.1,
      color: AppColors.cloud,
    ),

    // Body M
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.125,
      color: AppColors.white,
    ),
    // Body S
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.142,
      color: AppColors.white,
    ),

    // Label
    labelMedium: TextStyle( 
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 1.142,
    ),

    // Caption
    labelSmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.166,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';
import 'package:my_fm/core/configs/theme/app_text_theme.dart';

class AppTheme {
  static final appDarkTheme = ThemeData(
    fontFamily: AppTextTheme.defaultFont,
    textTheme: AppTextTheme.textTheme,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.dark,

    snackBarTheme: const SnackBarThemeData(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      contentTextStyle: TextStyle(color: Colors.white),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white.withValues(alpha: 0.05),
      contentPadding: AppSizes.inputPadding,
      border: OutlineInputBorder(
        borderRadius: AppSizes.inputBorderRadius,
        borderSide: BorderSide(
          color: AppColors.white.withValues(alpha: 0.1),
          width: AppSizes.inputBorderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppSizes.inputBorderRadius,
        borderSide: BorderSide(
          color: AppColors.white.withValues(alpha: 0.1),
          width: AppSizes.inputBorderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSizes.inputBorderRadius,
        borderSide: BorderSide(
          color: AppColors.white.withValues(alpha: 0.2),
          width: AppSizes.inputBorderWidthFocused,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary,
        fixedSize: AppSizes.buttonSize,
        elevation: 0,
        foregroundColor: AppColors.white,
        textStyle: AppTextTheme.textTheme.labelMedium,
        shape: RoundedRectangleBorder(
          borderRadius: AppSizes.buttonBorderRadius,
        ),
      ),
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      circularTrackColor: AppColors.air.withValues(alpha: 0.2),
      color: AppColors.air,
      strokeWidth: AppSizes.progressIndStrokeWidth,
      constraints: AppSizes.progressIndConstraints,
    ),
  );
}

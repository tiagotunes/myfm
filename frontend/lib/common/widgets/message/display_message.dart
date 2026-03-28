import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';

class DisplayMessage {
  static void errorMessage(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.cancel_rounded, color: AppColors.highlightRed),
          AppSizes.spaceBtwIconText,
          Text(message),
        ],
      ),
      backgroundColor: AppColors.highlightRed.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: AppSizes.snackbarBorderRadius,
        side: const BorderSide(
          color: AppColors.highlightRed,
          width: AppSizes.snackbarBorderWidth,
        ),
      ),
      margin: AppSizes.snackBarConstraints,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void successMessage(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: AppColors.cloud),
          AppSizes.spaceBtwIconText,
          Text(message),
        ],
      ),
      backgroundColor: AppColors.cloud.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: AppSizes.snackbarBorderRadius,
        side: const BorderSide(
          color: AppColors.cloud,
          width: AppSizes.snackbarBorderWidth,
        ),
      ),
      margin: AppSizes.snackBarConstraints,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/assets/app_images.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.splashBackground),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.background.withValues(alpha: 0),
                  AppColors.background,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';

class DefaultCenter extends StatelessWidget {
  final IconData icon;
  final String message;
  const DefaultCenter({super.key, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.white.withValues(alpha: 0.25)),
          const SizedBox(height: 12),
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.white.withValues(alpha: 0.25),
            ),
          ),
        ],
      ),
    );
  }
}

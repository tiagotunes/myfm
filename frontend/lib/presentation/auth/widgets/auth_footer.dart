import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  const AuthFooter({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
        color: AppColors.white.withValues(alpha: 0.5),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';

class AuthSwitchText extends StatelessWidget {
  final String question;
  final String actionText;
  final VoidCallback onTap;

  const AuthSwitchText({
    super.key,
    required this.question,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: question,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.cloud.withValues(alpha: 0.7),
            ),
          ),
          TextSpan(
            text: actionText,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.cloud,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

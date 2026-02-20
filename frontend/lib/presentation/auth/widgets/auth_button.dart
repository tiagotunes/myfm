import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:reactive_button/reactive_button.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final Future<void> Function() onPressed;
  final VoidCallback onSuccess;
  final Function(dynamic) onFailure;

  const AuthButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveButton(
      title: title,
      activeColor: AppColors.primary,
      onPressed: onPressed,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );
  }
}

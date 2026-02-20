import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
          TextSpan(text: question),
          TextSpan(
            text: actionText,
            style: const TextStyle(
              color: Color(0xFFAF78FF),
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

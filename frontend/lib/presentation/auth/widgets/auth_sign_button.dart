import 'package:flutter/material.dart';
import 'package:my_fm/common/widgets/button/basic_button.dart';

class AuthSignButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AuthSignButton({
    super.key,
    required this.title,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return BasicButton(
      title: title,
      onPressed: onPressed,
    );
  }
}

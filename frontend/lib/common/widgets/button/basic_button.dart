import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;

  const BasicButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(title.toUpperCase()),
      onPressed: onPressed,
    );
  }
}

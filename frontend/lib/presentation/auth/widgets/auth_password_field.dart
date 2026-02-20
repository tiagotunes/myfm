import 'package:flutter/material.dart';

class AuthPasswordField extends StatelessWidget {
  final TextEditingController controller;

  const AuthPasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }
}

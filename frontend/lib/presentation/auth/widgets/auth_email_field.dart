import 'package:flutter/material.dart';

class AuthEmailField extends StatelessWidget {
  final TextEditingController controller;

  const AuthEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }
}

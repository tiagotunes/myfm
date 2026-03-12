import 'package:flutter/material.dart';

class AuthNameField extends StatelessWidget {
  final TextEditingController controller;

  const AuthNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(hintText: 'Name'),
    );
  }
}

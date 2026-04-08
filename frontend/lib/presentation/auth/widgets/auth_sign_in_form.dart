import 'package:flutter/material.dart';
import 'package:my_fm/common/widgets/input/input_text.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';

class AuthSignInForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthSignInForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputText(
          label: 'email',
          controller: emailController,
          inputType: TextInputType.emailAddress,
        ),

        AppSizes.spaceBtwInputs,

        InputText(
          label: 'password',
          controller: passwordController,
          obscureText: true,
        ),
      ],
    );
  }
}

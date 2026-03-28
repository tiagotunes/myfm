import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_fm/common/widgets/input/input_text.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';

class AuthSignUpForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;

  const AuthSignUpForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
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
    
        AppSizes.spaceBtwInputs,
    
        InputText(
          label: 'confirm password',
          controller: confirmPasswordController,
          obscureText: true,
        ),
    
        AppSizes.spaceBtwInputs,
    
        InputText(
          label: 'name',
          controller: nameController,
          inputType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

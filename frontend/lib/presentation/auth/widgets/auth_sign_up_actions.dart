import 'package:flutter/material.dart';
import 'package:my_fm/common/widgets/message/display_message.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';
import 'package:my_fm/data/auth/models/sign_up_params.dart';
import 'package:my_fm/domain/auth/usecases/sign_up_uc.dart';
import 'package:my_fm/presentation/auth/pages/sign_in.dart';
import 'package:my_fm/presentation/auth/widgets/auth_sign_button.dart';
import 'package:my_fm/presentation/auth/widgets/auth_switch_text.dart';
import 'package:my_fm/service_locator.dart';

class AuthSignUpActions extends StatelessWidget {
  final List<TextEditingController> controllers;

  const AuthSignUpActions({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthSignButton(
          title: 'create account',
          useCase: sl<SignUpUseCase>(),
          params: () => SignUpParams(
            email: controllers[0].text,
            password: controllers[1].text,
            confirmPassword: controllers[2].text,
            name: controllers[3].text,
          ),
          onSuccess: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => SignInPage()),
            );
            DisplayMessage.successMessage(
              context,
              "Account created successfully.",
            );
          },
        ),

        AppSizes.spaceBtwActions,

        AuthSwitchText(
          question: 'Already have an account? ',
          actionText: 'Sign In',
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

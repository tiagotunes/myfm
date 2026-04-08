import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/auth/auth_cubit.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';
import 'package:my_fm/domain/auth/usecases/sign_in_uc.dart';
import 'package:my_fm/presentation/auth/pages/sign_up.dart';
import 'package:my_fm/presentation/auth/widgets/auth_sign_button.dart';
import 'package:my_fm/presentation/auth/widgets/auth_switch_text.dart';
import 'package:my_fm/service_locator.dart';

class AuthSignInActions extends StatelessWidget {
  final List<TextEditingController> controllers;

  const AuthSignInActions({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthSignButton(
          title: 'continue',
          useCase: sl<SignInUseCase>(),
          params: () => SignInRequest(
            email: controllers[0].text,
            password: controllers[1].text,
          ),
          onSuccess: () {
            context.read<AuthCubit>().appStarted();
          },
        ),

        AppSizes.spaceBtwActions,

        AuthSwitchText(
          question: 'Forgot password?',
          actionText: '',
          onTap: () {},
        ),

        AppSizes.spaceBtwSecondaryActions,

        AuthSwitchText(
          question: '',
          actionText: 'Create account',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SignUpPage()),
          ),
        ),
      ],
    );
  }
}

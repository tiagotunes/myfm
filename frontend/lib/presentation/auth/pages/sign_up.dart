import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/button/button_cubit.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';
import 'package:my_fm/presentation/auth/widgets/auth_footer.dart';
import 'package:my_fm/presentation/auth/widgets/auth_header.dart';
import 'package:my_fm/presentation/auth/widgets/auth_sign_up_actions.dart';
import 'package:my_fm/presentation/auth/widgets/auth_sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: SafeArea(
          minimum: AppSizes.safeAreaConstraints,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: AppSizes.scsvConstraints,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthHeader(
                        headline: 'create account',
                        title: 'Start managing your team beyond the game.',
                      ),

                      AppSizes.spaceBtwHeaderForm,

                      AuthSignUpForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        nameController: _nameController,
                      ),

                      AppSizes.spaceBtwFormActions,

                      AuthSignUpActions(
                        controllers: [
                          _emailController,
                          _passwordController,
                          _confirmPasswordController,
                          _nameController,
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const AuthFooter(
                text:
                    'By continuing, you agree to our Terms and Privacy Policy.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

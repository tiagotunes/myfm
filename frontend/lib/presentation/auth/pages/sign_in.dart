import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';
import 'package:my_fm/presentation/auth/widgets/auth_footer.dart';
import 'package:my_fm/presentation/auth/widgets/auth_header.dart';
import 'package:my_fm/presentation/auth/widgets/auth_sign_in_actions.dart';
import 'package:my_fm/presentation/auth/widgets/auth_sign_in_form.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        minimum: AppSizes.safeAreaConstraints.copyWith(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppSizes.scsvConstraints,
                child: Column(
                  children: [
                    const AuthHeader(
                      headline: 'take control',
                      title:
                          'Manage your team anytime. Stay in control beyond the game.',
                    ),
              
                    AppSizes.spaceBtwHeaderForm,
              
                    AuthSignInForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
              
                    AppSizes.spaceBtwFormActions,
              
                    AuthSignInActions(
                      controllers: [_emailController, _passwordController],
                    ),
                  ],
                ),
              ),
            ),

            const AuthFooter(
              text: 'Not affiliated with Football Manager. Built for fans.',
            ),
          ],
        ),
      ),
    );
  }
}

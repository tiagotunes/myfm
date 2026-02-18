import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_fm/common/helper/navigation/app_navigation.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/presentation/auth/pages/sign_up.dart';
import 'package:reactive_button/reactive_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signInText(),
            const SizedBox(height: 30),
            _emailField(),
            const SizedBox(height: 20),
            _passwordField(),
            const SizedBox(height: 60),
            _signInButton(),
            const SizedBox(height: 20),
            _signUpText(context),
          ],
        ),
      ),
    );
  }

  Widget _signInText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _emailField() {
    return const TextField(decoration: InputDecoration(hintText: 'Email'));
  }

  Widget _passwordField() {
    return const TextField(decoration: InputDecoration(hintText: 'Password'));
  }

  Widget _signInButton() {
    return ReactiveButton(
      title: 'Sign In',
      activeColor: AppColors.primary,
      onPressed: () async {},
      onSuccess: () {},
      onFailure: (error) {},
    );
  }

  Widget _signUpText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: 'Don\'t have an account? '),
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
              color: Color(0xFFAF78FF),
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigation.push(context, const SignUpPage());
              },
          ),
        ],
      ),
    );
  }
}

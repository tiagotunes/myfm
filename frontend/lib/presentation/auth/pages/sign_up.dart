import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_fm/common/helper/navigation/app_navigation.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/presentation/auth/pages/sign_in.dart';
import 'package:reactive_button/reactive_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signUpText(),
            const SizedBox(height: 30),
            _emailField(),
            const SizedBox(height: 20),
            _passwordField(),
            const SizedBox(height: 60),
            _signUpButton(),
            const SizedBox(height: 20),
            _signInText(context),
          ],
        ),
      ),
    );
  }

  Widget _signUpText() {
    return const Text(
      'Sign Up',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _emailField() {
    return const TextField(decoration: InputDecoration(hintText: 'Email'));
  }

  Widget _passwordField() {
    return const TextField(decoration: InputDecoration(hintText: 'Password'));
  }

  Widget _signUpButton() {
    return ReactiveButton(
      title: 'Sign Up',
      activeColor: AppColors.primary,
      onPressed: () async {},
      onSuccess: () {},
      onFailure: (error) {},
    );
  }

  Widget _signInText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: 'Already have an account? '),
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
              color: Color(0xFFAF78FF),
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigation.push(context, SignInPage());
              },
          ),
        ],
      ),
    );
  }
}

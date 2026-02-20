import 'package:flutter/material.dart';
import 'package:my_fm/common/helper/navigation/app_navigation.dart';
import 'package:my_fm/presentation/auth/pages/sign_in.dart';
import 'package:my_fm/presentation/auth/widgets/auth_button.dart';
import 'package:my_fm/presentation/auth/widgets/auth_email_field.dart';
import 'package:my_fm/presentation/auth/widgets/auth_password_field.dart';
import 'package:my_fm/presentation/auth/widgets/auth_switch_text.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            AuthEmailField(controller: _emailController),
            const SizedBox(height: 20),
            AuthPasswordField(controller: _passwordController),
            const SizedBox(height: 60),
            AuthButton(
              title: 'Sign Up',
              onPressed: () async {},
              onSuccess: () {},
              onFailure: (error) {},
            ),
            const SizedBox(height: 20),
            AuthSwitchText(
              question: 'Already have an account? ',
              actionText: 'Sign In',
              onTap: () => AppNavigation.push(context, SignInPage()),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_fm/common/helper/message/display_message.dart';
import 'package:my_fm/common/helper/navigation/app_navigation.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';
import 'package:my_fm/domain/auth/usecases/sign_in_uc.dart';
import 'package:my_fm/presentation/auth/pages/sign_up.dart';
import 'package:my_fm/presentation/auth/widgets/auth_button.dart';
import 'package:my_fm/presentation/auth/widgets/auth_email_field.dart';
import 'package:my_fm/presentation/auth/widgets/auth_password_field.dart';
import 'package:my_fm/presentation/auth/widgets/auth_switch_text.dart';
import 'package:my_fm/presentation/home/pages/home.dart';
import 'package:my_fm/service_locator.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

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
              'Sign In',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            AuthEmailField(controller: _emailController),
            const SizedBox(height: 20),
            AuthPasswordField(controller: _passwordController),
            const SizedBox(height: 60),
            AuthButton(
              title: 'Sign In',
              onPressed: () async => await sl<SignInUseCase>().call(
                params: SignInRequest(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              ),
              onSuccess: () =>
                  AppNavigation.pushAndRemoveUntil(context, const HomePage()),
              onFailure: (error) => DisplayMessage.errorMessage(context, error),
            ),
            const SizedBox(height: 20),
            AuthSwitchText(
              question: 'Don\'t have an account? ',
              actionText: 'Sign Up',
              onTap: () => AppNavigation.push(context, SignUpPage()),
            ),
          ],
        ),
      ),
    );
  }
}

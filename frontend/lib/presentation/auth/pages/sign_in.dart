import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/auth/auth_cubit.dart';
import 'package:my_fm/common/widgets/button/bloc_button.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';
import 'package:my_fm/domain/auth/usecases/sign_in_uc.dart';
import 'package:my_fm/presentation/auth/pages/sign_up.dart';
import 'package:my_fm/presentation/auth/widgets/auth_email_field.dart';
import 'package:my_fm/presentation/auth/widgets/auth_password_field.dart';
import 'package:my_fm/presentation/auth/widgets/auth_switch_text.dart';
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

            BlocButton(
              title: 'Sign In',
              useCase: sl<SignInUseCase>(),
              params: () => SignInRequest(
                email: _emailController.text,
                password: _passwordController.text,
              ),
              onSuccess: () {
                context.read<AuthCubit>().appStarted();
              },
            ),

            const SizedBox(height: 20),
            AuthSwitchText(
              question: 'Don\'t have an account? ',
              actionText: 'Sign Up',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SignUpPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

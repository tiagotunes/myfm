import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/button/button_state.dart';
import 'package:my_fm/common/bloc/button/button_cubit.dart';
import 'package:my_fm/common/widgets/button/bloc_button.dart';
import 'package:my_fm/common/widgets/message/display_message.dart';
import 'package:my_fm/data/auth/models/sign_up_request.dart';
import 'package:my_fm/domain/auth/usecases/sign_up_uc.dart';
import 'package:my_fm/presentation/auth/pages/sign_in.dart';
import 'package:my_fm/presentation/auth/widgets/auth_email_field.dart';
import 'package:my_fm/presentation/auth/widgets/auth_name_field.dart';
import 'package:my_fm/presentation/auth/widgets/auth_password_field.dart';
import 'package:my_fm/presentation/auth/widgets/auth_switch_text.dart';
import 'package:my_fm/service_locator.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SignInPage()),
              );
              DisplayMessage.infoMessage(context, 'VERIFY_EMAIL');
            }
            if (state is ButtonFailureState) {
              DisplayMessage.errorMessage(context, state.errorMessage);
            }
          },
          child: SafeArea(
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
                const SizedBox(height: 20),
                AuthNameField(controller: _nameController),
                const SizedBox(height: 60),
                BlocButton(
                  title: 'Sign Up',
                  useCase: sl<SignUpUseCase>(),
                  params: () => SignUpRequest(
                    email: _emailController.text,
                    password: _passwordController.text,
                    name: _nameController.text,
                  ),
                  onSuccess: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SignInPage()),
                    );
                    DisplayMessage.infoMessage(context, "VERIFY_EMAIL");
                  },
                ),
                const SizedBox(height: 20),
                AuthSwitchText(
                  question: 'Already have an account? ',
                  actionText: 'Sign In',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

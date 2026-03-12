import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/auth/auth_cubit.dart';
import 'package:my_fm/common/bloc/auth/auth_state.dart';
import 'package:my_fm/common/widgets/message/display_message.dart';
import 'package:my_fm/core/configs/theme/app_theme.dart';
import 'package:my_fm/presentation/auth/pages/sign_in.dart';
import 'package:my_fm/presentation/home/pages/home.dart';
import 'package:my_fm/presentation/splash/pages/splash.dart';
import 'package:my_fm/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return BlocProvider(
      create: (_) => sl<AuthCubit>()..appStarted(),
      child: MaterialApp(
        theme: AppTheme.appDarkTheme,
        home: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              DisplayMessage.errorMessage(context, state.message);
            }
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthenticatedState) {
                return const HomePage();
              }
              if (state is UnauthenticatedState) {
                return SignInPage();
              }
              return const SplashPage();
            },
          ),
        ),
      ),
    );
  }
}

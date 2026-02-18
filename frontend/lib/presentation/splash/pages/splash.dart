import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/helper/navigation/app_navigation.dart';
import 'package:my_fm/core/configs/assets/app_images.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/presentation/auth/pages/sign_in.dart';
import 'package:my_fm/presentation/home/pages/home.dart';
import 'package:my_fm/presentation/splash/bloc/splash_cubit.dart';
import 'package:my_fm/presentation/splash/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            AppNavigation.pushReplacement(context, const HomePage());
          } else if (state is UnauthenticatedState) {
            AppNavigation.pushReplacement(context, SignInPage());
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.splashBackground),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background.withValues(alpha: 0),
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

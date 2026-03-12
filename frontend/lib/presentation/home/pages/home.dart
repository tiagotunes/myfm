import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/auth/auth_cubit.dart';
import 'package:my_fm/common/bloc/button/button_cubit.dart';
import 'package:my_fm/common/widgets/button/bloc_button.dart';
import 'package:my_fm/domain/auth/entities/user_entity.dart';
import 'package:my_fm/domain/auth/usecases/sign_out_uc.dart';
import 'package:my_fm/presentation/home/bloc/user_display_cubit.dart';
import 'package:my_fm/presentation/home/bloc/user_display_state.dart';
import 'package:my_fm/service_locator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
          BlocProvider(create: (context) => ButtonCubit()),
        ],
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
          child: Center(
            child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is UserLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _id(state.userEntity),
                      const SizedBox(height: 20),
                      _email(state.userEntity),
                      const SizedBox(height: 20),
                      _name(state.userEntity),
                      const SizedBox(height: 60),
                      _signOut(context),
                    ],
                  );
                }
                if (state is UserFailure) {
                  return Text(state.errorMessage);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _id(UserEntity user) {
    return Text('[ID] ${user.id}');
  }

  Widget _email(UserEntity user) {
    return Text('[EMAIL] ${user.email}');
  }

  Widget _name(UserEntity user) {
    return Text('[NAME] ${user.name}');
  }

  Widget _signOut(BuildContext context) {
    return BlocButton(
      title: 'Sign Out',
      useCase: sl<SignOutUseCase>(),
      params: () {},
      onSuccess: () {
        context.read<AuthCubit>().sessionExpired();
      },
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/auth/auth_state.dart';
import 'package:my_fm/domain/auth/usecases/refresh_token_uc.dart';
import 'package:my_fm/service_locator.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AppInitialState());

  void appStarted() async {
    try {
      Either result = await sl<RefreshTokenUseCase>().call();

      result.fold((error) {
        if (error != null) {
          emit(AuthErrorState(error.toString()));
        }
        emit(UnauthenticatedState());
      }, (_) => emit(AuthenticatedState()));
    } catch (ex) {
      emit(AuthErrorState(ex.toString()));
    }
  }

  void sessionExpired() async {
    emit(AppInitialState());
    await Future.delayed(const Duration(seconds: 1));
    emit(UnauthenticatedState());
  }
}

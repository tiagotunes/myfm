import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/domain/auth/usecases/auto_login_uc.dart';
import 'package:my_fm/presentation/splash/bloc/splash_state.dart';
import 'package:my_fm/service_locator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplashState());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    var autoLogin = await sl<AutoLoginUseCase>().call();
    if (autoLogin) {
      emit(AuthenticatedState());
    } else {
      emit(UnauthenticatedState());
    }
  }
}

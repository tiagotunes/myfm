import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/presentation/splash/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplashState());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(UnauthenticatedState());
  }
}

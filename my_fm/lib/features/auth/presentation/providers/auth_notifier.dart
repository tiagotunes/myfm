import 'package:flutter_riverpod/legacy.dart';
import 'package:my_fm/features/auth/domain/usecases/login_usecase.dart';
import 'package:my_fm/features/auth/presentation/providers/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;

  AuthNotifier(this.loginUseCase) : super(AuthState.initial());

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await loginUseCase.execute(email: email, password: password);

      state = state.copyWith(isLoading: false, isAuthenticated: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void logout() {
    state = AuthState.initial();
  }
}

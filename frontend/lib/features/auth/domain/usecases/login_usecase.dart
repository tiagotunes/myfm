import 'package:my_fm/features/auth/domain/entities/auth_tokens.dart';
import 'package:my_fm/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthTokens> execute({
    required String email,
    required String password,
  }) {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password must not be empty');
    }

    return repository.login(email: email, password: password);
  }
}

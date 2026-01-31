import 'package:my_fm/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:my_fm/features/auth/domain/entities/auth_tokens.dart';
import 'package:my_fm/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthTokens> login({required String email, required String password}) {
    return remoteDataSource.login(email: email, password: password);
  }
}

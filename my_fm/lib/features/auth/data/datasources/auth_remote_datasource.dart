import 'package:dio/dio.dart';
import 'package:my_fm/features/auth/data/models/auth_tokens_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<AuthTokensModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    return AuthTokensModel.fromJson(response.data);
  }
}

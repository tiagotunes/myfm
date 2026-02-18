import 'package:dartz/dartz.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';
import 'package:my_fm/data/auth/sources/auth_api_service.dart';
import 'package:my_fm/domain/auth/repositories/auth_rep.dart';
import 'package:my_fm/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signIn(SignInRequest params) async {
    return await sl<AuthApiService>().signIn(params);
  }

  @override
  Future<Either> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}

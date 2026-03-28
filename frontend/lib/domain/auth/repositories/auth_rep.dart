import 'package:dartz/dartz.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';
import 'package:my_fm/data/auth/models/sign_up_params.dart';

abstract class AuthRepository {
  Future<Either> getMe();
  Future<Either> refreshToken();
  Future<Either> signIn(SignInRequest params);
  Future<Either> signOut();
  Future<Either> signUp(SignUpParams params);
}

import 'package:dartz/dartz.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';

abstract class AuthRepository {
  Future<Either> signUp();
  Future<Either> signIn(SignInRequest params);
  Future<bool> isLoggedIn();
}

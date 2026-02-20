import 'package:dartz/dartz.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';
import 'package:my_fm/data/auth/sources/auth_api_service.dart';
import 'package:my_fm/data/auth/storage/token_storage.dart';
import 'package:my_fm/domain/auth/repositories/auth_rep.dart';
import 'package:my_fm/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Either> signIn(SignInRequest params) async {
    var data = await sl<AuthApiService>().signIn(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final sharedPrerences = await SharedPreferences.getInstance();
        sharedPrerences.setString('token', data['access_token']);
        return Right(data);
      },
    );
  }

  @override
  Future<bool> autoLogin() async {
    final refreshToken = await sl<TokenStorage>().getRefreshToken();
    if (refreshToken == null) return false;

    final result = await sl<AuthApiService>().refreshToken(refreshToken);

    return result.fold(
      (_) async {
        await sl<TokenStorage>().clear();
        return false;
      },
      (tokens) async {
        await sl<TokenStorage>().saveTokens(
          accessToken: tokens.accessToken,
          refreshToken: tokens.refreshToken,
        );
        return true;
      },
    );
  }

  @override
  Future<String?> getAccessToken() {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }
}

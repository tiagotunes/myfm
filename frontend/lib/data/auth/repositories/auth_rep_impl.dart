import 'package:dartz/dartz.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';
import 'package:my_fm/data/auth/models/sign_up_request.dart';
import 'package:my_fm/data/auth/models/user_model.dart';
import 'package:my_fm/data/auth/sources/auth_api_service.dart';
import 'package:my_fm/data/auth/storage/token_storage.dart';
import 'package:my_fm/domain/auth/repositories/auth_rep.dart';
import 'package:my_fm/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> getMe() async {
    var data = await sl<AuthApiService>().getMe();
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        var userModel = UserModel.fromMap(data);
        var userEntity = userModel.toEntity();
        return Right(userEntity);
      },
    );
  }

  @override
  Future<Either> refreshToken() async {
    final refreshToken = await sl<TokenStorage>().getRefreshToken();
    if (refreshToken == null) {
      return const Left(null);
    }

    var data = await sl<AuthApiService>().refreshToken();
    return data.fold(
      (error) async {
        await sl<TokenStorage>().clearTokens();
        return Left(error);
      },
      (data) async {
        await sl<TokenStorage>().saveTokens(tokens: data);
        return Right(data);
      },
    );
  }

  @override
  Future<Either> signIn(SignInRequest params) async {
    var data = await sl<AuthApiService>().signIn(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        await sl<TokenStorage>().saveTokens(tokens: data);
        return Right(data);
      },
    );
  }

  @override
  Future<Either> signOut() async {
    var data = await sl<AuthApiService>().signOut();
    return data.fold(
      (error) async {
        await sl<TokenStorage>().clearTokens();
        return Left(error);
      },
      (data) async {
        await sl<TokenStorage>().clearTokens();
        return Right(data);
      },
    );
  }

  @override
  Future<Either> signUp(SignUpRequest params) async {
    var data = await sl<AuthApiService>().signUp(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        await sl<TokenStorage>().saveTokens(tokens: data);
        return Right(data);
      },
    );
  }
}

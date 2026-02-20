import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_fm/core/configs/constants/api_url.dart';
import 'package:my_fm/core/network/dio_cliente.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';
import 'package:my_fm/data/auth/models/token_response.dart';
import 'package:my_fm/service_locator.dart';

abstract class AuthApiService {
  Future<Either> signIn(SignInRequest params);
  Future<Either> refreshToken(String refreshToken);
}

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<Either> signIn(SignInRequest params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.signIn,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> refreshToken(String refreshToken) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.refreshToken,
        data: {'refresh_token': refreshToken},
      );
      return Right(TokenResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}

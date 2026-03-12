import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_fm/core/configs/constants/api_url.dart';
import 'package:my_fm/core/network/dio_cliente.dart';
import 'package:my_fm/data/auth/models/sign_in_request.dart';
import 'package:my_fm/data/auth/models/sign_up_request.dart';
import 'package:my_fm/service_locator.dart';

abstract class AuthApiService {
  Future<Either> getMe();
  Future<Either> refreshToken();
  Future<Either> signIn(SignInRequest params);
  Future<Either> signOut();
  Future<Either> signUp(SignUpRequest params);
}

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<Either> getMe() async {
    try {
      var response = await sl<DioClient>().get(ApiUrl.getMe);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unexpected error');
    }
  }

  @override
  Future<Either> refreshToken() async {
    try {
      var response = await sl<DioClient>().post(ApiUrl.refreshToken);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unexpected error');
    }
  }

  @override
  Future<Either> signIn(SignInRequest params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.signIn,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unexpected error');
    }
  }

  @override
  Future<Either> signOut() async {
    try {
      var response = await sl<DioClient>().post(ApiUrl.signOut);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unexpected error');
    }
  }

  @override
  Future<Either> signUp(SignUpRequest params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.signUp,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unexpected error');
    }
  }
}

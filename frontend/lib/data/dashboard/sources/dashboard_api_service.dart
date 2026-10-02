import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_fm/core/configs/constants/api_url.dart';
import 'package:my_fm/core/network/dio_cliente.dart';
import 'package:my_fm/service_locator.dart';

abstract class DashboardApiService {
  Future<Either> getConfigurations(String params);
  Future<Either> getConfigurationCount(String params);
  Future<Either> postConfiguration(String params);
}

class DashboardApiServiceImpl implements DashboardApiService {
  @override
  Future<Either> getConfigurations(String params) async {
    try {
      var response = await sl<DioClient>().get(params);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unexpected error');
    }
  }

  @override
  Future<Either> getConfigurationCount(String params) async {
    try {
      var response = await sl<DioClient>().get(params + ApiUrl.count);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unexpected error');
    }
  }

  @override
  Future<Either> postConfiguration(String params) async {
    try {
      var response = await sl<DioClient>().get(params + ApiUrl.count);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unexpected error');
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:my_fm/core/usecases/usecase.dart';
import 'package:my_fm/data/dashboard/models/configuration_request.dart';
import 'package:my_fm/domain/dashboard/repositories/dashboard_rep.dart';
import 'package:my_fm/service_locator.dart';

class PostConfigurationUseCase extends UseCase<Either, ConfigurationRequest>  {
  @override
  Future<Either> call({ConfigurationRequest? params}) async {
    return await sl<DashboardRepository>().postConfiguration(params!);
  }
}
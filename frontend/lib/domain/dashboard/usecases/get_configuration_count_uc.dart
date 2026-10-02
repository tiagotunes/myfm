import 'package:dartz/dartz.dart';
import 'package:my_fm/core/usecases/usecase.dart';
import 'package:my_fm/domain/dashboard/repositories/dashboard_rep.dart';
import 'package:my_fm/service_locator.dart';

class GetConfigurationCountUserCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<DashboardRepository>().getConfigurationCount(params!);
  }
}

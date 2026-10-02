import 'package:dartz/dartz.dart';
import 'package:my_fm/core/configs/constants/api_url.dart';
import 'package:my_fm/data/dashboard/models/continent_model.dart';
import 'package:my_fm/data/dashboard/models/federation_model.dart';
import 'package:my_fm/data/dashboard/models/nation_model.dart';
import 'package:my_fm/data/dashboard/models/configuration_request.dart';
import 'package:my_fm/data/dashboard/sources/dashboard_api_service.dart';
import 'package:my_fm/domain/dashboard/repositories/dashboard_rep.dart';
import 'package:my_fm/service_locator.dart';

typedef EntityMapper = dynamic Function(Map<String, dynamic> map);

class DashboardRepositoryImpl implements DashboardRepository {
  final Map<String, EntityMapper> _mappers = {
    ApiUrl.continentsCtrl: (map) => ContinentModel.fromMap(map).toEntity(),
    ApiUrl.federationsCtrl: (map) => FederationModel.fromMap(map).toEntity(),
    ApiUrl.nationsCtrl: (map) => NationModel.fromMap(map).toEntity(),
  };

  @override
  Future<Either> getConfigurations(String params) async {
    final result = await sl<DashboardApiService>().getConfigurations(params);

    return result.fold(Left.new, (data) {
      final mapper = _mappers[params];

      if (mapper == null) {
        return Right(data);
      }

      final entities = (data as List)
          .map((item) => mapper(item as Map<String, dynamic>))
          .toList();

      return Right(entities);
    });
  }

  @override
  Future<Either> getConfigurationCount(String params) async {
    final result = await sl<DashboardApiService>().getConfigurationCount(
      params,
    );

    return result.fold(Left.new, Right.new);
  }

  @override
  Future<Either> postConfiguration(ConfigurationRequest params) {
    
    if (params is FederationRequest)
    {
      print(params.acronym);
    }
    throw UnimplementedError();
  }
}

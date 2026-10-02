import 'package:dartz/dartz.dart';
import 'package:my_fm/data/dashboard/models/configuration_request.dart';

abstract class DashboardRepository {
  Future<Either> getConfigurations(String params);
  Future<Either> getConfigurationCount(String params);
  Future<Either> postConfiguration(ConfigurationRequest params);
}
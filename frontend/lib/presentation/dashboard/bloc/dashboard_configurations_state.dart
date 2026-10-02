import 'package:my_fm/domain/dashboard/entities/configuration_entity.dart';

abstract class DashboardConfigurationsState {}

class DashboardConfigurationsLoadingState
    extends DashboardConfigurationsState {}

class DashboardConfigurationsSuccessState extends DashboardConfigurationsState {
  final List<ConfigurationWithCountEntity> configurations;
  DashboardConfigurationsSuccessState({required this.configurations});
}

class DashboardConfigurationsFailureState
    extends DashboardConfigurationsState {}

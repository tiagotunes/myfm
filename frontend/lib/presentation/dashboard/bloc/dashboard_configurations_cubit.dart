import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/core/usecases/usecase.dart';
import 'package:my_fm/domain/dashboard/entities/configuration_entity.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_configurations_state.dart';

class DashboardConfigurationsCubit extends Cubit<DashboardConfigurationsState> {
  DashboardConfigurationsCubit() : super(DashboardConfigurationsLoadingState());

  Future<void> load({
    required List<ConfigurationEntity> configs,
    required UseCase usecase,
  }) async {
    try {
      final List<ConfigurationWithCountEntity> results = [];

      for (var config in configs) {
        Either result = await usecase.call(params: config.url);

        result.fold(
          (error) {
            results.add(
              ConfigurationWithCountEntity(configuration: config, count: '-'),
            );
          },
          (data) {
            results.add(
              ConfigurationWithCountEntity(configuration: config, count: data),
            );
          },
        );
      }
      emit(DashboardConfigurationsSuccessState(configurations: results));
    } catch (e) {
      if (!isClosed) {
        emit(DashboardConfigurationsFailureState());
      }
    }
  }

  Future<void> refresh(
    List<ConfigurationEntity> configs,
    UseCase usecase,
  ) async {
    await load(configs: configs, usecase: usecase);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/core/configs/constants/api_url.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';
import 'package:my_fm/domain/dashboard/entities/configuration_entity.dart';
import 'package:my_fm/domain/dashboard/usecases/get_configuration_count_uc.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_configurations_cubit.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_configurations_state.dart';
import 'package:my_fm/presentation/dashboard/widgets/dashboard_configuration_card.dart';

final configurationsList = [
  ConfigurationEntity.new(
    icon: Icons.map_rounded,
    label: 'continents',
    url: ApiUrl.continentsCtrl,
  ),
  ConfigurationEntity.new(
    icon: Icons.hub_rounded,
    label: 'federations',
    url: ApiUrl.federationsCtrl,
  ),
  ConfigurationEntity.new(
    icon: Icons.flag_rounded,
    label: 'nations',
    url: ApiUrl.nationsCtrl,
  ),
];

class DashboardConfigurationsPage extends StatelessWidget {
  const DashboardConfigurationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: AppSizes.screenPadding,
      separatorBuilder: (context, index) => AppSizes.dashConfigSpaceBtwCards,
      itemCount: configurationsList.length,
      itemBuilder: (context, index) {
        return BlocProvider(
          create: (context) => DashboardConfigurationsCubit()
            ..load(
              configs: configurationsList,
              usecase: GetConfigurationCountUserCase(),
            ),
          child:
              BlocBuilder<
                DashboardConfigurationsCubit,
                DashboardConfigurationsState
              >(
                builder: (context, state) {
                  return DashboardConfigurationCard(
                    configuration: configurationsList[index],
                    isLoading: state is DashboardConfigurationsLoadingState,
                    count: state is DashboardConfigurationsSuccessState
                        ? state.configurations[index].count
                        : '-',
                  );
                },
              ),
        );
      },
    );
  }
}

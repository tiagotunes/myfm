import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/widgets/message/default_center.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/domain/dashboard/entities/configuration_entity.dart';
import 'package:my_fm/domain/dashboard/entities/configuration_generic_entity.dart';
import 'package:my_fm/domain/dashboard/usecases/get_configurations_uc.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_configuration_state.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_configuration_cubit.dart';
import 'package:my_fm/presentation/dashboard/widgets/dashboard_configuration_list.dart';
import 'package:my_fm/presentation/dashboard/widgets/dashboard_configuration_dialog.dart';
import 'package:my_fm/presentation/dashboard/widgets/dashboard_configuration_search_bar.dart';

class DashboardConfigurationPage<T extends ConfigurationGenericEntity> extends StatelessWidget {
  final ConfigurationEntity configuration;
  const DashboardConfigurationPage({super.key, required this.configuration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.midnight,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded, size: 30),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) =>
                    DashboardConfigurationDialog(configuration: configuration),
              );
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => DashboardConfigurationCubit<T>()
          ..execute(
            usecase: GetConfigurationsUseCase(),
            params: configuration.url,
          ),
        child:
            BlocBuilder<
               DashboardConfigurationCubit<T>,
              DashboardConfigurationState<T>
            >(
              builder: (context, state) {
                if (state is DashboardConfigurationLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is DashboardConfigurationFailureState) {
                  return DefaultCenter(
                    icon: Icons.cloud_off_rounded,
                    message: 'Could not GET ${configuration.label}',
                  );
                }

                if (state is DashboardConfigurationSuccessState<T>) {
                  return Column(
                    children: [
                      DashboardConfigurationSearchBar(query: state.query),
                      Expanded(
                        child: DashboardConfigurationList<T>(
                          configuration: configuration,
                          items: state.items,
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/widgets/message/display_message.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';
import 'package:my_fm/domain/dashboard/entities/configuration_entity.dart';
import 'package:my_fm/domain/dashboard/usecases/get_configuration_count_uc.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_configurations_cubit.dart';
import 'package:my_fm/presentation/dashboard/pages/dashboard_configuration.dart';
import 'package:my_fm/presentation/dashboard/pages/dashboard_configurations.dart';

class DashboardConfigurationCard extends StatelessWidget {
  final ConfigurationEntity configuration;
  final bool isLoading;
  final String count;

  const DashboardConfigurationCard({
    super.key,
    required this.configuration,
    required this.isLoading,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (count == '-') {
          DisplayMessage.errorMessage(context, 'Could not COUNT ${configuration.label}');
        } else {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  DashboardConfigurationPage(configuration: configuration),
            ),
          );

          context.read<DashboardConfigurationsCubit>().refresh(
            configurationsList,
            GetConfigurationCountUserCase(),
          );
        }
      },
      child: Container(
        padding: AppSizes.dashConfigCardPadding,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.15),
          borderRadius: AppSizes.dashConfigCardBorderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(configuration.icon, size: AppSizes.dashConfigCardIconSize),
                AppSizes.dashConfigSpaceBtwiconText,
                Text(
                  configuration.label.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            isLoading
                ? const CircularProgressIndicator()
                : Text(
                    count,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.white.withValues(alpha: 0.20),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_fm/common/widgets/button/bloc_button.dart';
import 'package:my_fm/common/widgets/input/input_text.dart';
import 'package:my_fm/core/configs/constants/api_url.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';
import 'package:my_fm/data/dashboard/models/configuration_request.dart';
import 'package:my_fm/domain/dashboard/entities/configuration_entity.dart';
import 'package:my_fm/domain/dashboard/usecases/post_configuration_uc.dart';
import 'package:my_fm/presentation/dashboard/widgets/dashboard_configuration_dialog_header.dart';
import 'package:my_fm/service_locator.dart';

class DashboardConfigurationDialog extends StatelessWidget {
  final ConfigurationEntity configuration;
  const DashboardConfigurationDialog({super.key, required this.configuration});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.midnight,
          border: Border.all(
            color: AppColors.air.withValues(alpha: 0.2),
            width: 3,
          ),
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DashboardConfigurationDialogHeader(
              isNew: true,
              label: configuration.label.substring(
                0,
                configuration.label.length - 1,
              ),
            ),
            const SizedBox(height: 24),
            _buildForm(context, configuration.url),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, String url) {
    switch (url) {
      case ApiUrl.federationsCtrl:
        TextEditingController _acronymController = TextEditingController();
        TextEditingController _nameController = TextEditingController();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputText(label: 'acronym', controller: _acronymController),
            AppSizes.spaceBtwInputs,
            InputText(label: 'name', controller: _nameController),
            const SizedBox(height: 24),
            BlocButton(
              title: 'save',
              useCase: sl<PostConfigurationUseCase>(),
              params: () => FederationRequest(
                acronym: _acronymController.text,
                name: _nameController.text,
              ),
              displayMessage: false,
              onSuccess: () => print('OK'),
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:my_fm/common/widgets/assets/safe_svg.dart';
import 'package:my_fm/common/widgets/message/default_center.dart';
import 'package:my_fm/core/configs/assets/app_icons.dart';
import 'package:my_fm/domain/dashboard/entities/configuration_entity.dart';
import 'package:my_fm/domain/dashboard/entities/configuration_generic_entity.dart';
import 'package:my_fm/presentation/dashboard/widgets/dashboard_configuration_list_item.dart';

class DashboardConfigurationList<T extends ConfigurationGenericEntity>
    extends StatelessWidget {
  final ConfigurationEntity configuration;
  final List<T> items;

  const DashboardConfigurationList({
    super.key,
    required this.configuration,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return DefaultCenter(
        icon: configuration.icon,
        message: 'Could not GET ${configuration.label}',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return DashboardConfigurationListItem(
          prefix: SafeSvg(
            path: '${AppIcons.basePath}/${configuration.label}/${item.icon}',
            safeIcon: configuration.icon,
            height: 28,
          ),
          title: item.title,
          subtitle: item.subtitle,
        );
      },
    );
  }
}

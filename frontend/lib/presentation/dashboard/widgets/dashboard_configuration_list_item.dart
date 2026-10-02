import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';

class DashboardConfigurationListItem extends StatelessWidget {
  final Widget prefix;
  final String title;
  final String subtitle;
  const DashboardConfigurationListItem({
    super.key,
    required this.prefix,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Row(
        children: [
          prefix,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: subtitle.isNotEmpty
                      ? Theme.of(context).textTheme.bodyMedium
                      : Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                subtitle.isNotEmpty
                    ? Text(
                        subtitle,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: AppColors.white.withValues(alpha: 0.5),
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

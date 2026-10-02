import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';

class DashboardConfigurationDialogHeader extends StatelessWidget {
  final bool isNew;
  final String label;
  
  const DashboardConfigurationDialogHeader({
    super.key,
    required this.isNew,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isNew ? 'New' : 'Edit',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: AppColors.white),
            ),
          ],
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close_rounded, size: 30),
        ),
      ],
    );
  }
}

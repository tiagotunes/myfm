import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_drawer_cubit.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_drawer_state.dart';

class DashboardDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final DashboardDrawerState item;
  final DashboardDrawerState selectedItem;

  const DashboardDrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.item,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = item.runtimeType == selectedItem.runtimeType;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      leading: Container(
        width: 8,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
          color: isSelected ? AppColors.cloud : Colors.transparent,
        ),
      ),
      title: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: isSelected
                ? AppColors.cloud
                : AppColors.white.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w400,
              color: isSelected
                  ? AppColors.white
                  : AppColors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
      onTap: () {
        context.read<DashboardDrawerCubit>().set(item);
        Navigator.pop(context);
      },
    );
  }
}

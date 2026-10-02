import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/auth/auth_cubit.dart';
import 'package:my_fm/common/widgets/button/bloc_button.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/domain/auth/usecases/sign_out_uc.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_drawer_cubit.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_drawer_state.dart';
import 'package:my_fm/presentation/dashboard/widgets/dashboard_drawer_item.dart';
import 'package:my_fm/service_locator.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: BlocBuilder<DashboardDrawerCubit, DashboardDrawerState>(
        builder: (context, state) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.dashboard_rounded, size: 48),
                    const SizedBox(height: 8),
                    Text("DASHBOARD", style: Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Divider(
                indent: 6,
                endIndent: 6,
                thickness: 6,
                radius: const BorderRadius.all(Radius.circular(3)),
                color: AppColors.air.withValues(alpha: 0.15),
              ),
              const SizedBox(height: 24),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_buildItems(context, state), _signOut(context)],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItems(BuildContext context, DashboardDrawerState state) {
    return Column(
      children: [
        DashboardDrawerItem(
          icon: Icons.home_rounded,
          title: "Home",
          item: HomeDrawerState(),
          selectedItem: state,
        ),
        DashboardDrawerItem(
          icon: Icons.pie_chart_rounded,
          title: "Analytics",
          item: AnalyticsDrawerState(),
          selectedItem: state,
        ),
        DashboardDrawerItem(
          icon: Icons.construction_rounded,
          title: "Configurations",
          item: ConfigurationsDrawerState(),
          selectedItem: state,
        ),
        DashboardDrawerItem(
          icon: Icons.group_rounded,
          title: "Users",
          item: UsersDrawerState(),
          selectedItem: state,
        ),
        DashboardDrawerItem(
          icon: Icons.settings_rounded,
          title: "Settings",
          item: SettingsDrawerState(),
          selectedItem: state,
        ),
      ],
    );
  }

  Widget _signOut(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocButton(
        title: 'Sign Out',
        useCase: sl<SignOutUseCase>(),
        params: () {},
        onSuccess: () {
          context.read<AuthCubit>().sessionExpired();
        },
      ),
    );
  }
}

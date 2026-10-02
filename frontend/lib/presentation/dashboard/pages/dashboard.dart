import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_drawer_cubit.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_drawer_state.dart';
import 'package:my_fm/presentation/dashboard/pages/dashboard_analytics.dart';
import 'package:my_fm/presentation/dashboard/pages/dashboard_configurations.dart';
import 'package:my_fm/presentation/dashboard/pages/dashboard_home.dart';
import 'package:my_fm/presentation/dashboard/pages/dashboard_settings.dart';
import 'package:my_fm/presentation/dashboard/pages/dashboard_users.dart';
import 'package:my_fm/presentation/dashboard/widgets/dashboard_drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardDrawerCubit(),
      child: BlocBuilder<DashboardDrawerCubit, DashboardDrawerState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.midnight,
            ),
            drawer: const DashboardDrawer(),
            body: SafeArea(
              child: switch (state) {
                HomeDrawerState() => const DashboardHomePage(),
                AnalyticsDrawerState() => const DashboardAnalyticsPage(),
                ConfigurationsDrawerState() => const DashboardConfigurationsPage(),
                UsersDrawerState() => const DashboardUsersPage(),
                SettingsDrawerState() => const DashboardSettingsPage(),
                _ => const SizedBox(),
              },
            ),
          );
        },
      ),
    );
  }
}

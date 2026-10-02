import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_configuration_cubit.dart';

class DashboardConfigurationSearchBar extends StatelessWidget {
  final String query;
  DashboardConfigurationSearchBar({super.key, required this.query});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.value = TextEditingValue(
      text: query,
      selection: TextSelection.collapsed(offset: query.length),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          context.read<DashboardConfigurationCubit>().onSearchChanged(value);
        },
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              context.read<DashboardConfigurationCubit>().clearSearch();
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ),
    );
  }
}

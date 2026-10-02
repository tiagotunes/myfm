import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_drawer_state.dart';

class DashboardDrawerCubit extends Cubit<DashboardDrawerState> {
  DashboardDrawerCubit() : super(HomeDrawerState());

  void set(DashboardDrawerState state) => emit(state);
}


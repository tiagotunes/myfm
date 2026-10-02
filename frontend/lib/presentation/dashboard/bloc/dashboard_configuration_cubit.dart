import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/core/usecases/usecase.dart';
import 'package:my_fm/domain/dashboard/entities/configuration_generic_entity.dart';
import 'package:my_fm/presentation/dashboard/bloc/dashboard_configuration_state.dart';

class DashboardConfigurationCubit<T extends ConfigurationGenericEntity>
    extends Cubit<DashboardConfigurationState<T>> {
  DashboardConfigurationCubit()
    : super(DashboardConfigurationLoadingState<T>());

  List<T> _allItems = [];
  String _query = '';
  Timer? _debounce;

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    emit(DashboardConfigurationLoadingState<T>());

    try {
      Either result = await usecase.call(params: params);

      result.fold((_) => emit(DashboardConfigurationFailureState<T>()), (data) {
        _allItems = List<T>.from(data);
        _applyFilter();
      });
    } catch (_) {
      emit(DashboardConfigurationFailureState<T>());
    }
  }

  void onSearchChanged(String query) {
    _query = query;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _applyFilter();
    });
  }

  void clearSearch() {
    _query = '';
    _applyFilter();
  }

  void _applyFilter() {
    final q = _query.toLowerCase();

    final filtered = _query.isEmpty
        ? _allItems
        : _allItems.where((item) {
            return item.searchableText.toLowerCase().contains(q);
          }).toList();

    emit(DashboardConfigurationSuccessState<T>(items: filtered, query: _query));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

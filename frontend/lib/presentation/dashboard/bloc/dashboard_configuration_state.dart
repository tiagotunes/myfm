abstract class DashboardConfigurationState<T> {}

class DashboardConfigurationLoadingState<T>
    extends DashboardConfigurationState<T> {}

class DashboardConfigurationFailureState<T>
    extends DashboardConfigurationState<T> {}

class DashboardConfigurationSuccessState<T>
    extends DashboardConfigurationState<T> {
  final List<T> items;
  final String query;

  DashboardConfigurationSuccessState({
    required this.items,
    required this.query,
  });
}

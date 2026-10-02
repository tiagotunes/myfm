abstract class DashboardDrawerState {
  String title;
  DashboardDrawerState({required this.title});
}

class HomeDrawerState extends DashboardDrawerState {
  HomeDrawerState() : super(title: "");
}

class AnalyticsDrawerState extends DashboardDrawerState {
  AnalyticsDrawerState() : super(title: "Analytics");
}

class ConfigurationsDrawerState extends DashboardDrawerState {
  ConfigurationsDrawerState() : super(title: "Configurations");
}

class UsersDrawerState extends DashboardDrawerState {
  UsersDrawerState() : super(title: "Users");
}

class SettingsDrawerState extends DashboardDrawerState {
  SettingsDrawerState() : super(title: "Settings");
}

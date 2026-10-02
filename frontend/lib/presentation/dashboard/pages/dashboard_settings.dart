import 'package:flutter/material.dart';
import 'package:my_fm/common/widgets/message/default_center.dart';

class DashboardSettingsPage extends StatelessWidget {
  const DashboardSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultCenter(icon: Icons.settings_rounded, message: 'SETTINGS'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_fm/common/widgets/message/default_center.dart';

class DashboardAnalyticsPage extends StatelessWidget {
  const DashboardAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultCenter(icon: Icons.pie_chart_rounded, message: 'ANALYTICS'),
    );
  }
}

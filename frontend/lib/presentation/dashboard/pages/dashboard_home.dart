import 'package:flutter/material.dart';
import 'package:my_fm/common/widgets/message/default_center.dart';

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultCenter(icon: Icons.home_rounded, message: 'HOME'),
    );
  }
}

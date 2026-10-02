import 'package:flutter/material.dart';
import 'package:my_fm/common/widgets/message/default_center.dart';

class DashboardUsersPage extends StatelessWidget {
  const DashboardUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultCenter(icon: Icons.group_rounded, message: 'USERS'),
    );
  }
}

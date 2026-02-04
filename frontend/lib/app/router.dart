import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fm/features/auth/presentation/pages/login_page.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/team', builder: (context, state) => const TeamPage()),
  ],
);

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Team')));
  }
}

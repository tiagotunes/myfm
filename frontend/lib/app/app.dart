import 'package:flutter/material.dart';
import 'package:my_fm/app/router.dart';
import 'package:my_fm/core/theme/app_theme.dart';

class MyFmApp extends StatelessWidget {
  const MyFmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My FM',
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';

class AuthHeader extends StatelessWidget {
  final String headline;
  final String title;

  const AuthHeader({super.key, required this.headline, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          headline.toUpperCase(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),

        AppSizes.spaceBtwHeaderText,

        Text(title, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}

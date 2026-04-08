import 'package:flutter/material.dart';
import 'package:my_fm/common/widgets/button/bloc_button.dart';
import 'package:my_fm/core/usecases/usecase.dart';

class AuthSignButton extends StatelessWidget {
  final String title;
  final UseCase useCase;
  final VoidCallback params;
  final VoidCallback onSuccess;

  const AuthSignButton({
    super.key,
    required this.title,
    required this.useCase,
    required this.params,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocButton(
        title: title,
        useCase: useCase,
        params: params,
        onSuccess: onSuccess,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/button/button_cubit.dart';
import 'package:my_fm/common/bloc/button/button_state.dart';
import 'package:my_fm/common/widgets/button/basic_button.dart';
import 'package:my_fm/common/widgets/message/display_message.dart';
import 'package:my_fm/core/usecases/usecase.dart';

class BlocButton extends StatelessWidget {
  final String title;
  final UseCase useCase;
  final dynamic Function() params;
  final VoidCallback? onSuccess;

  const BlocButton({
    super.key,
    required this.title,
    required this.useCase,
    required this.params,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ButtonCubit(),
      child: BlocConsumer<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonFailureState) {
            DisplayMessage.errorMessage(context, state.errorMessage);
          }

          if (state is ButtonSuccessState) {
            if (onSuccess != null) {
              onSuccess!();
            }
          }
        },
        builder: (context, state) {
          final isLoading = state is ButtonLoadingState;

          return BasicButton(
            title: title,
            isLoading: isLoading,
            onPressed: isLoading
                ? null
                : () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.read<ButtonCubit>().execute(
                      usecase: useCase,
                      params: params(),
                    );
                  },
          );
        },
      ),
    );
  }
}

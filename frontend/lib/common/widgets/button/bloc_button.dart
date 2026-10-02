import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fm/common/bloc/button/button_cubit.dart';
import 'package:my_fm/common/bloc/button/button_state.dart';
import 'package:my_fm/common/widgets/button/basic_button.dart';
import 'package:my_fm/common/widgets/message/display_message.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';
import 'package:my_fm/core/usecases/usecase.dart';

class BlocButton extends StatelessWidget {
  final String title;
  final UseCase useCase;
  final dynamic Function() params;
  final VoidCallback? onSuccess;
  final bool displayMessage;

  const BlocButton({
    super.key,
    required this.title,
    required this.useCase,
    required this.params,
    this.onSuccess,
    this.displayMessage = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ButtonCubit(),
      child: BlocConsumer<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonFailureState && displayMessage) {
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
          final error = state is ButtonFailureState ? state.errorMessage : null;
          return Column(
            children: [
              BasicButton(
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
              ),
              if (error != null && !displayMessage) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.highlightRed.withValues(alpha: 0.15),
                    borderRadius: AppSizes.snackbarBorderRadius,
                    border: Border.all(
                      color: AppColors.highlightRed,
                      width: AppSizes.snackbarBorderWidth,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.cancel_rounded,
                        color: AppColors.highlightRed,
                      ),
                      AppSizes.spaceBtwIconText,
                      Text(error),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

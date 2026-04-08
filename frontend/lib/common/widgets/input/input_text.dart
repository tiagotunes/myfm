import 'package:flutter/material.dart';
import 'package:my_fm/core/configs/theme/app_colors.dart';
import 'package:my_fm/core/configs/theme/app_sizes.dart';

class InputText extends StatelessWidget {
  final String label;
  final bool mandatory;
  final TextEditingController controller;
  final TextInputType? inputType;
  final bool obscureText;

  const InputText({
    super.key,
    required this.label,
    this.mandatory = true,
    required this.controller,
    this.inputType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase() + (mandatory ? ' *' : ''),
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(color: AppColors.cloud),
        ),

        AppSizes.spaceBtwLabelInput,
        

        TextField(
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText,
          obscuringCharacter: '*',
        ),
      ],
    );
  }
}

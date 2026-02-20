import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';

class InputTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool isRequired;

  const InputTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorPalette.borderColor,
          width: AppDimens.borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                color: ColorPalette.textPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: TextStyles.fontFamily, 
              ),
              children: [
                if (isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: ColorPalette.errorColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: ColorPalette.textDisabledColor,
                fontSize: TextStyles.mediumInputTextSize,
                fontFamily: TextStyles.fontFamily,
              ),
              border: InputBorder.none, 
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none, 
              isDense: true,
            ),
            style: const TextStyle(
              fontSize: TextStyles.mediumInputTextSize,
              color: ColorPalette.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
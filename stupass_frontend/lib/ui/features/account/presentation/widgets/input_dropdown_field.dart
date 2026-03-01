import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class InputDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final bool isRequired;

  const InputDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.options,
    required this.onChanged,
    this.value,
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
          DropdownButtonFormField<String>(
            value: value,
            hint: Text(
              hintText,
              style: const TextStyle(
                color: ColorPalette.textDisabledColor,
                fontSize: TextStyles.mediumInputTextSize,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: ColorPalette.textSecondaryColor,
            ),
            style: const TextStyle(
              fontSize: TextStyles.mediumInputTextSize,
              color: ColorPalette.textPrimaryColor,
              fontFamily: TextStyles.fontFamily,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4),
            ),
            items: options
                .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

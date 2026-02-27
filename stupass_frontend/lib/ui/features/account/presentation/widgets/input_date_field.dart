import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class InputDateField extends StatelessWidget {
  final String label;
  final String hintText;
  final String value;
  final VoidCallback onTap;
  final bool isRequired;

  const InputDateField({
    super.key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.onTap,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value.isEmpty ? hintText : value,
                    style: TextStyle(
                      fontSize: TextStyles.mediumInputTextSize,
                      color: value.isEmpty
                          ? ColorPalette.textDisabledColor
                          : ColorPalette.textPrimaryColor,
                      fontFamily: TextStyles.fontFamily,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  size: AppDimens.iconSmall,
                  color: ColorPalette.textSecondaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

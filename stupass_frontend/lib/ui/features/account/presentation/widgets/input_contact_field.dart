import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class InputContactField extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final String label;
  final VoidCallback onAdd;

  const InputContactField({
    super.key,
    this.icon,
    this.customIcon,
    required this.label,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingDefault,
        vertical: AppDimens.spacingM,
      ),
      child: Row(
        children: [
          if (customIcon != null)
            customIcon!
          else
            Icon(
              icon,
              size: AppDimens.iconDefault,
              color: ColorPalette.textSecondaryColor,
            ),
          const SizedBox(width: AppDimens.spacingM),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: TextStyles.smallBodySize,
                color: ColorPalette.textPrimaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: const Text(
              'Thêm',
              style: TextStyle(
                fontSize: TextStyles.smallBodySize,
                color: ColorPalette.primaryColor,
                fontWeight: FontWeight.w600,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

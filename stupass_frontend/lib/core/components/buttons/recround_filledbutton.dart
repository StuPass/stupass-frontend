import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';
import 'package:stupass_frontend/core/theme/app_dimens.dart';

class RecroundFilledButton extends StatelessWidget {
  const RecroundFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isSelected,
    this.prefixIcon,
  });

  final String label;
  final IconData? prefixIcon;
  final bool isSelected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? ColorPalette.secondaryButtonColor : ColorPalette.disabledButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusCir),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? ColorPalette.onPrimaryButtonColor : ColorPalette.onDisabledButtonColor,
            fontSize: TextStyles.mediumInputTextSize,
            fontFamily: TextStyles.fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
    );
  }
}
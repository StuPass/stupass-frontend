import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.labelSize,
    required this.buttonHeight,
    required this.backgroundColor,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String label;
  final double labelSize;
  final double buttonHeight;
  final Color backgroundColor;
  final Function() onPressed;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null)...[
            Icon(
              prefixIcon,
              color: ColorPalette.onPrimaryButtonColor,
              fontWeight: FontWeight.bold,
              size: 24,
            ),
            SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: ColorPalette.onPrimaryButtonColor,
                fontSize: labelSize,
                fontFamily: TextStyles.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (suffixIcon != null)...[
            SizedBox(width: 8),
            Icon(
              suffixIcon,
              color: ColorPalette.onPrimaryButtonColor,
              fontWeight: FontWeight.bold,
              size: 24,
            ),
            ]
          ],
        ),
      ),
    );
  }
}
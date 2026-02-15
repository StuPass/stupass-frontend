import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.label,
    required this.labelSize,
    required this.buttonHeight,
    required this.onPressed,
    this.prefixWidget,
    this.suffixWidget,
  });

  final String label;
  final double labelSize;
  final double buttonHeight;
  final Function() onPressed;
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed, 
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixWidget != null)...[
              prefixWidget!,
              SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: ColorPalette.textColorSecondary ,
                fontSize: labelSize,
                fontFamily: TextStyles.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (suffixWidget != null)...[
              SizedBox(width: 8),
              suffixWidget!,
            ]
          ],
        ),
      )
    );
  }
}
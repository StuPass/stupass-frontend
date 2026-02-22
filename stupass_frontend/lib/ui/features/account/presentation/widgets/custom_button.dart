import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(
        color: ColorPalette.surfaceColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusCir),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) 
            Icon(prefixIcon, size: AppDimens.iconSmall, color: color),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontFamily: TextStyles.fontFamily,
                fontSize: TextStyles.smallBodySize,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Spacer(),
            if (suffixIcon != null) 
            Icon(suffixIcon, size: AppDimens.iconSmall, color: color),
          ],
        ),
      ),
    );
  }
}
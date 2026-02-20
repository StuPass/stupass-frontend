import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';

class CircleIconbutton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  const CircleIconbutton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.iconDefault + 20,
      height: AppDimens.iconDefault + 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorPalette.surfaceColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: ColorPalette.secondaryButtonColor,
          size: AppDimens.iconDefault,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
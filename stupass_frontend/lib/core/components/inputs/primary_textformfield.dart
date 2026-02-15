import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/app_dimens.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';

class PrimaryTextformfield extends StatelessWidget {
  const PrimaryTextformfield({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.isPassword = false,
    this.isPasswordVisible = false,
    required this.onTogglePassword,
    required this.keyboardType,
    required this.controller,
    required this.onSaved,
    required this.validator,
  });

  final String hintText;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback onTogglePassword;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;



  @override
  Widget build(BuildContext context) {
    Widget? finalPrefix;

    if (prefixWidget != null) {
      finalPrefix = prefixWidget;
    } 
    else if (prefixIcon != null) {
      finalPrefix = Icon(
        prefixIcon,
        color: ColorPalette.disableTextColor, 
        size: AppDimens.iconDefault,
      );
    }

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword && !isPasswordVisible,
      style: TextStyle(
        color: ColorPalette.disableTextColor,
        fontSize: TextStyles.largeInputTextSize,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorPalette.textColorSecondary,
          fontSize: TextStyles.largeInputTextSize,
        ),
        prefixIcon: finalPrefix,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: ColorPalette.disableTextColor,
                  size: AppDimens.iconDefault,
                ),
                onPressed: onTogglePassword,
              )
            : suffixWidget,
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}

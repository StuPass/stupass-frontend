import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/app_dimens.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';

class PrimaryTextformfield extends StatelessWidget {
  const PrimaryTextformfield({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.isPasswordVisible = false,
    required this.onTogglePassword,
    required this.keyboardType,
    required this.controller,
    required this.onSaved,
    required this.validator,
  });
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final bool isPasswordVisible;
  final Function() onTogglePassword;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function() onSaved;
  final Function() validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorPalette.disableTextColor,
          fontSize: TextStyles.largeInputTextSize,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: ColorPalette.disableTextColor,
          size: AppDimens.iconDefault,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: ColorPalette.disableTextColor,
                  size: AppDimens.iconDefault,
                ),
                onPressed: onTogglePassword,
              )
            : null,
      ),
      onSaved: (newValue) => onSaved(),
      validator: (value) => validator(),
    );
  }
}

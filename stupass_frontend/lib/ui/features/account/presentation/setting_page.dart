import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Setting Page',
          style: TextStyle(
            fontSize: TextStyles.heading1Size,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textPrimaryColor,
          ),
        ),
      ),
    );
  }
}
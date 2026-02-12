import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/app_dimens.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';
import 'package:stupass_frontend/core/components/buttons/primary_button.dart';

class StoragePage extends StatelessWidget {
  const StoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Storage Page',
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
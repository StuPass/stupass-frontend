import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Marketplace Page',
          style: TextStyle(
            fontSize: TextStyles.heading1Size,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textColorPrimary,
          ),
        ),
      ),
    );
  }
}
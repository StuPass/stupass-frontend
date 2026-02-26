import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class ProductsSearchField extends StatelessWidget {
  const ProductsSearchField({
    super.key,
    required this.searchController,
    });

  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Tìm sản phẩm...',
        hintStyle: TextStyle(
          color: ColorPalette.textDisabledColor,
          fontSize: TextStyles.smallInputTextSize,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: ColorPalette.textDisabledColor,
          size: AppDimens.iconDefault,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide.none,
        ),
        fillColor: ColorPalette.inputFieldBackgroundColor,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/core/components/buttons/input_text_button.dart';
import 'package:stupass_frontend/ui/core/components/inputs/input_text_field.dart';


class SelectingLocationSheet extends StatelessWidget {
  const SelectingLocationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.all(AppDimens.paddingDefault),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusRec),
      ),
      child: Column(
        spacing: AppDimens.spacingM,
        children: [
          Container(
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingDefault,
            ),
            decoration: BoxDecoration(
              color: ColorPalette.surfaceColor,
              borderRadius: BorderRadius.circular(AppDimens.radiusRec),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  iconSize: AppDimens.iconSmall,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Text(
                    'Địa chỉ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: TextStyles.fontFamily,
                      fontSize: TextStyles.heading5Size,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12, height: 1),
              ],
            ),
          ),
          InputTextButton(
            label: 'Tỉnh, thành phố',
            hintText: 'Chọn tỉnh, thành phố',
            isRequired: true,
            onTap: () {},
          ),
          InputTextButton(
            label: 'Quận, huyện, thị xã',
            hintText: 'Chọn quận, huyện, thị xã',
            isRequired: true,
            onTap: () {},
          ),
          InputTextButton(
            label: 'Phường, xã, thị trấn',
            hintText: 'Chọn phường, xã, thị trấn',
            isRequired: true,
            onTap: () {},
          ),
          InputTextField(
            label: 'Địa chỉ cụ thể',
            hintText: 'Nhập địa chỉ cụ thể',
            isRequired: true,
          ),
        ],
      ),
    );
  }
}

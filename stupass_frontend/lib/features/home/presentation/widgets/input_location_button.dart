import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/app_dimens.dart';

class InputLocationButton extends StatelessWidget {
  final String label;
  final String hintText;
  final Function() onTap;
  final bool isRequired;

  const InputLocationButton({
    super.key,
    required this.label,
    required this.hintText,
    required this.onTap,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorPalette.borderColor, width: AppDimens.borderWidth),
      ),
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: label,
                          style: const TextStyle(
                            color: ColorPalette.textPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: TextStyles.fontFamily,
                          ),
                          children: [
                            if (isRequired)
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: ColorPalette.errorColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        hintText,
                        style: const TextStyle(
                          color: ColorPalette.textDisabledColor,
                          fontSize: TextStyles.mediumInputTextSize,
                          fontFamily: TextStyles.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: ColorPalette.textDisabledColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';

class DescriptionTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool isRequired;

  const DescriptionTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.isRequired = false,
  });

  @override
  State<DescriptionTextField> createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  @override
  Widget build(BuildContext context) {
    int currentLength = 0;

    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorPalette.borderColor,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: const TextStyle(
                color: ColorPalette.textPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: TextStyles.fontFamily, 
              ),
              children: [
                if (widget.isRequired)
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

          const SizedBox(height: 4),
          
          TextField(
            controller: widget.controller,
            onChanged: (value) {
              setState(() {
                currentLength = value.length;
              });
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: ColorPalette.textDisabledColor,
                fontSize: TextStyles.mediumInputTextSize,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
            style: const TextStyle(
              fontSize: TextStyles.mediumInputTextSize,
              color: ColorPalette.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$currentLength/1000',
            style: const TextStyle(
              fontSize: 12,
              color: ColorPalette.textSecondaryColor,
              fontFamily: TextStyles.fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
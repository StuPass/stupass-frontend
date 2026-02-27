import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class _LanguageOption {
  final String flag;
  final String label;
  final String code;

  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.code,
  });
}

class SelectingLanguagePage extends StatefulWidget {
  const SelectingLanguagePage({super.key});

  @override
  State<SelectingLanguagePage> createState() => _SelectingLanguagePageState();
}

class _SelectingLanguagePageState extends State<SelectingLanguagePage> {
  static const List<_LanguageOption> _languages = [
    _LanguageOption(flag: '🇻🇳', label: 'Tiếng Việt', code: 'vi'),
    _LanguageOption(flag: '🇬🇧', label: 'Tiếng Anh', code: 'en'),
  ];

  String _selectedCode = 'vi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorPalette.surfaceColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorPalette.textPrimaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Ngôn ngữ',
          style: TextStyle(
            fontSize: TextStyles.heading5Size,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textPrimaryColor,
            fontFamily: TextStyles.fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingDefault),
        child: Container(
          decoration: BoxDecoration(
            color: ColorPalette.surfaceColor,
            borderRadius: BorderRadius.circular(AppDimens.radiusRec),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_languages.length, (index) {
              final lang = _languages[index];
              final isSelected = lang.code == _selectedCode;
              final isLast = index == _languages.length - 1;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => setState(() => _selectedCode = lang.code),
                    borderRadius: BorderRadius.vertical(
                      top: index == 0
                          ? const Radius.circular(AppDimens.radiusRec)
                          : Radius.zero,
                      bottom: isLast
                          ? const Radius.circular(AppDimens.radiusRec)
                          : Radius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.paddingDefault,
                        vertical: AppDimens.spacingM,
                      ),
                      child: Row(
                        children: [
                          // ─── Flag emoji ───
                          Text(
                            lang.flag,
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(width: AppDimens.spacingM),

                          // ─── Language name ───
                          Expanded(
                            child: Text(
                              lang.label,
                              style: TextStyle(
                                fontSize: TextStyles.smallBodySize,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: ColorPalette.textPrimaryColor,
                                fontFamily: TextStyles.fontFamily,
                              ),
                            ),
                          ),

                          // ─── Checkmark if selected ───
                          if (isSelected)
                            const Icon(
                              Icons.check,
                              size: AppDimens.iconDefault,
                              color: ColorPalette.primaryColor,
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: AppDimens.paddingDefault,
                      endIndent: AppDimens.paddingDefault,
                      color: ColorPalette.backgroundColor,
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

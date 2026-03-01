import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/selecting_item_button.dart';

class SelectingCateSheet extends StatefulWidget {
  const SelectingCateSheet({super.key});

  @override
  State<SelectingCateSheet> createState() => _SelectingCateSheetState();
}

class _SelectingCateSheetState extends State<SelectingCateSheet> {
  final List<String> categories = [
    'Hà Nội',
    'Hồ Chí Minh',
    'Đà Nẵng',
    'Hải Phòng',
    'Cần Thơ',
    'Nha Trang',
    'Vũng Tàu',
    'Huế',
    'Quy Nhơn',
    'Buôn Ma Thuột',
  ];
  int selectedCategoryIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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
                    'Loại sản phẩm',
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

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: categories
                    .map(
                      (category) => SelectingItemButton(
                        text: category,
                        isSelected: selectedCategoryIndex == categories.indexOf(category),
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex = categories.indexOf(category);
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

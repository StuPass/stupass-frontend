import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/selecting_item_button.dart';

class SelectingDistrictSheet extends StatefulWidget {
  const SelectingDistrictSheet({super.key});

  @override
  State<SelectingDistrictSheet> createState() => _SelectingDistrictSheetState();
}

class _SelectingDistrictSheetState extends State<SelectingDistrictSheet> {
  final List<String> districts = [
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
  int selectedDistrictIndex = -1;
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
                    'Quận, huyện',
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
          Container(
            width: double.infinity,
            height: 40,
            color: ColorPalette.surfaceColor,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm quận, huyện, thị xã',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: ColorPalette.surfaceColor,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: districts
                    .map(
                      (district) => SelectingItemButton(
                        text: district,
                        isSelected: selectedDistrictIndex == districts.indexOf(district),
                        onTap: () {
                          setState(() {
                            selectedDistrictIndex = districts.indexOf(district);
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

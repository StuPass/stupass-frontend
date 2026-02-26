import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/selecting_item_button.dart';

class SelectingWardSheet extends StatefulWidget {
  const SelectingWardSheet({super.key});

  @override
  State<SelectingWardSheet> createState() => _SelectingWardSheetState();
}

class _SelectingWardSheetState extends State<SelectingWardSheet> {
  final List<String> wards = [
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
  int selectedWardIndex = -1;
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
                    'Phường, xã, thị trấn',
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
                hintText: 'Tìm kiếm phường, xã, thị trấn',
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
                children: wards
                    .map(
                      (ward) => SelectingItemButton(
                        text: ward,
                        isSelected: selectedWardIndex == wards.indexOf(ward),
                        onTap: () {
                          setState(() {
                            selectedWardIndex = wards.indexOf(ward);
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

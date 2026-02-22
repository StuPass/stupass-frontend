import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class NavigationBottomAppBar extends StatelessWidget {
  const NavigationBottomAppBar({
    super.key,
    required this.currentPageIndex,
    required this.onDestinationSelected,
  });

  final int currentPageIndex;
  final void Function(int index) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.all(8.0),
      height: 62,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navigationItem(Icons.home, Icons.home_outlined, "Trang chủ", 0),
          _navigationItem(Icons.storage, Icons.storage_outlined, "Kho hàng", 1),
          Container(
            width: 40,
            height: 37,
            alignment: Alignment.bottomCenter,
            child: Text(
              'Đăng tin',
              style: TextStyle(
                fontSize: TextStyles.smallCaptionSize,
                fontWeight: FontWeight.bold,
                color: ColorPalette.textPrimaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
          ),
          _navigationItem(Icons.chat, Icons.chat_bubble_outline, "Tin nhắn", 3),
          _navigationItem(Icons.person, Icons.person_outline, "Hồ sơ", 4),
        ],
      ),
    );
  }

  Widget _navigationItem(
    IconData selectedIcon,
    IconData disabledIcon,
    String label,
    int index,
  ) {
    bool isSelected = (currentPageIndex == index);
    return InkWell(
      onTap: () => onDestinationSelected(index),
      child: SizedBox(
        width: 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : disabledIcon,
              color: isSelected
                  ? ColorPalette.primaryColor
                  : ColorPalette.textSecondaryColor,
              size: AppDimens.iconDefault,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? ColorPalette.primaryColor
                    : ColorPalette.textSecondaryColor,
                fontSize: TextStyles.smallCaptionSize,
                fontWeight: FontWeight.bold,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

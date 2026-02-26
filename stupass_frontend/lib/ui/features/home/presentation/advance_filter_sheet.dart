import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class AdvanceFilterSheet extends StatelessWidget {
  const AdvanceFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: const Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: const Offset(0, 2),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Text(
                    'Bộ lọc nâng cao',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 40.0),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Khu vực',
                    style: TextStyle(
                      fontSize: TextStyles.smallBodySize,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.textPrimaryColor,
                    ),
                  ),
                  CustomDropdownButton(
                    title: 'Tỉnh, thành phố',
                    prefixIcon: Icons.location_city_outlined,
                    onTap: () {}, 
                  ),
                  Text(
                    'Thông tin sản phẩm',
                    style: TextStyle(
                      fontSize: TextStyles.smallBodySize,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.textPrimaryColor,
                    ),
                  ),
                  CustomDropdownButton(
                    title: 'Loại sản phẩm',
                    prefixIcon: Icons.category_outlined,
                    onTap: () {},
                  ),
                  Divider(height: 0.3, color: ColorPalette.borderColor),
                  CustomDropdownButton(
                    title: 'Tình trạng',
                    prefixIcon: Icons.autorenew_outlined,
                    onTap: () {},
                  ),
                  Divider(height: 0.3, color: ColorPalette.borderColor),
                  CustomDropdownButton(
                    title: 'Giá',
                    prefixIcon: Icons.attach_money_outlined,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropdownButton extends StatelessWidget {
  final String title;
  final IconData prefixIcon;
  final VoidCallback onTap;

  const CustomDropdownButton({
    super.key,
    required this.title,
    required this.prefixIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color iconAndTextColor = Color(0xFF7D8C8D);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          children: [
            // 1. Icon bên trái (Được truyền từ bên ngoài vào)
            Icon(
              prefixIcon,
              color: iconAndTextColor,
              size: 24.0,
            ),
            
            const SizedBox(width: 12.0),
            
            // 2. Chữ ở giữa (Được truyền từ bên ngoài vào)
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: iconAndTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: iconAndTextColor,
              size: 28.0,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/app_dimens.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';
import 'package:stupass_frontend/core/components/buttons/primary_button.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. image section
          Expanded(
            flex: 4,
            child: Image.asset('assets/images/flea_market_image.jfif',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // 2. Text section
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //Logo StuPass
                      const Text(
                        "Stu",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.textColorPrimary,
                        ),
                      ),
                      const Text(
                        "Pass",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.shopping_bag,
                        color: ColorPalette.primaryColor,
                        size: 36,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Slogan
                  const Text(
                    "Cũ người - Mới ta - Giá sinh viên",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Nền tảng mua bán trao đổi đồ dùng dành riêng cho cộng đồng sinh viên",
                    style: TextStyle(
                      fontSize: TextStyles.mediumBodySize,
                      color: ColorPalette.disableTextColor,
                    ),
                  ),

                  const SizedBox(height: 32),

                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        color: ColorPalette.primaryColor,
                        size: 8,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Mua bán đồ cũ giá tốt",
                        style: const TextStyle(
                          fontSize: TextStyles.mediumBodySize,
                          color: ColorPalette.disableTextColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        color: ColorPalette.primaryColor,
                        size: 8,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Cộng đồng sinh viên uy tín",
                        style: const TextStyle(
                          fontSize: TextStyles.mediumBodySize,
                          color: ColorPalette.disableTextColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        color: ColorPalette.primaryColor,
                        size: 8,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Giao dịch an toàn nhanh chóng",
                        style: const TextStyle(
                          fontSize: TextStyles.mediumBodySize,
                          color: ColorPalette.disableTextColor,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Nút "Bắt đầu ngay"
                  PrimaryButton(
                    label: "Bắt đầu ngay",
                    labelSize: TextStyles.largeButtonTextSize,
                    buttonHeight: 56,
                    backgroundColor: ColorPalette.primaryColor,
                    suffixIcon: Icons.arrow_forward,
                    onPressed: () => context.push('/signin'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

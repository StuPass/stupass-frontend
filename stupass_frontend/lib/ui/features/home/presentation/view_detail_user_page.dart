import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/user_summary.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/user_detail_infor.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/horizontal_item_post.dart';

class ViewDetailUserPage extends StatelessWidget {
  const ViewDetailUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Summary Section
            UserSummary(
              avatarUrl: 'https://via.placeholder.com/60',
              backgroundImageUrl: 'https://via.placeholder.com/400x150',
              userName: 'Nguyễn Trần Khánh Duy',
              selledProducts: 12,
              purchasingProducts: 24,
              reputationScore: 10,
            ),
            Padding(
              padding: EdgeInsets.all(AppDimens.paddingDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Detail Information Section
                  UserDetailInfor(
                    schoolName: 'Trường đại học Công nghệ thông tin',
                    studentId: '24521827',
                    location: 'Quận 1, tp.Hồ Chí Minh',
                    gender: 'Nam',
                    birthday: '01-01-2000',
                  ),
                  SizedBox(height: AppDimens.spacingM),
                  
                  // Items Section Header
                  Text(
                    'Tất cả tin đăng (100)',
                    style: TextStyle(
                      fontSize: TextStyles.heading5Size,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: AppDimens.spacingS),
                  
                  // Tab Filters
                  Row(
                    children: [
                      _buildTab('Đang hoạt động', isSelected: true),
                      SizedBox(width: AppDimens.spacingL),
                      _buildTab('Đã bán', isSelected: false),
                    ],
                  ),
                  Divider(height: 1, color: ColorPalette.borderColor),
                  SizedBox(height: AppDimens.spacingM),
                  
                  // List of Items
                  HorizontalItemPost(
                    imageUrl: 'https://via.placeholder.com/80',
                    title: 'Advanced Database Systems Textbook',
                    location: 'Thủ Đức, tp.HCM',
                    price: '24.000 VNĐ',
                    onTap: () {},
                  ),
                  HorizontalItemPost(
                    imageUrl: 'https://via.placeholder.com/80',
                    title: 'Mini Fridge OLED Display',
                    location: 'Dorm A, Room 302',
                    price: '1.200.000 VNĐ',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(bottom: AppDimens.spacingS),
        decoration: BoxDecoration(
          border: isSelected
              ? Border(
                  bottom: BorderSide(
                    color: ColorPalette.primaryColor,
                    width: 2,
                  ),
                )
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: TextStyles.smallBodySize,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? ColorPalette.textPrimaryColor
                : ColorPalette.textSecondaryColor,
          ),
        ),
      ),
    );
  }
}

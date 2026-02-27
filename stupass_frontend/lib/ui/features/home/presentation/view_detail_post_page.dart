import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/seller_info_card.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/post_image_carousel.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/product_info_section.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/comment_section.dart';

class ViewDetailPostPage extends StatelessWidget {
  const ViewDetailPostPage({super.key});

  static const List<String> _images = [
    'https://via.placeholder.com/400x300',
    'https://via.placeholder.com/400x300',
    'https://via.placeholder.com/400x300',
    'https://via.placeholder.com/400x300',
  ];

  static const List<CommentItem> _sampleComments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Image Carousel ───
            PostImageCarousel(
              imageUrls: _images,
              onBack: () => Navigator.of(context).pop(),
            ),

            SizedBox(height: AppDimens.spacingS),

            // ─── Product Info + Description ───
            ProductInfoSection(
              title: 'Mini Fridge OLED Display',
              price: '1.200.000 VNĐ',
              address: 'An Khánh, Thủ Đức, tp.HCM',
              category: 'Sách vở',
              condition: 'Mới',
              quantity: '',
              description:
                  'Stupass được phát triển vào năm 2026, được khởi tạo bởi UIT-Together – một nhóm các kỹ sư Công nghệ trẻ đầy nhiệt huyết từ Trường Đại học Công nghệ Thông tin (UIT). Xuất phát từ chính nhu cầu thực tế tại giảng đường: Giáo trình cũ bỏ thì phí, đồ điện tử muốn bán đổi mũi giá cũ bỏ gìa, hay đơn giản là tìm một nơi tin cậy để sang nhượng vật dụng cá nhân. Chúng tớ tạo ra Stupass không phải để cạnh tranh với các sàn thương mại điện tử khổng lồ, mà để giải quyết bài toán "Cũ người mới ta" ngay trong chính cộng đồng sinh viên...',
            ),

            SizedBox(height: AppDimens.spacingS),

            // ─── Seller Info ───
            Container(
              color: ColorPalette.surfaceColor,
              width: double.infinity,
              padding: EdgeInsets.all(AppDimens.paddingDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông tin người bán:',
                    style: TextStyle(
                      fontSize: TextStyles.heading5Size,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: AppDimens.spacingM),
                  SellerInfoCard(
                    avatarUrl: 'https://via.placeholder.com/60',
                    sellerName: 'Nguyễn Trần Khánh Duy',
                    universityName:
                        'University of Information and Technology',
                    selledProducts: 12,
                    purchasingProducts: 24,
                    reputationScore: 100,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            SizedBox(height: AppDimens.spacingS),

            // ─── Comment Section ───
            CommentSection(comments: _sampleComments),

            SizedBox(height: AppDimens.spacingM),
          ],
        ),
      ),
    );
  }
}

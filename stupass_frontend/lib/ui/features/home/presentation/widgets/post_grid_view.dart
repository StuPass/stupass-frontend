import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/post.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class PostGridView extends StatelessWidget {
  const PostGridView({
    super.key,
    required this.itemCount,
    this.title,
  });

  final String? title;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          // title of category
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingM),
              child: Text(
                title ?? '',
                style: TextStyle(
                  fontFamily: TextStyles.fontFamily,
                  fontSize: TextStyles.heading4Size,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textPrimaryColor,
                ),
              ),
            ),
          ),
          
          // 2. grid view of posts
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppDimens.spacingM,
              crossAxisSpacing: AppDimens.spacingM,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => const Post(
                imageUrl: 'assets/images/sample_product.jpg',
                title: 'Giáo trình Cơ sở dữ liệu',
                price: '150,000 VND',
                location: 'Thủ Đức, tp.HCM',
              ),
              childCount: itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/home/presentation/view_detail_post_page.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.location,
    this.onTap,
    });

  final String imageUrl;
  final String title;
  final String price;
  final String location;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.postWidth,
      height: AppDimens.postHeight,
      decoration: BoxDecoration(
        color: ColorPalette.surfaceColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusRec),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Column(
          children: [
            // image section
            Stack(
              children: [
                Container(
                  height: AppDimens.postWidth,
                  width: AppDimens.postWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimens.radiusRec),
                      topRight: Radius.circular(AppDimens.radiusRec),
                    ),
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    icon: Icon(Icons.bookmark_border),
                    color: ColorPalette.textPrimaryColor,
                    iconSize: AppDimens.iconDefault,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            // Title section
            Text(
              title,
              style: TextStyle(
                fontSize: TextStyles.smallBodySize,
                fontWeight: FontWeight.normal,
                color: ColorPalette.textPrimaryColor,
              ),
            ),
            // Price section
            Text(
              price,
              style: TextStyle(
                fontSize: TextStyles.mediumBodySize,
                fontWeight: FontWeight.bold,
                color: ColorPalette.primaryColor,
              ),
            ),
            // Location section
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: ColorPalette.textSecondaryColor,
                ),
                SizedBox(width: 4),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: TextStyles.largeCaptionSize,
                    fontWeight: FontWeight.normal,
                    color: ColorPalette.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDetailPostPage()));
        },
      ),
    );
  }
}
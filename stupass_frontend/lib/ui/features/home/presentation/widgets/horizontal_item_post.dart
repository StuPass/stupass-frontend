import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class HorizontalItemPost extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final VoidCallback? onTap;

  const HorizontalItemPost({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusRec),
      child: Container(
        margin: EdgeInsets.only(bottom: AppDimens.spacingS),
        padding: EdgeInsets.all(AppDimens.spacingM),
        decoration: BoxDecoration(
          color: ColorPalette.surfaceColor,
          borderRadius: BorderRadius.circular(AppDimens.radiusRec),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                color: ColorPalette.backgroundColor,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: AppDimens.spacingM),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: TextStyles.smallBodySize,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.textPrimaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppDimens.spacingXS),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: ColorPalette.textSecondaryColor,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: TextStyles.largeCaptionSize,
                            color: ColorPalette.textSecondaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimens.spacingXS),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: TextStyles.mediumBodySize,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class SellerInfoCard extends StatelessWidget {
  final String avatarUrl;
  final String backgroundImageUrl;
  final String sellerName;
  final String universityName;
  final int selledProducts;
  final int purchasingProducts;
  final int reputationScore;
  final VoidCallback? onTap;

  const SellerInfoCard({
    super.key,
    required this.avatarUrl,
    required this.backgroundImageUrl,
    required this.sellerName,
    required this.universityName,
    required this.selledProducts,
    required this.purchasingProducts,
    required this.reputationScore,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.surfaceColor,
          borderRadius: BorderRadius.circular(AppDimens.radiusRec),
        ),
        child: Column(
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppDimens.radiusRec),
                topRight: Radius.circular(AppDimens.radiusRec),
              ),
              child: Image.network(
                backgroundImageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 100,
                  color: ColorPalette.borderColor,
                ),
              ),
            ),
            // Seller info row
            Padding(
              padding: EdgeInsets.all(AppDimens.spacingM),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(avatarUrl),
                    backgroundColor: ColorPalette.borderColor,
                  ),
                  SizedBox(width: AppDimens.spacingM),
                  // Name + university + stats
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sellerName,
                          style: TextStyle(
                            fontSize: TextStyles.heading5Size,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          universityName,
                          style: TextStyle(
                            fontSize: TextStyles.largeCaptionSize,
                            color: ColorPalette.textSecondaryColor,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: AppDimens.spacingS),
                        Row(
                          children: [
                            _buildStatItem(selledProducts.toString(), 'Bán'),
                            SizedBox(width: AppDimens.spacingL),
                            _buildStatItem(
                                purchasingProducts.toString(), 'Mua'),
                            SizedBox(width: AppDimens.spacingL),
                            _buildStatItem(
                                reputationScore.toString(), 'Uy tín'),
                          ],
                        ),
                      ],
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

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: TextStyles.smallBodySize,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textPrimaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: TextStyles.largeCaptionSize,
            color: ColorPalette.textSecondaryColor,
          ),
        ),
      ],
    );
  }
}

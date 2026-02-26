import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class UserSummary extends StatelessWidget {
  final String avatarUrl;
  final String backgroundImageUrl;
  final String userName;
  final int selledProducts;
  final int purchasingProducts;
  final int reputationScore;

  const UserSummary({
    super.key,
    required this.avatarUrl,
    required this.backgroundImageUrl,
    required this.userName,
    required this.selledProducts,
    required this.purchasingProducts,
    required this.reputationScore,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.surfaceColor,
      ),
      child: Column(
        children: [
          // Background image with back button
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Background image
              Container(
                height: 160 + statusBarHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(backgroundImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Back button
              Positioned(
                top: statusBarHeight + AppDimens.spacingS,
                left: AppDimens.spacingM,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back,
                        size: 20, color: ColorPalette.textPrimaryColor),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.all(AppDimens.spacingXS),
                    constraints: BoxConstraints(),
                  ),
                ),
              ),
            ],
          ),
          // User info row: avatar + name/stats
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.spacingM, vertical: AppDimens.spacingM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorPalette.surfaceColor,
                      width: 3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage(avatarUrl),
                    backgroundColor: ColorPalette.borderColor,
                  ),
                ),
                SizedBox(width: AppDimens.spacingM),
                // Name + stats
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: TextStyles.heading4Size,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: AppDimens.spacingS),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildStatItem(
                              selledProducts.toString(), 'Bán'),
                          SizedBox(width: AppDimens.spacingXL),
                          _buildStatItem(
                              purchasingProducts.toString(), 'Mua'),
                          SizedBox(width: AppDimens.spacingXL),
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
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: TextStyles.heading4Size,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textPrimaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: TextStyles.smallBodySize,
            color: ColorPalette.textSecondaryColor,
          ),
        ),
      ],
    );
  }
}

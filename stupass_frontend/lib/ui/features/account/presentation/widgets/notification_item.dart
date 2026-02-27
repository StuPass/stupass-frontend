import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class NotificationItem extends StatelessWidget {
  final String avatarUrl;
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationItem({
    super.key,
    required this.avatarUrl,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isRead
            ? Colors.transparent
            : ColorPalette.notificationBackgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingDefault,
          vertical: AppDimens.spacingM,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ─── Avatar ───
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(avatarUrl),
              backgroundColor: ColorPalette.backgroundColor,
            ),
            const SizedBox(width: AppDimens.spacingM),

            // ─── Title + subtitle ───
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: TextStyles.smallBodySize,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.textPrimaryColor,
                      fontFamily: TextStyles.fontFamily,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacingXS),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: TextStyles.largeCaptionSize,
                      fontWeight: FontWeight.normal,
                      color: ColorPalette.textSecondaryColor,
                      fontFamily: TextStyles.fontFamily,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDimens.spacingS),

            // ─── Time ───
            Text(
              time,
              style: const TextStyle(
                fontSize: TextStyles.largeCaptionSize,
                fontWeight: FontWeight.normal,
                color: ColorPalette.textSecondaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

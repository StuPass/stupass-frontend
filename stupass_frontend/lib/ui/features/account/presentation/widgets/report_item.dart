import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class ReportItem extends StatelessWidget {
  final String avatarUrl;
  final String reporterName;
  final String reason;
  final String time;
  final VoidCallback? onTap;

  const ReportItem({
    super.key,
    required this.avatarUrl,
    required this.reporterName,
    required this.reason,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.red[100],
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

            // ─── Reporter name + reason ───
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reporterName,
                    style: const TextStyle(
                      fontSize: TextStyles.smallBodySize,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.textPrimaryColor,
                      fontFamily: TextStyles.fontFamily,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacingXS),
                  Text(
                    reason,
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

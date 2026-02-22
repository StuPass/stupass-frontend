import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class ProfileSummary extends StatelessWidget {
  final String name;
  final String schoolName;
  final String imageUrl;
  final int sellingCount;
  final int buyingCount;
  final int reputationScore;

  const ProfileSummary({super.key, required this.name, required this.schoolName, required this.imageUrl, required this.sellingCount, required this.buyingCount, required this.reputationScore});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.paddingDefault),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusRec),
      ),
      child: InkWell(
        onTap: () {

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: TextStyles.fontFamily,
                        fontSize: TextStyles.mediumBodySize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      schoolName,
                      style: TextStyle(
                        fontFamily: TextStyles.fontFamily,
                        fontSize: TextStyles.mediumCaptionSize,
                        color: ColorPalette.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sellingCount.toString(),
                              style: TextStyle(
                                fontFamily: TextStyles.fontFamily,
                                fontSize: TextStyles.mediumBodySize,
                                color: ColorPalette.textPrimaryColor,
                              ),
                            ),
                            Text(
                              'Bán',
                              style: TextStyle(
                                fontFamily: TextStyles.fontFamily,
                                fontSize: TextStyles.mediumCaptionSize,
                                color: ColorPalette.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              buyingCount.toString(),
                              style: TextStyle(
                                fontFamily: TextStyles.fontFamily,
                                fontSize: TextStyles.mediumBodySize,
                                color: ColorPalette.textPrimaryColor,
                              ),
                            ),
                            Text(
                              'Mua',
                              style: TextStyle(
                                fontFamily: TextStyles.fontFamily,
                                fontSize: TextStyles.mediumCaptionSize,
                                color: ColorPalette.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reputationScore.toString(),
                              style: TextStyle(
                                fontFamily: TextStyles.fontFamily,
                                fontSize: TextStyles.mediumBodySize,
                                color: ColorPalette.textPrimaryColor,
                              ),
                            ),
                            Text(
                              'Uy tín',
                              style: TextStyle(
                                fontFamily: TextStyles.fontFamily,
                                fontSize: TextStyles.mediumCaptionSize,
                                color: ColorPalette.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

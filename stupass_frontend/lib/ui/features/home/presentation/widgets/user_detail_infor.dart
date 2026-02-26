import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class UserDetailInfor extends StatelessWidget {
  final String schoolName;
  final String studentId;
  final String location;
  final String gender;
  final String birthday;

  const UserDetailInfor({
    super.key,
    required this.schoolName,
    required this.studentId,
    required this.location,
    required this.gender,
    required this.birthday,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.spacingM),
      decoration: BoxDecoration(
        color: ColorPalette.surfaceColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusRec),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin cá nhân',
            style: TextStyle(
              fontSize: TextStyles.heading5Size,
              fontWeight: FontWeight.bold,
              color: ColorPalette.textPrimaryColor,
            ),
          ),
          SizedBox(height: AppDimens.spacingM),
          _buildDetailRow(Icons.school_outlined, schoolName),
          SizedBox(height: AppDimens.spacingS),
          _buildDetailRow(Icons.badge_outlined, 'ID  $studentId'),
          SizedBox(height: AppDimens.spacingS),
          _buildDetailRow(Icons.location_on_outlined, location),
          SizedBox(height: AppDimens.spacingS),
          _buildDetailRow(Icons.person_outline, gender),
          SizedBox(height: AppDimens.spacingS),
          _buildDetailRow(Icons.cake_outlined, birthday),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppDimens.iconDefault,
          color: ColorPalette.textSecondaryColor,
        ),
        SizedBox(width: AppDimens.spacingS),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: TextStyles.smallBodySize,
              color: ColorPalette.textPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

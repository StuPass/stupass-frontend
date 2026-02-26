import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class ProductInfoSection extends StatefulWidget {
  final String title;
  final String price;
  final String address;
  final String category;
  final String condition;
  final String quantity;
  final String description;
  final bool isBookmarked;
  final VoidCallback? onBookmark;

  const ProductInfoSection({
    super.key,
    required this.title,
    required this.price,
    required this.address,
    required this.category,
    required this.condition,
    required this.quantity,
    required this.description,
    this.isBookmarked = false,
    this.onBookmark,
  });

  @override
  State<ProductInfoSection> createState() => _ProductInfoSectionState();
}

class _ProductInfoSectionState extends State<ProductInfoSection> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ─── Product Info Card ───
        Container(
          color: ColorPalette.surfaceColor,
          width: double.infinity,
          padding: EdgeInsets.all(AppDimens.paddingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + Bookmark
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: TextStyles.heading4Size,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.textPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimens.spacingS),
                  GestureDetector(
                    onTap: widget.onBookmark,
                    child: Column(
                      children: [
                        Icon(
                          widget.isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          size: AppDimens.iconDefault,
                          color: widget.isBookmarked
                              ? ColorPalette.primaryColor
                              : ColorPalette.textPrimaryColor,
                        ),
                        Text(
                          'Lưu',
                          style: TextStyle(
                            fontSize: TextStyles.smallCaptionSize,
                            color: ColorPalette.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimens.spacingS),

              // Price
              Text(
                widget.price,
                style: TextStyle(
                  fontSize: TextStyles.heading4Size,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.primaryColor,
                ),
              ),
              SizedBox(height: AppDimens.spacingM),

              // Detail rows
              _buildDetailRow(
                  Icons.location_on_outlined, 'Địa chỉ: ', widget.address),
              SizedBox(height: AppDimens.spacingS),
              _buildDetailRow(
                  Icons.category_outlined, 'Loại sản phẩm: ', widget.category),
              SizedBox(height: AppDimens.spacingS),
              _buildDetailRow(
                  Icons.new_releases_outlined, 'Tình trạng: ', widget.condition),
              SizedBox(height: AppDimens.spacingS),
              _buildDetailRow(
                  Icons.inventory_2_outlined, 'Số lượng: ', widget.quantity),
            ],
          ),
        ),

        SizedBox(height: AppDimens.spacingS),

        // ─── Description Card ───
        Container(
          color: ColorPalette.surfaceColor,
          width: double.infinity,
          padding: EdgeInsets.all(AppDimens.paddingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mô tả sản phẩm:',
                style: TextStyle(
                  fontSize: TextStyles.heading5Size,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textPrimaryColor,
                ),
              ),
              SizedBox(height: AppDimens.spacingS),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: TextStyles.smallBodySize,
                  color: ColorPalette.textPrimaryColor,
                  height: 1.5,
                ),
                maxLines: _isDescriptionExpanded ? null : 6,
                overflow: _isDescriptionExpanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
              ),
              SizedBox(height: AppDimens.spacingXS),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isDescriptionExpanded = !_isDescriptionExpanded;
                  });
                },
                child: Text(
                  _isDescriptionExpanded ? 'Thu gọn' : 'Xem thêm',
                  style: TextStyle(
                    fontSize: TextStyles.smallBodySize,
                    color: ColorPalette.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: ColorPalette.textSecondaryColor),
        SizedBox(width: AppDimens.spacingS),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: TextStyles.smallBodySize,
                color: ColorPalette.textPrimaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

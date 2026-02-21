import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/components/buttons/input_text_button.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/core/components/inputs/input_text_field.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/user_image_picker.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/description_text_field.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/input_location_button.dart';
import 'package:stupass_frontend/ui/core/components/buttons/primary_button.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: Column(
        spacing: AppDimens.spacingS,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            color: ColorPalette.surfaceColor,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingDefault),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),

                Expanded(
                  child: Text(
                    'Đăng bài',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: TextStyles.fontFamily,
                      fontSize: TextStyles.heading4Size,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 48, height: 1,),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppDimens.spacingM),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(AppDimens.paddingDefault),
                    decoration: BoxDecoration(
                      color: ColorPalette.surfaceColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppDimens.radiusRec),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppDimens.spacingM,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Hình ảnh/Video',
                            style: TextStyle(
                              fontFamily: TextStyles.fontFamily,
                              fontSize: TextStyles.mediumBodySize,
                              fontWeight: FontWeight.bold,
                              color: ColorPalette.textPrimaryColor,
                            ),
                            children: const [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: ColorPalette.errorColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        UserImagePicker(),

                        DescriptionTextField(
                          label: 'Mô tả sản phẩm',
                          hintText: 'Nhập mô tả sản phẩm...',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mô tả tốt nên có:",
                              style: const TextStyle(
                                fontSize: 12,
                                color: ColorPalette.textSecondaryColor,
                                fontFamily: TextStyles.fontFamily,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.download_done,
                                  size: 12,
                                  color: ColorPalette.textPrimaryColor,
                                ),
                                Text('Tên và nguồn gốc sản phẩm'),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.download_done,
                                  size: 12,
                                  color: ColorPalette.textPrimaryColor,
                                ),
                                Text('Lí do và giá bán bạn bán'),
                              ],
                            ),
                          ],
                        ),

                        InputTextField(
                          label: 'Tiêu đề',
                          hintText: 'Nhập tiêu đề',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),

                        InputTextField(
                          label: 'Giá bán',
                          hintText: '0.00',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),

                        InputTextField(
                          label: 'Số lượng',
                          hintText: '0',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppDimens.spacingL),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(AppDimens.paddingDefault),
                    decoration: BoxDecoration(
                      color: ColorPalette.surfaceColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppDimens.radiusRec),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppDimens.spacingM,
                      children: [
                        Text(
                          'Thông tin chi tiết',
                          style: TextStyle(
                            fontFamily: TextStyles.fontFamily,
                            fontSize: TextStyles.mediumBodySize,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.textPrimaryColor,
                          ),
                        ),
                        InputTextButton(
                          label: 'Loại sản phẩm',
                          hintText: 'Chọn loại sản phẩm',
                          isRequired: true,
                          onTap: () {},
                        ),
                        InputTextButton(
                          label: 'Loại sản phẩm',
                          hintText: 'Chọn loại sản phẩm',
                          isRequired: true,
                          onTap: () {},
                        ),
                        InputLocationButton(
                          label: 'Địa chỉ',
                          hintText: 'Chọn địa chỉ',
                          isRequired: true,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppDimens.paddingDefault),
                    child: PrimaryButton(
                      label: 'Đăng bài',
                      labelSize: TextStyles.smallBodySize,
                      buttonHeight: AppDimens.mediumButtonHeight,
                      backgroundColor: ColorPalette.primaryColor,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

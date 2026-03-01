import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/account/presentation/widgets/profile_summary.dart';
import 'package:stupass_frontend/ui/features/account/presentation/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/routing/routes.dart';
import 'package:stupass_frontend/ui/features/account/view_models/setting_view_model.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.viewModel});

  final SettingViewModel viewModel;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant SettingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.removeListener(_onResult);
    widget.viewModel.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onResult);
    super.dispose();
  }

  void _onResult() {
    if (widget.viewModel.isLoading) return;
    if (widget.viewModel.isSuccess) {
      // navigate to sign-in or home depending on flow
      if (context.mounted) {
        context.go(Routes.signin);
      }
    } else if (widget.viewModel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.viewModel.errorMessage!),
          backgroundColor: ColorPalette.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimens.spacingS,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            color: ColorPalette.surfaceColor,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingDefault,
            ),
            child: Text(
              'Tài khoản',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: TextStyles.fontFamily,
                fontSize: TextStyles.heading4Size,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileSummary(
                      name: "name",
                      schoolName: "schoolName",
                      imageUrl: "imageUrl",
                      sellingCount: 12,
                      buyingCount: 24,
                      reputationScore: 100,
                    ),
                    SizedBox(height: AppDimens.spacingM),
                    Text(
                      "Tài khoản",
                      style: TextStyle(
                        fontFamily: TextStyles.fontFamily,
                        fontSize: TextStyles.smallBodySize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingDefault),
                      decoration: BoxDecoration(
                        color: ColorPalette.surfaceColor,
                        borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                      ),
                      child: Column(
                        children: [
                          CustomButton(
                            text: 'Chỉnh sửa trang cá nhân',
                            color: ColorPalette.textPrimaryColor,
                            prefixIcon: Icons.perm_identity,
                            suffixIcon: Icons.arrow_forward,
                            onTap: () {},
                          ),
                          Divider(color: Colors.grey, height: 0.3),
                          CustomButton(
                            text: 'Đổi mật khẩu',
                            color: ColorPalette.textPrimaryColor,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: Icons.arrow_forward,
                            onTap: () {},
                          ),
                          Divider(color: Colors.grey, height: 0.3),
                          CustomButton(
                            text: 'Thông báo',
                            color: ColorPalette.textPrimaryColor,
                            prefixIcon: Icons.notifications_none,
                            suffixIcon: Icons.arrow_forward,
                            onTap: () {},
                          ),
                          Divider(color: Colors.grey, height: 0.3),
                          CustomButton(
                            text: 'Ngôn ngữ',
                            color: ColorPalette.textPrimaryColor,
                            prefixIcon: Icons.translate,
                            suffixIcon: Icons.arrow_forward,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppDimens.spacingM),
                    Text(
                      "Tiện ích",
                      style: TextStyle(
                        fontFamily: TextStyles.fontFamily,
                        fontSize: TextStyles.smallBodySize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingDefault),
                      decoration: BoxDecoration(
                        color: ColorPalette.surfaceColor,
                        borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                      ),
                      child: Column(
                        children: [
                          CustomButton(
                            text: 'Tin đăng đã lưu',
                            color: ColorPalette.textPrimaryColor,
                            prefixIcon: Icons.bookmark_border,
                            suffixIcon: Icons.arrow_forward,
                            onTap: () {},
                          ),
                          Divider(color: Colors.grey, height: 0.3),
                          CustomButton(
                            text: 'Lịch sử xem tin',
                            color: ColorPalette.textPrimaryColor,
                            prefixIcon: Icons.history,
                            suffixIcon: Icons.arrow_forward,
                            onTap: () {},
                          ),
                          Divider(color: Colors.grey, height: 0.3),
                          CustomButton(
                            text: 'Đánh giá từ tôi',
                            color: ColorPalette.textPrimaryColor,
                            prefixIcon: Icons.star_border,
                            suffixIcon: Icons.arrow_forward,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppDimens.spacingM),
                    Text(
                      "Khác",
                      style: TextStyle(
                        fontFamily: TextStyles.fontFamily,
                        fontSize: TextStyles.smallBodySize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingDefault),
                      decoration: BoxDecoration(
                        color: ColorPalette.surfaceColor,
                        borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                      ),
                      child: Column(
                        children: [
                          CustomButton(
                            text: 'Về chúng tôi',
                            color: ColorPalette.textPrimaryColor,
                            prefixIcon: Icons.assignment_outlined,
                            suffixIcon: Icons.arrow_forward,
                            onTap: () {},
                          ),
                          Divider(color: Colors.grey, height: 0.3),
                          CustomButton(
                            text: 'Đóng góp ý kiến',
                            color: ColorPalette.textPrimaryColor,
                            prefixIcon: Icons.tips_and_updates_outlined,
                            suffixIcon: Icons.arrow_forward,
                            onTap: () {},
                          ),
                          Divider(color: Colors.grey, height: 0.3),
                          ListenableBuilder(
                            listenable: widget.viewModel,
                            builder: (context, child) {
                              if (widget.viewModel.isLoading) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return CustomButton(
                                text: 'Đăng xuất',
                                color: Colors.red,
                                prefixIcon: Icons.logout,
                                onTap: () {
                                  widget.viewModel.logout();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppDimens.spacingM),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

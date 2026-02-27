import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/components/buttons/primary_button.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorPalette.surfaceColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorPalette.textPrimaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Đổi mật khẩu',
          style: TextStyle(
            fontSize: TextStyles.heading5Size,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textPrimaryColor,
            fontFamily: TextStyles.fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ─── Scrollable content ───
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimens.paddingDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Current password ───
                  _buildPasswordField(
                    label: 'Mật khẩu hiện tại',
                    hintText: 'Nhập mật khẩu hiện tại',
                    controller: _currentPasswordController,
                    obscureText: _obscureCurrent,
                    onToggle: () =>
                        setState(() => _obscureCurrent = !_obscureCurrent),
                  ),
                  const SizedBox(height: AppDimens.spacingM),

                  // ─── New password ───
                  _buildPasswordField(
                    label: 'Mật khẩu mới',
                    hintText: 'Nhập mật khẩu mới',
                    controller: _newPasswordController,
                    obscureText: _obscureNew,
                    onToggle: () => setState(() => _obscureNew = !_obscureNew),
                    subHint: '✓  Tối thiểu 8 kí tự',
                  ),
                  const SizedBox(height: AppDimens.spacingM),

                  // ─── Confirm new password ───
                  _buildPasswordField(
                    label: 'Xác nhận mật khẩu mới',
                    hintText: 'Nhập mật khẩu mới',
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirm,
                    onToggle: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ],
              ),
            ),
          ),

          // ─── Lưu button ───
          PrimaryButton(
            label: 'Lưu',
            labelSize: TextStyles.mediumButtonTextSize,
            buttonHeight: AppDimens.mediumButtonHeight,
            backgroundColor: ColorPalette.primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggle,
    String? subHint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ColorPalette.surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ColorPalette.borderColor,
              width: AppDimens.borderWidth,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  text: label,
                  style: const TextStyle(
                    color: ColorPalette.textPrimaryColor,
                    fontSize: TextStyles.smallBodySize,
                    fontWeight: FontWeight.bold,
                    fontFamily: TextStyles.fontFamily,
                  ),
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: ColorPalette.errorColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: const TextStyle(
                          color: ColorPalette.textDisabledColor,
                          fontSize: TextStyles.mediumInputTextSize,
                          fontFamily: TextStyles.fontFamily,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: const TextStyle(
                        fontSize: TextStyles.mediumInputTextSize,
                        color: ColorPalette.textPrimaryColor,
                        fontFamily: TextStyles.fontFamily,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onToggle,
                    child: Icon(
                      obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: AppDimens.iconDefault,
                      color: ColorPalette.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (subHint != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              subHint,
              style: const TextStyle(
                fontSize: TextStyles.smallBodySize,
                color: ColorPalette.textSecondaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/routing/routes.dart';
import 'package:stupass_frontend/ui/core/components/buttons/primary_button.dart';
import 'package:stupass_frontend/ui/core/components/inputs/primary_textformfield.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/reset_password_view_model.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    required this.viewModel,
    required this.token,
  });

  final ResetPasswordViewModel viewModel;
  final String token;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant ResetPasswordPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.removeListener(_onResult);
    widget.viewModel.addListener(_onResult);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    widget.viewModel.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go(Routes.signin),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const SizedBox(height: 16),
              const Text(
                "Đặt lại mật khẩu",
                style: TextStyle(
                  fontSize: TextStyles.heading1Size,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Nhập mật khẩu mới của bạn",
                style: TextStyle(
                  fontSize: TextStyles.largeButtonTextSize,
                  color: ColorPalette.textSecondaryColor,
                ),
              ),

              const SizedBox(height: 32),

              // New Password Input
              const Text(
                "Mật khẩu mới",
                style: TextStyle(
                  fontSize: 16,
                  color: ColorPalette.textSecondaryColor,
                ),
              ),

              const SizedBox(height: 8),

              PrimaryTextformfield(
                hintText: "**********",
                prefixWidget:
                    const Icon(Icons.lock_outline, color: Colors.grey),
                isPassword: true,
                isPasswordVisible: _isPasswordVisible,
                onTogglePassword: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                onSaved: (newValue) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Mật khẩu là bắt buộc.";
                  }
                  if (value.length < 8) {
                    return "Mật khẩu phải ít nhất 8 ký tự.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Confirm Password Input
              const Text(
                "Xác nhận mật khẩu",
                style: TextStyle(
                  fontSize: 16,
                  color: ColorPalette.textSecondaryColor,
                ),
              ),

              const SizedBox(height: 8),

              PrimaryTextformfield(
                hintText: "**********",
                prefixWidget:
                    const Icon(Icons.lock_outline, color: Colors.grey),
                isPassword: true,
                isPasswordVisible: _isConfirmPasswordVisible,
                onTogglePassword: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmPasswordController,
                onSaved: (newValue) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Xác nhận mật khẩu là bắt buộc.";
                  }
                  if (value != _passwordController.text) {
                    return "Mật khẩu không khớp.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Submit Button
              ListenableBuilder(
                listenable: widget.viewModel,
                builder: (context, child) {
                  if (widget.viewModel.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorPalette.primaryColor,
                      ),
                    );
                  }
                  return PrimaryButton(
                    label: "Đặt lại mật khẩu",
                    labelSize: TextStyles.largeButtonTextSize,
                    buttonHeight: 56,
                    backgroundColor: ColorPalette.primaryColor,
                    suffixIcon: Icons.arrow_forward,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final password = _passwordController.text;
                        await widget.viewModel.submitResetPassword(
                          widget.token,
                          password,
                        );
                      }
                    },
                  );
                },
              ),

              const Spacer(),

              // Back to Sign In
              Center(
                child: TextButton(
                  onPressed: () => context.go(Routes.signin),
                  child: const Text(
                    "Quay lại Đăng nhập",
                    style: TextStyle(
                      color: ColorPalette.primaryButtonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _onResult() {
    if (widget.viewModel.isLoading) return;

    if (widget.viewModel.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu đã được đặt lại thành công!'),
          backgroundColor: Colors.green,
        ),
      );

      if (context.mounted) context.go(Routes.signin);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.viewModel.errorMessage ?? 'Có lỗi xảy ra'),
          backgroundColor: ColorPalette.errorColor,
        ),
      );
    }
  }
}

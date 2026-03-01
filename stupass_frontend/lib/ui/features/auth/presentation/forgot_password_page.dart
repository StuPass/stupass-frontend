import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/routing/routes.dart';
import 'package:stupass_frontend/ui/core/components/buttons/primary_button.dart';
import 'package:stupass_frontend/ui/core/components/inputs/primary_textformfield.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/forgot_password_view_model.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key, required this.viewModel});

  final ForgotPasswordViewModel viewModel;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant ForgotPasswordPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.removeListener(_onResult);
    widget.viewModel.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onResult);
    _emailController.dispose();
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
              const SizedBox(height: 16),
              const Text(
                "Quên mật khẩu",
                style: TextStyle(
                  fontSize: TextStyles.heading1Size,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Nhập email của bạn để nhận đường dẫn đặt lại mật khẩu",
                style: TextStyle(
                  fontSize: TextStyles.largeButtonTextSize,
                  color: ColorPalette.textSecondaryColor,
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                "Email",
                style: TextStyle(
                  fontSize: 16,
                  color: ColorPalette.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 8),
              PrimaryTextformfield(
                hintText: "student@placeholder.edu.vn",
                prefixWidget: const Icon(Icons.email_outlined, color: Colors.grey),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                onSaved: (newValue) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email là bắt buộc.";
                  }
                  // simple email check
                  if (!RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$").hasMatch(value)) {
                    return "Email không hợp lệ.";
                  }
                  return null;
                },
                onTogglePassword: () {},
              ),

              const SizedBox(height: 24),

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
                    label: "Gửi email đặt lại",
                    labelSize: TextStyles.largeButtonTextSize,
                    buttonHeight: 56,
                    backgroundColor: ColorPalette.primaryColor,
                    suffixIcon: Icons.arrow_forward,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await widget.viewModel.submitForgotPassword(
                            _emailController.text.trim());
                      }
                    },
                  );
                },
              ),

              const Spacer(),

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
          content: Text('Kiểm tra email để lấy đường dẫn đặt lại mật khẩu.'),
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

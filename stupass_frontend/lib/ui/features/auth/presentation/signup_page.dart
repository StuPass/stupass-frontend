import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/routing/routes.dart';
import 'package:stupass_frontend/ui/core/components/buttons/primary_button.dart';
import 'package:stupass_frontend/ui/core/components/inputs/primary_textformfield.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/signnup_view_model/signup_view_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, required this.viewModel});

  final SignupViewModel viewModel;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  void didUpdateWidget(covariant SignupPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }  

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,

      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          widget.viewModel.cancelRegistration();
        }
      },  

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.pop(),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------------------------------------------------
                    // 1. Header Section
                    // ---------------------------------------------------------
                    const SizedBox(height: 16),
                    const Text(
                      "Đăng ký",
                      style: TextStyle(
                        fontSize: TextStyles.heading1Size,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Nhập các thông tin cần thiết để hoàn thành thiết lập hồ sơ cá nhân",
                      style: TextStyle(
                        fontSize: 16, 
                        color: ColorPalette.textSecondaryColor,
                        height: 1.5, 
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ---------------------------------------------------------
                    // 2. Form Section
                    // ---------------------------------------------------------
                    
                    // --- identifier Field ---
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
                      onTogglePassword: () {}, 
                      keyboardType: TextInputType.emailAddress,
                      controller: _identifierController,
                      onSaved: (newValue) {},
                      validator: (value) {
                        if (!value!.contains("edu")) {
                          return "Email không phải của sinh viên.";
                        }

                        return null; 
                      },
                    ),

                    const SizedBox(height: 24),

                    // --- Password Field ---
                    const Text(
                      "Mật khẩu",
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorPalette.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    PrimaryTextformfield(
                      hintText: "Tối thiểu 8 kí tự", 
                      prefixWidget: const Icon(Icons.lock_outline, color: Colors.grey),
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

                    // --- Confirm Password Field (New) ---
                    const Text(
                      "Nhập lại mật khẩu",
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorPalette.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    PrimaryTextformfield(
                      hintText: "**********",
                      prefixWidget: const Icon(Icons.lock_outline, color: Colors.grey),
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
                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    // ---------------------------------------------------------
                    // 3. Action Section
                    // ---------------------------------------------------------
                    PrimaryButton(
                    label: "Đăng ký",
                    labelSize: TextStyles.largeButtonTextSize,
                    buttonHeight: 56,
                    backgroundColor: ColorPalette.primaryColor,
                    suffixIcon: Icons.arrow_forward,
                    onPressed: () {
                        final identifier = _identifierController.text.trim();
                        final password = _passwordController.text;
                        final confirmPassword = _confirmPasswordController.text;

                        if (password != confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mật khẩu không khớp!')),
                          );
                          return; 
                        }

                        widget.viewModel.register(identifier, password);
                        context.pushNamed(Routes.createProfileName);
                      },
                    ),


                    const Spacer(),

                    // ---------------------------------------------------------
                    // 4. Footer
                    // ---------------------------------------------------------
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Đã có tài khoản? ",
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                          children: [
                            TextSpan(
                              text: "Đăng nhập",
                              style: const TextStyle(
                                color: ColorPalette.primaryButtonColor,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  widget.viewModel.cancelRegistration();

                                  context.pop(); 
                                },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
          ),
        )
     );
  }
}
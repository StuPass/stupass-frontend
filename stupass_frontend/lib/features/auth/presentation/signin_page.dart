import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/core/components/buttons/outline_button.dart';
import 'package:stupass_frontend/core/components/buttons/primary_button.dart';
import 'package:stupass_frontend/core/components/inputs/primary_textformfield.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';
import 'package:stupass_frontend/features/home/presentation/marketplace_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
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
          onPressed: () => context.go('/'), 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Section
            const SizedBox(height: 16),
            const Text(
              "Chào mừng trở lại!",
              style: TextStyle(
                fontSize: TextStyles.heading1Size, 
                fontWeight: FontWeight.bold,
                color: ColorPalette.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Đăng nhập để tiếp tục",
              style: TextStyle(
                fontSize: TextStyles.largeButtonTextSize,
                color: ColorPalette.textSecondaryColor, 
              ),
            ),
            
            const SizedBox(height: 32),

            // 2. Form Section
            // Phone Number Input
            const Text(
              "Số điện thoại",
              style: TextStyle(
                fontSize: 16,
                color: ColorPalette.textSecondaryColor,
              ),
            ),

            const SizedBox(height: 8),

            PrimaryTextformfield(
              hintText: "0123456789", 
              prefixWidget: const Icon(Icons.phone_outlined, color: Colors.grey), 
              onTogglePassword: () {}, 
              keyboardType: TextInputType.number, 
              controller: _phoneNumberController, 
              onSaved: (newValue) {}, 
              validator: (value) {
                return null;
              }
            ),

            const SizedBox(height: 24),

            // Password Input
            const Text(
              "Mật khẩu",
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
              isPasswordVisible: _isPasswordVisible,
              onTogglePassword: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              }, 
              keyboardType: TextInputType.visiblePassword, 
              controller: _passwordController, 
              onSaved: (newValue) {
                debugPrint("Password saved: $newValue");
              }, 
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }
                if (value.length < 8) {
                  return "Password must be at least 6 chars";
                }
                return null; 
              }
            ),

            const SizedBox(height: 8),

            // Forgot Password Link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Quên mật khẩu?",
                  style: TextStyle(
                    color: ColorPalette.primaryButtonColor, // Green color from image
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 3. Actions Section
            // Login Button
            PrimaryButton(
              label: "Đăng nhập", 
              labelSize: TextStyles.largeButtonTextSize, 
              buttonHeight: 56, 
              backgroundColor: ColorPalette.primaryColor, 
              suffixIcon: Icons.arrow_forward,
              onPressed: () => context.go('/marketplace')
            ),

            const SizedBox(height: 24),

            // Divider "hoặc" (or)
            const Row(
              children: [
                Expanded(child: Divider(color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("hoặc", style: TextStyle(color: Colors.grey)),
                ),
                Expanded(child: Divider(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 24),

            // Google Sign In Button
            CustomOutlinedButton(
              label: "Đăng nhập với Google", 
              labelSize: TextStyles.largeButtonTextSize, 
              buttonHeight: 56, 
              prefixWidget: Image.asset(
                'assets/images/Google_logo.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {

              }
            ),

            const Spacer(),

            // Footer: Sign Up
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Chưa có tài khoản? ", 
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                  children: [
                    TextSpan(
                      text: "Đăng ký ngay", 
                      style: const TextStyle(
                        color: ColorPalette.primaryButtonColor,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push('/signup');
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
    );
  }
}
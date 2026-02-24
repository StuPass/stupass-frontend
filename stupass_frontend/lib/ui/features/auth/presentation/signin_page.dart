import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/routing/routes.dart';
import 'package:stupass_frontend/ui/core/components/buttons/outline_button.dart';
import 'package:stupass_frontend/ui/core/components/buttons/primary_button.dart';
import 'package:stupass_frontend/ui/core/components/inputs/primary_textformfield.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/signin_view_model.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key, required this.viewModel});

  final SigninViewModel viewModel;

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onResult);
  }
  
  @override
  void didUpdateWidget(covariant SigninPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.removeListener(_onResult);
    widget.viewModel.addListener(_onResult);
  }  

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
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
          onPressed: () => context.go(Routes.home), 
        ),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
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
                    final regex = RegExp(r'^(0)(3|5|7|8|9)[0-9]{8}$');

                    if (value == null || !regex.hasMatch(value)) {
                      return "Số điện thoại không hợp lệ.";
                    }

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
                      return "Mật khẩu là bắt buộc.";
                    }
                    if (value.length < 8) {
                      return "Mật khẩu phải ít nhất 8 ký tự.";
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
                      label: "Đăng nhập", 
                      labelSize: TextStyles.largeButtonTextSize, 
                      buttonHeight: 56, 
                      backgroundColor: ColorPalette.primaryColor, 
                      suffixIcon: Icons.arrow_forward,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final phone = _phoneNumberController.text.trim();
                          final password = _passwordController.text;

                          await widget.viewModel.submitLogin(phone, password);
                        }
                      },
                    );
                  }
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
                              context.push(Routes.signup);
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
      )
    );
  }

  void _onResult() {
    if (widget.viewModel.isLoading) return;

    if (widget.viewModel.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập thành công!'), 
          backgroundColor: Colors.green,
        ),
      );

      if (context.mounted) context.go(Routes.marketplace);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.viewModel.errorMessage!),
          backgroundColor: ColorPalette.errorColor,
        ),
      );
    }
  }
}
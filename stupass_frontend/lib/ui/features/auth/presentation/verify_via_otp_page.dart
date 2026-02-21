import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/routing/routes.dart';
import 'package:pinput/pinput.dart';
import 'package:stupass_frontend/ui/core/components/buttons/primary_button.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/verify_via_otp_view_model.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key, required this.viewModel});

  final OtpVerificationViewModel viewModel;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant OtpVerificationPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.removeListener(_onResult);
    widget.viewModel.addListener(_onResult);
  } 

  @override
  void dispose() {
    _otpController.dispose();
    widget.viewModel.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Define the default theme (Grey box)
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    // 2. Define the focused theme (Green border)
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: ColorPalette.primaryColor, // Your green color
        width: 2, // Thicker border when typing
      ),
      borderRadius: BorderRadius.circular(8),
    );

    // 3. Define the submitted theme (Filled/Green background if you want)
    // For now, let's keep it similar to default but maybe slightly different border
    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.grey.shade500),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------------------------------------------------
            // 1. Header Section
            // ---------------------------------------------------------
            const SizedBox(height: 16),
            const Text(
              "Nhập mã OTP",
              style: TextStyle(
                fontSize: TextStyles.heading1Size,
                fontWeight: FontWeight.bold,
                color: ColorPalette.textPrimaryColor, 
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                text: "Mã xác thực đã được gửi đến số điện thoại ",
                style: TextStyle(
                  fontSize: TextStyles.mediumInputTextSize,
                  color: ColorPalette.textSecondaryColor,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: "\n+84 *** *** 6789",
                    style: TextStyle(
                      fontSize: TextStyles.mediumInputTextSize,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ---------------------------------------------------------
            // 2. OTP Input Section
            // ---------------------------------------------------------
            const Text(
              "OTP",
              style: TextStyle(
                fontSize: TextStyles.mediumInputTextSize,
                color: ColorPalette.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 12),
            
            SizedBox(
              width: double.infinity, 
              child: Pinput(
                length: 6,
                controller: _otpController,
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) async {
                  await widget.viewModel.verifyFirebaseOtp(pin);
                },
              ),
            ),

            const SizedBox(height: 32),

            // ---------------------------------------------------------
            // 3. Action Section
            // ---------------------------------------------------------
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
                  label: "Xác nhận",
                  labelSize: TextStyles.largeButtonTextSize, 
                  buttonHeight: 56,
                  backgroundColor: ColorPalette.primaryColor, 
                  onPressed: () async {
                    final finalPin = _otpController.text;

                    if (finalPin.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Vui lòng nhập đủ 6 số')),
                      );
                      return;
                    }

                    await widget.viewModel.verifyFirebaseOtp(finalPin);
                  },
                );                
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
                          
                          context.go(Routes.signin); 
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

  void _onResult() {
    if (widget.viewModel.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nhập mã thành công!'), 
          backgroundColor: Colors.green,
        ),
      );

      if (context.mounted) context.pushNamed(Routes.createProfileName);
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

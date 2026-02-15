import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/core/components/buttons/primary_button.dart';
import 'package:stupass_frontend/core/components/buttons/primary_dropdown.dart';
import 'package:stupass_frontend/core/components/inputs/primary_textformfield.dart';
import 'package:stupass_frontend/core/constants/school_names.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _fullNameController = TextEditingController();
  final _studentIdController = TextEditingController();
  
  String? _selectedSchool;

  @override
  void dispose() {
    _fullNameController.dispose();
    _studentIdController.dispose();
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
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------------------------------------------------
              // 1. Header Section
              // ---------------------------------------------------------
              const SizedBox(height: 16),
              const Text(
                "Tạo hồ sơ",
                style: TextStyle(
                  fontSize: TextStyles.heading1Size, 
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textColorPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Nhập các thông tin cần thiết để hoàn thành thiết lập hồ sơ cá nhân",
                style: TextStyle(
                  fontSize: 16,
                  color: ColorPalette.textColorSecondary,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // ---------------------------------------------------------
              // 2. Form Section
              // ---------------------------------------------------------

              // --- Full Name Field ---
              const Text(
                "Họ và tên",
                style: TextStyle(
                  fontSize: 16,
                  color: ColorPalette.textColorSecondary,
                ),
              ),
              const SizedBox(height: 8),
              PrimaryTextformfield(
                hintText: "Nguyễn Văn A",
                prefixWidget: const Icon(Icons.person_outline, color: Colors.grey),
                controller: _fullNameController,
                keyboardType: TextInputType.name,
                onSaved: (newValue) {},
                onTogglePassword: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) return "Vui lòng nhập họ tên";
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // --- Student ID Field ---
              const Text(
                "Mã số sinh viên",
                style: TextStyle(
                  fontSize: 16,
                  color: ColorPalette.textColorSecondary,
                ),
              ),
              const SizedBox(height: 8),
              PrimaryTextformfield(
                hintText: "20020001",
                // Using a hash icon or similar for ID
                prefixWidget: const Icon(Icons.tag, color: Colors.grey),
                controller: _studentIdController,
                keyboardType: TextInputType.number,
                onSaved: (newValue) {},
                onTogglePassword: () {},
                validator: (value) {},
              ),

              const SizedBox(height: 24),

              // --- University Field (Dropdown simulation) ---
              const Text(
                "Trường",
                style: TextStyle(
                  fontSize: 16,
                  color: ColorPalette.textColorSecondary,
                ),
              ),
              const SizedBox(height: 8),
              
              PrimaryDropdown(
                value: _selectedSchool,
                items: schools, 
                hintText: "Chọn trường của bạn",
                prefixIcon: const Icon(Icons.apartment_outlined, color: Colors.grey),
                
                onChanged: (newValue) {
                  setState(() {
                    _selectedSchool = newValue;
                  });
                },
                
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn trường học';
                  }
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
                onPressed: () => context.go('/signin'),
              ),

              const SizedBox(height: 24),

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
                          ..onTap = () => context.go('/signin'),
                          
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
    );
  }


}
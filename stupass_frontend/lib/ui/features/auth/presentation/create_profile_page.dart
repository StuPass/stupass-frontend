import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/routing/routes.dart';
import 'package:stupass_frontend/ui/core/components/buttons/primary_button.dart';
import 'package:stupass_frontend/ui/core/components/buttons/primary_dropdown.dart';
import 'package:stupass_frontend/ui/core/components/inputs/primary_textformfield.dart';
import 'package:stupass_frontend/ui/core/constants/school_names.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/create_profile_view_model.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key, required this.viewModel});

  final CreateProfileViewModel viewModel;

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _studentIdController = TextEditingController();
  
  String? _selectedSchool;

  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant CreateProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.removeListener(_onResult);
    widget.viewModel.addListener(_onResult);
  }  
  
  @override
  void dispose() {
    _fullNameController.dispose();
    _studentIdController.dispose();
    _usernameController.dispose();
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
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
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

                // --- Username Field ---
                const Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorPalette.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                PrimaryTextformfield(
                  hintText: "A_123",
                  prefixWidget: const Icon(Icons.account_circle, color: Colors.grey),
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  onSaved: (newValue) {},
                  onTogglePassword: () {},
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Vui lòng nhập username.";
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // --- Full Name Field ---
                const Text(
                  "Họ và tên",
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorPalette.textSecondaryColor,
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
                    if (value == null || value.isEmpty) return "Vui lòng nhập họ tên.";
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // --- Student ID Field ---
                const Text(
                  "Mã số sinh viên",
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorPalette.textSecondaryColor,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Vui lòng nhập MSSV.";
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // --- University Field (Dropdown simulation) ---
                const Text(
                  "Trường",
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorPalette.textSecondaryColor,
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
                      return 'Vui lòng chọn trường học.';
                    }
                    return null;
                  },
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
                      label: "Đăng ký",
                      labelSize: TextStyles.largeButtonTextSize,
                      buttonHeight: 56,
                      backgroundColor: ColorPalette.primaryColor,
                      suffixIcon: Icons.arrow_forward,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await widget.viewModel.completeRegistration(
                            _usernameController.text,
                            _fullNameController.text,
                            _studentIdController.text,
                            _selectedSchool!,
                          );
                        }
                      },
                    );                
                  },
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
        ),
      ),
    );
  }
  void _onResult() {
    if (widget.viewModel.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thành công!'), 
          backgroundColor: Colors.green,
        ),
      );

      if (context.mounted) context.go(Routes.signin);
    } else if (widget.viewModel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.viewModel.errorMessage!),
          backgroundColor: ColorPalette.errorColor,
        ),
      );
    }
  }
}
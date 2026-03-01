import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/components/buttons/primary_button.dart';
import 'package:stupass_frontend/ui/core/components/inputs/input_text_field.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/account/presentation/widgets/input_contact_field.dart';
import 'package:stupass_frontend/ui/features/account/presentation/widgets/input_date_field.dart';
import 'package:stupass_frontend/ui/features/account/presentation/widgets/input_dropdown_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: 'Nguyễn Trần Khánh Duy');
  final _studentIdController = TextEditingController();
  final _schoolController = TextEditingController();
  final _addressController = TextEditingController();
  String? _selectedGender;
  DateTime? _birthday;

  static const List<String> _genderOptions = ['Nam', 'Nữ', 'Khác'];

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _schoolController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthday() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthday ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _birthday = picked);
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorPalette.surfaceColor,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorPalette.textPrimaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Chỉnh sửa trang cá nhân',
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
                  // ─── Section: Thông tin cá nhân ───
                  _buildSectionHeader('Thông tin cá nhân'),
                  const SizedBox(height: AppDimens.spacingM),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.surfaceColor,
                      borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                    ),
                    padding: const EdgeInsets.all(AppDimens.spacingM),
                    child: Column(
                      children: [
                        InputTextField(
                          label: 'Họ và tên',
                          isRequired: true,
                          hintText: '',
                          controller: _nameController,
                        ),
                        const SizedBox(height: AppDimens.spacingM),
                        InputTextField(
                          label: 'Mã số sinh viên',
                          isRequired: true,
                          hintText: 'Mã số sinh viên của bạn',
                          controller: _studentIdController,
                        ),
                        const SizedBox(height: AppDimens.spacingM),
                        InputTextField(
                          label: 'Trường',
                          isRequired: true,
                          hintText: 'Trường của bạn',
                          controller: _schoolController,
                        ),
                        const SizedBox(height: AppDimens.spacingM),
                        InputTextField(
                          label: 'Địa chỉ',
                          hintText: 'Địa chỉ của bạn',
                          controller: _addressController,
                        ),
                        const SizedBox(height: AppDimens.spacingM),
                        InputDropdownField(
                          label: 'Giới tính',
                          hintText: 'Chọn giới tính',
                          value: _selectedGender,
                          options: _genderOptions,
                          onChanged: (val) =>
                              setState(() => _selectedGender = val),
                        ),
                        const SizedBox(height: AppDimens.spacingM),
                        InputDateField(
                          label: 'Ngày sinh',
                          hintText: 'Ngày, tháng, sinh',
                          value: _formatDate(_birthday),
                          onTap: _pickBirthday,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimens.spacingL),

                  // ─── Section: Thông tin liên lạc ───
                  _buildSectionHeader('Thông tin liên lạc'),
                  const SizedBox(height: AppDimens.spacingM),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.surfaceColor,
                      borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                    ),
                    child: Column(
                      children: [
                        InputContactField(
                          icon: Icons.phone,
                          label: 'Số điện thoại',
                          onAdd: () {},
                        ),
                        Divider(
                          height: 1,
                          indent: AppDimens.paddingDefault,
                          color: ColorPalette.backgroundColor,
                        ),
                        InputContactField(
                          customIcon: _buildGoogleIcon(),
                          label: 'Google',
                          onAdd: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimens.spacingXL),
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

  // ─── Helpers ───

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: TextStyles.heading5Size,
        fontWeight: FontWeight.bold,
        color: ColorPalette.textPrimaryColor,
        fontFamily: TextStyles.fontFamily,
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: AppDimens.iconDefault,
      height: AppDimens.iconDefault,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDDDDDD)),
      ),
      child: const Center(
        child: Text(
          'G',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4285F4),
          ),
        ),
      ),
    );
  }
}

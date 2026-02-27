import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController =
      TextEditingController(text: 'Nguyễn Trần Khánh Duy');
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
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: ColorPalette.textPrimaryColor),
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
                      borderRadius:
                          BorderRadius.circular(AppDimens.radiusRec),
                    ),
                    padding: const EdgeInsets.all(AppDimens.spacingM),
                    child: Column(
                      children: [
                        _buildLabeledField(
                          label: 'Họ và tên *',
                          controller: _nameController,
                          hint: '',
                        ),
                        const SizedBox(height: AppDimens.spacingM),
                        _buildLabeledField(
                          label: 'Mã số sinh viên *',
                          controller: _studentIdController,
                          hint: 'Mã số sinh viên của bạn',
                        ),
                        const SizedBox(height: AppDimens.spacingM),
                        _buildLabeledField(
                          label: 'Trường *',
                          controller: _schoolController,
                          hint: 'Trường của bạn',
                        ),
                        const SizedBox(height: AppDimens.spacingM),
                        _buildLabeledField(
                          label: 'Địa chỉ',
                          controller: _addressController,
                          hint: 'Địa chỉ của bạn',
                        ),
                        const SizedBox(height: AppDimens.spacingM),
                        _buildDropdownField(
                          label: 'Giới tính',
                          hint: 'Chọn giới tính',
                          value: _selectedGender,
                          options: _genderOptions,
                          onChanged: (val) =>
                              setState(() => _selectedGender = val),
                        ),
                        const SizedBox(height: AppDimens.spacingM),
                        _buildDateField(
                          label: 'Ngày sinh',
                          hint: 'Ngày, tháng, sinh',
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
                      borderRadius:
                          BorderRadius.circular(AppDimens.radiusRec),
                    ),
                    child: Column(
                      children: [
                        _buildContactRow(
                          icon: Icons.phone,
                          label: 'Số điện thoại',
                          onAdd: () {},
                        ),
                        Divider(
                          height: 1,
                          indent: AppDimens.paddingDefault,
                          color: ColorPalette.backgroundColor,
                        ),
                        _buildContactRow(
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
          Container(
            color: ColorPalette.surfaceColor,
            padding: const EdgeInsets.all(AppDimens.paddingDefault),
            child: SizedBox(
              width: double.infinity,
              height: AppDimens.largeButtonHeight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimens.radiusCir),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Lưu',
                  style: TextStyle(
                    fontSize: TextStyles.mediumButtonTextSize,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.onPrimaryButtonColor,
                    fontFamily: TextStyles.fontFamily,
                  ),
                ),
              ),
            ),
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

  Widget _buildLabeledField({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: TextStyles.smallBodySize,
            fontWeight: FontWeight.w500,
            color: ColorPalette.textPrimaryColor,
            fontFamily: TextStyles.fontFamily,
          ),
        ),
        const SizedBox(height: AppDimens.spacingXS),
        SizedBox(
          height: AppDimens.smallInputFieldHeight,
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: TextStyles.smallBodySize,
              color: ColorPalette.textPrimaryColor,
              fontFamily: TextStyles.fontFamily,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: TextStyles.smallBodySize,
                color: ColorPalette.textSecondaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
              filled: true,
              fillColor: ColorPalette.surfaceColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                borderSide: const BorderSide(
                    color: ColorPalette.borderColor,
                    width: AppDimens.borderWidth),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                borderSide: const BorderSide(
                    color: ColorPalette.primaryColor,
                    width: AppDimens.borderWidth),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingM,
                vertical: AppDimens.spacingS,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: TextStyles.smallBodySize,
            fontWeight: FontWeight.w500,
            color: ColorPalette.textPrimaryColor,
            fontFamily: TextStyles.fontFamily,
          ),
        ),
        const SizedBox(height: AppDimens.spacingXS),
        SizedBox(
          height: AppDimens.smallInputFieldHeight,
          child: DropdownButtonFormField<String>(
            hint: Text(
              hint,
              style: const TextStyle(
                fontSize: TextStyles.smallBodySize,
                color: ColorPalette.textSecondaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down,
                color: ColorPalette.textSecondaryColor),
            style: const TextStyle(
              fontSize: TextStyles.smallBodySize,
              color: ColorPalette.textPrimaryColor,
              fontFamily: TextStyles.fontFamily,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorPalette.surfaceColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                borderSide: const BorderSide(
                    color: ColorPalette.borderColor,
                    width: AppDimens.borderWidth),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                borderSide: const BorderSide(
                    color: ColorPalette.primaryColor,
                    width: AppDimens.borderWidth),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.spacingM, vertical: 0),
            ),
            items: options
                .map((opt) =>
                    DropdownMenuItem(value: opt, child: Text(opt)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required String hint,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: TextStyles.smallBodySize,
            fontWeight: FontWeight.w500,
            color: ColorPalette.textPrimaryColor,
            fontFamily: TextStyles.fontFamily,
          ),
        ),
        const SizedBox(height: AppDimens.spacingXS),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: AppDimens.smallInputFieldHeight,
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingM),
            decoration: BoxDecoration(
              color: ColorPalette.surfaceColor,
              borderRadius: BorderRadius.circular(AppDimens.radiusRec),
              border: Border.all(
                  color: ColorPalette.borderColor,
                  width: AppDimens.borderWidth),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value.isEmpty ? hint : value,
                    style: TextStyle(
                      fontSize: TextStyles.smallBodySize,
                      color: value.isEmpty
                          ? ColorPalette.textSecondaryColor
                          : ColorPalette.textPrimaryColor,
                      fontFamily: TextStyles.fontFamily,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today_outlined,
                    size: AppDimens.iconSmall,
                    color: ColorPalette.textSecondaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow({
    IconData? icon,
    Widget? customIcon,
    required String label,
    required VoidCallback onAdd,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingDefault,
        vertical: AppDimens.spacingM,
      ),
      child: Row(
        children: [
          if (customIcon != null)
            customIcon
          else
            Icon(icon,
                size: AppDimens.iconDefault,
                color: ColorPalette.textSecondaryColor),
          const SizedBox(width: AppDimens.spacingM),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: TextStyles.smallBodySize,
                color: ColorPalette.textPrimaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: const Text(
              'Thêm',
              style: TextStyle(
                fontSize: TextStyles.smallBodySize,
                color: ColorPalette.primaryColor,
                fontWeight: FontWeight.w600,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
          ),
        ],
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

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';


class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final List<String> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          _selectedImages.add(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var file in _selectedImages)
            Container(
              margin: const EdgeInsets.only(right: AppDimens.spacingS),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                image: DecorationImage(
                  image: FileImage(File(file)),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          InkWell(
            onTap: _pickImage,
            child: Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFEEF5EE),
                borderRadius: BorderRadius.circular(AppDimens.radiusRec),
                border: Border.all(color: ColorPalette.borderColor, width: 2),
              ),
              child: const Icon(
                Icons.image,
                size: AppDimens.iconLarge,
                color: ColorPalette.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

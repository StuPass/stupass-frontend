import 'package:flutter/material.dart';

class PrimaryDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Color? fillColor;

  const PrimaryDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = 'Select an option',
    this.prefixIcon,
    this.validator,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
      isExpanded: true,
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: fillColor ?? Colors.grey[100], 
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
      ),

      validator: validator,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}
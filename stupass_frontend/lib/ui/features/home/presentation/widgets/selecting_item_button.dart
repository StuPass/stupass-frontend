import 'package:flutter/material.dart';

class SelectingItemButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectingItemButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle_outline : Icons.circle_outlined,
              color: Colors.black,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
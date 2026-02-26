import 'package:flutter/material.dart';

class AdvanceFilterSheet extends StatelessWidget {
  const AdvanceFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: const Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: const Offset(0, 2),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Text(
                    'Bộ lọc nâng cao',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 40.0),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Text('Nội dung bộ lọc nâng cao sẽ hiển thị ở đây'),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropdownButton extends StatelessWidget {
  final String title;
  final IconData prefixIcon;
  final VoidCallback onTap;

  const CustomDropdownButton({
    super.key,
    required this.title,
    required this.prefixIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color iconAndTextColor = Color(0xFF7D8C8D);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            // 1. Icon bên trái (Được truyền từ bên ngoài vào)
            Icon(
              prefixIcon,
              color: iconAndTextColor,
              size: 24.0,
            ),
            
            const SizedBox(width: 12.0),
            
            // 2. Chữ ở giữa (Được truyền từ bên ngoài vào)
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: iconAndTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: iconAndTextColor,
              size: 28.0,
            ),
          ],
        ),
      ),
    );
  }
}
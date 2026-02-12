import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/components/buttons/recround_filledbutton.dart';

class FilterCategoryBar extends StatefulWidget {
  const FilterCategoryBar({super.key});

  @override
  _FilterCategoryBarState createState() => _FilterCategoryBarState();
}

class _FilterCategoryBarState extends State<FilterCategoryBar> {
  final List<Map<String, dynamic>> categories = [
    {'label': 'Tất cả', 'icon': null},
    {'label': 'Sách giáo trình', 'icon': Icons.menu_book},
    {'label': 'Điện tử', 'icon': Icons.devices},
    {'label': 'Thời trang', 'icon': Icons.checkroom},
    {'label': 'Đồ gia dụng', 'icon': Icons.home_repair_service},
    {'label': 'Phụ kiện', 'icon': Icons.watch},
  ];

  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;
          return RecroundFilledButton(
            label: categories[index]['label'],
            prefixIcon: categories[index]['icon'],
            isSelected: isSelected,
            onPressed: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/components/buttons/recround_filledbutton.dart';

class FilterCategoryBar extends StatefulWidget {
  const FilterCategoryBar({super.key});

  @override
  _FilterCategoryBarState createState() => _FilterCategoryBarState();
}

class _FilterCategoryBarState extends State<FilterCategoryBar> {
  final List<String> categories = ['Tất cả', 'Sách giáo trình'];

  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;
          return RecroundFilledButton(
            label: categories[index],
            isSelected: isSelected,
            onPressed: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
          );
        }

      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/features/storage/presentation/widgets/product_item_horizontal.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  // 0: Đang bán, 1: Đã bán, 2: Đã mua
  int _selectedTabIndex = 0;

  final List<Map<String, String>> _products = [
    {
      'image': 'https://picsum.photos/200/300', 
      'title': 'Advanced Database Systems Textbook',
      'location': 'Thu Duc, tp.HCM',
      'price': '24.000 VNĐ',
    },
    {
      'image': 'https://picsum.photos/201/300',
      'title': 'Mini Fridge OLED Display',
      'location': 'Dorm A, Room 302',
      'price': '1.200.000 VNĐ',
    },
    {
      'image': 'https://picsum.photos/202/300',
      'title': 'Wacom Intuos Tablet Small',
      'location': 'Library, Zone B',
      'price': '1.500.000 VNĐ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.paddingDefault),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kho của tôi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.textPrimaryColor,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: ColorPalette.surfaceColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications, size: AppDimens.iconDefault),
                ),
              ],
            ),
          ),
      
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(4),
            height: 48,
            decoration: BoxDecoration(
              color: ColorPalette.surfaceColor, 
              borderRadius: BorderRadius.circular(AppDimens.radiusRec),
            ),
            child: Row(
              children: [
                _buildTabItem(index: 0, label: 'Đang bán'),
                _buildSeparator(),
                _buildTabItem(index: 1, label: 'Đã bán'),
                _buildSeparator(),
                _buildTabItem(index: 2, label: 'Đã mua'),
              ],
            ),
          ),
      
          const SizedBox(height: AppDimens.spacingM),
      
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _products.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppDimens.spacingM),
              itemBuilder: (context, index) {
                final product = _products[index];
                return ProductItemHorizontal(
                  imageUrl: product['image']!,
                  title: product['title']!,
                  location: product['location']!,
                  price: product['price']!,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      width: 1,
      height: 20,
      color: Colors.grey[300],
    );
  }

  Widget _buildTabItem({required int index, required String label}) {
    final bool isSelected = _selectedTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
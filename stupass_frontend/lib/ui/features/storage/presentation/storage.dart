import 'package:flutter/cupertino.dart';
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
  int _selectedTabIndex = 0;
  final PageController _pageController = PageController();
  final List<Map<String, String>> _productsSelling = [
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
      body: SafeArea(
        child: Column(
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
                    child: const Icon(
                      Icons.notifications,
                      size: AppDimens.iconDefault,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: const Color.fromARGB(255, 220, 220, 220),
                thumbColor: Colors.white,
                groupValue: _selectedTabIndex,
                children: {
                  0: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Đang bán',
                      style: TextStyle(
                        fontWeight: _selectedTabIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  1: const Text('Đã bán'),
                  2: const Text('Đã mua'),
                },
                onValueChanged: (value) {
                  setState(() => _selectedTabIndex = value!);
                  _pageController.animateToPage(
                    value!,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            const SizedBox(height: AppDimens.spacingM),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) =>
                    setState(() => _selectedTabIndex = index),
                children: [
                  _buildProductList(_productsSelling),
                  _buildEmptyState('Bạn chưa bán món đồ nào'),
                  _buildEmptyState('Bạn chưa mua món đồ nào'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<Map<String, String>> products) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: products.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppDimens.spacingM),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductItemHorizontal(
          imageUrl: product['image']!,
          title: product['title']!,
          location: product['location']!,
          price: product['price']!,
          onTap: () {},
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Text(message, style: const TextStyle(color: Colors.grey)),
    );
  }
}

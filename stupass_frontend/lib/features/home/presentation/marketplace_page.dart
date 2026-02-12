import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/app_dimens.dart';
import 'package:stupass_frontend/core/theme/color_palette.dart';
import 'package:stupass_frontend/core/theme/text_styles.dart';
import 'package:stupass_frontend/core/components/buttons/circle_iconbutton.dart';
import 'package:stupass_frontend/core/components/inputs/products_search_field.dart';
import 'package:stupass_frontend/features/home/presentation/widgets/filter_category_bar.dart';
import 'package:stupass_frontend/features/home/presentation/widgets/post_grid_view.dart';

// hiện tại chưa có logic, selectedindex sẽ được thêm sau này. để đồng bộ filterbar và post grid
class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: AppDimens.spacingL,
          children: [
            Row(
              children: [
                Icon(
                  Icons.shopping_bag,
                  color: ColorPalette.primaryColor,
                  size: 36,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Stu",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.textPrimaryColor,
                    fontFamily: TextStyles.fontFamily
                  ),
                ),
                const Text(
                  "Pass",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: ColorPalette.primaryColor,
                    fontFamily: TextStyles.fontFamily
                  ),
                ),
                const Spacer(),
                CircleIconbutton(
                  icon: Icons.notifications_rounded,
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 9, 
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorPalette.surfaceColor,
                      borderRadius: BorderRadius.circular(AppDimens.radiusCir),
                    ),
                    child: ProductsSearchField())),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleIconbutton(
                        icon: Icons.filter_list,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Category filter section
            FilterCategoryBar(),
            // Posts grid section
            PostGridView(
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}


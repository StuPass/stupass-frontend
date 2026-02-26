import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/core/components/buttons/circle_iconbutton.dart';
import 'package:stupass_frontend/ui/features/home/presentation/widgets/post_grid_view.dart';
import 'package:stupass_frontend/ui/features/home/presentation/advance_filter_sheet.dart';
import 'package:stupass_frontend/ui/core/components/inputs/products_search_field.dart';

class FilteredPage extends StatefulWidget {
  final String searchQuery;
  final List<String> activeFilters;

  const FilteredPage({
    super.key,
    this.searchQuery = '',
    this.activeFilters = const [],
  });

  @override
  State<FilteredPage> createState() => _FilteredPageState();
}

class _FilteredPageState extends State<FilteredPage> {
  late TextEditingController _searchController;
  late List<String> _activeFilters;
  String _sortMethod = 'Mới nhất';

  static const int _itemCount = 6;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
    _activeFilters = List.from(widget.activeFilters);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _removeFilter(String filter) {
    setState(() => _activeFilters.remove(filter));
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppDimens.spacingM)),
      ),
      builder: (context) => _SortSheet(
        currentSort: _sortMethod,
        onSortSelected: (sort) {
          setState(() => _sortMethod = sort);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppDimens.spacingM)),
      ),
      builder: (context) => const AdvanceFilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: Column(
        children: [
          // ─── Top bar ───
          Container(
            color: ColorPalette.surfaceColor,
            padding: EdgeInsets.only(
              top: statusBarHeight + AppDimens.spacingS,
              left: AppDimens.spacingM,
              right: AppDimens.spacingM,
              bottom: AppDimens.spacingM,
            ),
            child: Row(
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: ColorPalette.backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back,
                        size: 20, color: ColorPalette.textPrimaryColor),
                  ),
                ),
                SizedBox(width: AppDimens.spacingS),
                // Search bar
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: ColorPalette.backgroundColor,
                      borderRadius: BorderRadius.circular(AppDimens.radiusCir),
                    ),
                    child: ProductsSearchField(
                      searchController: _searchController,
                    ),
                  ),
                ),
                SizedBox(width: AppDimens.spacingS),
                // Filter icon
                CircleIconbutton(
                  icon: Icons.filter_list,
                  onPressed: _showFilterSheet,
                ),
              ],
            ),
          ),

          // ─── Active filter chips ───
          if (_activeFilters.isNotEmpty)
            Container(
              color: ColorPalette.surfaceColor,
              padding: EdgeInsets.only(
                left: AppDimens.spacingM,
                right: AppDimens.spacingM,
                bottom: AppDimens.spacingS,
              ),
              child: SizedBox(
                height: 32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _activeFilters.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: AppDimens.spacingS),
                  itemBuilder: (context, index) {
                    final filter = _activeFilters[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.spacingM,
                        vertical: AppDimens.spacingXS,
                      ),
                      decoration: BoxDecoration(
                        color: ColorPalette.borderColor,
                        borderRadius: BorderRadius.circular(AppDimens.radiusCir),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            filter,
                            style: TextStyle(
                              fontSize: TextStyles.largeCaptionSize,
                              color: ColorPalette.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => _removeFilter(filter),
                            child: Icon(Icons.close,
                                size: 14, color: ColorPalette.primaryColor),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

          // ─── Sort bar + result count ───
          Container(
            color: ColorPalette.surfaceColor,
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.paddingDefault,
              vertical: AppDimens.spacingS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Result count
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: TextStyles.smallBodySize,
                      color: ColorPalette.textSecondaryColor,
                      fontFamily: TextStyles.fontFamily,
                    ),
                    children: [
                      TextSpan(
                        text: '$_itemCount ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.textPrimaryColor,
                        ),
                      ),
                      const TextSpan(text: 'kết quả'),
                    ],
                  ),
                ),
                // Sort button
                GestureDetector(
                  onTap: _showSortSheet,
                  child: Row(
                    children: [
                      Icon(Icons.swap_vert,
                          size: 18, color: ColorPalette.primaryColor),
                      SizedBox(width: 4),
                      Text(
                        _sortMethod,
                        style: TextStyle(
                          fontSize: TextStyles.smallBodySize,
                          color: ColorPalette.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: ColorPalette.borderColor),

          // ─── Results list ───
          if (_itemCount == 0)
            Expanded(child: _buildEmptyState())
          else
            PostGridView(itemCount: _itemCount),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off,
              size: 64, color: ColorPalette.textSecondaryColor),
          SizedBox(height: AppDimens.spacingM),
          Text(
            'Không tìm thấy kết quả',
            style: TextStyle(
              fontSize: TextStyles.heading5Size,
              fontWeight: FontWeight.bold,
              color: ColorPalette.textPrimaryColor,
            ),
          ),
          SizedBox(height: AppDimens.spacingS),
          Text(
            'Thử thay đổi từ khoá hoặc bộ lọc',
            style: TextStyle(
              fontSize: TextStyles.smallBodySize,
              color: ColorPalette.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Sort Bottom Sheet ───
class _SortSheet extends StatelessWidget {
  final String currentSort;
  final ValueChanged<String> onSortSelected;

  static const List<Map<String, dynamic>> _sortOptions = [
    {'label': 'Mới nhất', 'icon': Icons.access_time},
    {'label': 'Giá tăng dần', 'icon': Icons.arrow_upward},
    {'label': 'Giá giảm dần', 'icon': Icons.arrow_downward},
    {'label': 'Phổ biến nhất', 'icon': Icons.trending_up},
  ];

  const _SortSheet({
    required this.currentSort,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingDefault),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ColorPalette.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: AppDimens.spacingM),
          Text(
            'Sắp xếp theo',
            style: TextStyle(
              fontSize: TextStyles.heading5Size,
              fontWeight: FontWeight.bold,
              color: ColorPalette.textPrimaryColor,
            ),
          ),
          SizedBox(height: AppDimens.spacingS),
          ..._sortOptions.map((option) {
            final isSelected = option['label'] == currentSort;
            return ListTile(
              leading: Icon(
                option['icon'] as IconData,
                color: isSelected
                    ? ColorPalette.primaryColor
                    : ColorPalette.textSecondaryColor,
              ),
              title: Text(
                option['label'] as String,
                style: TextStyle(
                  fontSize: TextStyles.smallBodySize,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? ColorPalette.primaryColor
                      : ColorPalette.textPrimaryColor,
                ),
              ),
              trailing: isSelected
                  ? Icon(Icons.check, color: ColorPalette.primaryColor)
                  : null,
              onTap: () => onSortSelected(option['label'] as String),
              contentPadding: EdgeInsets.zero,
              dense: true,
            );
          }),
          SizedBox(height: AppDimens.spacingM),
        ],
      ),
    );
  }
}
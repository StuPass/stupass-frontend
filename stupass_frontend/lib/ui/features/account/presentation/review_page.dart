import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/account/presentation/widgets/product_item_horizontal.dart';
import 'package:stupass_frontend/ui/features/account/presentation/widgets/report_item.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // ─── Mock comment data ───
  static const List<Map<String, String>> _comments = [
    {
      'imageUrl': 'https://picsum.photos/id/1/200',
      'title': 'Giáo trình Cơ sở dữ liệu',
      'price': '24.000 VND',
      'location': 'Thủ Đức, tp.HCM',
    },
    {
      'imageUrl': 'https://picsum.photos/id/20/200',
      'title': 'Airpod 12 pro',
      'price': '120.000 VND',
      'location': 'Làng Đại Học, tp.HCM',
    },
    {
      'imageUrl': 'https://picsum.photos/id/30/200',
      'title': 'Macbook Air M11 2020',
      'price': '120.000 VND',
      'location': 'Quận 1, tp.HCM',
    },
  ];

  // ─── Mock report data ───
  static const List<Map<String, dynamic>> _reports = [
    {
      'avatarUrl': 'assets/images/flea_market_image.jfif',
      'reporterName': 'Bạn đã report Lan',
      'reason': 'Làm ăn gian lận...',
      'time': '3h trước',
    },
    {
      'avatarUrl': 'assets/images/flea_market_image.jfif',
      'reporterName': 'Bạn đã report Hoa',
      'reason': 'Sản phẩm không đúng mô tả...',
      'time': '2 ngày trước',
    },
    {
      'avatarUrl': 'assets/images/flea_market_image.jfif',
      'reporterName': 'Bạn đã report Huy',
      'reason': 'Không phản hồi tin nhắn...',
      'time': '5 ngày trước',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorPalette.surfaceColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorPalette.textPrimaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Đánh giá từ tôi',
          style: TextStyle(
            fontSize: TextStyles.heading5Size,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textPrimaryColor,
            fontFamily: TextStyles.fontFamily,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: ColorPalette.primaryColor,
          unselectedLabelColor: ColorPalette.textSecondaryColor,
          labelStyle: const TextStyle(
            fontSize: TextStyles.smallBodySize,
            fontWeight: FontWeight.bold,
            fontFamily: TextStyles.fontFamily,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: TextStyles.smallBodySize,
            fontWeight: FontWeight.normal,
            fontFamily: TextStyles.fontFamily,
          ),
          indicatorColor: ColorPalette.primaryColor,
          indicatorWeight: 2.5,
          tabs: const [
            Tab(text: 'Bình luận'),
            Tab(text: 'Báo cáo'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ─── Comment tab ───
          ListView.separated(
            padding: const EdgeInsets.all(AppDimens.paddingDefault),
            itemCount: _comments.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppDimens.spacingM),
            itemBuilder: (context, index) {
              final item = _comments[index];
              return ProductItemHorizontal(
                imageUrl: item['imageUrl']!,
                title: item['title']!,
                price: item['price']!,
                location: item['location']!,
              );
            },
          ),

          // ─── Report tab ───
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimens.spacingM,
            ),
            itemCount: _reports.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              indent: AppDimens.paddingDefault,
              endIndent: AppDimens.paddingDefault,
              color: ColorPalette.backgroundColor,
            ),
            itemBuilder: (context, index) {
              final item = _reports[index];
              return ReportItem(
                avatarUrl: item['avatarUrl'] as String,
                reporterName: item['reporterName'] as String,
                reason: item['reason'] as String,
                time: item['time'] as String,
              );
            },
          ),
        ],
      ),
    );
  }
}

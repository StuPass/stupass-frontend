import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/features/account/presentation/widgets/notification_item.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'avatarUrl': 'assets/images/flea_market_image.jfif',
      'title': 'Lan đã report bạn',
      'subtitle': 'Làm ăn như...',
      'time': '3h trước',
      'isRead': false,
    },
    {
      'avatarUrl': 'assets/images/flea_market_image.jfif',
      'title': 'Lan đã bình luận bài viết của bạn',
      'subtitle': 'Gặp ở hồ đá đừng bạn nhé!',
      'time': '9 ngày trước',
      'isRead': false,
    },
    {
      'avatarUrl': 'assets/images/flea_market_image.jfif',
      'title': 'Lan đã report bạn',
      'subtitle': 'Làm ăn như...',
      'time': '3h trước',
      'isRead': false,
    },
  ];
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
          'Thông báo',
          style: TextStyle(
            fontSize: TextStyles.heading5Size,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textPrimaryColor,
            fontFamily: TextStyles.fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingDefault,
              vertical: AppDimens.spacingM,
            ),
            child: const Text(
              'Gần đây',
              style: TextStyle(
                fontSize: TextStyles.heading5Size,
                fontWeight: FontWeight.bold,
                color: ColorPalette.textPrimaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _notifications.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey, height: 0.3),
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return NotificationItem(
                  avatarUrl: notification['avatarUrl'],
                  title: notification['title'],
                  subtitle: notification['subtitle'],
                  time: notification['time'],
                  isRead: notification['isRead'],
                  onTap: () =>
                      setState(() => _notifications[index]['isRead'] = true),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/features/chat/presentation/widgets/chat_item.dart';
import 'package:stupass_frontend/ui/features/chat/presentation/widgets/filter_category_bar.dart';

class ChatBoxPage extends StatelessWidget {
  const ChatBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingDefault),
        child: Column(
          children: [
            Text(
              'Tin nhắn',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: TextStyles.fontFamily,
                fontSize: TextStyles.heading4Size,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm sinh viên...',
                        hintStyle: TextStyle(
                          color: ColorPalette.textDisabledColor,
                          fontSize: TextStyles.smallInputTextSize,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorPalette.textDisabledColor,
                          size: AppDimens.iconDefault,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimens.radiusCir,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: ColorPalette.disabledButtonColor,
                      ),
                    ),
                    const SizedBox(height: AppDimens.spacingM),
                    FilterCategoryBar(),
                    const SizedBox(height: AppDimens.spacingM),
                    ChatItem(
                      name: "Nguyễn Văn A",
                      productName: "Laptop Dell XPS 13",
                      lastMessage: "Chào bạn, mình có thể giúp gì?",
                      time: "10:30",
                      avatarUrl: "https://picsum.photos/200/300",
                      productImageUrl: "https://picsum.photos/200/300",
                    ),
                    ChatItem(
                      name: "Trần Thị B",
                      productName: "Điện thoại iPhone 12",
                      lastMessage: "Sản phẩm còn không?",
                      time: "09:15",
                      avatarUrl: "https://picsum.photos/200/300",
                      productImageUrl: "https://picsum.photos/200/300",
                      hasUnread: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

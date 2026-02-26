import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class ChatItem extends StatelessWidget {
  final String name;
  final String productName;
  final String lastMessage;
  final String time;
  final String avatarUrl;
  final String productImageUrl;
  final bool hasUnread;
  final VoidCallback? onTap;

  const ChatItem({
    super.key,
    required this.name,
    required this.productName,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    required this.productImageUrl,
    this.hasUnread = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingDefault, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 32, backgroundImage: NetworkImage(avatarUrl)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontFamily: TextStyles.fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: ColorPalette.textPrimaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                              color: hasUnread
                                  ? ColorPalette.primaryColor
                                  : Colors.grey,
                              fontSize: 13,
                              fontWeight: hasUnread
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (hasUnread)
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: ColorPalette.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          productName,
                          style: TextStyle(
                            color: ColorPalette.secondaryColor,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    style: TextStyle(
                      color: hasUnread ? ColorPalette.textPrimaryColor : ColorPalette.textSecondaryColor,
                      fontSize: TextStyles.smallBodySize,
                      fontWeight: hasUnread
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                productImageUrl,
                width: 65,
                height: 65,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

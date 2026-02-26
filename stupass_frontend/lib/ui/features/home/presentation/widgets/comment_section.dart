import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class CommentItem {
  final String avatarUrl;
  final String userName;
  final String content;
  final String timeAgo;

  const CommentItem({
    required this.avatarUrl,
    required this.userName,
    required this.content,
    required this.timeAgo,
  });
}

class CommentSection extends StatefulWidget {
  final List<CommentItem> comments;

  const CommentSection({
    super.key,
    this.comments = const [],
  });

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _controller = TextEditingController();
  final List<CommentItem> _localComments = [];

  @override
  void initState() {
    super.initState();
    _localComments.addAll(widget.comments);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendComment() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _localComments.add(CommentItem(
        avatarUrl: 'https://via.placeholder.com/40',
        userName: 'Bạn',
        content: text,
        timeAgo: 'Vừa xong',
      ));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette.surfaceColor,
      width: double.infinity,
      padding: EdgeInsets.all(AppDimens.paddingDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Bình luận:',
            style: TextStyle(
              fontSize: TextStyles.heading5Size,
              fontWeight: FontWeight.bold,
              color: ColorPalette.textPrimaryColor,
            ),
          ),
          SizedBox(height: AppDimens.spacingM),

          // Comment list
          if (_localComments.isEmpty)
            SizedBox(height: 100)
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _localComments.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppDimens.spacingM),
              itemBuilder: (context, index) {
                final comment = _localComments[index];
                return _buildCommentItem(comment);
              },
            ),

          SizedBox(height: AppDimens.spacingM),

          // Input bar
          Container(
            decoration: BoxDecoration(
              color: ColorPalette.backgroundColor,
              borderRadius: BorderRadius.circular(AppDimens.radiusCir),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.spacingM,
              vertical: AppDimens.spacingXS,
            ),
            child: Row(
              children: [
                // Text input
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      fontSize: TextStyles.smallBodySize,
                      color: ColorPalette.textPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Aa',
                      hintStyle: TextStyle(
                        fontSize: TextStyles.smallBodySize,
                        color: ColorPalette.textSecondaryColor,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: AppDimens.spacingS,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendComment(),
                  ),
                ),

                // Emoji button
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.sentiment_satisfied_alt,
                    size: 26,
                    color: ColorPalette.primaryColor,
                  ),
                ),
                SizedBox(width: AppDimens.spacingS),

                // Send button
                GestureDetector(
                  onTap: _sendComment,
                  child: Icon(
                    Icons.send,
                    size: 24,
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(CommentItem comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(comment.avatarUrl),
          backgroundColor: ColorPalette.borderColor,
        ),
        SizedBox(width: AppDimens.spacingS),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.spacingM,
              vertical: AppDimens.spacingS,
            ),
            decoration: BoxDecoration(
              color: ColorPalette.backgroundColor,
              borderRadius: BorderRadius.circular(AppDimens.radiusRec),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: TextStyle(
                    fontSize: TextStyles.smallBodySize,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.textPrimaryColor,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  comment.content,
                  style: TextStyle(
                    fontSize: TextStyles.smallBodySize,
                    color: ColorPalette.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: AppDimens.spacingXS),
        Padding(
          padding: EdgeInsets.only(top: AppDimens.spacingS),
          child: Text(
            comment.timeAgo,
            style: TextStyle(
              fontSize: TextStyles.largeCaptionSize,
              color: ColorPalette.textSecondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

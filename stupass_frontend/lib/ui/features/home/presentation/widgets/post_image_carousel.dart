import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class PostImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final VoidCallback? onBack;
  final VoidCallback? onShare;

  const PostImageCarousel({
    super.key,
    required this.imageUrls,
    this.onBack,
    this.onShare,
  });

  @override
  State<PostImageCarousel> createState() => _PostImageCarouselState();
}

class _PostImageCarouselState extends State<PostImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final totalPages = widget.imageUrls.length;

    return Stack(
      children: [
        // PageView
        SizedBox(
          height: 300 + statusBarHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: totalPages,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.imageUrls[index],
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: ColorPalette.backgroundColor,
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: ColorPalette.textSecondaryColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Back button
        Positioned(
          top: statusBarHeight + AppDimens.spacingS,
          left: AppDimens.spacingM,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  size: 20, color: ColorPalette.textPrimaryColor),
              onPressed:
                  widget.onBack ?? () => Navigator.of(context).pop(),
              padding: EdgeInsets.all(AppDimens.spacingXS),
              constraints: const BoxConstraints(),
            ),
          ),
        ),

        // Share button
        Positioned(
          top: statusBarHeight + AppDimens.spacingS,
          right: AppDimens.spacingM,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.share,
                  size: 20, color: ColorPalette.textPrimaryColor),
              onPressed: widget.onShare ?? () {},
              padding: EdgeInsets.all(AppDimens.spacingXS),
              constraints: const BoxConstraints(),
            ),
          ),
        ),

        // Left arrow
        Positioned(
          left: AppDimens.spacingS,
          top: (300 + statusBarHeight) / 2 - 16,
          child: GestureDetector(
            onTap: () {
              if (_currentPage > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chevron_left,
                  color: Colors.white, size: 24),
            ),
          ),
        ),

        // Right arrow
        Positioned(
          right: AppDimens.spacingS,
          top: (300 + statusBarHeight) / 2 - 16,
          child: GestureDetector(
            onTap: () {
              if (_currentPage < totalPages - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chevron_right,
                  color: Colors.white, size: 24),
            ),
          ),
        ),

        // Page indicator
        Positioned(
          bottom: AppDimens.spacingM,
          right: AppDimens.spacingM,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_currentPage + 1}/$totalPages',
              style: TextStyle(
                fontSize: TextStyles.largeCaptionSize,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

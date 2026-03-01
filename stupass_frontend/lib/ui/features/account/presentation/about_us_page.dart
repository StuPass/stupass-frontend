import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/core/theme/color_palette.dart';
import 'package:stupass_frontend/ui/core/theme/text_styles.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.surfaceColor,
      appBar: AppBar(
        title: const Text(
          'Về chúng tôi',
          style: TextStyle(
            fontSize: TextStyles.heading5Size,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textPrimaryColor,
            fontFamily: TextStyles.fontFamily,
          ),
        ),
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Logo ───
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Stu",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.textPrimaryColor,
                    ),
                  ),
                  const Text(
                    "Pass",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: ColorPalette.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.spacingM),

            // ─── Câu chuyện ───
            _boldText('Câu chuyện của chúng tôi:'),
            _bodyText(
              'Stupass được phát triển vào năm 2026, được khởi tạo bởi UIT-Together – một nhóm các kỹ sư công nghệ trẻ đầy nhiệt huyết từ Trường Đại học Công nghệ Thông tin (UIT). Xuất phát từ chính nhu cầu thực tế tại giảng đường: Giáo trình cũ bỏ thì phí, đồ điện tử muốn lên đời nhưng sợ bị ép giá, hay đơn giản là tìm một nơi tin cậy để sang nhượng vật dụng cá nhân. Chúng tôi tạo ra Stupass không phải để cạnh tranh với các sàn thương mại điện tử khổng lồ, mà để giải quyết bài toán "Cũ người mới ta" ngay trong chính cộng đồng sinh viên.',
            ),
            const SizedBox(height: AppDimens.spacingM),

            // ─── Stupass là gì? ───
            _boldText('Stupass là gì?'),
            _bodyText(
              'Stupass là nền tảng chợ ứng dụng di động C2C (Consumer-to-Consumer) chuyên biệt dành riêng cho sinh viên các trường đại học. Chúng tôi tạo ra một "vòng tròn tin cậy" (Trusted Circle), nơi sinh viên có thể mua bán, trao đổi:',
            ),
            _bullet('Học liệu: Giáo trình, sách tham khảo, tài liệu chuyên ngành.'),
            _bullet('Thiết bị: Laptop, máy tính bảng, máy tính cầm tay, phụ kiện điện tử.'),
            _bullet('Đồ dùng cá nhân: Các vật dụng thiết yếu cho đời sống sinh viên.'),
            const SizedBox(height: AppDimens.spacingS),
            _bodyText(
              'Mô hình hoạt động khác biệt hẳn với các sàn thương mại điện tử thông thường, Stupass nói KHÔNG với các gian hàng bán lẻ chuyên nghiệp, không qua trung gian vận chuyển phức tạp.',
            ),
            const SizedBox(height: AppDimens.spacingM),

            // ─── Sự Khác Biệt ───
            _boldText('Sự Khác Biệt:'),
            _bodyText(
              'StuPass đặt Công nghệ làm nền tảng để giải quyết vấn đề lớn nhất của mua bán C2C: Niềm Tin.',
            ),
            _bullet(
              'Xác thực danh tính (Student Verification): Stupass nói KHÔNG với tài khoản ảo. Chúng tôi áp dụng quy trình xác thực sinh viên nghiêm ngặt để đảm bảo người bán và người mua đều là những sinh viên thực thụ.',
            ),
            _bullet(
              'Mô hình "Anti-Retailer": Chúng tôi từ chối các gian hàng bán lẻ chuyên nghiệp hay các shop kinh doanh đại trà. Stupass là sân chơi thuần khiết của sinh viên, giữ cho giá cả luôn ở mức "thanh lý" đúng nghĩa.',
            ),
            _bullet('Giao dịch linh hoạt & An toàn:'),
            _subBullet(
              'Face-to-Face: Khuyến khích giao dịch trực tiếp ngay tại khuôn viên trường học, kiểm tra hàng tận tay, miễn phí vận chuyển 100%.',
            ),
            _subBullet(
              'Secure Payment: Hệ thống thanh toán đảm bảo của Stupass giữ tiền hộ người mua và chỉ giải ngân cho người bán khi giao dịch thành công.',
            ),
            const SizedBox(height: AppDimens.spacingM),

            // ─── Giá trị cốt lõi ───
            _boldText('Giá trị cốt lõi:'),
            _bullet(
              'Cộng đồng thực: Chúng tôi xây dựng một môi trường minh bạch, nơi mỗi tài khoản là một con người thật, sinh viên thật. Không có lừa đảo, không có spam.',
            ),
            _bullet(
              'Tiết kiệm thực: Loại bỏ hoàn toàn các lớp trung gian và phí vận chuyển không cần thiết. Giá cả trên Stupass là giá trị thực của sản phẩm dành cho sinh viên.',
            ),
            _bullet(
              'Kết nối thực: Mỗi giao dịch không chỉ là mua bán, mà là sự kết nối. Đó là lúc đàn anh khóa trên truyền lại kinh nghiệm cho khóa dưới qua cuốn sách cũ, là sẻ chia khó khăn giữa những người bạn đồng trang lứa.',
            ),
            const SizedBox(height: AppDimens.spacingXL),
          ],
        ),
      ),
    );
  }

  Widget _boldText(String text) => Padding(
        padding: const EdgeInsets.only(bottom: AppDimens.spacingXS),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: TextStyles.smallBodySize,
            fontWeight: FontWeight.bold,
            color: ColorPalette.textPrimaryColor,
            fontFamily: TextStyles.fontFamily,
          ),
        ),
      );

  Widget _bodyText(String text) => Padding(
        padding: const EdgeInsets.only(bottom: AppDimens.spacingXS),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: TextStyles.smallBodySize,
            color: ColorPalette.textPrimaryColor,
            fontFamily: TextStyles.fontFamily,
            height: 1.5,
          ),
        ),
      );

  Widget _bullet(String text) => Padding(
        padding: const EdgeInsets.only(
          left: AppDimens.spacingM,
          bottom: AppDimens.spacingXS,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '• ',
              style: TextStyle(
                fontSize: TextStyles.smallBodySize,
                color: ColorPalette.textPrimaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: TextStyles.smallBodySize,
                  color: ColorPalette.textPrimaryColor,
                  fontFamily: TextStyles.fontFamily,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _subBullet(String text) => Padding(
        padding: const EdgeInsets.only(
          left: AppDimens.spacingXL,
          bottom: AppDimens.spacingXS,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '- ',
              style: TextStyle(
                fontSize: TextStyles.smallBodySize,
                color: ColorPalette.textPrimaryColor,
                fontFamily: TextStyles.fontFamily,
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: TextStyles.smallBodySize,
                  color: ColorPalette.textPrimaryColor,
                  fontFamily: TextStyles.fontFamily,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      );
}

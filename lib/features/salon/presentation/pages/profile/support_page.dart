import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      bgColor: AppColors.whiteTwo,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.whiteOne,
                      border: Border.all(
                        color: AppColors.greyOne,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(CupertinoIcons.back, color: AppColors.blackTwo),
                  ),
                ),
                const HorizontalSpacing(10),
                CommonText(
                  Strings.supportText,
                  fontSize: 24,
                  fontWeight: 600,
                  color: AppColors.blackOne,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CommonText(
                    Strings.supportDescriptionText,
                    fontSize: 16,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                    textOverflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                  const VerticalSpacing(30),
                  _buildSupportCard(
                    icon: Assets.faqIcon,
                    title: Strings.faqsText,
                    subtitle: Strings.faqsDescriptionText,
                    onTap: () => Get.toNamed(RouteNames.faq),
                  ),
                  const VerticalSpacing(15),
                  _buildSupportCard(
                    icon: Assets.chatSupportIcon,
                    title: Strings.chatsText,
                    subtitle: Strings.needHelpText,
                    onTap: () => Get.toNamed(RouteNames.chatSupport),
                  ),
                  const VerticalSpacing(15),
                  _buildSupportCard(
                    icon: Assets.callSupportIcon,
                    title: Strings.callSupportText,
                    subtitle: Strings.callSupportTimeText,
                    onTap: () async {
                      final Uri url = Uri(
                        scheme: 'tel',
                        path: Strings.supportPhoneNumber,
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.greyOne, width: 1),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
            ),
            const HorizontalSpacing(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    title,
                    fontSize: 16,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(4),
                  CommonText(
                    subtitle,
                    fontSize: 14,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                    textOverflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            const Icon(CupertinoIcons.chevron_right, color: AppColors.greyTwo, size: 20),
          ],
        ),
      ),
    );
  }
}

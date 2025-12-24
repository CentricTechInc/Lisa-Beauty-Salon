import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/components/close_account_dialog_component.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/components/sign_out_dialog_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/profile_menu_item.dart';

class CustomerProfilePage extends StatelessWidget {
  const CustomerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuSections = [
      {
        'title': "General",
        'items': [
          {
            'icon': Assets.bankAccountIcon,
            'title': "Payment Methods",
            'onTap': () => Get.toNamed(RouteNames.customerPaymentMethods),
            'iconColor': AppColors.blackTwo,
            'arrowIconColor': AppColors.blackTwo,
            'iconBackgroundColor': AppColors.whiteThree,
            'backgroundColor': AppColors.whiteOne,
          },
          {
            'icon': Assets.paymentHistoryIcon,
            'title': "Payment History",
            'onTap': () => Get.toNamed(RouteNames.customerPaymentHistory),
            'iconColor': AppColors.blackTwo,
            'arrowIconColor': AppColors.blackTwo,
            'iconBackgroundColor': AppColors.whiteThree,
            'backgroundColor': AppColors.whiteOne,
          },
          {
            'icon': Assets.changePasswordIcon,
            'title': "Change Password",
            'onTap': () => Get.toNamed(RouteNames.customerChangePassword),
            'iconColor': AppColors.blackTwo,
            'arrowIconColor': AppColors.blackTwo,
            'iconBackgroundColor': AppColors.whiteThree,
            'backgroundColor': AppColors.whiteOne,
          },
          {
            'icon': Assets.notificationIcon,
            'title': "Notifications",
            'onTap': () => Get.toNamed(RouteNames.customerNotification),
            'iconColor': AppColors.blackTwo,
            'arrowIconColor': AppColors.blackTwo,
            'iconBackgroundColor': AppColors.whiteThree,
            'backgroundColor': AppColors.whiteOne,
          },
        ],
      },
      {
        'title': "Security & Privacy",
        'items': [
          {
            'icon': Assets.supportIcon,
            'title': "Support",
            'onTap': () => Get.toNamed(RouteNames.customerSupport),
            'iconColor': AppColors.blackTwo,
            'arrowIconColor': AppColors.blackTwo,
            'iconBackgroundColor': AppColors.whiteThree,
            'backgroundColor': AppColors.whiteOne,
          },
          {
            'icon': Assets.privacyPolicyIcon,
            'title': "Privacy Policy",
            'onTap': () => Get.toNamed(RouteNames.customerPrivacyPolicy),
            'iconColor': AppColors.blackTwo,
            'arrowIconColor': AppColors.blackTwo,
            'iconBackgroundColor': AppColors.whiteThree,
            'backgroundColor': AppColors.whiteOne,
          },
          {
            'icon': Assets.privacyPolicyIcon,
            'title': "Terms & Conditions",
            'onTap': () => Get.toNamed(RouteNames.customerTermsAndConditions),
            'iconColor': AppColors.blackTwo,
            'arrowIconColor': AppColors.blackTwo,
            'iconBackgroundColor': AppColors.whiteThree,
            'backgroundColor': AppColors.whiteOne,
          },
          {
            'icon': Assets.aboutUsIcon,
            'title': "About Us",
            'onTap': () => Get.toNamed(RouteNames.customerAboutUs),
            'iconColor': AppColors.blackTwo,
            'arrowIconColor': AppColors.blackTwo,
            'iconBackgroundColor': AppColors.whiteThree,
            'backgroundColor': AppColors.whiteOne,
          },
        ],
      },
      {
        'title': "Danger Zone",
        'items': [
          {
            'icon': Assets.deleteAccountIcon,
            'title': "Close Account",
            "iconColor": AppColors.whiteOne,
            "arrowIconColor": AppColors.pinkTwo,
            "iconBackgroundColor": AppColors.pinkTwo,
            "backgroundColor": AppColors.pinkTwo.withValues(alpha: 0.2),
            'onTap': () async {
              final result = await Get.dialog(
                CustomerCloseAccountDialogComponent(),
                barrierDismissible: true,
              );
              if (result == true) {
                Get.offAllNamed(RouteNames.signIn);
              }
            },
          },
        ],
      },
      {
        'title': "Sign Out",
        'items': [
          {
            'icon': Assets.signOutIcon,
            'title': "Sign Out",
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () async {
              final result = await Get.dialog(
                CustomerSignOutDialogComponent(),
                barrierDismissible: true,
              );
              if (result == true) {
                Get.offAllNamed(RouteNames.signIn);
              }
            },
          },
        ],
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacing(30),
          _buildProfileHeader(),
          const VerticalSpacing(32),
          ...menuSections.map((section) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  section['title'],
                  fontSize: 18,
                  fontWeight: 700,
                  color: AppColors.blackTwo,
                ),
                const VerticalSpacing(05),
                ...List.generate(section['items'].length, (index) {
                  final item = section['items'][index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ProfileMenuItem(
                      icon: item['icon'],
                      title: item['title'],
                      onTap: item['onTap'],
                      iconColor: item['iconColor'],
                      arrowIconColor: item['arrowIconColor'],
                      iconBackgroundColor: item['iconBackgroundColor'],
                      backgroundColor: item['backgroundColor'],
                    ),
                  );
                }),
                const VerticalSpacing(16),
              ],
            );
          }),
          const VerticalSpacing(24),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg="
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyOne),
              ),
              child: SvgPicture.asset(
                Assets.notificationIcon,
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
        const VerticalSpacing(16),
        Row(
          children: [
            const CommonText(
              "Eleanor",
              fontSize: 24,
              fontWeight: 600,
              color: AppColors.blackTwo,
            ),
            const HorizontalSpacing(8),
            GestureDetector(
              onTap: () => Get.toNamed(RouteNames.customerEditProfile),
              child: SvgPicture.asset(
                Assets.profileEditIcon,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(AppColors.pinkTwo, BlendMode.srcIn),
              ),
            ),
          ],
        ),
        const CommonText(
          "eleanor@mail.com",
          fontSize: 16,
          fontWeight: 400,
          color: AppColors.greyTwo,
        ),
      ],
    );
  }
}

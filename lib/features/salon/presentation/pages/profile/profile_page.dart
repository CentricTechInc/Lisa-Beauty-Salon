import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/components/close_account_dialog_component.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/components/profile_menu_item.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/components/sign_out_dialog_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define menu sections with their items
    final List<Map<String, dynamic>> menuSections = [
      {
        'title': Strings.generalText,
        'items': [
          {
            'icon': Assets.bankAccountIcon,
            'title': Strings.bankAccountMenuText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.bankAccount);
            },
          },
          {
            'icon': Assets.paymentHistoryIcon,
            'title': Strings.paymentHistoryText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.paymentHistory);
            },
          },
          {
            'icon': Assets.serviceIcon,
            'title': Strings.servicesMenuText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.services);
            },
          },
          {
            'icon': Assets.bottomBarIconTwo,
            'title': Strings.availabilityText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.availability);
            },
          },
          {
            'icon': Assets.promotionalToolIcon,
            'title': Strings.promotionalToolText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.promotionalTool);
            },
          },
          {
            'icon': Assets.changePasswordIcon,
            'title': Strings.changePasswordText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.changePassword);
            },
          },
          {
            'icon': Assets.notificationIcon,
            'title': Strings.notificationsText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.notification);
            },
          },
        ],
      },
      {
        'title': Strings.securityAndPrivacyText,
        'items': [
          {
            'icon': Assets.supportIcon,
            'title': Strings.supportText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.support);
            },
          },
          {
            'icon': Assets.privacyPolicyIcon,
            'title': Strings.privacyPolicyMenuText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.privacyPolicy);
            },
          },
          {
            'icon': Assets.privacyPolicyIcon,
            'title': Strings.termsAndConditionMenuText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.termsAndConditions);
            },
          },
          {
            'icon': Assets.aboutUsIcon,
            'title': Strings.aboutUsText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () {
              Get.toNamed(RouteNames.aboutUs);
            },
          },
        ],
      },
      {
        'title': Strings.dangerZoneText,
        'items': [
          {
            'icon': Assets.deleteAccountIcon,
            'title': Strings.closeAccountText,
            "iconColor": AppColors.whiteOne,
            "arrowIconColor": AppColors.pinkTwo,
            "iconBackgroundColor": AppColors.pinkTwo,
            "backgroundColor": AppColors.pinkTwo.withValues(alpha: 0.2),
            'onTap': () async {
              final result = await Get.dialog(
                CloseAccountDialogComponent(),
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
        'title': Strings.signOutText,
        'items': [
          {
            'icon': Assets.signOutIcon,
            'title': Strings.signOutText,
            "iconColor": AppColors.blackTwo,
            "arrowIconColor": AppColors.blackTwo,
            "iconBackgroundColor": AppColors.whiteThree,
            "backgroundColor": AppColors.whiteOne,
            'onTap': () async {
              final result = await Get.dialog(
                SignOutDialogComponent(),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.greyOne,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/150?u=5'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              // Notification Button
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.whiteOne,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.greyOne, width: 1),
                ),
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  Assets.notificationIcon,
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
          VerticalSpacing(16),

          // Name and Edit Button
          Row(
            children: [
              CommonText(
                Strings.businessNamePlaceholderText,
                fontSize: 24,
                fontWeight: 600,
                color: AppColors.blackTwo,
              ),
              HorizontalSpacing(12),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteNames.profileEdit);
                },
                child: SvgPicture.asset(
                  Assets.profileEditIcon,
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
          // Email
          CommonText(
            'bnb@mail.com',
            fontSize: 16,
            fontWeight: 400,
            color: AppColors.greyTwo,
          ),
          VerticalSpacing(32),

          // Menu Sections
          ...menuSections.map((section) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                CommonText(
                  section['title'],
                  fontSize: 18,
                  fontWeight: 700,
                  color: AppColors.blackTwo,
                ),
                VerticalSpacing(16),

                // Section Items
                ...List.generate(section['items'].length, (index) {
                  final item = section['items'][index];
                  return Column(
                    children: [
                      ProfileMenuItem(
                        icon: item['icon'],
                        title: item['title'],
                        onTap: item['onTap'],
                        iconColor: item['iconColor'],
                        arrowIconColor: item['arrowIconColor'],
                        iconbackgroundColor: item['iconBackgroundColor'],
                        backgroundColor: item['backgroundColor'],
                      ),
                      if (index < section['items'].length - 1)
                        VerticalSpacing(12),
                    ],
                  );
                }),
                VerticalSpacing(16),
              ],
            );
          }),
        ],
      ),
    );
  }
}

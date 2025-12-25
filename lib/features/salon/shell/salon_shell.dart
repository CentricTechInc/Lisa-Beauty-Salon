import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/controllers/setting_controller.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/appointment/appointment_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/finance/finance_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/home/home_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/message/message_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/profile_page.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_bottom_bar.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';

import 'package:lisa_beauty_salon/shared/widgets/lazy_load_stack.dart';

class SalonShell extends StatelessWidget {
  SalonShell({
    super.key
  });

  final controller = Get.find<SettingController>();

  final List<WidgetBuilder> pages = [
    (context) => HomePage(),
    (context) => const AppointmentPage(),
    (context) => const FinancePage(),
    (context) => const MessagePage(),
    (context) => const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => CommonScaffoldWidget(
      bgColor: AppColors.whiteTwo,
      padding: EdgeInsets.zero,
      useSafeArea: false,
      extendBody: true,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteOne,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      bottomNavigationBar: CommonBottomBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTab,
        items: [
          SvgPicture.asset(
            controller.currentIndex.value == 0 ? Assets.bottomBarIconOneActive
            : Assets.bottomBarIconOneInActive,
          ),
          SvgPicture.asset(
            Assets.bottomBarIconTwo,
          ),
          SvgPicture.asset(
            Assets.bottomBarIconThree,
          ),
          SvgPicture.asset(
            Assets.bottomBarIconFour,
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                  "https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg="
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(
                16
              ),
            ),
          )
        ],
      ),
      child: LazyLoadStack(
        index: controller.currentIndex.value,
        builders: pages,
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/controllers/setting_controller.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/appointment/appointment_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/finance/finance_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/home/home_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/message/message_page.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_bottom_bar.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';

class SalonShell extends StatelessWidget {
  SalonShell({
    super.key
  });

  final controller = Get.put(SettingController());

  final pages = [
    HomePage(),
    AppointmentPage(),
    FinancePage(),
    MessagePage(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => CommonScaffoldWidget(
      bgColor: AppColors.whiteTwo,
      bottomNavigationBar: CommonBottomBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTab,
        items: [
          SvgPicture.asset(
            Assets.bottomBarIconOne,
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
              image: DecorationImage(
                image: NetworkImage(
                  "https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg="
                )
              ),
              borderRadius: BorderRadius.circular(
                16
              ),
            ),
          )
        ],
      ),
      child: IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      ),
    ));
  }
}

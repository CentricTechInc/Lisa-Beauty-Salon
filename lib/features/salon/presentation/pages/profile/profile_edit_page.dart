import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/components/personal_info_tab.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/components/professional_info_tab.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      resizeToAvoidBottomInset: true,
      child: Column(
        children: [
          VerticalSpacing(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyOne),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: AppColors.blackOne,
                    ),
                  ),
                ),
                HorizontalSpacing(15),
                CommonText(
                  Strings.profileText,
                  fontSize: 20,
                  fontWeight: 700,
                  color: AppColors.blackTwo,
                ),
              ],
            ),
          ),
          VerticalSpacing(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.whiteOne,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyOne),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.pinkTwo,
                ),
                labelColor: AppColors.whiteOne,
                unselectedLabelColor: AppColors.greyTwo,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Manrope',
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Manrope',
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                tabs: const [
                  Tab(text: "Personal Info"),
                  Tab(text: "Professional Info"),
                ],
              ),
            ),
          ),
          VerticalSpacing(20),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [PersonalInfoTab(), ProfessionalInfoTab()],
            ),
          ),
        ],
      ),
    );
  }
}

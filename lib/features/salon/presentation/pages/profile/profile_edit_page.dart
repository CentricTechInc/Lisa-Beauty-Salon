import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/components/personal_info_tab.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/components/professional_info_tab.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_tabbar_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      resizeToAvoidBottomInset: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(30),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyOne),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
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
            VerticalSpacing(20),
            CommonTabBarWidgetTwo(
              indicatorColor: AppColors.pinkTwo,
              selectedLabelColor: AppColors.whiteOne,
              unselectedLabelColor: AppColors.greyTwo,
              tabPadding: EdgeInsets.zero,
              tabs: const [
                Strings.personalInfoText,
                Strings.professionalInfoText,
              ],
              tabViews: const [PersonalInfoTab(), ProfessionalInfoTab()],
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'components/availability_edit_section.dart';
import 'components/availability_view_section.dart';

class AvailabilityPage extends StatelessWidget {
  const AvailabilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (authController.showAvailabilityEditForm.value) {
          authController.showAvailabilityEditForm.value = false;
        } else {
          Get.back();
        }
      },
      child: CommonScaffoldWidget(
        padding: EdgeInsets.zero,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppColors.whiteTwo,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        resizeToAvoidBottomInset: true,
        bgColor: AppColors.whiteTwo,
        child: Column(
          children: [
            const VerticalSpacing(30),
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (authController.showAvailabilityEditForm.value) {
                            authController.showAvailabilityEditForm.value = false;
                          } else {
                            Get.back();
                          }
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.whiteOne,
                            border: Border.all(color: AppColors.greyOne, width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(CupertinoIcons.back, color: AppColors.blackTwo),
                        ),
                      ),
                      const HorizontalSpacing(15),
                      CommonText(
                        authController.showAvailabilityEditForm.value
                            ? "Availability"
                            : "Availability",
                        fontSize: 20,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                      ),
                    ],
                  ),
                )),
            const VerticalSpacing(20),
            Expanded(
              child: Obx(() {
                if (authController.showAvailabilityEditForm.value) {
                  return AvailabilityEditSection(
                    onSaved: () {
                      authController.showAvailabilityEditForm.value = false;
                      // Logic to save data to DTO would go here
                    },
                  );
                } else {
                  return AvailabilityViewSection(
                    onEdit: () {
                      authController.showAvailabilityEditForm.value = true;
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

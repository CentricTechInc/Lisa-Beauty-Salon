import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_bottom_sheet_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';

import 'components/add_promotion_form_component.dart';
import 'components/promotion_bottom_sheet_component.dart';
import 'components/promotion_list_section.dart';

class PromotionalToolPage extends StatefulWidget {
  const PromotionalToolPage({super.key});

  @override
  State<PromotionalToolPage> createState() => _PromotionalToolPageState();
}

class _PromotionalToolPageState extends State<PromotionalToolPage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (authController.showAddPromotionForm.value) {
          authController.toggleAddPromotionForm();
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        if (authController.showAddPromotionForm.value) {
                          authController.toggleAddPromotionForm();
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
                  const CommonText(
                    Strings.promotionalToolText,
                    fontSize: 20,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                ],
              ),
            ),
            const VerticalSpacing(20),
            Expanded(
              child: Obx(() {
                if (authController.showAddPromotionForm.value) {
                  return AddPromotionFormComponent(
                    onSaved: () {
                      authController.toggleAddPromotionForm();
                    },
                  );
                } else {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PromotionListSection(
                          promotions: authController.promotions,
                          onAddPromotion: authController.toggleAddPromotionForm,
                          onSelect: (index) {
                            selectedIndex = index;
                            final p = authController.promotions[index];
                            CommonBottomSheet.show(
                              context,
                              title: "", // The component itself handles the internal title/layout
                              initialChildSize: 0.65,
                              maxChildSize: 0.9,
                              content: PromotionBottomSheetComponent(promotion: p),
                              footer: CommonButton(
                                height: 60,
                                radius: 12,
                                onPressed: () => Get.back(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonText(
                                        Strings.bookNowText,
                                        fontSize: 18,
                                        fontWeight: 600,
                                        color: AppColors.whiteOne,
                                      ),
                                      CommonText(
                                        p.priceText,
                                        fontSize: 18,
                                        fontWeight: 600,
                                        color: AppColors.whiteOne,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const VerticalSpacing(20),
                      ],
                    ),
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

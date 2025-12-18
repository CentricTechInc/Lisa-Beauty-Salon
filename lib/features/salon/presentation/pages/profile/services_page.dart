import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'components/add_service_form_component.dart';
import 'components/service_category_detail_section.dart';
import 'components/services_list_section.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return CommonScaffoldWidget(
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
                        if (authController.showAddServiceForm.value) {
                          authController.toggleAddServiceForm();
                        } else if (authController.viewingCategory.value.isNotEmpty) {
                          authController.viewingCategory.value = "";
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
                      authController.showAddServiceForm.value
                          ? Strings.addAServiceText
                          : (authController.viewingCategory.value.isNotEmpty
                              ? authController.viewingCategory.value
                              : Strings.servicesTitleText),
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
              if (authController.showAddServiceForm.value) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AddServiceFormComponent(
                    onSaved: () {
                      authController.toggleAddServiceForm();
                    },
                  ),
                );
              } else if (authController.viewingCategory.value.isNotEmpty) {
                return ServiceCategoryDetailSection(
                  category: authController.viewingCategory.value,
                );
              } else {
                return SingleChildScrollView(
                  child: ServicesListSection(
                    onAddService: () => authController.toggleAddServiceForm(),
                    onCategoryTap: (category) {
                      authController.viewingCategory.value = category;
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

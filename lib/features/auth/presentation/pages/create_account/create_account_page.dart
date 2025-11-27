import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accountCategories = [
      Strings.individualServiceProvidersText,
      Strings.salonsText,
      Strings.customerText
    ];

    final authController = Get.find<AuthController>();

    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      bgColor: AppColors.blackThree,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteTwo,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)
                  )
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(25),
                    Center(
                      child: CommonText(
                        Strings.createAccountText,
                        fontSize: 24,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                      ),
                    ),
                    VerticalSpacing(8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20
                      ),
                      child: Center(
                        child: CommonText(
                          Strings.createAccountDescriptionText,
                          fontSize: 16,
                          fontWeight: 400,
                          color: AppColors.greyTwo,
                          textOverflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    VerticalSpacing(15),
                    Center(
                      child: SvgPicture.asset(
                        Assets.createAccountIllustration,
                      ),
                    ),
                    VerticalSpacing(10),
                    CommonText(
                      Strings.selectCategoryText,
                      fontSize: 24,
                      fontWeight: 600,
                      color: AppColors.blackTwo,
                    ),
                    VerticalSpacing(10),
                    for (var category in accountCategories)...[
                      Obx(() {
                        final isSelected = authController.selectedCategory.value == category;

                        return GestureDetector(
                          onTap: () => authController.selectCategory(category),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteOne,
                              border: Border.all(
                                color: AppColors.greyOne
                              ),
                              borderRadius: BorderRadius.circular(16)
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText(
                                  category,
                                  fontSize: 16,
                                  fontWeight: 500,
                                  color: AppColors.blackTwo,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.pinkTwo : AppColors.whiteOne,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? AppColors.transparent : AppColors.greyOne,
                                      width: 2
                                    )
                                  ),
                                  child: isSelected ? Center(
                                    child: Icon(
                                      Icons.check,
                                      color: AppColors.whiteOne,
                                      size: 15,
                                    ),
                                  ) : null,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                      VerticalSpacing(15),
                    ],
                    VerticalSpacing(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25
                      ),
                      child: CommonText(
                        Strings.categoryDescriptionText,
                        fontSize: 12,
                        fontWeight: 400,
                        color: AppColors.greyTwo,
                        textOverflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    VerticalSpacing(20),
                    CommonButton(
                      child: CommonText(
                        Strings.nextText,
                        fontSize: 18,
                        fontWeight: 600,
                        color: AppColors.whiteOne,
                        textOverflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
                    ),
                    VerticalSpacing(20),
                  ]
                )
              )
            ],
          ),
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_checkbox.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class SignUpCustomerPage extends StatefulWidget {
  const SignUpCustomerPage({super.key});

  @override
  State<SignUpCustomerPage> createState() => _SignUpCustomerPageState();
}

class _SignUpCustomerPageState extends State<SignUpCustomerPage> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();

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
                  VerticalSpacing(30),
                  Center(
                    child: CommonText(
                      Strings.signUpText,
                      fontSize: 24,
                      fontWeight: 600,
                      color: AppColors.blackTwo,
                    ),
                  ),
                  VerticalSpacing(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20
                    ),
                    child: CommonText(
                      Strings.signUpCustomerDescriptionText,
                      fontSize: 16,
                      fontWeight: 400,
                      color: AppColors.greyTwo,
                      textOverflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  VerticalSpacing(30),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          controller: firstNameController,
                          titleLabelText: Strings.firstNameText,
                          labelText: Strings.firstNamePlaceholderText,
                          labelSize: 15,
                          labelColor: AppColors.greyTwo,
                          hintText: Strings.firstNamePlaceholderText,
                          hintSize: 15,
                          hintColor: AppColors.greyTwo,
                          borderColor: AppColors.greyOne,
                          fontSize: 15,
                          textColor: AppColors.greyTwo,
                        ),
                      ),
                      HorizontalSpacing(10),
                      Expanded(
                        child: CommonTextField(
                          controller: emailController,
                          titleLabelText: Strings.lastNameText,
                          labelText: Strings.lastNamePlaceholderText,
                          labelSize: 15,
                          labelColor: AppColors.greyTwo,
                          hintText: Strings.lastNamePlaceholderText,
                          hintSize: 15,
                          hintColor: AppColors.greyTwo,
                          borderColor: AppColors.greyOne,
                          fontSize: 15,
                          textColor: AppColors.greyTwo,
                        ),
                      )
                    ],
                  ),
                  VerticalSpacing(20),
                  CommonTextField(
                    controller: emailController,
                    titleLabelText: Strings.emailText,
                    labelText: Strings.emailPlaceholderText,
                    labelSize: 15,
                    labelColor: AppColors.greyTwo,
                    hintText: Strings.emailPlaceholderText,
                    hintSize: 15,
                    hintColor: AppColors.greyTwo,
                  ),
                  VerticalSpacing(20),
                  CommonTextField(
                    controller: passwordController,
                    titleLabelText: Strings.passwordText,
                    labelText: Strings.passwordPlaceholderText,
                    labelSize: 16,
                    labelColor: AppColors.greyTwo,
                    hintText: Strings.passwordPlaceholderText,
                    hintSize: 16,
                    hintColor: AppColors.greyTwo,
                  ),
                  VerticalSpacing(20),
                  CommonTextField(
                    controller: confirmPasswordController,
                    titleLabelText: Strings.confirmPasswordText,
                    labelText: Strings.passwordPlaceholderText,
                    labelSize: 16,
                    labelColor: AppColors.greyTwo,
                    hintText: Strings.passwordPlaceholderText,
                    hintSize: 16,
                    hintColor: AppColors.greyTwo,
                  ),
                  VerticalSpacing(20),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          controller: ageController,
                          titleLabelText: Strings.ageText,
                          labelText: Strings.agePlaceholderText,
                          labelSize: 15,
                          labelColor: AppColors.greyTwo,
                          hintText: Strings.agePlaceholderText,
                          hintSize: 15,
                          hintColor: AppColors.greyTwo,
                          borderColor: AppColors.greyOne,
                          fontSize: 15,
                          textColor: AppColors.greyTwo,
                        ),
                      ),
                      HorizontalSpacing(10),
                      Expanded(
                        child: CommonDropdownField(
                          titleLabelText: Strings.genderText,
                          items: [
                            Strings.otherText,
                            Strings.maleText,
                            Strings.femaleText
                          ].map((value) => DropdownMenuItem(
                            value: value,
                            child: CommonText(
                              value,
                              fontSize: 15,
                              color: AppColors.greyTwo,
                            ),
                          )
                          ).toList(),
                          onChanged: (value) {
                            genderController.text = value ?? '';
                          },
                        ),
                      )
                    ],
                  ),
                  VerticalSpacing(20),
                  CommonDropdownField(
                    titleLabelText: Strings.stateText,
                    items: (authController.countryDataOfUs?.states ?? []).map(
                      (state) => DropdownMenuItem(
                        value: state,
                        child: CommonText(
                          state.name,
                          fontSize: 15,
                          color: AppColors.greyTwo,
                        ),
                      )
                    ).toList(),
                    onChanged: (value) {
                      stateController.text = value?.name ?? '';
                      authController.setCitiesAccordingToState(
                        stateController.text,
                        Strings.signUpDropdownScenario
                      );
                    },
                  ),
                  VerticalSpacing(20),
                  Obx(() {
                    final cities = authController.citiesList;
                    final selectedIndex = cities.indexWhere(
                      (c) => c.name == authController.selectedCityForSignUp.value,
                    );
                    final int? safeIndex = selectedIndex >= 0 ? selectedIndex : null;

                    return CommonDropdownField<int>(
                      titleLabelText: Strings.cityText,
                      value: safeIndex,
                      items: cities.asMap().entries.map((entry) {
                        final index = entry.key;
                        final city = entry.value;
                        return DropdownMenuItem(
                          value: index,
                          child: CommonText(
                            city.name,
                            fontSize: 15,
                            color: AppColors.greyTwo,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null && value >= 0 && value < cities.length) {
                          authController.selectedCityForSignUp.value = cities[value].name;
                        } else {
                          authController.selectedCityForSignUp.value = '';
                        }
                      },
                      hintText: cities.isEmpty ? 'No cities available' : 'Select City',
                    );
                  }),
                  VerticalSpacing(20),
                  CommonTextField(
                    titleLabelText: Strings.zipCodeText,
                    controller: zipCodeController,
                    labelText: Strings.zipCodePlaceholderText,
                    labelSize: 15,
                    labelColor: AppColors.greyTwo,
                    hintText: Strings.zipCodePlaceholderText,
                    hintSize: 15,
                    hintColor: AppColors.greyTwo,
                  ),
                  VerticalSpacing(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => CommonCheckbox(
                          label: Strings.agreeToText,
                          spacing: 5,
                          labelFontSize: 12,
                          labelFontWeight: 400,
                          inactiveColor: AppColors.whiteTwo,
                          activeColor: AppColors.pinkTwo,
                          value: authController.agreeToTermsAndCondition.value,
                          onChanged: (value) {
                            authController.agreeToTermsAndCondition.value = value ?? false;
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          LoggerService.info('Terms and Conditions tapped');
                        },
                        child: CommonText(
                          Strings.termsAndConditionsText,
                          fontSize: 12,
                          fontWeight: 400,
                          color: AppColors.pinkTwo,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      CommonText(
                        Strings.andText,
                        fontSize: 12,
                        fontWeight: 400,
                        color: AppColors.greyTwo,
                      ),
                      GestureDetector(
                        onTap: () {
                          LoggerService.info('Privacy Policy tapped');
                        },
                        child: CommonText(
                          Strings.privacyPolicyText,
                          fontSize: 12,
                          fontWeight: 400,
                          color: AppColors.pinkTwo,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  VerticalSpacing(20),
                  CommonButton(
                    backgroundColor: AppColors.pinkTwo,
                    radius: 15,
                    child: CommonText(
                      Strings.signUpText,
                      color: AppColors.whiteOne,
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    onPressed: () {
                      Get.toNamed(
                        RouteNames.emailVerification
                      );
                    },
                  ),
                  VerticalSpacing(30),
                ],
              ),
            ),
            VerticalSpacing(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CommonText(
                  Strings.alreadyHaveAccountText,
                  color: AppColors.whiteOne,
                  fontSize: 16,
                  fontWeight: 300,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      RouteNames.signIn
                    );
                  },
                  child: const CommonText(
                    Strings.loginText,
                    color: AppColors.pinkTwo,
                    fontSize: 16,
                    fontWeight: 400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            VerticalSpacing(40),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.greyThree,
                    ),
                  ),
                  HorizontalSpacing(20),
                  CommonText(
                    Strings.orText,
                    color: AppColors.whiteTwo,
                  ),
                  HorizontalSpacing(20),
                  Expanded(
                    child: Divider(
                      color: AppColors.greyThree,
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpacing(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      backgroundColor: AppColors.whiteOne,
                      radius: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.googleIcon
                          ),
                          HorizontalSpacing(15),
                          Container(
                            width: 1,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.greyOne
                            ),
                          ),
                          HorizontalSpacing(15),
                          CommonText(
                            Strings.googleText,
                            color: AppColors.blackOne,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      onPressed: () {
                        LoggerService.info('Login button pressed');
                      },
                    ),
                  ),
                  HorizontalSpacing(10),
                  Expanded(
                    child: CommonButton(
                      backgroundColor: AppColors.whiteOne,
                      radius: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.appleIcon
                          ),
                          HorizontalSpacing(15),
                          Container(
                            width: 1,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.greyOne
                            ),
                          ),
                          HorizontalSpacing(15),
                          CommonText(
                            Strings.appleText,
                            color: AppColors.blackOne,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      onPressed: () {
                        LoggerService.info('Login button pressed');
                      },
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpacing(20),
          ],
        ),
      ),
    );
  }
}

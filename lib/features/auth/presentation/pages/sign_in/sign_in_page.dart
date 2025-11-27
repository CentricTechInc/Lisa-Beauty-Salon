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
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                    Strings.loginText,
                    fontSize: 24,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                ),
                VerticalSpacing(30),
                CommonText(
                  Strings.loginDescriptionText,
                  fontSize: 16,
                  fontWeight: 400,
                  color: AppColors.greyTwo,
                  textOverflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
                VerticalSpacing(30),
                CommonText(
                  Strings.emailText,
                  fontSize: 12,
                  fontWeight: 400,
                  color: AppColors.blackTwo,
                ),
                VerticalSpacing(5),
                CommonTextField(
                  controller: emailController,
                  labelText: Strings.emailPlaceholderText,
                  labelSize: 16,
                  labelColor: AppColors.greyTwo,
                  hintText: Strings.emailPlaceholderText,
                  hintSize: 16,
                  hintColor: AppColors.greyTwo,
                ),
                VerticalSpacing(40),
                CommonText(
                  Strings.passwordText,
                  fontSize: 12,
                  fontWeight: 400,
                  color: AppColors.blackTwo,
                ),
                VerticalSpacing(5),
                CommonTextField(
                  controller: passwordController,
                  labelText: Strings.passwordPlaceholderText,
                  labelSize: 16,
                  labelColor: AppColors.greyTwo,
                  hintText: Strings.passwordPlaceholderText,
                  hintSize: 16,
                  hintColor: AppColors.greyTwo,
                ),
                VerticalSpacing(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => CommonCheckbox(
                        label: Strings.rememberMeText,
                        spacing: 5,
                        labelFontSize: 14,
                        labelFontWeight: 400,
                        inactiveColor: AppColors.whiteTwo,
                        activeColor: AppColors.pinkTwo,
                        value: authController.rememberMe.value,
                        onChanged: (value) {
                          authController.rememberMe.value = value ?? false;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          RouteNames.forgotPassword
                        );
                      },
                      child: CommonText(
                        Strings.forgotPasswordText,
                        fontSize: 14,
                        fontWeight: 400,
                        color: AppColors.pinkTwo,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                VerticalSpacing(30),
                CommonButton(
                  backgroundColor: AppColors.pinkTwo,
                  radius: 15,
                  child: CommonText(
                    Strings.loginText,
                    color: AppColors.whiteOne,
                    fontWeight: 600,
                    fontSize: 18,
                  ),
                  onPressed: () {
                    LoggerService.info('Login button pressed');
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
                Strings.firstTimeHereText,
                color: AppColors.whiteOne,
                fontSize: 16,
                fontWeight: 300,
              ),
              GestureDetector(
                onTap: () {
                  LoggerService.info('Sign Up tapped');
                },
                child: const CommonText(
                  Strings.signUpText,
                  color: AppColors.pinkTwo,
                  fontSize: 16,
                  fontWeight: 400,
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
    );
  }
}

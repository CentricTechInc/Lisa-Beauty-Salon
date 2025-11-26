import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
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
        statusBarColor: AppColors.whiteTwo
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
              horizontal: 30
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
                        labelFontSize: 16,
                        labelFontWeight: 400,
                        inactiveColor: AppColors.whiteTwo,
                        activeColor: AppColors.pinkTwo,
                        value: authController.rememberMe.value,
                        onChanged: (value) {
                          authController.rememberMe.value = value ?? false;
                        },
                      ),
                    ),
                    CommonText(
                      Strings.forgotPasswordText,
                      fontSize: 16,
                      fontWeight: 400,
                      color: AppColors.pinkTwo,
                      decoration: TextDecoration.underline,
                    ),
                  ],
                ),
                VerticalSpacing(30),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.pinkTwo,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20
                  ),
                  child: Center(
                    child: CommonText(
                      Strings.loginText,
                      color: AppColors.whiteOne,
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                  ),
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
              horizontal: 20
            ),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.greyTwo.withValues(
                      alpha: 0.3
                    ),
                  ),
                ),
                HorizontalSpacing(15),
                CommonText(
                  Strings.orText,
                  color: AppColors.whiteTwo,
                ),
                HorizontalSpacing(15),
                Expanded(
                  child: Divider(
                    color: AppColors.greyTwo.withValues(
                      alpha: 0.3
                    ),
                  ),
                ),
              ],
            ),
          ),
          VerticalSpacing(20),
          Row(
            children: [],
          )
          VerticalSpacing(20),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_checkbox.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class SignUpSalonPage extends StatefulWidget {
  const SignUpSalonPage({super.key});

  @override
  State<SignUpSalonPage> createState() => _SignUpSalonPageState();
}

class _SignUpSalonPageState extends State<SignUpSalonPage> with FieldsValidation {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> passwordObscure = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordObscure = ValueNotifier(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordObscure.dispose();
    confirmPasswordObscure.dispose();
    super.dispose();
  }

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
              child: Form(
                key: _formKey,
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
                        Strings.signUpSalonDescriptionText,
                        fontSize: 16,
                        fontWeight: 400,
                        color: AppColors.greyTwo,
                        textOverflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    VerticalSpacing(20),
                    CommonTextField(
                      titleLabelText: Strings.emailText,
                      controller: emailController,
                      labelText: Strings.emailPlaceholderText,
                      hintText: Strings.emailPlaceholderText,
                      labelSize: 15,
                      hintSize: 15,
                      labelColor: AppColors.greyTwo,
                      hintColor: AppColors.greyTwo,
                      textColor: AppColors.blackTwo,
                      cursorColor: AppColors.blackTwo,
                      validator: validateEmail,
                    ),
                    VerticalSpacing(20),
                    ValueListenableBuilder<bool>(
                      valueListenable: passwordObscure,
                      builder: (context, obscure, child) {
                        return CommonTextField(
                          titleLabelText: Strings.passwordText,
                          controller: passwordController,
                          labelText: Strings.passwordPlaceholderText,
                          hintText: Strings.passwordPlaceholderText,
                          hintSize: 16,
                          labelSize: 16,
                          labelColor: AppColors.greyTwo,
                          hintColor: AppColors.greyTwo,
                          textColor: AppColors.blackTwo,
                          cursorColor: AppColors.blackTwo,
                          pass: obscure,
                          suffix: Icon(
                            obscure ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                            color: AppColors.greyTwo,
                          ),
                          suffixIconOnTap: () {
                            passwordObscure.value = !passwordObscure.value;
                          },
                          validator: validatePassword,
                        );
                      }
                    ),
                    VerticalSpacing(20),
                    ValueListenableBuilder<bool>(
                      valueListenable: confirmPasswordObscure,
                      builder: (context, obscure, child) {
                        return CommonTextField(
                          titleLabelText: Strings.confirmPasswordText,
                          controller: confirmPasswordController,
                          labelText: Strings.passwordPlaceholderText,
                          hintText: Strings.passwordPlaceholderText,
                          labelSize: 16,
                          hintSize: 16,
                          labelColor: AppColors.greyTwo,
                          hintColor: AppColors.greyTwo,
                          textColor: AppColors.blackTwo,
                          cursorColor: AppColors.blackTwo,
                          pass: obscure,
                          suffix: Icon(
                            obscure ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                            color: AppColors.greyTwo,
                          ),
                          suffixIconOnTap: () {
                            confirmPasswordObscure.value = !confirmPasswordObscure.value;
                          },
                          validator: (value) => validateConfirmPassword(
                            passwordController.text,
                            value
                          ),
                        );
                      }
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
                            Get.toNamed(
                              RouteNames.termsAndConditions
                            );
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
                            Get.toNamed(
                              RouteNames.privacyPolicy
                            );
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
                    Obx(
                      () => CommonButton(
                        backgroundColor: AppColors.pinkTwo,
                        radius: 15,
                        isLoading: authController.isLoading.value,
                        child: CommonText(
                          Strings.signUpText,
                          color: AppColors.whiteOne,
                          fontWeight: 600,
                          fontSize: 18,
                        ),
                        onPressed: () async {
                          final isFormStateValid =
                              _formKey.currentState!.validate();
                          final isAgreedToTermsAndCondition =
                              authController.agreeToTermsAndCondition.value;
                          if (isFormStateValid && isAgreedToTermsAndCondition) {
                            try {
                              authController.isLoading.value = true;
                              await Future.delayed(
                                const Duration(seconds: 2),
                              );
                              MessageUtils.showSuccessSnackBar(
                                "Account Created Successfully",
                              );
                              Get.toNamed(RouteNames.emailVerification);
                            } finally {
                              authController.isLoading.value = false;
                            }
                          } else {
                            if (!authController.agreeToTermsAndCondition.value) {
                              MessageUtils.showErrorSnackBar(
                                'You must agree to the Terms and Conditions and Privacy Policy.',
                              );
                            } else {
                              MessageUtils.showErrorSnackBar(
                                'Please make sure that all fields have been filled.',
                              );
                            }
                          }
                        },
                      ),
                    ),
                    VerticalSpacing(30),
                  ],
                ),
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

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

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with FieldsValidation {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final ValueNotifier<bool> passwordObscure = ValueNotifier(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordObscure.dispose();
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
                    CommonTextField(
                      controller: emailController,
                      titleLabelText: Strings.emailText,
                      labelText: Strings.emailPlaceholderText,
                      hintText: Strings.emailPlaceholderText,
                      labelSize: 16,
                      hintSize: 16,
                      labelColor: AppColors.greyTwo,
                      hintColor: AppColors.greyTwo,
                      textColor: AppColors.blackTwo,
                      cursorColor: AppColors.blackTwo,
                      validator: validateEmailSimple,
                    ),
                    VerticalSpacing(40),
                    ValueListenableBuilder<bool>(
                      valueListenable: passwordObscure,
                        builder: (context, obscure, child) {
                        return CommonTextField(
                          titleLabelText: Strings.passwordText,
                          controller: passwordController,
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
                            passwordObscure.value = !passwordObscure.value;
                          },
                          validator: validatePasswordSimple,
                        );
                      }
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
                    Obx(
                      () => CommonButton(
                        backgroundColor: AppColors.pinkTwo,
                        radius: 15,
                        isLoading: authController.isLoading.value,
                        child: CommonText(
                          Strings.loginText,
                          color: AppColors.whiteOne,
                          fontWeight: 600,
                          fontSize: 18,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              authController.isLoading.value = true;
                              await Future.delayed(
                                const Duration(seconds: 2),
                              );
                              MessageUtils.showSuccessSnackBar(
                                "Login Successful",
                              );
                              if (authController.selectedCategory.value ==
                                  Strings.salonsText) {
                                Get.offAllNamed(RouteNames.mainSalon);
                              } else {
                                Get.offAllNamed(RouteNames.mainCustomer);
                              }
                            } finally {
                              authController.isLoading.value = false;
                            }
                          } else {
                            MessageUtils.showErrorSnackBar(
                              "Please make sure to fill all these fields",
                            );
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
                  Strings.firstTimeHereText,
                  color: AppColors.whiteOne,
                  fontSize: 16,
                  fontWeight: 300,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      RouteNames.createAccount
                    );
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
      ),
    );
  }
}

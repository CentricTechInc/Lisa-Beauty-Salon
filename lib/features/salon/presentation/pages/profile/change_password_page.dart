import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_back_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> with FieldsValidation {
  final _formKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> currentPasswordObscure = ValueNotifier(true);
  final ValueNotifier<bool> newPasswordObscure = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordObscure = ValueNotifier(true);

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    currentPasswordObscure.dispose();
    newPasswordObscure.dispose();
    confirmPasswordObscure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      bgColor: AppColors.whiteTwo,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteTwo,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpacing(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.whiteOne,
                                border: Border.all(
                                  color: AppColors.greyOne, 
                                  width: 1
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                CupertinoIcons.back, 
                                color: AppColors.blackTwo
                              ),
                            ),
                          ),
                          const HorizontalSpacing(10),
                          CommonText(
                            Strings.changePasswordText,
                            fontSize: 24,
                            fontWeight: 600,
                            color: AppColors.blackOne,
                          ),
                        ],
                      ),
                      const VerticalSpacing(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CommonText(
                          Strings.changePasswordDescriptionText,
                          fontSize: 16,
                          fontWeight: 400,
                          color: AppColors.greyTwo,
                          textOverflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const VerticalSpacing(50),
                      ValueListenableBuilder<bool>(
                        valueListenable: currentPasswordObscure,
                        builder: (context, obscure, child) {
                          return CommonTextField(
                            titleLabelText: Strings.currentPasswordText,
                            controller: currentPasswordController,
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
                              obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.greyTwo,
                            ),
                            suffixIconOnTap: () {
                              currentPasswordObscure.value = !currentPasswordObscure.value;
                            },
                            validator: validatePassword,
                          );
                        },
                      ),
                      const VerticalSpacing(20),
                      ValueListenableBuilder<bool>(
                        valueListenable: newPasswordObscure,
                        builder: (context, obscure, child) {
                          return CommonTextField(
                            titleLabelText: Strings.newPasswordText,
                            controller: newPasswordController,
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
                              obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.greyTwo,
                            ),
                            suffixIconOnTap: () {
                              newPasswordObscure.value = !newPasswordObscure.value;
                            },
                            validator: validatePassword,
                          );
                        },
                      ),
                      const VerticalSpacing(20),
                      ValueListenableBuilder<bool>(
                        valueListenable: confirmPasswordObscure,
                        builder: (context, obscure, child) {
                          return CommonTextField(
                            titleLabelText: Strings.confirmPasswordText,
                            controller: confirmPasswordController,
                            labelText: Strings.passwordPlaceholderText, // Changed to passwordPlaceholderText as per image which shows "Password"
                            hintText: Strings.passwordPlaceholderText,
                            labelSize: 16,
                            hintSize: 16,
                            labelColor: AppColors.greyTwo,
                            hintColor: AppColors.greyTwo,
                            textColor: AppColors.blackTwo,
                            cursorColor: AppColors.blackTwo,
                            pass: obscure,
                            suffix: Icon(
                              obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.greyTwo,
                            ),
                            suffixIconOnTap: () {
                              confirmPasswordObscure.value = !confirmPasswordObscure.value;
                            },
                            validator: (value) => validateConfirmPassword(
                              newPasswordController.text,
                              value,
                            ),
                          );
                        },
                      ),
                      const VerticalSpacing(150),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: SafeArea(
              top: false,
              child: CommonButton(
                child: CommonText(
                  Strings.createNewPasswordButtonText,
                  fontSize: 16,
                  fontWeight: 600,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    MessageUtils.showSuccessSnackBar(
                      "Password has been changed successfully",
                    );
                    Get.back();
                  } else {
                    MessageUtils.showErrorSnackBar(
                      "Please make sure to fill all the required fields correctly",
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_back_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> with FieldsValidation {

  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
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
      bgColor: AppColors.blackThree,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
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
                        VerticalSpacing(25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonBackButton(),
                            Expanded(
                              child: Center(
                                child: CommonText(
                                  Strings.resetPasswordText,
                                  fontSize: 24,
                                  fontWeight: 600,
                                  color: AppColors.blackOne,
                                ),
                              ),
                            ),
                          ],
                        ),
                        VerticalSpacing(25),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40
                          ),
                          child: CommonText(
                            Strings.resetPasswordDescriptionText,
                            fontSize: 16,
                            fontWeight: 400,
                            color: AppColors.greyTwo,
                            textOverflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        VerticalSpacing(50),
                        CommonTextField(
                          titleLabelText:  Strings.passwordText,
                          controller: passwordController,
                          labelText: Strings.passwordPlaceholderText,
                          hintText: Strings.passwordPlaceholderText,
                          labelSize: 16,
                          hintSize: 16,
                          labelColor: AppColors.greyTwo,
                          hintColor: AppColors.greyTwo,
                          textColor: AppColors.blackTwo,
                          cursorColor: AppColors.blackTwo,
                          validator: validatePassword,
                        ),
                        VerticalSpacing(20),
                        CommonTextField(
                          titleLabelText: Strings.confirmPasswordText,
                          controller: confirmPasswordController,
                          labelText: Strings.confirmPasswordPlaceholderText,
                          hintText: Strings.confirmPasswordPlaceholderText,
                          labelSize: 16,
                          hintSize: 16,
                          labelColor: AppColors.greyTwo,
                          hintColor: AppColors.greyTwo,
                          textColor: AppColors.blackTwo,
                          cursorColor: AppColors.blackTwo,
                          validator: (value) => validateConfirmPassword(
                            passwordController.text,
                            value,
                          ),
                        ),
                        VerticalSpacing(150),
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
                    Strings.createPasswordText,
                    fontSize: 16,
                    fontWeight: 600,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      MessageUtils.showSuccessSnackBar(
                        "Password has been reset, please login again",
                      );
                      Get.offAllNamed(
                        RouteNames.signIn
                      );
                    }
                    else {
                      MessageUtils.showErrorSnackBar(
                        "Please make sure to enter password and confirm password",
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

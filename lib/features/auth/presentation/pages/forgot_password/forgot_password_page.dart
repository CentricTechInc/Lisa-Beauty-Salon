import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_back_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> with FieldsValidation {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

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
      child: Column(
        children: [
          Expanded(
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
                          VerticalSpacing(25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CommonBackButton(),
                              Expanded(
                                child: Center(
                                  child: CommonText(
                                    Strings.forgotPasswordText,
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
                              Strings.forgotPasswordDescriptionText,
                              fontSize: 16,
                              fontWeight: 400,
                              color: AppColors.greyTwo,
                              textOverflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          VerticalSpacing(50),
                          CommonTextField(
                            titleLabelText: Strings.emailText,
                            controller: emailController,
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
                          VerticalSpacing(300),
                        ],
                      ),
                    ),
                  ),
                  VerticalSpacing(10),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20
            ),
            child: CommonButton(
              backgroundColor: AppColors.pinkTwo,
              radius: 15,
              child: CommonText(
                Strings.sendText,
                color: AppColors.whiteOne,
                fontWeight: 600,
                fontSize: 18,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  LoggerService.info('Send Forgot Password Email to: ${emailController.text}');
                  Get.toNamed(RouteNames.otpVerification);
                }
                else{
                  Get.snackbar(
                    "Error",
                    "Please make sure to enter the email to receive OTP code",
                    snackPosition: SnackPosition.BOTTOM
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

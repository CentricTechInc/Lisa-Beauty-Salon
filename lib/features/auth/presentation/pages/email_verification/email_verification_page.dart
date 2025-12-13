import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage>
    with FieldsValidation {
  final int _otpLength = 4;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1) {
      if (index + 1 != _otpLength) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (value.isEmpty) {
      if (index - 1 >= 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: CommonTextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        fontSize: 20,
        textWeight: FontWeight.w600,
        inputType: TextInputType.number,
        borderColor: AppColors.greyOne,
        textColor: AppColors.blackTwo,
        cursorColor: AppColors.blackTwo,
        inputFormatter: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) => _onOtpChanged(value, index),
      ),
    );
  }

  String? validateOtp(String otp, int length) {
    return validateOtpCode(otp);
  }

  void _submitOtp() {
    final otp = _controllers.map((c) => c.text).join();
    final error = validateOtpCode(otp);

    if (error != null) {
      MessageUtils.showErrorSnackBar(error);
      return;
    }

    final authController = Get.find<AuthController>();
    if (authController.selectedCategory.value == Strings.salonsText) {
      Get.toNamed(RouteNames.buildYourProfile);
    } else {
      Get.offAllNamed(RouteNames.main);
    }
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
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerticalSpacing(30),
                        Center(
                          child: CommonText(
                            Strings.verifyEmailText,
                            fontSize: 24,
                            fontWeight: 600,
                            color: AppColors.blackTwo,
                          ),
                        ),
                        VerticalSpacing(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Center(
                            child: CommonText(
                              Strings.verifyEmailDescriptionText,
                              fontSize: 16,
                              fontWeight: 400,
                              color: AppColors.greyTwo,
                              textOverflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        VerticalSpacing(120),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _otpLength,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 05,
                                ),
                                child: _buildOtpField(index),
                              ),
                            ),
                          ),
                        ),
                        VerticalSpacing(250),
                      ],
                    ),
                  ),
                  VerticalSpacing(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        Strings.didNotReceiveTheOtpText,
                        fontSize: 16,
                        fontWeight: 700,
                        color: AppColors.whiteTwo,
                      ),
                      CommonText(
                        Strings.resendText,
                        fontSize: 16,
                        fontWeight: 700,
                        color: AppColors.pinkOne,
                        decoration: TextDecoration.underline,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SafeArea(
              top: false,
              child: CommonButton(
                backgroundColor: AppColors.pinkTwo,
                radius: 15,
                child: CommonText(
                  Strings.verifyText,
                  color: AppColors.whiteOne,
                  fontWeight: 600,
                  fontSize: 18,
                ),
                onPressed: () {
                  _submitOtp();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

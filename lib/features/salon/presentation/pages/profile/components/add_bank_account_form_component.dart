import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_checkbox.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'package:lisa_beauty_salon/core/services/loading_service.dart';

class AddBankAccountFormComponent extends StatefulWidget {
  final VoidCallback onSaved;

  const AddBankAccountFormComponent({required this.onSaved, super.key});

  @override
  State<AddBankAccountFormComponent> createState() => _AddBankAccountFormComponentState();
}

class _AddBankAccountFormComponentState extends State<AddBankAccountFormComponent>
    with FieldsValidation {
  final _formKey = GlobalKey<FormState>();

  final accountHolderNameController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final confirmAccountNumberController = TextEditingController();

  final List<String> _bankNames = [
    Strings.africanBankText,
    Strings.sasfinBankText,
    Strings.bidvestBankText,
    Strings.tymeBankText,
    Strings.discoveryBankText,
    Strings.investecBankText,
    Strings.grindrodBankText,
    Strings.ubankText,
    Strings.alBarakaBankText,
    Strings.habibOverseasBankText,
    Strings.habibBankZurichText,
    Strings.mercantileBankText,
  ];

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextField(
                        titleLabelText: Strings.accountHolderNameText,
                        controller: accountHolderNameController,
                        labelText: Strings.accountHolderPlaceholderNameText,
                        hintText: Strings.accountHolderPlaceholderNameText,
                        labelSize: 15,
                        hintSize: 15,
                        labelColor: AppColors.greyTwo,
                        hintColor: AppColors.greyTwo,
                        textColor: AppColors.blackTwo,
                        cursorColor: AppColors.blackTwo,
                        validator: validateTextOnly,
                      ),
                      VerticalSpacing(20),
                      CommonDropdownField(
                        titleLabelText: Strings.bankAccountNameText,
                        items: _bankNames
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: CommonText(value,
                                      fontSize: 15, color: AppColors.greyTwo),
                                ))
                            .toList(),
                        selectedItemBuilder: (context) => _bankNames
                            .map((value) => CommonText(value,
                                fontSize: 15, color: AppColors.blackTwo))
                            .toList(),
                        validator: validateTextNotEmpty,
                        onChanged: (value) =>
                            bankNameController.text = value ?? '',
                      ),
                      VerticalSpacing(20),
                      CommonTextField(
                        titleLabelText: Strings.accountNumberNameText,
                        controller: accountNumberController,
                        labelText: Strings.accountNumberNameText,
                        hintText: Strings.accountNumberNameText,
                        labelSize: 15,
                        hintSize: 15,
                        labelColor: AppColors.greyTwo,
                        hintColor: AppColors.greyTwo,
                        textColor: AppColors.blackTwo,
                        cursorColor: AppColors.blackTwo,
                        validator: validateAccountNumber,
                      ),
                      VerticalSpacing(20),
                      CommonTextField(
                        titleLabelText: Strings.confirmAccountNumberText,
                        controller: confirmAccountNumberController,
                        labelText: Strings.confirmAccountPlaceholderNameText,
                        hintText: Strings.confirmAccountPlaceholderNameText,
                        labelSize: 15,
                        hintSize: 15,
                        labelColor: AppColors.greyTwo,
                        hintColor: AppColors.greyTwo,
                        textColor: AppColors.blackTwo,
                        cursorColor: AppColors.blackTwo,
                        validator: (value) => validateConfirmAccountNumber(
                            value, accountNumberController.text),
                      ),
                      VerticalSpacing(20),
                      Obx(() => CommonCheckbox(
                            label: Strings.confirmAndConsentToAccountText,
                            spacing: 5,
                            labelFontSize: 12,
                            labelFontWeight: 400,
                            inactiveColor: AppColors.whiteTwo,
                            activeColor: AppColors.pinkTwo,
                            padding: EdgeInsets.zero,
                            value: authController
                                .confirmAndConsentToThisAccount.value,
                            onChanged: (value) => authController
                                .confirmAndConsentToThisAccount.value =
                                value ?? false,
                          )),
                    ],
                  ),
                ),
                VerticalSpacing(20),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 10),
          child: CommonButton(
            text: Strings.addAccountText,
            textColor: AppColors.whiteOne,
            textFontSize: 16,
            textFontWeight: 500,
            onPressed: () async {
              final haveConsented =
                  authController.confirmAndConsentToThisAccount.value;

              if (_formKey.currentState!.validate() && haveConsented) {
                final loadingService = Get.find<LoadingService>();
                loadingService.show();

                // Simulate network delay
                await Future.delayed(const Duration(seconds: 2));

                authController.addBankAccount(
                  BankAccountInfoDto(
                    accountHolderFullName: accountHolderNameController.text,
                    bankName: bankNameController.text,
                    accountNumber: accountNumberController.text,
                    areTermsAndConditionsAccepted: haveConsented,
                  ),
                );

                loadingService.hide();

                // Small delay to ensure dialog is completely closed before navigating
                await Future.delayed(const Duration(milliseconds: 100));

                widget.onSaved();
                MessageUtils.showSuccessSnackBar(
                  "Bank account added successfully",
                );
              } else if (!haveConsented) {
                MessageUtils.showErrorSnackBar(
                  "Please check the confirmation to consent to link bank accounts",
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

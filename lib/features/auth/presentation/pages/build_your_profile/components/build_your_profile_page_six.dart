

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_bottom_sheet_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_checkbox.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class BuildYourProfilePageSix extends StatelessWidget {
  const BuildYourProfilePageSix({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CommonText(
                Strings.yourBankAccountInfoText,
                fontSize: 20,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
            ),
            VerticalSpacing(20),
            Center(
              child: CommonText(
                Strings.yourBankAccountInfoDescriptionText,
                fontSize: 16,
                fontWeight: 400,
                color: AppColors.greyTwo,
                textOverflow: TextOverflow.visible,
                maxLines: 4,
                textAlign: TextAlign.center,
              ),
            ),
            VerticalSpacing(10),
            Obx(() {
              if (authController.showAddBankAccountsForm.value) {
                return _ShowAddBankAccountsForm();
              }
              else {
                return _ShowBankAccountsWidget(
                  pageController: pageController,
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class _ShowAddBankAccountsForm extends StatelessWidget {
  final accountHolderNameController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final confirmAccountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final bankAccountsName = [
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
    return Column(
      children: [
        CommonTextField(
          titleLabelText: Strings.accountHolderNameText,
          controller: accountHolderNameController,
          labelText: Strings.accountHolderPlaceholderNameText,
          labelSize: 15,
          labelColor: AppColors.greyTwo,
          hintText: Strings.accountHolderPlaceholderNameText,
          hintSize: 15,
          hintColor: AppColors.greyTwo,
        ),
        VerticalSpacing(20),
        CommonDropdownField(
          titleLabelText: Strings.bankAccountNameText,
          items: bankAccountsName.map((value) => DropdownMenuItem(
            value: value,
            child: CommonText(
              value,
              fontSize: 15,
              color: AppColors.greyTwo,
            ),
          )
          ).toList(),
          onChanged: (value) {
            bankNameController.text = value ?? '';
          },
        ),
        VerticalSpacing(20),
        CommonTextField(
          titleLabelText: Strings.accountNumberNameText,
          controller: accountNumberController,
          labelText: Strings.accountNumberNameText,
          labelSize: 15,
          labelColor: AppColors.greyTwo,
          hintText: Strings.accountNumberNameText,
          hintSize: 15,
          hintColor: AppColors.greyTwo,
        ),
        VerticalSpacing(20),
        CommonTextField(
          titleLabelText: Strings.confirmAccountNumberText,
          controller: confirmAccountNumberController,
          labelText: Strings.confirmAccountPlaceholderNameText,
          labelSize: 15,
          labelColor: AppColors.greyTwo,
          hintText: Strings.confirmAccountPlaceholderNameText,
          hintSize: 15,
          hintColor: AppColors.greyTwo,
        ),
        VerticalSpacing(20),
        Obx(() => CommonCheckbox(
          label: Strings.confirmAndConsentToAccountText,
          spacing: 5,
          labelFontSize: 16,
          labelFontWeight: 500,
          inactiveColor: AppColors.whiteTwo,
          activeColor: AppColors.pinkTwo,
          value: authController.confirmAndConsentToThisAccount.value,
          onChanged: (value) {
            authController.confirmAndConsentToThisAccount.value = value ?? false;
          },
        )),
        VerticalSpacing(20),
        CommonButton(
          width: context.width * 0.8,
          height: 50,
          text: Strings.addAccountText,
          textColor: AppColors.whiteOne,
          textFontSize: 16,
          textFontWeight: 500,
          onPressed: () {
            authController.addBankAccount(
                BankAccountInfoDto(
                  accountHolderFullName: accountHolderNameController.text,
                  bankName: bankNameController.text,
                  accountNumber: accountNumberController.text,
                  areTermsAndConditionsAccepted: authController
                      .confirmAndConsentToThisAccount.value,
                )
            );
            authController.toggleAddBankAccountsForm();
          },
        )
      ],
    );
  }
}

class _ShowBankAccountsWidget extends StatelessWidget {
  const _ShowBankAccountsWidget({
    required this.pageController,
  });

  final PageController pageController;

  String maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) {
      return accountNumber;
    }
    final visible = accountNumber.substring(accountNumber.length - 4);
    final masked = '*' * (accountNumber.length - 4);
    return masked + visible;
  }


  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final bankAccounts = authController.buildProfileData?.bankAccounts ?? [];

    return Column(
      children: [
        if ((authController.buildProfileData?.bankAccounts ?? []).isNotEmpty)...[
          for (int index = 0; index < bankAccounts.length; index++) ...[
            Obx(() {
              final bankAccount = bankAccounts[index];
              final bool isSelected =
                  authController.selectedBankAccountIndex.value == index;

              return GestureDetector(
                onTap: () {
                  authController.selectBankAccount(index);
                },
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.whiteOne,
                    border: Border.all(
                      color: isSelected ? AppColors.pinkTwo : AppColors.greyOne,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.pinkTwo,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              Assets.bankAccountSvgIcon,
                              width: 10,
                              height: 10,
                            ),
                          ),
                          HorizontalSpacing(10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                Strings.bankAccountText,
                                fontSize: 16,
                                fontWeight: 700,
                                color: AppColors.blackTwo,
                              ),
                              CommonText(
                                maskAccountNumber(bankAccount.accountNumber),
                                fontSize: 14,
                                fontWeight: 500,
                                color: AppColors.blackTwo,
                              ),
                            ],
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: () {
                          authController.selectBankAccount(index);
                        },
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? AppColors.pinkTwo
                                : AppColors.whiteOne,
                            border: Border.all(
                              color: isSelected ? AppColors.pinkTwo
                                  : AppColors.greyOne,
                              width: 2,
                            ),
                          ),
                          child: isSelected ? Center(
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColors.whiteOne,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ) : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            VerticalSpacing(10),
          ],
          VerticalSpacing(150),
          CommonButton(
            onPressed: () {
              authController.toggleAddBankAccountsForm();
            },
            backgroundColor: AppColors.whiteOne,
            textColor: AppColors.blackTwo,
            borderColor: AppColors.greyOne,
            text: Strings.addAccountText,
            textFontSize: 18,
            textFontWeight: 600,
          ),
          VerticalSpacing(10),
          CommonButton(
            onPressed: () {
              CommonBottomSheet.show(
                context,
                title: '',
                minChildSize: 0.4,
                maxChildSize: 0.5,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: AppColors.greenOne.withValues(
                          alpha: 0.2
                        ),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: AppColors.greenOne,
                        ),
                      ),
                    ),
                    VerticalSpacing(20),
                    CommonText(
                      Strings.onboardingCompleteTitleText,
                      fontSize: 22,
                      fontWeight: 700,
                      color: AppColors.blackTwo,
                    ),
                    VerticalSpacing(30),
                    CommonText(
                      Strings.onboardingCompleteSubTitleOneText,
                      fontSize: 16,
                      fontWeight: 400,
                      color: AppColors.redOne,
                    ),
                    CommonText(
                      Strings.onboardingCompleteSubTitleTwoText,
                      fontSize: 16,
                      fontWeight: 400,
                      maxLines: 6,
                      color: AppColors.blackTwo,
                      textOverflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                    VerticalSpacing(40),
                  ],
                )
              );
            },
            text: Strings.doneText,
            textColor: AppColors.whiteOne,
          )
        ]
        else...[
          VerticalSpacing(60),
          Center(
            child: SvgPicture.asset(
              Assets.addBankAccountSvgIcon,
              width: 110,
              height: 110,
            ),
          ),
          VerticalSpacing(60),
          CommonButton(
            width: context.width / 2.5,
            text: Strings.addNewText,
            textFontSize: 18,
            textFontWeight: 700,
            radius: 15,
            onPressed: () {
              authController.toggleAddBankAccountsForm();
            },
          )
        ],
      ],
    );
  }
}
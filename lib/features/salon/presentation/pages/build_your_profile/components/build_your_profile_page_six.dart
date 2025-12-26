import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/core/services/loading_service.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_bottom_sheet_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_checkbox.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class BuildYourProfilePageSix extends StatefulWidget {
  const BuildYourProfilePageSix({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  State<BuildYourProfilePageSix> createState() => _BuildYourProfilePageSixState();
}

class _BuildYourProfilePageSixState extends State<BuildYourProfilePageSix> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  pageController: widget.pageController,
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class _ShowBankAccountsWidget extends StatelessWidget {
  const _ShowBankAccountsWidget({
    required this.pageController,
  });

  final PageController pageController;

  String maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return '*' * (accountNumber.length - 4) +
        accountNumber.substring(accountNumber.length - 4);
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final bankAccounts = authController.buildProfileData?.bankAccounts ?? [];

    if (bankAccounts.isEmpty) {
      return _EmptyBankAccountState(authController: authController);
    }

    return Column(
      children: [
        SizedBox(
          height: context.height * 0.5,
          child: Column(
            children: [
              ...List.generate(
                bankAccounts.length,
                  (index) => Column(
                  children: [
                    Obx(() => _BankAccountTile(
                      bankAccount: bankAccounts[index],
                      isSelected: authController.selectedBankAccountIndex.value == index,
                      onSelect: () => authController.selectBankAccount(index),
                      maskedNumber: maskAccountNumber(bankAccounts[index].accountNumber),
                    )),
                    VerticalSpacing(10),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              CommonButton(
                onPressed: authController.toggleAddBankAccountsForm,
                backgroundColor: AppColors.whiteOne,
                textColor: AppColors.blackTwo,
                borderColor: AppColors.greyOne,
                text: Strings.addAccountText,
                textFontSize: 18,
                textFontWeight: 600,
              ),

              VerticalSpacing(10),

              CommonButton(
                onPressed: () async {
                  if (authController.selectedBankAccountIndex.value == null) {
                    MessageUtils.showErrorSnackBar(
                      "Please select at least one bank account as primary account",
                    );
                    return;
                  }

                  final loadingService = Get.find<LoadingService>();
                  try {
                    loadingService.show();
                    await Future.delayed(const Duration(seconds: 2));
                    loadingService.hide();
                    _showCompletionBottomSheet(context);
                  } catch (e) {
                    loadingService.hide();
                    rethrow;
                  }
                },
                text: Strings.doneText,
                textColor: AppColors.whiteOne,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCompletionBottomSheet(BuildContext context) {
    CommonBottomSheet.show(
      context,
      title: '',
      minChildSize: 0.4,
      maxChildSize: 0.5,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: AppColors.greenOne.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Icon(Icons.check, color: AppColors.greenOne),
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
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      final authController = Get.find<AuthController>();
      authController.resetOnboardingData();
      Get.offAllNamed(RouteNames.mainSalon);
    });
  }
}

class _BankAccountTile extends StatelessWidget {
  final BankAccountInfoDto bankAccount;
  final bool isSelected;
  final VoidCallback onSelect;
  final String maskedNumber;

  const _BankAccountTile({
    required this.bankAccount,
    required this.isSelected,
    required this.onSelect,
    required this.maskedNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          border: Border.all(
            color: isSelected ? AppColors.pinkTwo : AppColors.greyOne,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(20),
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
                      maskedNumber,
                      fontSize: 14,
                      fontWeight: 500,
                      color: AppColors.blackTwo,
                    ),
                  ],
                ),
              ],
            ),
            _RadioIndicator(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  final bool isSelected;

  const _RadioIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.pinkTwo : AppColors.whiteOne,
        border: Border.all(
          color: isSelected ? AppColors.pinkTwo : AppColors.greyOne,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteOne,
          ),
        ),
      )
          : null,
    );
  }
}

class _EmptyBankAccountState extends StatelessWidget {
  final AuthController authController;

  const _EmptyBankAccountState({required this.authController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          onPressed: authController.toggleAddBankAccountsForm,
        )
      ],
    );
  }
}

class _ShowAddBankAccountsForm extends StatefulWidget {
  @override
  State<_ShowAddBankAccountsForm> createState() => _ShowAddBankAccountsFormState();
}

class _ShowAddBankAccountsFormState extends State<_ShowAddBankAccountsForm> with FieldsValidation {

  final _formKey = GlobalKey<FormState>();

  final confirmAccountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextField(
            titleLabelText: Strings.accountHolderNameText,
            controller: authController.bankAccountHolderNameController,
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
            titleLabelText: Strings.bankNameText,
            items: _bankNames.map((value) => DropdownMenuItem(
              value: value,
              child: CommonText(
                value,
                fontSize: 15,
                color: AppColors.greyTwo
              ),
            )).toList(),
            selectedItemBuilder: (context) => _bankNames.map((value) => CommonText(
              value,
              fontSize: 15,
              color: AppColors.blackTwo
            )).toList(),
            validator: validateTextNotEmpty,
            value: authController.bankNameController.text.isEmpty ? null : authController.bankNameController.text,
            onChanged: (value) => authController.bankNameController.text = value ?? '',
          ),

          VerticalSpacing(20),

          CommonTextField(
            titleLabelText: Strings.accountNumberNameText,
            controller: authController.accountNumberController,
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
              value,
              confirmAccountNumberController.text
            ),
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
            value: authController.confirmAndConsentToThisAccount.value,
            onChanged: (value) => authController
                .confirmAndConsentToThisAccount
                .value = value ?? false,
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
              final haveConsented = authController
                  .confirmAndConsentToThisAccount.value;

              if (_formKey.currentState!.validate() && haveConsented) {
                authController.addBankAccount(
                  BankAccountInfoDto(
                    accountHolderFullName: authController.bankAccountHolderNameController.text,
                    bankName: authController.bankNameController.text,
                    accountNumber: authController.accountNumberController.text,
                    areTermsAndConditionsAccepted:
                    authController.confirmAndConsentToThisAccount.value,
                  ),
                );
                authController.toggleAddBankAccountsForm();
              }
              else {
                MessageUtils.showErrorSnackBar(
                  "Please check the confirmation to consent to link bank accounts",
                );
              }
            },
          ),
        ],
      ),
    );
  }

  List<String> get _bankNames => [
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
}





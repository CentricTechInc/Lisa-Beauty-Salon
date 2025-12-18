import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'components/add_bank_account_form_component.dart';
import 'components/bank_account_list_section.dart';

class BankAccountPage extends StatelessWidget {
  const BankAccountPage({super.key});

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
      resizeToAvoidBottomInset: true,
      bgColor: AppColors.whiteTwo,
      child: Column(
        children: [
          const VerticalSpacing(30),
          Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: authController.showAddBankAccountsForm.value
                        ? () => authController.toggleAddBankAccountsForm()
                        : () => Get.back(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.whiteOne,
                      border: Border.all(color: AppColors.greyOne, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(CupertinoIcons.back, color: AppColors.blackTwo),
                  ),
                ),
                const HorizontalSpacing(15),
                CommonText(
                  authController.showAddBankAccountsForm.value
                      ? Strings.addAccountTitleText
                      : Strings.bankAccountTitleText,
                  fontSize: 20,
                      fontWeight: 600,
                      color: AppColors.blackTwo,
                    ),
                  ],
                ),
            )
          ),
          const VerticalSpacing(20),
          Expanded(
            child: Obx(() {
              if (authController.showAddBankAccountsForm.value) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AddBankAccountFormComponent(
                    onSaved: () {
                      authController.toggleAddBankAccountsForm();
                    },
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const BankAccountListSection(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: CommonButton(
                        onPressed: () => authController.toggleAddBankAccountsForm(),
                        text: Strings.addAnotherAccountText,
                        textFontSize: 18,
                        textFontWeight: 600,
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class WithdrawBottomSheetComponent extends StatelessWidget {
  const WithdrawBottomSheetComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: const BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.greyOne,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            VerticalSpacing(24),
            Center(
              child: Column(
                children: [
                  CommonText(
                    Strings.remainingBalanceText,
                    fontSize: 20,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  CommonText(
                    Strings.remainingBalancePlaceholderText,
                    fontSize: 48,
                    fontWeight: 700,
                    color: AppColors.greenOne,
                  ),
                  CommonText(
                    "Blossom Steele", // TODO: Dynamic name
                    fontSize: 18,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                ],
              ),
            ),
            VerticalSpacing(20),
            CommonTextField(
              controller: TextEditingController(),
              titleLabelText: Strings.enterAmountToWithdrawText,
              labelText: Strings.payoutPlaceholderText,
              hintText: Strings.payoutPlaceholderText,
              suffix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.blackTwo, 
                        width: 1.5
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.attach_money,
                      size: 14,
                      color: AppColors.blackTwo,
                    ),
                  ),
                ),
            ),
            VerticalSpacing(24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyOne),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.pinkOne,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.account_balance,
                      color: AppColors.whiteOne,
                    ),
                  ),
                  HorizontalSpacing(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          Strings.bankAccountText,
                          fontSize: 16,
                          fontWeight: 700,
                          color: AppColors.blackTwo,
                        ),
                        VerticalSpacing(4),
                        CommonText(
                          "**** **** 2345",
                          fontSize: 14,
                          fontWeight: 400,
                          color: AppColors.blackTwo,
                        ),
                      ],
                    ),
                  ),
                  // Custom Radio Button look-alike
                   Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.pinkOne, width: 6),
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpacing(24),
            CommonText(
              Strings.notesText,
              fontSize: 16,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(8),
            CommonText(
              Strings.withdrawalsProcessedText,
              fontSize: 14,
              fontWeight: 400,
              color: AppColors.blackTwo,
              maxLines: 2,
              lineHeight: 1.5,
            ),
             VerticalSpacing(32),
            CommonButton(
              text: Strings.confirmWithdrawText,
              onPressed: () {
                 // Handle withdrawal
                 Navigator.pop(context);
              },
              backgroundColor: AppColors.pinkOne,
              textColor: AppColors.whiteOne,
            ),
            VerticalSpacing(16), // Bottom padding
          ],
        ),
      ),
    );
  }
}

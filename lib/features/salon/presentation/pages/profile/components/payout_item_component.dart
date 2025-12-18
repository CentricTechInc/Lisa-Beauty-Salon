import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/features/salon/domain/entities/payout_model.dart';

class PayoutItemComponent extends StatelessWidget {
  final PayoutModel payout;
  final VoidCallback onTap;

  const PayoutItemComponent({
    super.key,
    required this.payout,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.greyFour),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              "${DateFormat('dd MMMM yyyy').format(payout.dateTime)} - ${DateFormat('hh:mm a').format(payout.dateTime)}",
              fontSize: 16,
              fontWeight: 600.0,
              color: AppColors.blackTwo,
            ),
            const VerticalSpacing(12),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.pinkTwo,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.account_balance, color: Colors.white, size: 20),
                ),
                const HorizontalSpacing(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        Strings.bankAccountText,
                        fontSize: 16,
                        fontWeight: 700.0,
                        color: AppColors.blackTwo,
                      ),
                      CommonText(
                        payout.accountNumber,
                        fontSize: 14,
                        fontWeight: 500.0,
                        color: AppColors.blackTwo,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const VerticalSpacing(12),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Strings.withdrawAmountText,
                    style: TextStyle(
                      color: AppColors.blackTwo,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: Strings.fontFamily,
                    ),
                  ),
                  TextSpan(
                    text: "R ${payout.amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: AppColors.pinkTwo,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: Strings.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

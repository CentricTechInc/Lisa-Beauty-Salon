import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class PayoutHistoryCard extends StatelessWidget {
  final String date;
  final String time;
  final String bankName;
  final String accountNumberMasked;
  final String withdrawAmount;

  const PayoutHistoryCard({
    super.key,
    required this.date,
    required this.time,
    required this.bankName,
    required this.accountNumberMasked,
    required this.withdrawAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.greyOne),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            "$date - $time",
            fontSize: 16,
            fontWeight: 600,
            color: AppColors.blackTwo,
          ),
          VerticalSpacing(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.pinkOne,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_balance,
                  color: AppColors.whiteOne,
                  size: 24,
                ),
              ),
              HorizontalSpacing(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      bankName,
                      fontSize: 16,
                      fontWeight: 700,
                      color: AppColors.blackTwo,
                    ),
                    VerticalSpacing(4),
                    CommonText(
                      accountNumberMasked,
                      fontSize: 14,
                      fontWeight: 500,
                      color: AppColors.blackTwo,
                    ),
                  ],
                ),
              ),
            ],
          ),
          VerticalSpacing(16),
          RichText(
            text: TextSpan(
              text: Strings.withdrawAmountText,
              style: const TextStyle(
                fontFamily: Strings.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.blackTwo,
              ),
              children: [
                TextSpan(
                  text: withdrawAmount,
                  style: const TextStyle(
                    fontFamily: Strings.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.pinkTwo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

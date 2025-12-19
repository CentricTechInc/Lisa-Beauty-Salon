import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/features/salon/domain/entities/payout_model.dart';

class PayoutDetailsComponent extends StatelessWidget {
  final PayoutModel payout;

  const PayoutDetailsComponent({
    super.key,
    required this.payout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: AppColors.pinkTwo,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.account_balance, color: Colors.white, size: 40),
        ),
        const VerticalSpacing(15),
        const CommonText(
          Strings.bankAccountText,
          fontSize: 18,
          fontWeight: 700.0,
          color: AppColors.blackTwo,
        ),
        const VerticalSpacing(20),
        _buildDetailRow(
          context,
          Strings.dateTimeText,
          DateFormat('dd MMMM yyyy, hh:mm a').format(payout.dateTime),
          fontSize: 16,
          fontWeight: 700.0,
        ),
        const VerticalSpacing(10),
        _buildDetailRow(
          context,
          Strings.bankNameText,
          Strings.investecBankText,
          fontSize: 16,
          fontWeight: 500.0,
        ),
        const VerticalSpacing(10),
        _buildDetailRow(
          context,
          Strings.accountNumberNameText,
          payout.accountNumber,
          fontSize: 16,
          fontWeight: 500.0,
        ),
        const VerticalSpacing(10),
        _buildDetailRow(
          context,
          Strings.statusText,
          Strings.completedText,
          fontSize: 16,
          fontWeight: 500.0,
          valueColor: AppColors.greenOne,
        ),
        const Divider(height: 30),
        _buildDetailRow(
          context,
          Strings.totalWithdrawText,
          "R ${payout.amount.toStringAsFixed(2)}",
          fontSize: 24,
          fontWeight: 700.0,
          valueColor: AppColors.pinkTwo,
        ),
        const VerticalSpacing(20),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label, 
    String value, {
      double fontSize = 16, 
      double fontWeight = 500.0, 
      Color? valueColor
    }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.width * 0.4,
          child: CommonText(
            label, 
            fontSize: fontSize, 
            fontWeight: fontWeight, 
            color: AppColors.blackTwo,  
            maxLines: 3,
            textOverflow: TextOverflow.visible
          )
        ),
        SizedBox(
          width: context.width * 0.5,
          child: CommonText(
            value, 
            fontSize: fontSize, 
            fontWeight: fontWeight, 
            color: valueColor ?? AppColors.blackTwo,
            maxLines: 3,
            textOverflow: TextOverflow.visible,
          )
        ),
      ],
    );
  }
}

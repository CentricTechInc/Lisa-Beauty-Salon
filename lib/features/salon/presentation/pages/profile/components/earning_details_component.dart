import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/features/salon/domain/entities/earning_model.dart';

class EarningDetailsComponent extends StatelessWidget {
  final EarningModel earning;

  const EarningDetailsComponent({
    super.key,
    required this.earning,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: earning.clientImage.isNotEmpty
              ? Image.asset(
                  earning.clientImage,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildProfilePlaceholder(size: 80),
                )
              : _buildProfilePlaceholder(size: 80),
        ),
        const VerticalSpacing(10),
        CommonText(
          earning.clientName,
          fontSize: 18,
          fontWeight: 600.0,
          color: AppColors.blackTwo,
        ),
        const VerticalSpacing(20),
        _buildDetailRow(
          Strings.dateTimeText,
          DateFormat('dd MMMM, hh:mm a').format(earning.dateTime),
          fontSize: 16,
          fontWeight: 700.0,
          valueColor: AppColors.pinkTwo,
        ),
        const VerticalSpacing(15),
        Align(
          alignment: Alignment.centerLeft,
          child: CommonText(
            Strings.servicesText,
            fontSize: 16,
            fontWeight: 700.0,
            color: AppColors.blackTwo,
          ),
        ),
        const VerticalSpacing(10),
        ...earning.serviceItems.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildDetailRow(
                item.name,
                "R ${item.price.toStringAsFixed(2)}",
                fontSize: 16,
                fontWeight: 500.0,
              ),
            )),
        const VerticalSpacing(5),
        _buildDetailRow(
          Strings.totalText,
          "R ${earning.subTotal.toStringAsFixed(2)}",
          fontSize: 16,
          fontWeight: 700.0,
        ),
        const VerticalSpacing(8),
        _buildDetailRow(
          "${Strings.platformFeeText} (15%)",
          "R ${earning.platformFee.toStringAsFixed(2)}",
          fontSize: 16,
          fontWeight: 700.0,
        ),
        const Divider(
          height: 30,
          color: AppColors.greyFour,
        ),
        _buildDetailRow(
          Strings.grandTotalText,
          "R ${earning.totalAmount.toStringAsFixed(2)}",
          fontSize: 24,
          fontWeight: 700.0,
          valueColor: AppColors.pinkTwo,
        ),
        const VerticalSpacing(20),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value,
      {double fontSize = 16, double fontWeight = 500.0, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(label, fontSize: fontSize, fontWeight: fontWeight, color: AppColors.blackTwo),
        CommonText(value, fontSize: fontSize, fontWeight: fontWeight, color: valueColor ?? AppColors.blackTwo),
      ],
    );
  }

  Widget _buildProfilePlaceholder({double size = 60}) {
    return Container(
      width: size,
      height: size,
      color: AppColors.greyOne,
      child: Icon(Icons.person, color: Colors.white, size: size * 0.6),
    );
  }
}

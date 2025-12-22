import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            label,
            fontSize: 16,
            fontWeight: 400,
            color: AppColors.greyTwo,
          ),
          CommonText(
            value,
            fontSize: 16,
            fontWeight: 600,
            color: AppColors.blackTwo,
          ),
        ],
      ),
    );
  }
}

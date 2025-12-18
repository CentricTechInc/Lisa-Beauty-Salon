
import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class TimeSelectorBlock extends StatelessWidget {
  final String label;
  final TextEditingController timeController;
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const TimeSelectorBlock({
    required this.label,
    required this.timeController,
    required this.selectedPeriod,
    required this.onPeriodChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          label,
          fontSize: 12,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        const VerticalSpacing(8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CommonTextField(
                controller: timeController,
                fillColor: AppColors.greyFour,
                borderRadius: 12,
                textColor: AppColors.blackTwo,
                labelText: null,
                hintText: "00:00",
                cursorColor: AppColors.blackTwo,
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const HorizontalSpacing(12),
            Expanded(
              flex: 3,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.greyFour,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildPeriodToggle(Strings.amText, selectedPeriod == Strings.amText),
                    _buildPeriodToggle(Strings.pmText, selectedPeriod == Strings.pmText),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPeriodToggle(String period, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onPeriodChanged(period),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.pinkTwo : AppColors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CommonText(
            period,
            fontSize: 14,
            fontWeight: 600,
            color: isSelected ? AppColors.whiteOne : AppColors.greyTwo,
          ),
        ),
      ),
    );
  }
}

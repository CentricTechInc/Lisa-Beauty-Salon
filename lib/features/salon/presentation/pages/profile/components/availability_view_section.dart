
import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'circular_day_selector.dart';

class AvailabilityViewSection extends StatelessWidget {
  final VoidCallback onEdit;

  const AvailabilityViewSection({
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Mocking selected days for view mode for now, should come from controller
    final selectedDays = [
      Strings.monShortText,
      Strings.tueShortText,
      Strings.wedShortText,
      Strings.thuShortText,
      Strings.friShortText,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const VerticalSpacing(20),
          CircularDaySelector(
            selectedDays: selectedDays,
            onDayToggle: (_) {}, // Non-interactive in view mode
          ),
          const VerticalSpacing(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                "${Strings.fromText} ",
                fontSize: 14,
                color: AppColors.blackTwo,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.greyFour,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CommonText(
                  "08:30 AM",
                  fontSize: 14,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                ),
              ),
              const HorizontalSpacing(12),
              const CommonText("— ", color: AppColors.greyTwo),
              CommonText(
                "${Strings.toText} ",
                fontSize: 14,
                color: AppColors.blackTwo,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.greyFour,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CommonText(
                  "09:30 PM",
                  fontSize: 14,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                ),
              ),
            ],
          ),
          const VerticalSpacing(40),
          CommonText(
            Strings.addBreakTimeText,
            fontSize: 18,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
          const VerticalSpacing(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                "${Strings.fromText} ",
                fontSize: 14,
                color: AppColors.blackTwo,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.greyFour,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const CommonText(
                  "12:30",
                  fontSize: 14,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                ),
              ),
              const HorizontalSpacing(4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.pinkTwo.withValues(
                    alpha: 0.1
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const CommonText(
                  "PM",
                  fontSize: 12,
                  fontWeight: 600,
                  color: AppColors.pinkTwo,
                ),
              ),
              const HorizontalSpacing(12),
              const CommonText("— ", color: AppColors.greyTwo),
              CommonText(
                "${Strings.toText} ",
                fontSize: 14,
                color: AppColors.blackTwo,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.greyFour,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const CommonText(
                  "01:30",
                  fontSize: 14,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                ),
              ),
              const HorizontalSpacing(4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.pinkTwo.withValues(
                    alpha: 0.1
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const CommonText(
                  "PM",
                  fontSize: 12,
                  fontWeight: 600,
                  color: AppColors.pinkTwo,
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CommonButton(
              onPressed: onEdit,
              text: Strings.editAvailabilityText,
              backgroundColor: AppColors.transparent,
              borderColor: AppColors.pinkTwo,
              textColor: AppColors.pinkTwo,
              radius: 12,
              textFontWeight: 600,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class BookingSuccessBottomSheet extends StatelessWidget {
  const BookingSuccessBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 32,
      ),
      decoration: const BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.greenOne.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                color: AppColors.greenOne,
                size: 40,
              ),
            ),
          ),
          const VerticalSpacing(32),
          const CommonText(
            "Your appointment\nbooking is successfully.",
            fontSize: 24,
            fontWeight: 700,
            color: AppColors.blackTwo,
            textAlign: TextAlign.center,
          ),
          const VerticalSpacing(24),
          const CommonText(
            "You can view the appointment booking\ninfo in the “Appointment” section.",
            fontSize: 16,
            fontWeight: 400,
            color: AppColors.blackTwo,
            textAlign: TextAlign.center,
          ),
          const VerticalSpacing(16),
        ],
      ),
    );
  }
}

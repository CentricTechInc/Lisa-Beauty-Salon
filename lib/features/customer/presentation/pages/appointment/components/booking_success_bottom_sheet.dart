import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/utils/helpers.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';

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
          const VerticalSpacing(32),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.chat_bubble_outline,
                  label: Strings.chatText,
                  onTap: () => showFeatureUnderDevelopment(),
                ),
              ),
              const HorizontalSpacing(16),
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.directions_outlined,
                  label: Strings.directionText,
                  onTap: () => showFeatureUnderDevelopment(),
                ),
              ),
            ],
          ),
          const VerticalSpacing(32),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CommonButton(
              text: "Continue",
              onPressed: () {
                Get.offAllNamed(RouteNames.mainCustomer);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.blackThree,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.whiteOne, size: 20),
            const HorizontalSpacing(10),
            CommonText(label, fontSize: 16, color: AppColors.whiteOne, fontWeight: 500),
          ],
        ),
      ),
    );
  }
}

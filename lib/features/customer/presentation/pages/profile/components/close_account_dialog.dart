import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';

class CustomerCloseAccountDialog extends StatelessWidget {
  const CustomerCloseAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.pinkTwo.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.pinkTwo,
                size: 24,
              ),
            ),
            const VerticalSpacing(16),
            const CommonText(
              "Close Account?",
              fontSize: 20,
              fontWeight: 700,
              color: AppColors.blackTwo,
              textAlign: TextAlign.center,
            ),
            const VerticalSpacing(8),
            const CommonText(
              "Are you sure you want to close your account?",
              fontSize: 14,
              fontWeight: 400,
              color: AppColors.greyTwo,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.visible,
              maxLines: 3,
            ),
            const VerticalSpacing(12),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    onPressed: () => Get.back(result: true),
                    text: "Yes",
                    backgroundColor: AppColors.whiteOne,
                    textColor: AppColors.greyTwo,
                    borderColor: AppColors.greyOne,
                  ),
                ),
                const HorizontalSpacing(16),
                Expanded(
                  child: CommonButton(
                    onPressed: () => Get.back(result: false),
                    text: "No",
                    backgroundColor: AppColors.pinkTwo,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

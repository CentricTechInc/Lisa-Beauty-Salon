import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_sliding_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CustomerCloseAccountDialogComponent extends StatelessWidget {
  CustomerCloseAccountDialogComponent({super.key});

  final ValueNotifier<bool> isYesSelected = ValueNotifier(false);

  void _onSelect(bool value) {
    isYesSelected.value = value;
    Get.back(result: value);
  }


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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 24
              ),
              child: CommonSlidingButton(
                valueListenable: isYesSelected,
                leftLabel: "Yes",
                rightLabel: "No",
                onLeftTap: () => _onSelect(true),
                onRightTap: () => _onSelect(false),
                leftActiveColor: AppColors.whiteOne,
                rightActiveColor: AppColors.pinkTwo,
                leftActiveTextColor: AppColors.greyTwo,
                rightActiveTextColor: AppColors.whiteOne,
                inactiveTextColor: AppColors.greyTwo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

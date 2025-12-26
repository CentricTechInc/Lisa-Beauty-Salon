import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class DeleteServicesDialog extends StatelessWidget {
  final int count;
  const DeleteServicesDialog({super.key, required this.count});

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
                Icons.delete_outline,
                color: AppColors.pinkTwo,
                size: 24,
              ),
            ),
            const VerticalSpacing(16),
            CommonText(
              "Delete Services",
              fontSize: 20,
              fontWeight: 700,
              color: AppColors.blackTwo,
              textAlign: TextAlign.center,
            ),
            const VerticalSpacing(8),
            CommonText(
              "Are you sure you want to delete $count selected services?",
              fontSize: 14,
              fontWeight: 400,
              color: AppColors.blackTwo,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.visible,
              maxLines: 3,
            ),
            const VerticalSpacing(24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(result: false),
                    child: const CommonText(
                      "Cancel",
                      color: AppColors.greyTwo,
                      fontSize: 16,
                      fontWeight: 600,
                    ),
                  ),
                ),
                const HorizontalSpacing(12),
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(result: true),
                    child: const CommonText(
                      "Delete",
                      color: AppColors.pinkTwo,
                      fontSize: 16,
                      fontWeight: 700,
                    ),
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

import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class ServiceCategoryTile extends StatelessWidget {
  final String categoryName;
  final int count;
  final VoidCallback onTap;

  const ServiceCategoryTile({
    required this.categoryName,
    required this.count,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          border: Border.all(color: AppColors.greyOne, width: 1.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              categoryName,
              fontSize: 16,
              fontWeight: 500,
              color: AppColors.greyTwo,
            ),
            Row(
              children: [
                CommonText(
                  "$count ${Strings.typesText}",
                  fontSize: 14,
                  fontWeight: 400,
                  color: AppColors.blackTwo,
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.greyTwo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    this.isSelected = false,
  });

  final String name;
  final String description;
  final String price;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          RouteNames.subServices,
          arguments: {
            'categoryName': name,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.pinkTwo
                : AppColors.greyOne.withValues(alpha: 0.3),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CommonText(
                name,
                fontSize: 16,
                fontWeight: 600,
                color: isSelected ? AppColors.pinkTwo : AppColors.blackTwo,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonText(
                    description,
                    fontSize: 12,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                    textAlign: TextAlign.right,
                  ),
                  if (price.isNotEmpty) ...[
                    VerticalSpacing(4),
                    CommonText(
                      price,
                      fontSize: 14,
                      fontWeight: 600,
                      color: AppColors.pinkTwo,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ],
              ),
            ),
            HorizontalSpacing(12),
            Icon(
              Icons.chevron_right,
              color: AppColors.greyTwo.withValues(alpha: 0.5),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

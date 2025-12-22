import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package_detail_sheet.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({super.key, required this.package});

  final Map<String, dynamic> package;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyOne.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(package['image'] as String),
                fit: BoxFit.cover,
              ),
            ),
          ),
          HorizontalSpacing(12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  package['name'] as String,
                  fontSize: 16,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                ),
                VerticalSpacing(2),
                CommonText(
                  package['description'] as String,
                  fontSize: 12,
                  fontWeight: 400,
                  color: AppColors.greyTwo,
                ),
                VerticalSpacing(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      package['price'] as String,
                      fontSize: 18,
                      fontWeight: 700,
                      color: AppColors.pinkTwo,
                    ),
                    CommonButton(
                      width: 100,
                      height: 36,
                      radius: 8,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _showPackageDetails(context, package);
                      },
                      text: Strings.bookNowText,
                      textFontSize: 14,
                      textFontWeight: 600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPackageDetails(BuildContext context, Map<String, dynamic> package) {
    Get.bottomSheet(
      PackageDetailSheet(package: package),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

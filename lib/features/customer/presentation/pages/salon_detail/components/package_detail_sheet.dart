import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class PackageDetailSheet extends StatelessWidget {
  const PackageDetailSheet({super.key, required this.package});

  final Map<String, dynamic> package;

  @override
  Widget build(BuildContext context) {
    final List<String> services = package['services'] as List<String>;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            30
          )
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20, 
        vertical: 20
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.greyOne,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            VerticalSpacing(20),
            // Hero Image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: AssetImage(package['image'] as String),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            VerticalSpacing(20),
            CommonText(
              package['name'] as String,
              fontSize: 24,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            CommonText(
              package['description'] as String,
              fontSize: 14,
              fontWeight: 400,
              color: AppColors.greyTwo,
              textOverflow: TextOverflow.visible,
            ),
            VerticalSpacing(20),
            CommonText(
              package['about'] as String,
              fontSize: 14,
              fontWeight: 400,
              color: AppColors.blackTwo.withValues(alpha: 0.8),
              textOverflow: TextOverflow.visible,
              lineHeight: 1.5,
            ),
            VerticalSpacing(24),
            const CommonText(
              Strings.servicesTitleText,
              fontSize: 18,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(16),
            // 2-column services list
            Wrap(
              spacing: 20,
              runSpacing: 12,
              children: services.map((service) {
                return SizedBox(
                  width: (context.width - 60) / 2,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.greenOne, width: 1.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: AppColors.greenOne,
                          size: 10,
                        ),
                      ),
                      HorizontalSpacing(8),
                      Expanded(
                        child: CommonText(
                          service,
                          fontSize: 14,
                          fontWeight: 500,
                          color: AppColors.blackTwo,
                          maxLines: 4,
                          textOverflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            VerticalSpacing(30),
            // Booking Footer
            CommonButton(
              onPressed: () => Get.back(),
              radius: 16,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CommonText(
                      Strings.bookNowText,
                      fontSize: 18,
                      fontWeight: 600,
                      color: AppColors.whiteOne,
                    ),
                    CommonText(
                      package['price'] as String,
                      fontSize: 18,
                      fontWeight: 700,
                      color: AppColors.whiteOne,
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpacing(10),
          ],
        ),
      ),
    );
  }
}

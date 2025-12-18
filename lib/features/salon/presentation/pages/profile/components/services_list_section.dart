import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'service_category_tile.dart';

class ServicesListSection extends StatelessWidget {
  final VoidCallback onAddService;
  final Function(String) onCategoryTap;

  const ServicesListSection({
    required this.onAddService,
    required this.onCategoryTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const VerticalSpacing(20),
          const Center(
            child: CommonText(
              Strings.addAServiceHelpText,
              fontSize: 16,
              fontWeight: 400,
              color: AppColors.greyTwo,
              textAlign: TextAlign.center,
              maxLines: 2,
              textOverflow: TextOverflow.visible,
            ),
          ),
          const VerticalSpacing(40),
          Obx(() {
            final services = authController.buildProfileData?.services ?? [];
            if (services.isEmpty) {
              return const SizedBox.shrink();
            }

            // Group services by category
            final Map<String, int> categories = {};
            for (var service in services) {
              categories[service.serviceCategory] =
                  (categories[service.serviceCategory] ?? 0) + 1;
            }

            final sortedCategories = categories.keys.toList()..sort();

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortedCategories.length,
              separatorBuilder: (_, __) => const VerticalSpacing(12),
              itemBuilder: (context, index) {
                final category = sortedCategories[index];
                return ServiceCategoryTile(
                  categoryName: category,
                  count: categories[category]!,
                  onTap: () => onCategoryTap(category),
                );
              },
            );
          }),
          VerticalSpacing(60),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: CommonButton(
              width: context.width * 0.4,
              height: 55,
              onPressed: () => authController.toggleAddServiceForm(),
              backgroundColor: AppColors.pinkTwo.withValues(
                alpha: 0.2
              ),
              padding: EdgeInsets.all(12.0),
              borderColor: AppColors.pinkTwo,
              text: "+ ${Strings.addAServiceText}",
              textColor: AppColors.pinkTwo,
              radius: 12,
              textFontSize: 16,
              textFontWeight: 600,
            ),
          ),
        ],
      ),
    );
  }
}

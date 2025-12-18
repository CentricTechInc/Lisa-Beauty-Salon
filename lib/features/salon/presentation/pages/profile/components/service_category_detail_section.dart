import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'service_detail_card.dart';

class ServiceCategoryDetailSection extends StatelessWidget {
  final String category;

  const ServiceCategoryDetailSection({
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20),
              child: Obx(() {
                final allServices = authController.buildProfileData?.services ?? [];
                final categoryServices = allServices
                    .where((s) => s.serviceCategory == category)
                    .toList();

                return Column(
                  children: categoryServices
                      .map((service) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ServiceDetailCard(service: service),
                          ))
                      .toList(),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: CommonButton(
              onPressed: () {
                // Implementation for delete could open a selection mode or a bottom sheet
                // For now, mirroring the image which shows a simple button
                Get.snackbar(
                  "Notice",
                  "Tap a service to edit or delete (Not yet implemented)",
                );
              },
              text: Strings.deleteAnyServiceText,
              backgroundColor: AppColors.transparent,
              borderColor: AppColors.pinkTwo,
              textColor: AppColors.pinkTwo,
              radius: 12,
              textFontWeight: 600,
            ),
          ),
        ],
      ),
    );
  }
}

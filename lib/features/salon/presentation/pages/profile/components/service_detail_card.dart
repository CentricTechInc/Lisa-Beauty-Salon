import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class ServiceDetailCard extends StatelessWidget {
  final ServiceDto service;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback? onSelected;

  const ServiceDetailCard({
    required this.service,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSelectionMode ? onSelected : null,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          border: Border.all(
            color: isSelectionMode && isSelected
                ? AppColors.pinkTwo
                : AppColors.greyOne,
            width: isSelectionMode && isSelected ? 2 : 1.2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: service.servicePhoto.isNotEmpty &&
                          File(service.servicePhoto).existsSync()
                      ? Image.file(
                          File(service.servicePhoto),
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 70,
                          width: 70,
                          color: AppColors.pinkTwo.withValues(alpha: 0.1),
                          child:
                              const Icon(Icons.image, color: AppColors.pinkTwo),
                        ),
                ),
                const HorizontalSpacing(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            service.serviceFor,
                            fontSize: 12,
                            fontWeight: 400,
                            color: AppColors.greyTwo,
                          ),
                          if (isSelectionMode)
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? AppColors.pinkTwo
                                    : AppColors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.pinkTwo
                                      : AppColors.greyOne,
                                  width: 1.5,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: AppColors.whiteOne,
                                    )
                                  : null,
                            ),
                        ],
                      ),
                      const VerticalSpacing(4),
                      CommonText(
                        service.serviceName,
                        fontSize: 16,
                        fontWeight: 700,
                        color: AppColors.blackTwo,
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      const VerticalSpacing(8),
                      CommonText(
                        "R ${service.servicePrice.toStringAsFixed(2)}",
                        fontSize: 16,
                        fontWeight: 700,
                        color: AppColors.pinkTwo,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (service.serviceDescription.isNotEmpty) ...[
              const VerticalSpacing(15),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: Strings.descriptionLabelText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackTwo,
                        fontFamily: 'Onest',
                      ),
                    ),
                    TextSpan(
                      text: service.serviceDescription,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyTwo,
                        fontFamily: 'Onest',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }


}

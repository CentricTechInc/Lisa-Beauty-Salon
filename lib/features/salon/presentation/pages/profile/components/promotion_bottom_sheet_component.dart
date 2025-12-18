import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/features/promotions/data/dto/promotion_dto.dart';

class PromotionBottomSheetComponent extends StatelessWidget {
  final PromotionDto promotion;

  const PromotionBottomSheetComponent({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            height: 140,
            color: AppColors.greyFour,
            child: promotion.imagePath.isEmpty
                ? const Icon(Icons.image, color: AppColors.greyTwo, size: 48)
                : Image.file(
                    File(promotion.imagePath),
                    fit: BoxFit.cover,
                    height: 140,
                    width: double.infinity,
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonText(
                promotion.title,
                fontSize: 24,
                fontWeight: 600,
                color: AppColors.blackTwo,
              ),
              const VerticalSpacing(4),
              CommonText(
                promotion.subtitle,
                fontSize: 16,
                fontWeight: 400,
                color: AppColors.greyTwo,
              ),
              const VerticalSpacing(12),
              CommonText(
                promotion.description,
                fontSize: 16,
                fontWeight: 400,
                color: AppColors.blackTwo,
                lineHeight: 1.6,
              ),
              const VerticalSpacing(16),
              const CommonText(
                Strings.servicesTitleText,
                fontSize: 16,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
              const VerticalSpacing(10),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: promotion.services.map((s) => ServiceChipComponent(text: s)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ServiceChipComponent extends StatelessWidget {
  final String text;

  const ServiceChipComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 14, color: AppColors.whiteOne),
          ),
          const HorizontalSpacing(8),
          CommonText(
            text,
            fontSize: 14,
            fontWeight: 400,
            color: AppColors.blackTwo,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/features/promotions/data/dto/promotion_dto.dart';

class PromotionListSection extends StatelessWidget {
  final List<PromotionDto> promotions;
  final ValueChanged<int> onSelect;
  final VoidCallback onAddPromotion;

  const PromotionListSection({
    super.key,
    required this.promotions,
    required this.onSelect,
    required this.onAddPromotion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CommonText(
            Strings.promotionListDescriptionText,
            fontSize: 14,
            fontWeight: 400,
            color: AppColors.greyTwo,
            textOverflow: TextOverflow.visible,
            maxLines: null,
            textAlign: TextAlign.center,
          ),
          const VerticalSpacing(16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: promotions.length,
            separatorBuilder: (_, __) => const VerticalSpacing(12),
            itemBuilder: (context, index) {
              final p = promotions[index];
              return InkWell(
                onTap: () => onSelect(index),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteOne,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: AppColors.greyOne),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              p.title,
                              fontSize: 16,
                              fontWeight: 700,
                              color: AppColors.blackTwo,
                            ),
                            const VerticalSpacing(4),
                            CommonText(
                              p.subtitle,
                              fontSize: 14,
                              fontWeight: 400,
                              color: AppColors.greyTwo,
                            ),
                          ],
                        ),
                      ),
                      CommonText(
                        p.priceText,
                        fontSize: 14,
                        fontWeight: 700,
                        color: AppColors.pinkTwo,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const VerticalSpacing(20),
          CommonButton(
            onPressed: onAddPromotion,
            text: Strings.addAPromotionText,
            width: 180,
            backgroundColor: AppColors.transparent,
            borderColor: AppColors.pinkTwo,
            textColor: AppColors.pinkTwo,
            radius: 12,
          ),
          const VerticalSpacing(20),
        ],
      ),
    );
  }
}

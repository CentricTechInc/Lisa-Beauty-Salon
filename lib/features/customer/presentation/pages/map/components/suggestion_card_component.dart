import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class SuggestionCardComponent extends StatelessWidget {
  final String name;
  final String category;
  final String address;
  final String providerType;
  final double rating;
  final String image;
  final VoidCallback? onTap;

  const SuggestionCardComponent({
    super.key,
    required this.name,
    required this.category,
    required this.address,
    required this.providerType,
    required this.rating,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.greyOne),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const HorizontalSpacing(08),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    name,
                    fontSize: 18,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(4),
                  CommonText(
                    address,
                    fontSize: 12,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const VerticalSpacing(4),
                  CommonText(
                    providerType,
                    fontSize: 14,
                    fontWeight: 500,
                    color: AppColors.pinkTwo,
                  ),
                  const VerticalSpacing(8),
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < rating.floor()
                              ? Icons.star
                              : (index < rating
                                  ? Icons.star_half
                                  : Icons.star_border),
                          color: AppColors.yellowOne,
                          size: 16,
                        );
                      }),
                      const Spacer(),
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.blackTwo,
                      ),
                      const HorizontalSpacing(4),
                      CommonText(
                        "$rating km",
                        fontSize: 12,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

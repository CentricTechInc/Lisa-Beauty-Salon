import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });

  final String name;
  final int rating;
  final String comment;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.greyFive,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: CommonText(
              name[0],
              fontSize: 18,
              fontWeight: 600,
              color: AppColors.blackTwo,
            ),
          ),
        ),

        HorizontalSpacing(12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    name,
                    fontSize: 16,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                  CommonText(
                    date,
                    fontSize: 12,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                  ),
                ],
              ),

              VerticalSpacing(6),

              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating
                        ? Icons.star_rate_rounded
                        : Icons.star_border_rounded,
                    color: AppColors.yellowOne,
                    size: 16,
                  );
                }),
              ),

              VerticalSpacing(8),

              CommonText(
                comment,
                fontSize: 14,
                fontWeight: 400,
                color: AppColors.greyTwo,
                lineHeight: 1.4,
                textOverflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

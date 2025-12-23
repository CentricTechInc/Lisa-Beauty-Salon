import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';

class CommonMessageCard extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final String imageUrl;

  const CommonMessageCard({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.unreadCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: imageUrl.startsWith('http') 
                ? NetworkImage(imageUrl) as ImageProvider
                : AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const HorizontalSpacing(16),
        // Name and Message
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
                message,
                fontSize: 14,
                fontWeight: 400,
                color: AppColors.greyTwo,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Time and Badge
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CommonText(
              time,
              fontSize: 12,
              fontWeight: 400,
              color: AppColors.greyTwo,
            ),
            const VerticalSpacing(8),
            if (unreadCount > 0)
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.pinkOne,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: CommonText(
                    unreadCount.toString(),
                    fontSize: 12,
                    fontWeight: 700,
                    color: AppColors.whiteOne,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

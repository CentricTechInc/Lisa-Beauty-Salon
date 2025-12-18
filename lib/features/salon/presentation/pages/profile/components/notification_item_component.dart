import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class NotificationItemComponent extends StatelessWidget {
  final String title;
  final String time;
  final bool isRead;

  const NotificationItemComponent({
    super.key,
    required this.title,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isRead ? AppColors.greyOne : AppColors.pinkOne,
                ),
              ),
              const HorizontalSpacing(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      title,
                      fontSize: 16,
                      fontWeight: 400,
                      color: AppColors.blackTwo,
                      textOverflow: TextOverflow.visible,
                    ),
                    const VerticalSpacing(5),
                    CommonText(
                      time,
                      fontSize: 12,
                      fontWeight: 400,
                      color: AppColors.greyTwo,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: AppColors.greyOne,
          height: 1,
        ),
      ],
    );
  }
}

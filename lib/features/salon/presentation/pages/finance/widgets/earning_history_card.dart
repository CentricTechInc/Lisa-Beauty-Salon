import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class EarningHistoryCard extends StatelessWidget {
  final String date;
  final String time;
  final String professionalName;
  final String services;
  final String earnAmount;
  final String imagePath;

  const EarningHistoryCard({
    super.key,
    required this.date,
    required this.time,
    required this.professionalName,
    required this.services,
    required this.earnAmount,
    this.imagePath = Assets.welcomeOne,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.greyOne),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            "$date - $time",
            fontSize: 16,
            fontWeight: 600,
            color: AppColors.blackTwo,
          ),
          VerticalSpacing(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              HorizontalSpacing(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      professionalName,
                      fontSize: 18,
                      fontWeight: 600,
                      color: AppColors.blackTwo,
                    ),
                    VerticalSpacing(8),
                    RichText(
                      text: TextSpan(
                        text: Strings.servicesText,
                        style: const TextStyle(
                          fontFamily: Strings.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackTwo,
                        ),
                        children: [
                          TextSpan(
                            text: services,
                            style: const TextStyle(
                              fontFamily: Strings.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.pinkTwo,
                            ),
                          ),
                        ],
                      ),
                    ),
                    VerticalSpacing(8),
                    RichText(
                      text: TextSpan(
                        text: Strings.earnText,
                        style: const TextStyle(
                          fontFamily: Strings.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackTwo,
                        ),
                        children: [
                          TextSpan(
                            text: earnAmount,
                            style: const TextStyle(
                              fontFamily: Strings.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.pinkTwo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/appointment/components/previous_appointment_detail_bottom_sheet.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class PreviousAppointmentCard extends StatelessWidget {
  final String salonName;
  final String date;
  final String image;

  const PreviousAppointmentCard({
    super.key,
    required this.salonName,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetailsBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.greyOne.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackOne.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              date,
              fontSize: 14,
              fontWeight: 600,
              color: AppColors.blackTwo,
            ),
            const VerticalSpacing(12),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const HorizontalSpacing(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        salonName,
                        fontSize: 18,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                      ),
                      const VerticalSpacing(4),
                      const CommonText(
                        "6391 Elgin St. Celina, Delaware...",
                        fontSize: 12,
                        color: AppColors.greyTwo,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      const VerticalSpacing(8),
                      RichText(
                        text: TextSpan(
                          text: "Services: ",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.greyTwo,
                            fontFamily: Strings.fontFamily,
                          ),
                          children: [
                            const TextSpan(
                              text: "Regular Haircut, Classic Shaving",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.pinkTwo,
                                fontFamily: Strings.fontFamily,
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
            const VerticalSpacing(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonButton(
                  onPressed: () => Get.toNamed(RouteNames.review),
                  text: Strings.reviewText,
                  width: 100,
                  height: 40,
                  radius: 12,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 05,
                  ),
                  backgroundColor: AppColors.whiteOne,
                  borderColor: AppColors.greyOne,
                  textColor: AppColors.greyTwo,
                  textFontSize: 12,
                  textFontWeight: 600,
                ),
                const HorizontalSpacing(10),
                CommonButton(
                  onPressed: () => Get.toNamed(RouteNames.bookAppointment),
                  text: Strings.rescheduleText,
                  width: 120,
                  height: 40,
                  radius: 12,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 05,
                  ),
                  backgroundColor: AppColors.pinkTwo,
                  borderColor: AppColors.pinkTwo,
                  textColor: AppColors.whiteOne,
                  textFontSize: 12,
                  textFontWeight: 500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsBottomSheet(BuildContext context) {
    Get.bottomSheet(
      PreviousAppointmentDetailBottomSheet(
        salonName: salonName,
        date: date,
        image: image,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

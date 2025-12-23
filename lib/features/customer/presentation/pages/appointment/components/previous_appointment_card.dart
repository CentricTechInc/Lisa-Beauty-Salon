import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class PreviousAppointmentCard extends StatelessWidget {
  final String salonName;
  final String date;
  final String image;
  final VoidCallback onTap;

  const PreviousAppointmentCard({
    super.key,
    required this.salonName,
    required this.date,
    required this.image,
    required this.onTap,
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: AppColors.whiteOne,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Material(
            color: AppColors.whiteOne,
            child: Column(
              children: [
                const VerticalSpacing(12),
                Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.greyOne,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const VerticalSpacing(24),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          image,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const VerticalSpacing(16),
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
                        fontWeight: 400,
                        color: AppColors.greyTwo,
                      ),
                      const VerticalSpacing(32),
                      _buildDetailRow("Date & Time", "12 November, 09:00 AM", isHighlight: true),
                      const VerticalSpacing(24),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CommonText(
                          "Services",
                          fontSize: 16,
                          fontWeight: 700,
                          color: AppColors.blackTwo,
                        ),
                      ),
                      const VerticalSpacing(12),
                      _buildServiceItem("Nail", "\$8.00"),
                      const VerticalSpacing(8),
                      _buildServiceItem("Facial", "\$24.99"),
                      const VerticalSpacing(20),
                      const Divider(color: AppColors.greyOne),
                      const VerticalSpacing(20),
                      _buildDetailRow("Total", "\$32.99", isBold: true, isHighlight: true),
                      const VerticalSpacing(24),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CommonText(
                          "Notes",
                          fontSize: 16,
                          fontWeight: 700,
                          color: AppColors.blackTwo,
                        ),
                      ),
                      const VerticalSpacing(8),
                      const CommonText(
                        "Lorem ipsum dolor sit amet consectetur. Cras tincidunt purus sed scelerisque.",
                        fontSize: 16,
                        fontWeight: 400,
                        color: AppColors.greyTwo,
                        lineHeight: 1.5,
                        textOverflow: TextOverflow.visible,
                      ),
                      const VerticalSpacing(40),
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(RouteNames.review);
                              },
                              text: "Review",
                              height: 56,
                              radius: 16,
                              backgroundColor: AppColors.whiteOne,
                              borderColor: AppColors.greyOne,
                              textColor: AppColors.greyTwo,
                              textFontSize: 16,
                              textFontWeight: 600,
                            ),
                          ),
                          const HorizontalSpacing(12),
                          Expanded(
                            child: CommonButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(RouteNames.bookAppointment);
                              },
                              text: "Reschedule",
                              height: 56,
                              radius: 16,
                              backgroundColor: AppColors.pinkTwo,
                              borderColor: AppColors.pinkTwo,
                              textColor: AppColors.whiteOne,
                              textFontSize: 16,
                              textFontWeight: 600,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacing(24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  Widget _buildDetailRow(String label, String value, {bool isHighlight = false, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: CommonText(
            label,
            fontSize: isBold ? 20 : 16,
            fontWeight: isBold ? 700 : 600,
            color: AppColors.blackTwo,
            textOverflow: TextOverflow.visible,
          ),
        ),
        Expanded(
          flex: 3,
          child: CommonText(
            value,
            fontSize: isBold ? 20 : 16,
            fontWeight: isBold ? 700 : 500,
            color: isHighlight ? AppColors.pinkTwo : AppColors.blackTwo,
            textAlign: TextAlign.end,
            textOverflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceItem(String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(name, fontSize: 14, color: AppColors.greyTwo),
        CommonText(price, fontSize: 14, color: AppColors.pinkTwo, fontWeight: 500),
      ],
    );
  }
}

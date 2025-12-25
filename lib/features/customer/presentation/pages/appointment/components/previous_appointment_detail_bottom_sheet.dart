import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class PreviousAppointmentDetailBottomSheet extends StatelessWidget {
  final String salonName;
  final String date;
  final String image;

  const PreviousAppointmentDetailBottomSheet({
    super.key,
    required this.salonName,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
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
                    _buildDetailRow("Date & Time", date, isHighlight: true),
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

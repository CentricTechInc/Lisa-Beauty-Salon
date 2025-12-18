import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/features/salon/domain/entities/earning_model.dart';

class EarningItemComponent extends StatelessWidget {
  final EarningModel earning;
  final VoidCallback onTap;

  const EarningItemComponent({
    super.key,
    required this.earning,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.greyFour),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              "${DateFormat('dd MMMM yyyy').format(earning.dateTime)} - ${DateFormat('hh:mm a').format(earning.dateTime)}",
              fontSize: 16,
              fontWeight: 600.0,
              color: AppColors.blackTwo,
            ),
            const VerticalSpacing(12),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: earning.clientImage.isNotEmpty
                      ? Image.asset(
                          earning.clientImage,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildProfilePlaceholder(),
                        )
                      : _buildProfilePlaceholder(),
                ),
                const HorizontalSpacing(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        earning.clientName,
                        fontSize: 18,
                        fontWeight: 600.0,
                        color: AppColors.blackTwo,
                      ),
                      const VerticalSpacing(4),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: Strings.servicesText,
                              style: TextStyle(
                                color: AppColors.blackTwo,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Strings.fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: ": ",
                              style: TextStyle(
                                color: AppColors.blackTwo,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Strings.fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: earning.services.join(", "),
                              style: TextStyle(
                                color: AppColors.pinkTwo,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Strings.fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalSpacing(4),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: Strings.earnText,
                              style: TextStyle(
                                color: AppColors.blackTwo,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Strings.fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: "R ${earning.totalAmount.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: AppColors.pinkTwo,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePlaceholder({double size = 60}) {
    return Container(
      width: size,
      height: size,
      color: AppColors.greyOne,
      child: Icon(Icons.person, color: Colors.white, size: size * 0.6),
    );
  }
}

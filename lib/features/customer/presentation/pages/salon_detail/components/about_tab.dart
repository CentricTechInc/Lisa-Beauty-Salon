import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'info_row.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({super.key});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    const String fullText =
        "Welcome to Bloom & Blade, where your beauty is our priority. Our team of experts is dedicated to providing you with the best experience possible. Whether you're looking for a fresh cut, a stunning new color, or a relaxing spa treatment, we've got you covered. Visit us today and let us help you bloom!";

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            Strings.aboutSalonText,
            fontSize: 18,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
          VerticalSpacing(12),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.greyTwo,
                height: 1.5,
                fontFamily: Strings.fontFamily,
              ),
              children: [
                TextSpan(
                  text: _isExpanded
                      ? fullText
                      : "${fullText.substring(0, 150)}...",
                ),
                TextSpan(
                  text: _isExpanded ? " Read less" : " Read more",
                  style: const TextStyle(
                    color: AppColors.pinkTwo,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                ),
              ],
            ),
          ),
          VerticalSpacing(24),
          const CommonText(
            Strings.openingHoursText,
            fontSize: 18,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
          VerticalSpacing(16),
          const InfoRow(label: "Monday - Friday", value: "09:00 - 20:00"),
          const InfoRow(label: "Saturday", value: "09:00 - 18:00"),
          const InfoRow(label: "Sunday", value: Strings.closedText),
          VerticalSpacing(24),
          const CommonText(
            Strings.addressText,
            fontSize: 18,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
          VerticalSpacing(16),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.greyOne.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child:
                  Icon(Icons.map_outlined, size: 40, color: AppColors.greyTwo),
            ),
          ),
          VerticalSpacing(16),
          CommonButton(
            height: 54,
            onPressed: () {},
            text: Strings.getDirectionsText,
            textFontSize: 16,
            textFontWeight: 600,
          ),
        ],
      ),
    );
  }
}

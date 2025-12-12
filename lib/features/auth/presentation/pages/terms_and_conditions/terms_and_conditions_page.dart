import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String termsAndConditions = """
    <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Terms and Conditions - Lisa Salon Service</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      margin: 20px;
      color: #333;
    }
    h1, h2 {
      color: #444;
    }
    h1 {
      text-align: center;
      margin-bottom: 20px;
    }
    h2 {
      margin-top: 20px;
    }
    p {
      margin: 10px 0;
    }
    ul {
      margin: 10px 0 10px 20px;
    }
  </style>
</head>
<body>
  <h1>Terms and Conditions</h1>
  <p>Welcome to Lisa Salon Service! By accessing or using our mobile app, you agree to comply with and be bound by the following terms and conditions. Please read them carefully.</p>

  <h2>1. Use of Our App</h2>
  <p>You may use our app only for lawful purposes and in accordance with these Terms and Conditions. You agree not to use the app:</p>
  <ul>
    <li>In any way that violates any applicable laws or regulations.</li>
    <li>To exploit, harm, or attempt to exploit or harm minors in any way.</li>
    <li>To transmit any unsolicited or unauthorized advertising, promotional materials, or spam.</li>
    <li>To interfere with or disrupt the functionality of the app or its servers.</li>
  </ul>

  <h2>2. Account Registration</h2>
  <p>When you create an account, you must provide accurate, complete, and current information. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.</p>

  <h2>3. Services</h2>
  <p>Lisa Salon Service offers salon booking and related services through the app. While we strive to provide accurate information about our services, we do not guarantee the availability, quality, or results of any service.</p>

  <h2>4. Payment</h2>
  <p>Payments for services booked through the app are processed securely. You agree to pay all fees and charges in accordance with the prices and terms presented to you. Refunds, cancellations, or rescheduling policies are subject to our service-specific rules.</p>

  <h2>5. Intellectual Property</h2>
  <p>All content, logos, trademarks, and materials on the app are owned by Lisa Salon Service or its licensors. You may not use, copy, modify, or distribute any content without prior written permission.</p>

  <h2>6. Limitation of Liability</h2>
  <p>To the fullest extent permitted by law, Lisa Salon Service is not liable for any indirect, incidental, or consequential damages arising from your use of the app or services.</p>

  <h2>7. Changes to Terms</h2>
  <p>We may update these Terms and Conditions from time to time. Any significant changes will be communicated through the app. Continued use of the app after changes signifies your acceptance of the updated terms.</p>

  <h2>8. Governing Law</h2>
  <p>These Terms and Conditions are governed by and construed in accordance with the laws of the jurisdiction in which Lisa Salon Service operates, without regard to its conflict of law provisions.</p>

  <h2>9. Contact Us</h2>
  <p>If you have any questions or concerns about these Terms and Conditions, please contact us through the app or via our customer support email.</p>
</body>
</html>
    """;
    return CommonScaffoldWidget(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.whiteOne,
                      border: Border.all(
                        color: AppColors.greyOne
                      ),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    padding: EdgeInsets.only(
                      left: 10
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.blackTwo,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                HorizontalSpacing(20),
                CommonText(
                  toBeginningOfSentenceCase(Strings.termsAndConditionsText),
                  color: AppColors.blackTwo,
                  fontSize: 24,
                  fontWeight: 600,
                )
              ],
            ),
            VerticalSpacing(20),
            CommonText(
              Strings.lastUpdateText,
              fontSize: 16,
              fontWeight: 400,
              color: AppColors.greyTwo,
            ),
            VerticalSpacing(10),
            Html(
              data: termsAndConditions,
              style: {
                "body": Style(
                  margin: Margins.zero,
                  fontWeight: FontWeight.w400,
                  lineHeight: LineHeight.number(1.4),
                  fontSize: FontSize(14.0),
                  color: AppColors.blackTwo,
                  fontFamily: Strings.fontFamily,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

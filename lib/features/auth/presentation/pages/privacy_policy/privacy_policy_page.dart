import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    String privacyPolicyHtml = """
    <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Privacy Policy - Lisa Salon Service</title>
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
  </style>
</head>
<body>
  <h1>Privacy Policy</h1>
  <p>At Lisa Salon Service, we prioritize your privacy and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data when you use our mobile app.</p>

  <h2>Information We Collect</h2>
  <p>We may collect personal information such as your name, email address, phone number, and payment details when you create an account or book a service. Additionally, we may gather non-personal data like device information and usage statistics to enhance your experience.</p>

  <h2>How We Use Your Information</h2>
  <p>Your information helps us provide and improve our services, process transactions, communicate with you, and personalize your experience. We may also use your data for marketing purposes, but only with your consent.</p>

  <h2>Data Protection</h2>
  <p>We implement various security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction. We regularly review our practices to ensure your data remains secure.</p>

  <h2>Sharing Your Information</h2>
  <p>We do not sell or rent your personal information to third parties. We may share your data with trusted partners who assist us in operating our app and providing services, under strict confidentiality agreements.</p>

  <h2>Your Rights</h2>
  <p>You have the right to access, correct, or delete your personal information at any time. If you wish to exercise these rights, please contact us through the app.</p>

  <h2>Changes to This Policy</h2>
  <p>We may update this Privacy Policy from time to time. We will notify you of any significant changes through the app or via email. Your continued use of the app after such changes constitutes your acceptance of the new policy.</p>

  <h2>Contact Us</h2>
  <p>If you have any questions or concerns about this Privacy Policy, please reach out to us through the app or at our customer support email.</p>
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
                  toBeginningOfSentenceCase(Strings.privacyPolicyText),
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
              data: privacyPolicyHtml,
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

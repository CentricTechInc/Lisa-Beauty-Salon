import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String aboutUsHtml = """
    <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Lisa</title>
  <style>
    body {
      font-family: Arial, Helvetica, sans-serif;
      color: #333333;
      line-height: 1.6;
      margin: 0;
      padding: 0;
    }
    .content {
      padding: 16px;
    }
    h2 {
      color: #E91E63;
      margin-bottom: 12px;
    }
    p {
      margin-bottom: 14px;
    }
  </style>
</head>
<body>
  <div class="content">
    <h2>Welcome to Lisa</h2>

    <p>
      At <strong>Lisa</strong>, we believe that self-care should be accessible and enjoyable for everyone.
      Our mobile app connects you with top-notch salon services right at your fingertips.
      Whether you're looking for a quick haircut, a relaxing massage, or a complete makeover,
      Lisa is here to help you look and feel your best.
    </p>

    <p>
      With a user-friendly interface and a wide variety of services to choose from,
      booking your next appointment has never been easier.
    </p>

    <p>
      Our mission is to empower individuals to embrace their beauty and wellness journey.
      We partner with skilled professionals who are passionate about their craft,
      ensuring you receive the highest quality service.
    </p>

    <p>
      Join the <strong>Lisa</strong> community today and discover a world of beauty
      tailored just for you!
    </p>
  </div>
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
                  toBeginningOfSentenceCase(Strings.aboutUsText),
                  color: AppColors.blackTwo,
                  fontSize: 24,
                  fontWeight: 600,
                )
              ],
            ),
            VerticalSpacing(40),
            Center(
              child: SvgPicture.asset(
                Assets.logo,
                width: 200,
                height: 80,
              ),
            ),
            VerticalSpacing(40),
            Html(
              data: aboutUsHtml,
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

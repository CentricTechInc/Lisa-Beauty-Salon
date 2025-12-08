import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_back_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/custom_slider_thumb_circle.dart';

class BuildYourProfilePage extends StatefulWidget {
  const BuildYourProfilePage({super.key});

  @override
  State<BuildYourProfilePage> createState() => _BuildYourProfilePageState();
}

class _BuildYourProfilePageState extends State<BuildYourProfilePage> {

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 11;



  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(30),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommonBackButton(
                        iconColor: AppColors.blackTwo,
                      ),
                    ),
                    CommonText(
                      Strings.buildYourProfileText,
                      fontSize: 24,
                      fontWeight: 600,
                      color: AppColors.blackTwo,
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpacing(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20
              ),
              child: IgnorePointer(
                ignoring: true,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.pink,
                    inactiveTrackColor: Colors.grey[300],
                    trackHeight: 3.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: 8
                    ),
                    overlayShape: SliderComponentShape.noOverlay,
                    trackShape: RoundedRectSliderTrackShape(),
                  ),
                  child: Slider(
                    value: (_currentPage + 1) / _totalPages,
                    onChanged: (value) {},
                    min: 0,
                    max: 1,
                  ),
                ),
              ),
            ),
            VerticalSpacing(20),
            SizedBox(
              height: context.height * 0.8,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [],
              ),
            ),
            VerticalSpacing(20),
            VerticalSpacing(20),
          ],
        ),
      ),
    );
  }
}

class _BuildYourProfilePageOne extends StatefulWidget {


  const _BuildYourProfilePageOne({super.key});

  @override
  State<_BuildYourProfilePageOne> createState() => _BuildYourProfilePageOneState();
}

class _BuildYourProfilePageOneState extends State<_BuildYourProfilePageOne> {

  final licenseType = TextEditingController();
  final licenseNumber = TextEditingController();
  final issuanceStateOrCountry = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpacing(20),
        CommonText(
          Strings.verifyYourProfessionalStatusText,
          fontSize: 20,
          fontWeight: 700,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(10),
        CommonText(
          Strings.verifyYourProfessionalStatusDescriptionText,
          fontSize: 16,
          fontWeight: 400,
          color: AppColors.greyTwo,
        ),
        VerticalSpacing(30),
        CommonText(
          Strings.licenseTypeText,
          fontSize: 12,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(5),
        VerticalSpacing(20),
        CommonText(
          Strings.licenseNumberText,
          fontSize: 12,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(5),
        VerticalSpacing(20),
        CommonText(
          Strings.issuanceStateOrCountryNumberText,
          fontSize: 12,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(5),
        VerticalSpacing(20),
        CommonText(
          Strings.uploadLicensePhotoText,
          fontSize: 12,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(5),
        VerticalSpacing(20),
      ],
    );
  }
}


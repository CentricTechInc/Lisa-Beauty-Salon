import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/components/build_your_profile_page_five.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/components/build_your_profile_page_four.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/components/build_your_profile_page_one.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/components/build_your_profile_page_six.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/components/build_your_profile_page_three.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/components/build_your_profile_page_two.dart';

import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/custom_slider_thumb_circle.dart';

class BuildYourProfilePage extends StatefulWidget {
  const BuildYourProfilePage({super.key});

  @override
  State<BuildYourProfilePage> createState() => _BuildYourProfilePageState();
}

class _BuildYourProfilePageState extends State<BuildYourProfilePage> {

  final PageController _pageController = PageController();
  final int _totalPages = 6;

  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  void _handleBackNavigation() {
    final authController = Get.find<AuthController>();
    final currentPage = _currentPageNotifier.value;
    if (currentPage == 0) {
      Get.back();
    } else {
      if (currentPage == 5 && authController.showAddBankAccountsForm.value == true) {
        authController.toggleAddBankAccountsForm();
      }
      else if (currentPage == 3 && authController.showAddServiceForm.value == true) {
        authController.toggleAddServiceForm();
      }
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) {
        if (!didPop) {
          _handleBackNavigation();
        }
      },
      child: CommonScaffoldWidget(
        padding: EdgeInsets.zero,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppColors.whiteTwo,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        resizeToAvoidBottomInset: true,
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
                      child: GestureDetector(
                        onTap: _handleBackNavigation,
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.blackOne,
                        ),
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
                    thumbShape: const CustomSliderThumbCircle(
                      thumbRadius: 8,
                      showLabel: false,
                    ),
                    overlayShape: SliderComponentShape.noOverlay,
                    trackShape: RoundedRectSliderTrackShape(),
                  ),
                  child: ValueListenableBuilder<int>(
                    valueListenable: _currentPageNotifier,
                    builder: (context, currentPage, _) {
                      return Slider(
                        value: (currentPage + 1) / _totalPages,
                        onChanged: (_) {},
                        min: 0,
                        max: 1,
                      );
                    },
                  ),
                ),
              ),
            ),
            VerticalSpacing(20),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  _currentPageNotifier.value = index;
                },
                children: [
                  BuildYourProfilePageOne(
                    pageController: _pageController,
                  ),
                  BuildYourProfilePageTwo(
                    pageController: _pageController,
                  ),
                  BuildYourProfilePageThree(
                    pageController: _pageController,
                  ),
                  BuildYourProfilePageFour(
                    pageController: _pageController,
                  ),
                  BuildYourProfilePageFive(
                    pageController: _pageController,
                  ),
                  BuildYourProfilePageSix(
                    pageController: _pageController,
                  )
                ],
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





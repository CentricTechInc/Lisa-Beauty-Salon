import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  final PageController _pageController = PageController();

  final welcomePages = <Map<String, dynamic>>[
    {
      "imageUrl": Assets.welcomeOne,
      "title": Strings.welcomeOneTitle,
      "subTitle": Strings.welcomeOneSubTitle,
      "buttonText": Strings.welcomeOneButtonText,
    },
    {
      "imageUrl": Assets.welcomeTwo,
      "title": Strings.welcomeTwoTitle,
      "subTitle": Strings.welcomeTwoSubTitle,
      "buttonText": Strings.welcomeTwoButtonText,
    },
    {
      "imageUrl": Assets.welcomeThree,
      "title": Strings.welcomeThreeTitle,
      "subTitle": Strings.welcomeThreeSubTitle,
      "buttonText": Strings.welcomeThreeButtonText,
    },
  ];


  void _nextPage() {
    final int currentPage = _pageController.hasClients &&
      _pageController.page != null ? _pageController.page!.round() : 0;

    if (currentPage < welcomePages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else {
      Get.offNamed(
        RouteNames.createAccount
      );
    }
  }

  Widget _buildDot(int index, int currentPage) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: currentPage == index ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: currentPage == index ? AppColors.whiteOne : AppColors.whiteOne,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      extendBodyBehindAppBar: true,
      bgColor: AppColors.transparent,
      useSafeArea: false,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: welcomePages.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Image.asset(
                      welcomePages[index]['imageUrl'],
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.neutral200,
                        child: const Center(
                          child: CommonText(
                            Strings.imageNotAvailableText,
                            color: AppColors.whiteOne,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.neutral700.withValues(
                              alpha: 0.1
                            ),
                            AppColors.neutral700.withValues(
                              alpha: 0.7
                            ),
                            AppColors.neutral700.withValues(
                              alpha: 0.9
                            ),
                          ],
                          stops: const [0.0, 1.0, 0.4],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                final int currentPage = _pageController.hasClients && _pageController.page != null
                    ? _pageController.page!.round()
                    : 0;

                final currentPageData = welcomePages[currentPage];

                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                    left: 32,
                    right: 32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Column(
                          key: ValueKey<int>(currentPage),
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonText(
                              currentPageData['title'] ?? '',
                              textAlign: TextAlign.center,
                              color: AppColors.whiteOne,
                              textOverflow: TextOverflow.visible,
                              fontSize: 30,
                              fontWeight: 600,
                              shadows: [
                                Shadow(
                                  blurRadius: 4.0,
                                  color: AppColors.neutral100,
                                ),
                              ],
                            ),

                            VerticalSpacing(8),

                            CommonText(
                              currentPageData['subTitle'] ?? '',
                              color: AppColors.whiteOne,
                              textAlign: TextAlign.center,
                              fontSize: 16,
                              textOverflow: TextOverflow.visible,
                              shadows: [
                                Shadow(
                                  blurRadius: 4.0,
                                  color: AppColors.neutral700,
                                ),
                              ]
                            ),
                          ],
                        ),
                      ),

                      VerticalSpacing(32),

                      // Dot Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(welcomePages.length, (index) {
                          return _buildDot(index, currentPage); // Pass the calculated index
                        }),
                      ),

                      VerticalSpacing(32),

                      CommonButton(
                        text: currentPageData['buttonText'] ?? '',
                        width: double.infinity,
                        height: 56,
                        onPressed: _nextPage,
                        backgroundColor: AppColors.pinkOne,
                        radius: 16,
                        elevation: 5,
                        textFontSize: 18,
                        textFontWeight: 600,
                        textColor: AppColors.whiteOne,
                      ),

                      VerticalSpacing(16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CommonText(
                            Strings.firstTimeHereText,
                            color: AppColors.whiteOne,
                            fontSize: 14,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                RouteNames.createAccount
                              );
                            },
                            child: const CommonText(
                              Strings.signUpText,
                              color: AppColors.pinkTwo,
                              fontSize: 14,
                              fontWeight: 600,
                            ),
                          ),
                        ],
                      ),

                      VerticalSpacing(16),

                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

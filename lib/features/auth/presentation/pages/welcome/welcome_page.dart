import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';

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
      "title": "Best Stylist For You",
      "subTitle": "Styling your appearance according to your lifestyle",
      "buttonText": "Next",
    },
    {
      "imageUrl": Assets.welcomeTwo,
      "title": "Meet Our Specialists",
      "subTitle": "There are many best stylists from all the best salons ever",
      "buttonText": "Next",
    },
    {
      "imageUrl": Assets.welcomeThree,
      "title": "Find The Best Service",
      "subTitle": "There are various services from the best salons that have become our partners.",
      "buttonText": "Get Started",
    },
  ];


  void _nextPage() {
    // Determine the current page index without relying on local state
    final int currentPage = _pageController.hasClients && _pageController.page != null
        ? _pageController.page!.round()
        : 0;

    if (currentPage < welcomePages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else {
      // Handle completion of onboarding (e.g., navigate to home screen)
      LoggerService.info("Welcome Pages Completed!");
    }
  }

  Widget _buildDot(int index, int currentPage) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: currentPage == index ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      top: false,
      child: Stack(
        children: <Widget>[
          // --- BACKGROUND SLIDER (PageView) ---
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: welcomePages.length,
              itemBuilder: (context, index) {
                // Background image and overlay logic remains the same
                return Stack(
                  children: [
                    Image.asset(
                      welcomePages[index]['imageUrl'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      // Fallback image in case placeholder link fails
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Text(
                            'Image not available',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                    // Dark Overlay for better text readability
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
                      // Animated Text Content
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Column(
                          // Key is crucial for AnimatedSwitcher to recognize content change
                          key: ValueKey<int>(currentPage),
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              currentPageData['title'] ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4.0,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              currentPageData['subTitle'] ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4.0,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Dot Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(welcomePages.length, (index) {
                          return _buildDot(index, currentPage); // Pass the calculated index
                        }),
                      ),

                      const SizedBox(height: 32),

                      // Action Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFC5672), // Custom pink/red color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            currentPageData['buttonText'] ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Sign Up Link (static)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'First time here? ',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              LoggerService.info('Sign Up tapped');
                              // Navigate to Sign Up screen
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Color(0xFFFC5672), // Custom link color
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> circleAnimation;
  late Animation<double> textOpacityAnimation;
  late Animation<Offset> textSlideAnimation;

  bool _imagesPrecached = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Top pink circle slide animation
    circleAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    // Text fade-in
    textOpacityAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
    );

    // Text slide-up
    textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 10.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 300), () {
          Get.offNamed(RouteNames.welcome);
        });
      }
    });

    controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_imagesPrecached) {
      _precacheImages();
      _imagesPrecached = true;
    }
  }

  Future<void> _precacheImages() async {
    final welcomePages = [
      Assets.welcomeOne,
      Assets.welcomeTwo,
      Assets.welcomeThree
    ];
    for (var page in welcomePages) {
      final image = AssetImage(page);
      precacheImage(image, context);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Assets.splashBackground,
                ),
                fit: BoxFit.cover
              )
            ),
            child: Stack(
              children: [
                // TOP LEFT CIRCULAR HIGHLIGHT
                Positioned(
                  top: -200 * (1.7 - circleAnimation.value),
                  left: -300 * (1.7 - circleAnimation.value),
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.transparent,
                      border: Border.all(
                        color: AppColors.neutral500.withValues(
                          alpha: 0.1
                        ),
                        width: 5
                      )
                    ),
                  ),
                ),

                // TEXT ANIMATION (Lisa)
                Align(
                  alignment: Alignment.center,
                  child: SlideTransition(
                    position: textSlideAnimation,
                    child: FadeTransition(
                      opacity: textOpacityAnimation,
                      child: SvgPicture.asset(
                        Assets.logo,
                        width: 200,
                        height: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

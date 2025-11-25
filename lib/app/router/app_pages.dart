import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/splash/splash_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/welcome/welcome_page.dart';

class AppPages {

  static final routes = [
    // Auth routes
    GetPage(
      name: RouteNames.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RouteNames.signIn,
      page: () => SignInPage(),
    ),
    GetPage(
      name: RouteNames.welcome,
      page: () => WelcomePage(),
    ),
  ];
}
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/create_account/create_account_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/email_verification/email_verification_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/otp_verification/otp_verification_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/reset_password/reset_password_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/sign_up/sign_up_page.dart';
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
      name: RouteNames.welcome,
      page: () => WelcomePage(),
    ),
    GetPage(
      name: RouteNames.signIn,
      page: () => SignInPage(),
    ),
    GetPage(
      name: RouteNames.forgotPassword,
      page: () => ForgotPasswordPage(),
    ),
    GetPage(
      name: RouteNames.otpVerification,
      page: () => OtpVerificationPage(),
    ),
    GetPage(
      name: RouteNames.resetPassword,
      page: () => ResetPasswordPage(),
    ),
    GetPage(
      name: RouteNames.signUp,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: RouteNames.emailVerification,
      page: () => EmailVerificationPage(),
    ),
    GetPage(
      name: RouteNames.createAccount,
      page: () => CreateAccountPage(),
    ),
  ];
}
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/create_account/create_account_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/email_verification/email_verification_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/otp_verification/otp_verification_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/privacy_policy/privacy_policy_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/reset_password/reset_password_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/sign_up/sign_up_customer_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/sign_up/sign_up_salon_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/splash/splash_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/terms_and_conditions/terms_and_conditions_page.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/pages/welcome/welcome_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/shell/customer_shell.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/build_your_profile_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/message/message_detail_page.dart';
import 'package:lisa_beauty_salon/features/salon/shell/salon_shell.dart';

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
      name: RouteNames.signUpCustomer,
      page: () => SignUpCustomerPage(),
    ),
    GetPage(
      name: RouteNames.signUpSalon,
      page: () => SignUpSalonPage(),
    ),
    GetPage(
      name: RouteNames.emailVerification,
      page: () => EmailVerificationPage(),
    ),
    GetPage(
      name: RouteNames.createAccount,
      page: () => CreateAccountPage(),
    ),
    GetPage(
      name: RouteNames.buildYourProfile,
      page: () => BuildYourProfilePage(),
    ),
    GetPage(
      name: RouteNames.privacyPolicy,
      page: () => PrivacyPolicyPage(),
    ),
    GetPage(
      name: RouteNames.termsAndConditions,
      page: () => TermsAndConditionsPage(),
    ),
    GetPage(
      name: RouteNames.mainCustomer,
      page: () => CustomerShell(),
    ),
    GetPage(
      name: RouteNames.mainSalon,
      page: () => SalonShell(),
    ),
    GetPage(
      name: RouteNames.messageDetail,
      page: () => MessageDetailPage(),
    ),
  ];
}
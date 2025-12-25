import 'package:get/get.dart';
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
import 'package:lisa_beauty_salon/features/customer/presentation/pages/salon_detail/sub_services_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/shell/customer_shell.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/appointment/appointment_checkout_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/appointment/book_appointment_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/appointment/review_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/profile_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/profile_edit_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/payment_methods_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/add_payment_method_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/change_password_page.dart' as customer_change_password;
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/notification_page.dart' as customer_notification;
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/support_page.dart' as customer_support;
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/faq_page.dart' as customer_faq;
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/chat_support_page.dart' as customer_chat_support;
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/privacy_policy_page.dart' as customer_privacy_policy;
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/terms_and_conditions_page.dart' as customer_terms_and_conditions;
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/about_us_page.dart' as customer_about_us;
import 'package:lisa_beauty_salon/features/customer/presentation/pages/profile/payment_history_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/map/map_navigation_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/map/map_search_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/salon_detail/salon_detail_page.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/message/message_detail_page.dart' as customer;
import 'package:lisa_beauty_salon/features/salon/presentation/pages/build_your_profile/build_your_profile_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/message/message_detail_page.dart' as salon;
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/about_us_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/change_password_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/notification_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/support_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/faq_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/chat_support_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/payment_history_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/profile_edit_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/promotional_tool_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/bank_account_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/services_page.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/profile/availability_page.dart';
import 'package:lisa_beauty_salon/features/salon/shell/salon_shell.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/shell/customer_shell_binding.dart';
import 'package:lisa_beauty_salon/features/salon/shell/salon_shell_binding.dart';

class AppPages {
  static const String initial = RouteNames.splash;

  static final List<GetPage> routes = [
    GetPage(name: RouteNames.splash, page: () => const SplashPage()),
    GetPage(name: RouteNames.welcome, page: () => const WelcomePage()),
    GetPage(name: RouteNames.signIn, page: () => const SignInPage()),
    GetPage(
      name: RouteNames.forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: RouteNames.otpVerification,
      page: () => const OtpVerificationPage(),
    ),
    GetPage(
      name: RouteNames.resetPassword,
      page: () => const ResetPasswordPage(),
    ),
    GetPage(
      name: RouteNames.signUpCustomer,
      page: () => const SignUpCustomerPage(),
    ),
    GetPage(name: RouteNames.signUpSalon, page: () => const SignUpSalonPage()),
    GetPage(
      name: RouteNames.emailVerification,
      page: () => const EmailVerificationPage(),
    ),
    GetPage(name: RouteNames.privacyPolicy, page: () => PrivacyPolicyPage()),
    GetPage(
      name: RouteNames.termsAndConditions,
      page: () => TermsAndConditionsPage(),
    ),
    GetPage(
      name: RouteNames.createAccount,
      page: () => const CreateAccountPage(),
    ),
    GetPage(
      name: RouteNames.buildYourProfile,
      page: () => const BuildYourProfilePage(),
    ),
    GetPage(
      name: RouteNames.mainCustomer,
      page: () => CustomerShell(),
      binding: CustomerShellBinding(),
    ),
    GetPage(
      name: RouteNames.mainSalon,
      page: () => SalonShell(),
      binding: SalonShellBinding(),
    ),
    GetPage(
      name: RouteNames.profileEdit,
      page: () => const ProfileEditPage(),
    ),
    GetPage(
      name: RouteNames.customerProfile,
      page: () => const CustomerProfilePage(),
    ),
    GetPage(
      name: RouteNames.customerEditProfile,
      page: () => const CustomerEditProfilePage(),
    ),
    GetPage(
      name: RouteNames.customerPaymentMethods,
      page: () => const CustomerPaymentMethodsPage(),
    ),
    GetPage(
      name: RouteNames.customerAddAccount,
      page: () => const CustomerAddPaymentMethodPage(),
    ),
    GetPage(
      name: RouteNames.customerChangePassword,
      page: () => const customer_change_password.CustomerChangePasswordPage(),
    ),
    GetPage(
      name: RouteNames.customerNotification,
      page: () => const customer_notification.CustomerNotificationPage(),
    ),
    GetPage(
      name: RouteNames.salonChangePassword,
      page: () => const ChangePasswordPage()
    ),
    GetPage(
      name: RouteNames.salonNotification,
      page: () => const NotificationPage()
    ),
    GetPage(
      name: RouteNames.salonSupport, 
      page: () => const SupportPage()
    ),
    GetPage(
      name: RouteNames.salonFaq, 
      page: () => const FaqPage()
    ),
    GetPage(
      name: RouteNames.salonChatSupport, 
      page: () => const ChatSupportPage()
    ),
    GetPage(
      name: RouteNames.customerSupport,
      page: () => const customer_support.CustomerSupportPage(),
    ),
    GetPage(
      name: RouteNames.customerFaq,
      page: () => const customer_faq.CustomerFaqPage(),
    ),
    GetPage(
      name: RouteNames.customerChatSupport,
      page: () => const customer_chat_support.CustomerChatSupportPage(),
    ),
    GetPage(
      name: RouteNames.salonAboutUs, 
      page: () => const AboutUsPage()
    ),
    GetPage(
      name: RouteNames.salonPrivacyPolicy,
      page: () => const PrivacyPolicyPage()
    ),
    GetPage(
      name: RouteNames.salonTermsAndConditions,
      page: () => const TermsAndConditionsPage()
    ),
    GetPage(
      name: RouteNames.customerAboutUs,
      page: () => const customer_about_us.CustomerAboutUsPage(),
    ),
    GetPage(
      name: RouteNames.customerPrivacyPolicy,
      page: () => const customer_privacy_policy.CustomerPrivacyPolicyPage(),
    ),
    GetPage(
      name: RouteNames.customerTermsAndConditions,
      page: () => const customer_terms_and_conditions.CustomerTermsAndConditionsPage(),
    ),
    GetPage(
      name: RouteNames.promotionalTool,
      page: () => const PromotionalToolPage(),
    ),
    GetPage(
      name: RouteNames.paymentHistory,
      page: () => const PaymentHistoryPage(),
    ),
    GetPage(
      name: RouteNames.customerPaymentHistory,
      page: () => const CustomerPaymentHistoryPage(),
    ),
    GetPage(
      name: RouteNames.bankAccount,
      page: () => const BankAccountPage(),
    ),
    GetPage(name: RouteNames.services, page: () => const ServicesPage()),
    GetPage(
      name: RouteNames.availability,
      page: () => const AvailabilityPage(),
    ),
    GetPage(
      name: RouteNames.salonDetail,
      page: () => const SalonDetailPage(),
    ),
    GetPage(
      name: RouteNames.subServices,
      page: () => const SubServicesPage(),
    ),
    GetPage(
      name: RouteNames.mapNavigation,
      page: () => MapNavigationPage(selectedIndex: Get.arguments as int? ?? 0),
    ),
    GetPage(
      name: RouteNames.mapSearch,
      page: () => const MapSearchPage(),
    ),
    GetPage(
      name: RouteNames.review,
      page: () => const ReviewPage(),
    ),
    GetPage(
      name: RouteNames.bookAppointment,
      page: () => const BookAppointmentPage(),
    ),
    GetPage(
      name: RouteNames.appointmentCheckout,
      page: () => const AppointmentCheckoutPage(),
    ),
    GetPage(
      name: RouteNames.messageDetail,
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>?;
        final isFromSalon = arguments?['isFromSalon'] ?? false;
        if (isFromSalon) {
          return const salon.MessageDetailPage();
        } else {
          return const customer.MessageDetailPage();
        }
      },
    ),
  ];
}

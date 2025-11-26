import 'dart:developer';


import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/utils/error.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/user_dto.dart';
import 'package:lisa_beauty_salon/features/auth/domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  final Rx<UserDto?> _currentUser = Rx<UserDto?>(null);
  final RxBool isLoading = false.obs;
  final RxBool rememberMe = false.obs;
  final RxString errorMessage = ''.obs;

  UserDto? get currentUser => _currentUser.value;

  @override
  void onInit() {
    // checkAuthStatus();
    super.onInit();
  }

  // Future<void> checkAuthStatus() async {
  //   try {
  //     final user = await _authRepository.getCurrentUser();
  //     _currentUser.value = user;
  //   } catch (e, stackTrace) {
  //     ErrorUtils.logError(e.toString(), stackTrace, feature: 'checkAuthStatus');
  //   }
  // }

  // Future<void> login(String email, String password) async {
  //   try {
  //     isLoading.value = true;
  //     errorMessage.value = '';
  //
  //     final user = await _authRepository.login(
  //       email.trim().toLowerCase(),
  //       password,
  //     );
  //     Get.find<SharedPreferenceService>().currentUser.value = user;
  //
  //     if (rememberMe.value) {
  //       await Get.find<SharedPreferenceService>().saveUserData(user);
  //     }
  //
  //     Get.offAllNamed('/main');
  //   } catch (e, stackTrace) {
  //     ErrorUtils.logError(e.toString(), stackTrace, feature: 'login');
  //     errorMessage.value = ErrorUtils.getFriendlyErrorMessage(e);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<void> register(String name, String email, String password) async {
  //   try {
  //     isLoading.value = true;
  //     errorMessage.value = '';
  //
  //     final user = await _authRepository.register(name, email, password);
  //
  //     Get.find<OtpController>().setEmail(email);
  //     Get.toNamed('/otp-verification');
  //   } catch (e, stackTrace) {
  //     if (e.toString().contains(
  //       "received corrupt message of type InvalidContentType",
  //     )) {
  //       Get.find<OtpController>().setEmail(email);
  //       Get.toNamed('/otp-verification');
  //       return;
  //     }
  //
  //     ErrorUtils.logError(e.toString(), stackTrace, feature: 'register');
  //     log(e.toString());
  //     log(ErrorUtils.getFriendlyErrorMessage(e));
  //     errorMessage.value = ErrorUtils.getFriendlyErrorMessage(e);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<void> logout() async {
  //   try {
  //     await _authRepository.logout();
  //     _currentUser.value = null;
  //     Get.offAllNamed('/onboarding');
  //   } catch (e, stackTrace) {
  //     ErrorUtils.logError(e.toString(), stackTrace, feature: 'logout');
  //     errorMessage.value = ErrorUtils.getFriendlyErrorMessage(e);
  //   }
  // }
}
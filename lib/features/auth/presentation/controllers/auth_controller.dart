

import 'package:country_state_city_dropdown/country_state_city_dropdown.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/user_dto.dart';
import 'package:lisa_beauty_salon/features/auth/domain/use_cases/auth_use_case.dart';

class AuthController extends GetxController {
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  final Rx<UserDto?> _currentUser = Rx<UserDto?>(null);
  final RxBool isLoading = false.obs;
  final RxBool agreeToTermsAndCondition = false.obs;
  final RxBool rememberMe = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedCategory = ''.obs;

  List<Country> countriesList = [];
  RxList<City> citiesList = <City>[].obs;
  final RxInt selectedCityIndex = (-1).obs;
  Country? countryDataOfUs;

  UserDto? get currentUser => _currentUser.value;

  @override
  void onInit() {
    // checkAuthStatus();
    loadCountries();
    super.onInit();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
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

  Future<void> loadCountries() async {
    final result = await _authUseCase.loadCountries();

    result.fold(
      (failure) {
        LoggerService.error(failure.message);
      },
      (data) {
        countriesList = data ?? [];
        countryDataOfUs = countriesList.firstWhereOrNull(
          (country) {
            if (country.name == Strings.unitedStatesStringText) {
              return true;
            }
            return false;
          }
        );
      },
    );
  }

  void setCitiesAccordingToState(String stateName) {
    final state = countryDataOfUs?.states.firstWhereOrNull((s) => s.name == stateName);
    if (state != null) {
      citiesList.assignAll(state.cities);
    } else {
      citiesList.clear();
    }
  }
}


import 'package:country_state_city_dropdown/country_state_city_dropdown.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/user_dto.dart';
import 'package:lisa_beauty_salon/features/auth/domain/use_cases/auth_use_case.dart';

class AuthController extends GetxController {
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  final Rx<UserDto?> _currentUser = Rx<UserDto?>(null);
  final RxBool isLoading = false.obs;
  final RxBool agreeToTermsAndCondition = false.obs;
  final RxBool confirmAndConsentToThisAccount = false.obs;
  final RxBool rememberMe = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedCategory = Strings.salonsText.obs;

  final RxBool showAddServiceForm = false.obs;
  final RxBool showAddBankAccountsForm = false.obs;
  var selectedBankAccountIndex = Rx<int?>(null);

  final RxBool isCustomScheduleEnabled = false.obs;
  final Rx<DayScheduleDto> defaultSchedule = DayScheduleDto(
    workSlots: [
      TimeSlotDto(
        fromTime: "08:30",
        toTime: "05:00",
        fromAMPM: "AM",
        toAMPM: "PM"
      )
    ],
  ).obs;
  final Rx<TimeSlotDto> defaultBreakSchedule = TimeSlotDto(
    fromTime: "08:30",
    toTime: "09:30",
      fromAMPM: "AM",
    toAMPM: "PM"
  ).obs;

  final Rx<BuildProfileDto?> _buildProfileData = Rx<BuildProfileDto?>(null);

  List<Country> countriesList = [];
  RxList<City> citiesList = <City>[].obs;
  final RxInt selectedCityIndex = (-1).obs;
  Country? countryDataOfUs;

  UserDto? get currentUser => _currentUser.value;
  BuildProfileDto? get buildProfileData => _buildProfileData.value;

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
            if (country.name == Strings.southAfricaStringText) {
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

  void toggleAddServiceForm() {
    showAddServiceForm.toggle();
  }

  void toggleAddBankAccountsForm() {
    showAddBankAccountsForm.toggle();
  }

  void toggleCustomSchedule(bool value) {
    isCustomScheduleEnabled.value = value;

    if (!value) {
      final defaultDaySchedule = defaultSchedule.value;

      final data = _buildProfileData.value;
      data?.weeklySchedule = {
        "Monday": defaultDaySchedule,
        "Tuesday": defaultDaySchedule,
        "Wednesday": defaultDaySchedule,
        "Thursday": defaultDaySchedule,
        "Friday": defaultDaySchedule,
        "Saturday": defaultDaySchedule,
        "Sunday": defaultDaySchedule,
      };
      _buildProfileData.refresh();
    }
  }

  // New method to set the Default schedule when in the non-custom mode
  void setDefaultWorkSchedule(List<TimeSlotDto> workSlots, TimeSlotDto breakSlots) {
    defaultSchedule.value = DayScheduleDto(
      workSlots: workSlots,
    );
    // If custom schedule is NOT enabled, apply this new default to all days
    if (!isCustomScheduleEnabled.value) {
      // Logic to update all days in _buildProfileData.value.weeklySchedule as above
    }
  }

  void _ensureDtoInitialized() {
    if (_buildProfileData.value == null) {
      _buildProfileData.value = BuildProfileDto();
    }
  }

  void setBasicProfileData({
    required String firstName,
    required String lastName,
    required String age,
    required String gender,
    required String phoneNumber,
  }) {
    _ensureDtoInitialized();
    final data = _buildProfileData.value;
    data?.firstName = firstName;
    data?.lastName = lastName;
    data?.age = age;
    data?.gender = gender;
    data?.phoneNumber = phoneNumber;
    _buildProfileData.refresh();
  }

  void setBusinessAddressData({
    required String businessName,
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
  }) {
    _ensureDtoInitialized();
    final data = _buildProfileData.value;
    data?.businessName = businessName;
    data?.streetAddress = streetAddress;
    data?.city = city;
    data?.state = state;
    data?.zipCode = zipCode;
    _buildProfileData.refresh();
  }

  void setLicenseData({
    required String licenseType,
    required String licenseNumber,
    required String licenseIssuanceStateOrCountry,
    required String licenseFile,
  }) {
    _ensureDtoInitialized();
    final data = _buildProfileData.value;
    data?.licenseType = licenseType;
    data?.licenseNumber = licenseNumber;
    data?.licenseIssuanceStateOrCountry = licenseIssuanceStateOrCountry;
    data?.licenseFile = licenseFile;
    _buildProfileData.refresh();
  }

  void setProfessionalData({
    required String professionalBio,
    required int yearsOfExperience,
    required String profilePhotoFile,
  }) {
    _ensureDtoInitialized();
    final data = _buildProfileData.value;
    data?.professionalBio = professionalBio;
    data?.yearsOfExperience = yearsOfExperience;
    data?.profilePhotoFile = profilePhotoFile;
    _buildProfileData.refresh();
  }

  void addService(ServiceDto service) {
    _ensureDtoInitialized();
    _buildProfileData.value?.services = List.from(_buildProfileData.value?.services ?? [])..add(service);
    _buildProfileData.refresh();
  }

  void removeService(ServiceDto service) {
    _ensureDtoInitialized();
    _buildProfileData.value?.services.removeWhere((s) =>
    s.serviceName == service.serviceName && s.servicePrice == service.servicePrice);
    _buildProfileData.refresh();
  }

  void setDailySchedule(String dayName, DayScheduleDto schedule) {
    _ensureDtoInitialized();
    _buildProfileData.value?.weeklySchedule = Map.from(_buildProfileData.value?.weeklySchedule ?? {})
      ..[dayName] = schedule;
    _buildProfileData.refresh();
  }

  void addBankAccount(BankAccountInfoDto account) {
    _ensureDtoInitialized();
    _buildProfileData.value?.bankAccounts = List.from(_buildProfileData.value?.bankAccounts ?? [])..add(account);
    _buildProfileData.refresh();
  }

  void updateBankAccount(int index, BankAccountInfoDto account) {
    _ensureDtoInitialized();
    if (index >= 0 && index < (_buildProfileData.value?.bankAccounts ?? []).length) {
      _buildProfileData.value?.bankAccounts[index] = account;
      _buildProfileData.refresh();
    }
  }

  void removeBankAccount(int index) {
    _ensureDtoInitialized();
    if (index >= 0 && index < (_buildProfileData.value?.bankAccounts ?? []).length) {
      _buildProfileData.value?.bankAccounts.removeAt(index);
      _buildProfileData.refresh();
    }
  }

  Future<void> submitOnboardingData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // The DTO already has the toJson method
      final DataMap payload = _buildProfileData.value?.toJson() ?? {};

      // await _authUseCase.buildProfile(payload);

      LoggerService.info('Onboarding Data Submitted Successfully!');

    } catch (e, stackTrace) {
      LoggerService.error('Submission Failed: $e \n stackTrace: $stackTrace');
      errorMessage.value = 'Failed to submit profile. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void selectBankAccount(int index) {
    selectedBankAccountIndex.value = index;
  }
}
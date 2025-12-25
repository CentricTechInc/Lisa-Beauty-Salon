

import 'package:country_state_city_dropdown/country_state_city_dropdown.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/app_constants.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/user_dto.dart';
import 'package:lisa_beauty_salon/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:lisa_beauty_salon/features/promotions/data/dto/promotion_dto.dart';

class AuthController extends GetxController {
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  final Rx<UserDto?> _currentUser = Rx<UserDto?>(null);

  final RxBool isLoading = false.obs;
  final RxBool agreeToTermsAndCondition = false.obs;
  final RxBool confirmAndConsentToThisAccount = false.obs;
  final RxBool rememberMe = false.obs;
  final RxBool showAddServiceForm = false.obs;
  final RxBool showAddPromotionForm = false.obs;
  final RxBool showAddBankAccountsForm = false.obs;
  final RxBool showAvailabilityEditForm = false.obs;
  final RxBool isCustomScheduleEnabled = false.obs;
  final RxBool isCountryLoading = false.obs;

  final RxString selectedCategory = Strings.salonsText.obs;
  final RxString errorMessage = ''.obs;
  RxString selectedCityForSignUp = ''.obs;
  RxString selectedCityForBuildYourProfile = ''.obs;

  var selectedBankAccountIndex = Rx<int?>(null);
  final RxString viewingCategory = "".obs;
  final RxBool showAddBreakTime = false.obs;
  final RxInt selectedCityIndex = (-1).obs;

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
  final Rx<Country?> _countryDataOfUs = Rx<Country?>(null);
  Country? get countryDataOfUs => _countryDataOfUs.value;
  final RxList<String> defaultEnabledDays = <String>[
    Strings.monShortText,
    Strings.tueShortText,
    Strings.wedShortText,
    Strings.thuShortText,
    Strings.friShortText,
  ].obs;
  final RxList<PromotionDto> promotions = <PromotionDto>[].obs;

  UserDto? get currentUser => _currentUser.value;
  BuildProfileDto? get buildProfileData => _buildProfileData.value;

  @override
  void onInit() {
    // Countries will be loaded on demand to prevent navigation delays
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
    isCountryLoading.value = true;

    final result = await _authUseCase.loadCountries();

    result.fold(
      (failure) {
        LoggerService.error(failure.message);
      },
      (data) {
        countriesList = data ?? [];
        _countryDataOfUs.value = countriesList.firstWhereOrNull(
          (country) {
            if (country.name == Strings.southAfricaStringText) {
              return true;
            }
            return false;
          }
        );
      },
    );

    isCountryLoading.value = false;
  }

  void setCitiesAccordingToState(String stateName, String scenario) {
    final state = countryDataOfUs?.states.firstWhereOrNull(
      (s) => s.name == stateName
    );

    if (state != null) {
      citiesList.assignAll(state.cities);
    } else {
      citiesList.clear();
    }

    if (scenario == Strings.signUpDropdownScenario) {
      selectedCityForSignUp.value = '';
    }
    else{
      selectedCityForBuildYourProfile.value = '';
    }

  }

  void toggleAddServiceForm() {
    showAddServiceForm.toggle();
  }
  void toggleAddPromotionForm() {
    showAddPromotionForm.toggle();
  }

  void toggleAddBankAccountsForm() {
    showAddBankAccountsForm.toggle();
  }

  void toggleCustomSchedule(bool value) {
    isCustomScheduleEnabled.value = value;

    if (!value) {
      _applyDefaultScheduleToWeekly();
    }
  }

  void _applyDefaultScheduleToWeekly() {
    final defaultDaySchedule = defaultSchedule.value;
    final Map<String, DayScheduleDto> weeklySchedule = {};

    for (var day in AppConstants.fullWeekDaysNames) {
      final isEnabled = _isDayEnabledInDefault(day);
      weeklySchedule[day] = defaultDaySchedule.copyWith(isEnabled: isEnabled);
    }

    _ensureDtoInitialized();
    _buildProfileData.value?.weeklySchedule = weeklySchedule;
    _buildProfileData.refresh();
  }

  bool _isDayEnabledInDefault(String day) {
    if (day == "Monday") return defaultEnabledDays.contains(Strings.monShortText);
    if (day == "Tuesday") return defaultEnabledDays.contains(Strings.tueShortText);
    if (day == "Wednesday") return defaultEnabledDays.contains(Strings.wedShortText);
    if (day == "Thursday") return defaultEnabledDays.contains(Strings.thuShortText);
    if (day == "Friday") return defaultEnabledDays.contains(Strings.friShortText);
    if (day == "Saturday") return defaultEnabledDays.contains(Strings.satShortText);
    if (day == "Sunday") return defaultEnabledDays.contains(Strings.sunShortText);
    return false;
  }

  void toggleDefaultEnabledDay(String dayShortName) {
    if (defaultEnabledDays.contains(dayShortName)) {
      defaultEnabledDays.remove(dayShortName);
    } else {
      defaultEnabledDays.add(dayShortName);
    }

    if (!isCustomScheduleEnabled.value) {
      _applyDefaultScheduleToWeekly();
    }
  }

  // New method to set the Default schedule when in the non-custom mode
  void setDefaultWorkSchedule(List<TimeSlotDto> workSlots) {
    defaultSchedule.value = DayScheduleDto(
      workSlots: workSlots,
    );
    // If custom schedule is NOT enabled, apply this new default to all days
    if (!isCustomScheduleEnabled.value) {
      _applyDefaultScheduleToWeekly();
    }
  }

  void _ensureDtoInitialized() {
    if (_buildProfileData.value == null) {
      _buildProfileData.value = BuildProfileDto();

      final defaultDaySchedule = defaultSchedule.value;

      _buildProfileData.value = BuildProfileDto(
          weeklySchedule: {
            "Monday": defaultDaySchedule,
            "Tuesday": defaultDaySchedule,
            "Wednesday": defaultDaySchedule,
            "Thursday": defaultDaySchedule,
            "Friday": defaultDaySchedule,
            "Saturday": defaultDaySchedule,
            "Sunday": defaultDaySchedule,
          }
      );
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

  void addPromotion(PromotionDto promotion) {
    promotions.add(promotion);
  }

  void removePromotion(int index) {
    if (index >= 0 && index < promotions.length) {
      promotions.removeAt(index);
    }
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

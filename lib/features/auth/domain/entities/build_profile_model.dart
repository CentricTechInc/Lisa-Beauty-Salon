import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';

class BuildProfileModel {
  BuildProfileModel({
    this.firstName = "",
    this.lastName = "",
    this.age = "",
    this.gender = "",
    this.phoneNumber = "",
    this.businessName = "",
    this.streetAddress = "",
    this.city = "",
    this.state = "",
    this.zipCode = "",
    this.licenseType = "",
    this.licenseNumber = "",
    this.licenseIssuanceStateOrCountry = "",
    this.licenseFile = "",
    this.profilePhotoFile = "",
    this.professionalBio = "",
    this.yearsOfExperience = 0,
    this.services = const [],
    this.weeklySchedule = const {},
    this.bankAccounts = const [],
    this.breakTimeSchedule
  });

  // User/Business/License Info (No Change)
  String firstName;
  String lastName;
  String age;
  String gender;
  String phoneNumber;
  String businessName;
  String streetAddress;
  String city;
  String state;
  String zipCode;
  String licenseType;
  String licenseNumber;
  String licenseIssuanceStateOrCountry;
  String licenseFile;
  String profilePhotoFile;
  String professionalBio;
  int yearsOfExperience;
  List<ServiceDto> services;
  List<BankAccountInfoDto> bankAccounts;

  // Weekly Schedule Info (No Change)
  TimeSlotDto? breakTimeSchedule;
  Map<String, DayScheduleDto> weeklySchedule;

}

class DayScheduleModel {
  DayScheduleModel({
    this.isEnabled = true,
    this.workSlots = const [],
  });

  bool isEnabled;
  List<TimeSlotDto> workSlots;
}

class TimeSlotModel {
  TimeSlotModel({
    required this.fromTime,
    required this.toTime,
    required this.fromAMPM,
    required this.toAMPM,
  });

  final String fromTime;
  final String toTime;
  final String fromAMPM;
  final String toAMPM;
}

class BankAccountInfoModel {
  BankAccountInfoModel({
    this.accountHolderFullName = "",
    this.bankName = "",
    this.accountNumber = "",
    this.areTermsAndConditionsAccepted = false,
  });

  String accountHolderFullName;
  String bankName;
  String accountNumber;
  bool areTermsAndConditionsAccepted;
}

class ServiceModel {
  ServiceModel({
    required this.serviceCategory,
    this.subCategory = "",
    required this.serviceFor,
    required this.serviceName,
    required this.servicePhoto,
    required this.serviceDescription,
    required this.servicePrice,
  });

  final String serviceCategory;
  final String subCategory;
  final String serviceFor;
  final String serviceName;
  final String servicePhoto;
  final String serviceDescription;
  final double servicePrice;
}
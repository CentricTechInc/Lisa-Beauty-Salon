import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/auth/domain/entities/build_profile_model.dart';

class TimeSlotDto extends TimeSlotModel {
  TimeSlotDto({
    required super.fromTime,
    required super.toTime,
    required super.fromAMPM,
    required super.toAMPM,
  });

  factory TimeSlotDto.fromJson(DataMap json) {
    return TimeSlotDto(
      fromTime: json['fromTime'] as String,
      toTime: json['toTime'] as String,
      fromAMPM: json['fromAMPM'] as String,
      toAMPM: json['toAMPM'] as String,
    );
  }

  DataMap toJson() {
    return {
      "fromTime": fromTime,
      "toTime": toTime,
      "fromAMPM": fromAMPM,
      "toAMPM": toAMPM,
    };
  }
}

class DayScheduleDto extends DayScheduleModel {
  DayScheduleDto({
    super.isEnabled = true,
    super.workSlots = const [],
  });

  factory DayScheduleDto.fromJson(DataMap json) {
    return DayScheduleDto(
      isEnabled: json['isEnabled'] as bool,
      // Map JSON list to list of TimeSlotDto
      workSlots: (json['workSlots'] as List<dynamic>)
          .map((slotJson) => TimeSlotDto.fromJson(slotJson as DataMap))
          .toList(),
    );
  }

  DayScheduleDto copyWith({
    bool? isEnabled,
    List<TimeSlotDto>? workSlots,
  }) {
    return DayScheduleDto(
      isEnabled: isEnabled ?? this.isEnabled,
      workSlots: workSlots ?? this.workSlots
    );
  }

  DataMap toJson() {
    return {
      "isEnabled": isEnabled,
      // Convert list of Model/Dto back to list of JSON maps
      "workSlots": workSlots.map((slot) => (slot).toJson()).toList(),
    };
  }
}

// --- Bank Account DTO ---

class BankAccountInfoDto extends BankAccountInfoModel {
  BankAccountInfoDto({
    super.accountHolderFullName = "",
    super.bankName = "",
    super.accountNumber = "",
    super.areTermsAndConditionsAccepted = false,
  });

  factory BankAccountInfoDto.fromJson(DataMap json) {
    return BankAccountInfoDto(
      accountHolderFullName: json['accountHolderFullName'] as String,
      bankName: json['bankName'] as String,
      accountNumber: json['accountNumber'] as String,
      areTermsAndConditionsAccepted: json['areTermsAndConditionsAccepted'] as bool,
    );
  }

  DataMap toJson() {
    return {
      "bankFullName": accountHolderFullName,
      "bankName": bankName,
      "accountNumber": accountNumber,
      "areTermsAndConditionsAccepted": areTermsAndConditionsAccepted,
    };
  }
}

class ServiceDto extends ServiceModel {
  ServiceDto({
    required super.serviceCategory,
    required super.serviceFor,
    required super.serviceName,
    required super.servicePhoto,
    required super.serviceDescription,
    required super.servicePrice,
  });

  factory ServiceDto.fromJson(DataMap json) {
    return ServiceDto(
      serviceCategory: json['serviceCategory'] as String,
      serviceFor: json['serviceFor'] as String,
      serviceName: json['serviceName'] as String,
      servicePhoto: json['servicePhoto'] as String,
      serviceDescription: json['serviceDescription'] as String,
      servicePrice: (json['servicePrice'] as num).toDouble(),
    );
  }

  DataMap toJson() {
    return {
      "serviceCategory": serviceCategory,
      "serviceFor": serviceFor,
      "serviceName": serviceName,
      "servicePhoto": servicePhoto,
      "serviceDescription": serviceDescription,
      "servicePrice": servicePrice
    };
  }
}

class BuildProfileDto extends BuildProfileModel {
  BuildProfileDto({
    super.firstName = "",
    super.lastName = "",
    super.age = "",
    super.gender = "",
    super.phoneNumber = "",
    super.businessName = "",
    super.streetAddress = "",
    super.city = "",
    super.state = "",
    super.zipCode = "",
    super.licenseType = "",
    super.licenseNumber = "",
    super.licenseIssuanceStateOrCountry = "",
    super.licenseFile = "",
    super.profilePhotoFile = "",
    super.professionalBio = "",
    super.yearsOfExperience = 0,
    super.services = const [],
    super.weeklySchedule = const {},
    super.bankAccounts = const [],
    super.breakTimeSchedule
  });


  factory BuildProfileDto.fromJson(DataMap json) {
    final Map<String, DayScheduleDto> scheduleMap = {};
    if (json['weeklySchedule'] != null) {
      (json['weeklySchedule'] as DataMap).forEach((day, scheduleJson) {
        scheduleMap[day] = DayScheduleDto.fromJson(scheduleJson as DataMap);
      });
    }

    return BuildProfileDto(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      age: json['age'] as String,
      gender: json['gender'] as String,
      phoneNumber: json['phoneNumber'] as String,
      businessName: json['businessName'] as String,
      streetAddress: json['streetAddress'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      licenseType: json['licenseType'] as String,
      licenseNumber: json['licenseNumber'] as String,
      licenseIssuanceStateOrCountry: json['licenseIssuanceStateOrCountry'] as String,
      licenseFile: json['licenseFile'] as String,
      profilePhotoFile: json['profilePhotoFile'] as String,
      professionalBio: json['professionalBio'] as String,
      yearsOfExperience: json['yearsOfExperience'] as int,

      services: (json['services'] as List<dynamic>)
          .map((serviceJson) => ServiceDto.fromJson(serviceJson as DataMap))
          .toList(),
      bankAccounts: (json['bankAccounts'] as List<dynamic>)
          .map((bankJson) => BankAccountInfoDto.fromJson(bankJson as DataMap))
          .toList(),

      weeklySchedule: scheduleMap,
      breakTimeSchedule: json['breakTimeSchedul']
    );
  }

  DataMap toJson() {
    final Map<String, DataMap> scheduleJsonMap = {};
    weeklySchedule.forEach((day, scheduleModel) {
      scheduleJsonMap[day] = (scheduleModel).toJson();
    });

    return {
      "firstName": firstName,
      "lastName": lastName,
      "age": age,
      "gender": gender,
      "phoneNumber": phoneNumber,
      "businessName": businessName,
      "streetAddress": streetAddress,
      "city": city,
      "state": state,
      "zipCode": zipCode,
      "licenseType": licenseType,
      "licenseNumber": licenseNumber,
      "licenseIssuanceStateOrCountry": licenseIssuanceStateOrCountry,
      "licenseFile": licenseFile,
      "profilePhotoFile": profilePhotoFile,
      "professionalBio": professionalBio,
      "yearsOfExperience": yearsOfExperience,

      "services": services.map((service) => (service).toJson()).toList(),
      "bankAccounts": bankAccounts.map((account) => (account).toJson()).toList(),

      "weeklySchedule": scheduleJsonMap,
    };
  }
}
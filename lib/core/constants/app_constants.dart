import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';

class AppConstants {

  static const String appName = 'Liza Beauty Service';
  static const String appVersion = '1.0.0';

  static const EdgeInsets kScreenPadding = EdgeInsets.all(16);

  static const TextStyle labelDropDownStyle = TextStyle(
    color: AppColors.greyOne,
    fontFamily: Strings.fontFamily,
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle hintDropDownStyle = TextStyle(
    color: AppColors.greyOne,
    fontFamily: Strings.fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static final InputBorder dropdownBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.greyOne,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(15)
  );

  static final InputBorder errorDropDownBorder =  OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColors.redOne,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(15)
  );

  static const List<String> weekDays = [
    Strings.monText,
    Strings.tueText,
    Strings.wedText,
    Strings.thurText,
    Strings.friText,
    Strings.satText,
    Strings.sunText
  ];

  static const List<String> fullWeekDaysNames = [
    Strings.mondayText,
    Strings.tuesdayText,
    Strings.wednesdayText,
    Strings.thursdayText,
    Strings.fridayText,
    Strings.saturdayText,
    Strings.sundayText,
  ];

  static const Map<int, String> numberToFullName = {
    1: Strings.mondayText,
    2: Strings.tuesdayText,
    3: Strings.wednesdayText,
    4: Strings.thursdayText,
    5: Strings.fridayText,
    6: Strings.saturdayText,
    7: Strings.sundayText,
  };

  static const Map<String, int> fullNameToNumber = {
    Strings.mondayText: 1,
    Strings.tuesdayText: 2,
    Strings.wednesdayText: 3,
    Strings.thursdayText: 4,
    Strings.fridayText: 5,
    Strings.saturdayText: 6,
    Strings.sundayText: 7,
  };
}
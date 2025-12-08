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

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';

class CommonSwitchComponentReactive extends StatelessWidget {
  final RxBool value;
  final ValueChanged<bool> onChanged;
  final Color activeThumbColor;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;

  const CommonSwitchComponentReactive({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeThumbColor = AppColors.whiteOne,
    this.activeTrackColor = AppColors.greenOne,
    this.inactiveThumbColor = AppColors.whiteOne,
    this.inactiveTrackColor = AppColors.greyFour,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchTheme(
      data: SwitchThemeData(
        trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => AppColors.transparent,
        ),
      ),
      child: Obx(
        () => Switch(
          value: value.value,
          onChanged: onChanged,
          activeThumbColor: activeThumbColor,
          activeTrackColor: activeTrackColor,
          inactiveThumbColor: inactiveThumbColor,
          inactiveTrackColor: inactiveTrackColor,
        ),
      ),
    );
  }
}

class CommonSwitchComponentNonReactive extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeThumbColor;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;

  const CommonSwitchComponentNonReactive({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeThumbColor = AppColors.whiteOne,
    this.activeTrackColor = AppColors.greenOne,
    this.inactiveThumbColor = AppColors.whiteOne,
    this.inactiveTrackColor = AppColors.greyFour,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchTheme(
      data: SwitchThemeData(
        trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => AppColors.transparent,
        ),
      ),
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: activeThumbColor,
        activeTrackColor: activeTrackColor,
        inactiveThumbColor: inactiveThumbColor,
        inactiveTrackColor: inactiveTrackColor,
      ),
    );
  }
}
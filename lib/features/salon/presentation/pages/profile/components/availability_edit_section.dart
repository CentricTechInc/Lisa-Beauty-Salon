
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_switch_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/core/services/loading_service.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'circular_day_selector.dart';
import 'time_selector_block.dart';

class AvailabilityEditSection extends StatelessWidget {
  final VoidCallback onSaved;

  AvailabilityEditSection({
    required this.onSaved,
    super.key,
  });

  final authController = Get.find<AuthController>();

  // Simple Mode Notifiers
  final fromTimeController = TextEditingController(text: "08:30");
  final toTimeController = TextEditingController(text: "09:30");
  final fromPeriodNotifier = ValueNotifier<String>(Strings.amText);
  final toPeriodNotifier = ValueNotifier<String>(Strings.pmText);
  final selectedDaysNotifier = ValueNotifier<List<String>>([
    Strings.monShortText,
    Strings.tueShortText,
    Strings.wedShortText,
    Strings.thuShortText,
    Strings.friShortText,
  ]);

  // Break Time Notifiers
  final breakFromController = TextEditingController(text: "12:30");
  final breakToController = TextEditingController(text: "01:30");
  final breakFromPeriodNotifier = ValueNotifier<String>(Strings.pmText);
  final breakToPeriodNotifier = ValueNotifier<String>(Strings.pmText);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpacing(20),
                    Center(
                      child: CommonText(
                        authController.isCustomScheduleEnabled.value
                            ? Strings.availabilityByWeeklyText
                            : Strings.customizeTextSimple,
                        fontSize: 14,
                        fontWeight: 400,
                        color: AppColors.greyTwo,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        textOverflow: TextOverflow.visible,
                      ),
                    ),
                    const VerticalSpacing(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CommonText(
                          "Customize",
                          fontSize: 14,
                          fontWeight: 500,
                          color: AppColors.blackTwo,
                        ),
                        const HorizontalSpacing(8),
                        CommonSwitchComponentReactive(
                          value: authController.isCustomScheduleEnabled,
                          onChanged: (val) => authController.isCustomScheduleEnabled.value = val,
                        ),
                      ],
                    ),
                    const VerticalSpacing(20),
                    if (authController.isCustomScheduleEnabled.value)
                      _buildCustomizeMode()
                    else
                      _buildSimpleMode(),
                    const VerticalSpacing(30),
                    _buildBreakTimeSection(),
                    const VerticalSpacing(30),
                  ],
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CommonButton(
            onPressed: () async {
              final loadingService = Get.find<LoadingService>();
              loadingService.show();
              
              // Simulate network delay
              await Future.delayed(const Duration(seconds: 2));
              
              loadingService.hide();
              
              // Small delay to ensure dialog is completely closed before navigating
              await Future.delayed(const Duration(milliseconds: 100));
              
              onSaved();
              MessageUtils.showSuccessSnackBar(
                "Availability updated successfully",
              );
            },
            text: Strings.setAvailabilityText,
            radius: 12,
            textFontWeight: 600,
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleMode() {
    return Column(
      children: [
        ValueListenableBuilder<List<String>>(
          valueListenable: selectedDaysNotifier,
          builder: (context, selectedDays, child) {
            return CircularDaySelector(
              selectedDays: selectedDays,
              onDayToggle: (day) {
                final newList = List<String>.from(selectedDays);
                if (newList.contains(day)) {
                  newList.remove(day);
                } else {
                  newList.add(day);
                }
                selectedDaysNotifier.value = newList;
              },
            );
          },
        ),
        const VerticalSpacing(30),
        ValueListenableBuilder<String>(
          valueListenable: fromPeriodNotifier,
          builder: (context, fromPeriod, child) {
            return TimeSelectorBlock(
              label: Strings.fromText,
              timeController: fromTimeController,
              selectedPeriod: fromPeriod,
              onPeriodChanged: (p) => fromPeriodNotifier.value = p,
            );
          },
        ),
        const VerticalSpacing(20),
        ValueListenableBuilder<String>(
          valueListenable: toPeriodNotifier,
          builder: (context, toPeriod, child) {
            return TimeSelectorBlock(
              label: Strings.toText,
              timeController: toTimeController,
              selectedPeriod: toPeriod,
              onPeriodChanged: (p) => toPeriodNotifier.value = p,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCustomizeMode() {
    final days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    return Column(
      children: days.map((day) => _DayScheduleCustomizeItem(day: day)).toList(),
    );
  }

  Widget _buildBreakTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonText(
          "${Strings.addBreakTimeText} (Optional)",
          fontSize: 18,
          fontWeight: 700,
          color: AppColors.blackTwo,
        ),
        const VerticalSpacing(20),
        ValueListenableBuilder<String>(
          valueListenable: breakFromPeriodNotifier,
          builder: (context, breakFromPeriod, child) {
            return TimeSelectorBlock(
              label: Strings.fromText,
              timeController: breakFromController,
              selectedPeriod: breakFromPeriod,
              onPeriodChanged: (p) => breakFromPeriodNotifier.value = p,
            );
          },
        ),
        const VerticalSpacing(20),
        ValueListenableBuilder<String>(
          valueListenable: breakToPeriodNotifier,
          builder: (context, breakToPeriod, child) {
            return TimeSelectorBlock(
              label: Strings.toText,
              timeController: breakToController,
              selectedPeriod: breakToPeriod,
              onPeriodChanged: (p) => breakToPeriodNotifier.value = p,
            );
          },
        ),
      ],
    );
  }
}

class _DayScheduleCustomizeItem extends StatelessWidget {
  final String day;

  _DayScheduleCustomizeItem({required this.day});

  final isEnabled = false.obs;
  final fromTimeController = TextEditingController(text: "08:30");
  final toTimeController = TextEditingController(text: "09:30");
  final fromPeriodNotifier = ValueNotifier<String>(Strings.amText);
  final toPeriodNotifier = ValueNotifier<String>(Strings.pmText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          border: Border.all(color: AppColors.greyOne),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  day,
                  fontSize: 16,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                ),
                CommonSwitchComponentReactive(
                  value: isEnabled,
                  onChanged: (val) => isEnabled.value = val,
                ),
              ],
            ),
            Obx(() {
              if (!isEnabled.value) return const SizedBox.shrink();
              return Column(
                children: [
                  const VerticalSpacing(20),
                  ValueListenableBuilder<String>(
                    valueListenable: fromPeriodNotifier,
                    builder: (context, fromPeriod, child) {
                      return TimeSelectorBlock(
                        label: Strings.fromText,
                        timeController: fromTimeController,
                        selectedPeriod: fromPeriod,
                        onPeriodChanged: (p) => fromPeriodNotifier.value = p,
                      );
                    },
                  ),
                  const VerticalSpacing(20),
                  ValueListenableBuilder<String>(
                    valueListenable: toPeriodNotifier,
                    builder: (context, toPeriod, child) {
                      return TimeSelectorBlock(
                        label: Strings.toText,
                        timeController: toTimeController,
                        selectedPeriod: toPeriod,
                        onPeriodChanged: (p) => toPeriodNotifier.value = p,
                      );
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

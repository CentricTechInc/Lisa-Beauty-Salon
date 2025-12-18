
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_switch_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'circular_day_selector.dart';
import 'time_selector_block.dart';

class AvailabilityEditSection extends StatefulWidget {
  final VoidCallback onSaved;

  const AvailabilityEditSection({
    required this.onSaved,
    super.key,
  });

  @override
  State<AvailabilityEditSection> createState() => _AvailabilityEditSectionState();
}

class _AvailabilityEditSectionState extends State<AvailabilityEditSection> {
  final authController = Get.find<AuthController>();

  // Simple Mode Controllers
  final fromTimeController = TextEditingController(text: "08:30");
  final toTimeController = TextEditingController(text: "09:30");
  String fromPeriod = Strings.amText;
  String toPeriod = Strings.pmText;
  List<String> selectedDays = [
    Strings.monShortText,
    Strings.tueShortText,
    Strings.wedShortText,
    Strings.thuShortText,
    Strings.friShortText,
  ];

  // Break Time Controllers
  final breakFromController = TextEditingController(text: "12:30");
  final breakToController = TextEditingController(text: "01:30");
  String breakFromPeriod = Strings.pmText;
  String breakToPeriod = Strings.pmText;

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
            onPressed: widget.onSaved,
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
        CircularDaySelector(
          selectedDays: selectedDays,
          onDayToggle: (day) {
            setState(() {
              if (selectedDays.contains(day)) {
                selectedDays.remove(day);
              } else {
                selectedDays.add(day);
              }
            });
          },
        ),
        const VerticalSpacing(30),
        TimeSelectorBlock(
          label: Strings.fromText,
          timeController: fromTimeController,
          selectedPeriod: fromPeriod,
          onPeriodChanged: (p) => setState(() => fromPeriod = p),
        ),
        const VerticalSpacing(20),
        TimeSelectorBlock(
          label: Strings.toText,
          timeController: toTimeController,
          selectedPeriod: toPeriod,
          onPeriodChanged: (p) => setState(() => toPeriod = p),
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
        CommonText(
          "${Strings.addBreakTimeText} (Optional)",
          fontSize: 18,
          fontWeight: 700,
          color: AppColors.blackTwo,
        ),
        const VerticalSpacing(20),
        TimeSelectorBlock(
          label: Strings.fromText,
          timeController: breakFromController,
          selectedPeriod: breakFromPeriod,
          onPeriodChanged: (p) => setState(() => breakFromPeriod = p),
        ),
        const VerticalSpacing(20),
        TimeSelectorBlock(
          label: Strings.toText,
          timeController: breakToController,
          selectedPeriod: breakToPeriod,
          onPeriodChanged: (p) => setState(() => breakToPeriod = p),
        ),
      ],
    );
  }
}

class _DayScheduleCustomizeItem extends StatefulWidget {
  final String day;

  const _DayScheduleCustomizeItem({required this.day});

  @override
  State<_DayScheduleCustomizeItem> createState() => _DayScheduleCustomizeItemState();
}

class _DayScheduleCustomizeItemState extends State<_DayScheduleCustomizeItem> {
  final isEnabled = false.obs;
  final fromTimeController = TextEditingController(text: "08:30");
  final toTimeController = TextEditingController(text: "09:30");
  String fromPeriod = Strings.amText;
  String toPeriod = Strings.pmText;

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
                  widget.day,
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
                  TimeSelectorBlock(
                    label: Strings.fromText,
                    timeController: fromTimeController,
                    selectedPeriod: fromPeriod,
                    onPeriodChanged: (p) => setState(() => fromPeriod = p),
                  ),
                  const VerticalSpacing(20),
                  TimeSelectorBlock(
                    label: Strings.toText,
                    timeController: toTimeController,
                    selectedPeriod: toPeriod,
                    onPeriodChanged: (p) => setState(() => toPeriod = p),
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

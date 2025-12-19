

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/constants/app_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/build_profile_dto.dart';
import 'package:lisa_beauty_salon/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_switch_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class BuildYourProfilePageFive extends StatelessWidget {
  final PageController pageController;

  const BuildYourProfilePageFive({
    required this.pageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CommonText(
              Strings.yourDefaultWeeklyScheduleText,
              fontSize: 20,
              fontWeight: 700,
              color: AppColors.blackTwo,
              maxLines: 2,
              textOverflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
            VerticalSpacing(20),
            CommonText(
              Strings.yourDefaultWeeklyScheduleDescriptionText,
              fontSize: 16,
              fontWeight: 400,
              color: AppColors.greyTwo,
              maxLines: 3,
              textOverflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
            VerticalSpacing(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonText(
                  Strings.customizeText,
                  fontSize: 14,
                  fontWeight: 500,
                  color: AppColors.blackTwo,
                ),
                HorizontalSpacing(8),
                CommonSwitchComponentReactive(
                  value: authController.isCustomScheduleEnabled,
                  onChanged: authController.toggleCustomSchedule,
                )
              ],
            ),
            VerticalSpacing(20),
            Obx(() {
              return authController.isCustomScheduleEnabled.value
                  ? CustomScheduleUI(controller: authController)
                  : DefaultScheduleUI(controller: authController);
            }),
            VerticalSpacing(30),
            CommonButton(
              onPressed: () {
                pageController.animateToPage(
                  5,
                  duration: Duration(milliseconds: 50),
                  curve: Curves.easeInOut
                );
              },
              text: Strings.almostDoneText,
              textFontSize: 18,
              textFontWeight: 600,
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultScheduleUI extends StatelessWidget {
  final AuthController controller;

  const DefaultScheduleUI({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final defaultSchedule = controller.defaultSchedule.value;
    final defaultBreakSchedule = controller.defaultBreakSchedule.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TimeSlotEditor(
          fromTitle: Strings.fromText,
          toTitle: Strings.toText,
          timeSlot: defaultSchedule.workSlots.isNotEmpty ?
          defaultSchedule.workSlots.first : null,
          onTimeSelected: (_) {

          },
        ),
        VerticalSpacing(20),
        Row(
          children: [
            CommonText(
              Strings.addBreakTimeText,
              fontSize: 20,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            CommonText(
              " (${Strings.optionalText})",
              fontSize: 16,
              fontWeight: 400,
              color: AppColors.blackTwo,
            )
          ],
        ),
        VerticalSpacing(20),
        TimeSlotEditor(
          fromTitle: Strings.fromText,
          toTitle: Strings.toText,
          timeSlot: defaultBreakSchedule,
          onTimeSelected: (_) {},
        ),
      ],
    );
  }
}

class CustomScheduleUI extends StatelessWidget {
  final AuthController controller;

  const CustomScheduleUI({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBreakSchedule = controller.defaultBreakSchedule;
    return Column(
      children: [
        ...AppConstants.fullWeekDaysNames.map((day) {
          final DayScheduleDto daySchedule = controller
              .buildProfileData?.weeklySchedule[day] ?? DayScheduleDto();

          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: DayScheduleRow(
              day: day,
              schedule: daySchedule,
              controller: controller,
            ),
          );
        }),
        VerticalSpacing(10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteOne,
            border: Border.all(
                color: AppColors.greyOne,
              ),
              borderRadius: BorderRadius.circular(16)
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  CommonText(
                    Strings.addBreakTimeText,
                    fontSize: 20,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  CommonText(
                    " (${Strings.optionalText})",
                    fontSize: 16,
                    fontWeight: 400,
                    color: AppColors.blackTwo,
                  )
                ],
              ),
              VerticalSpacing(20),
              TimeSlotEditor(
                fromTitle: Strings.fromText,
                toTitle: Strings.toText,
                timeSlot: defaultBreakSchedule.value,
                onTimeSelected: (_) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DayScheduleRow extends StatelessWidget {
  final String day;
  final DayScheduleDto schedule;
  final AuthController controller;

  const DayScheduleRow({
    super.key,
    required this.day,
    required this.schedule,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Obx(() {
          final schedule = controller.buildProfileData!.weeklySchedule[day];
          final bool isEnabled = schedule?.isEnabled ?? false;

          return Container(
            decoration: BoxDecoration(
              color: AppColors.whiteOne,
              border: Border.all(color: AppColors.greyOne),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      day,
                      fontSize: 16,
                      fontWeight: 700,
                      color: AppColors.blackTwo,
                    ),
                    CommonSwitchComponentNonReactive(
                      value: isEnabled,
                      onChanged: (enabled) {
                        final updatedSchedule = schedule?.copyWith(isEnabled: enabled);
                        if (updatedSchedule != null) {
                          controller.setDailySchedule(day, updatedSchedule);
                        }
                      },
                    )
                  ],
                ),

                // Collapse content if disabled
                if (isEnabled)
                  TimeSlotEditor(
                    fromTitle: "From",
                    toTitle: "To",
                    timeSlot: (schedule?.workSlots ?? []).isNotEmpty
                        ? (schedule?.workSlots ?? []).first
                        : null,
                    onTimeSelected: (time) {},
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class TimeSlotEditor extends StatelessWidget {
  final String? fromTitle;
  final String? toTitle;
  final TimeSlotDto? timeSlot;
  final Function(TimeSlotDto) onTimeSelected;

  const TimeSlotEditor({
    super.key,
    required this.onTimeSelected,
    this.fromTitle,
    this.toTitle,
    this.timeSlot,
  });

  @override
  Widget build(BuildContext context) {
    final fromController = TextEditingController(
        text: timeSlot?.fromTime ?? ""
    );
    final toController = TextEditingController(
        text: timeSlot?.toTime ?? ""
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          fromTitle ?? '',
          fontSize: 14,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(10),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 50,
                child: CommonTextField(
                  controller: fromController,
                  fillColor: AppColors.greyFour,
                  borderRadius: 12,
                  textColor: AppColors.blackTwo,
                  labelText: null,
                  hintText: Strings.fromPlaceholderText,
                  cursorColor: AppColors.blackTwo,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            HorizontalSpacing(12),
            Expanded(
              flex: 4,
              child: AmPmToggleButtons(
                onPeriodSelected: (period) {},
              ),
            )
          ],
        ),
        VerticalSpacing(20),
        CommonText(
          toTitle ?? '',
          fontSize: 14,
          fontWeight: 400,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(10),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 50,
                child: CommonTextField(
                  controller: toController,
                  fillColor: AppColors.greyFour,
                  borderRadius: 12,
                  textColor: AppColors.blackTwo,
                  labelText: null,
                  hintText: Strings.toPlaceholderText,
                  cursorColor: AppColors.blackTwo,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            HorizontalSpacing(12),
            Expanded(
              flex: 4,
              child: AmPmToggleButtons(
                onPeriodSelected: (period) {},
              ),
            )
          ],
        ),
        VerticalSpacing(20),
      ],
    );
  }
}

class AmPmToggleButtons extends StatelessWidget {
  final String? initialPeriod;
  final Function(String selectedPeriod) onPeriodSelected;

  final ValueNotifier<int> _selectedIndexNotifier;

  AmPmToggleButtons({
    super.key,
    this.initialPeriod,
    required this.onPeriodSelected,
  }) : _selectedIndexNotifier = ValueNotifier<int>(initialPeriod == "PM" ? 1 : 0) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPeriodSelected(_selectedIndexNotifier.value == 0 ? Strings.amText : Strings.pmText);
    });
  }

  @override
  Widget build(BuildContext context) {
    const activeColor = AppColors.pinkTwo;
    const inactiveColor = AppColors.greyFour;

    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return Row(
          children: [
            Expanded(
              child: _buildToggleButton(
                  context: context,
                  index: 0,
                  label: Strings.amText,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  selectedIndex: selectedIndex
              ),
            ),
            Expanded(
              child: _buildToggleButton(
                  context: context,
                  index: 1,
                  label: Strings.pmText,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  selectedIndex: selectedIndex
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildToggleButton({
    required BuildContext context,
    required int index,
    required String label,
    required Color activeColor,
    required Color inactiveColor,
    required int selectedIndex,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        _selectedIndexNotifier.value = index;
        onPeriodSelected(label);
      },
      child: Container(
        // width: 90,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : inactiveColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
                index == 1 ? 12 : 0
            ),
            topLeft: Radius.circular(
                index == 0 ? 12 : 0
            ),
            bottomLeft: Radius.circular(
                index == 0 ? 12 : 0
            ),
            bottomRight: Radius.circular(
                index == 1 ? 12 : 0
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 10
        ),
        child: CommonText(
          label,
          fontSize: 16,
          fontWeight: 600,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
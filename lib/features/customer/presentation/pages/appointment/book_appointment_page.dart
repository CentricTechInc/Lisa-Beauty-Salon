import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_sliding_button.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({super.key});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  final ValueNotifier<String> _selectedMonth = ValueNotifier("Nov");
  final ValueNotifier<int> _selectedDateIndex = ValueNotifier(3); // Default to Wed 12
  final ValueNotifier<String> _selectedSlot = ValueNotifier("Morning");
  final ValueNotifier<int> _selectedTimeIndex = ValueNotifier(1); // Default to 09:30 AM - 10:30 AM
  final TextEditingController _notesController = TextEditingController();
  final ValueNotifier<bool> _isBackSelected = ValueNotifier(false);

  final List<String> _months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];

  final List<Map<String, String>> _dates = [
    {"day": "Su", "date": "09"},
    {"day": "Mo", "date": "10"},
    {"day": "Tu", "date": "11"},
    {"day": "We", "date": "12"},
    {"day": "Th", "date": "13"},
    {"day": "Fr", "date": "14"},
    {"day": "Sa", "date": "15"},
  ];

  final List<String> _slots = ["Morning", "Afternoon", "Evening"];

  final List<String> _times = [
    "08:30 AM - 09:30 AM",
    "09:30 AM - 10:30 AM",
    "10:30 AM - 11:30 AM",
    "11:30 AM - 12:30 PM",
  ];

  @override
  void dispose() {
    _selectedMonth.dispose();
    _selectedDateIndex.dispose();
    _selectedSlot.dispose();
    _selectedTimeIndex.dispose();
    _notesController.dispose();
    _isBackSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      useSafeArea: true,
      child: Column(
        children: [
          const VerticalSpacing(10),
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 45,
                  height: 45,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: AppColors.whiteOne,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: AppColors.greyOne
                      )
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.chevron_back,
                      color: AppColors.blackTwo,
                    ),
                  ),
                ),
              ),
              const HorizontalSpacing(15),
              const CommonText(
                "Book Appointment",
                fontSize: 24,
                fontWeight: 600,
                color: AppColors.blackTwo,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText(
                        "Select Date",
                        fontSize: 16,
                        fontWeight: 700,
                        color: AppColors.blackTwo,
                      ),
                      SizedBox(
                        width: 100,
                        child: ValueListenableBuilder<String>(
                          valueListenable: _selectedMonth,
                          builder: (context, selectedMonth, child) {
                            return CommonDropdownField<String>(
                              value: selectedMonth,
                              items: _months.map((month) {
                                return DropdownMenuItem(
                                  value: month,
                                  child: CommonText(
                                    month,
                                    fontSize: 14,
                                    fontWeight: 500,
                                    color: AppColors.blackTwo,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  _selectedMonth.value = value;
                                }
                              },
                              selectedItemBuilder: (context) {
                                return _months.map((month) {
                                  return CommonText(
                                    month,
                                    fontSize: 16,
                                    fontWeight: 500,
                                    color: AppColors.greyTwo,
                                  );
                                }).toList();
                              },
                              borderRadius: 12,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8
                              ),
                              borderColor: Colors.transparent,
                              fillColor: Colors.transparent,
                              isBorderEnabled: false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacing(8),
                  _buildDateSelector(),
                  const VerticalSpacing(32),
                  const CommonText(
                    "Slot",
                    fontSize: 16,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(16),
                  _buildSlotSelector(),
                  const VerticalSpacing(32),
                  const CommonText(
                    "Time",
                    fontSize: 16,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(16),
                  _buildTimeGrid(),
                  const VerticalSpacing(32),
                  const CommonText(
                    "Notes (If any)",
                    fontSize: 18,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(16),
                  _buildNotesField(),
                  const VerticalSpacing(32),
                ],
              ),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedDateIndex,
      builder: (context, selectedIndex, child) {
        return SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _dates.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(8),
            itemBuilder: (context, index) {
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () => _selectedDateIndex.value = index,
                child: Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.whiteOne : AppColors.whiteOne,
                    border: Border.all(
                      color: isSelected ? AppColors.pinkTwo : AppColors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        _dates[index]["day"] ?? '',
                        fontSize: 16,
                        fontWeight: 500,
                        color: isSelected ? AppColors.blackTwo : AppColors.greyTwo,
                      ),
                      const VerticalSpacing(8),
                      CommonText(
                        _dates[index]["date"] ?? '',
                        fontSize: 16,
                        fontWeight: 600,
                        color: isSelected ? AppColors.blackTwo : AppColors.greyTwo,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSlotSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.greyOne.withValues(
            alpha: 0.5
          )
        ),
      ),
      child: ValueListenableBuilder<String>(
        valueListenable: _selectedSlot,
        builder: (context, selectedSlot, child) {
          return Row(
            children: _slots.map((slot) {
              final isSelected = slot == selectedSlot;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _selectedSlot.value = slot,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.pinkTwo : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CommonText(
                      slot,
                      fontSize: 16,
                      fontWeight: 700,
                      color: isSelected ? AppColors.whiteOne : AppColors.blackTwo,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildTimeGrid() {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedTimeIndex,
      builder: (context, selectedIndex, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _times.length,
          itemBuilder: (context, index) {
            final isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () => _selectedTimeIndex.value = index,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.whiteOne : AppColors.greyFive.withValues(alpha: 0.3),
                  border: Border.all(
                    color: isSelected ? AppColors.greyOne : AppColors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CommonText(
                  _times[index],
                  fontSize: 14,
                  fontWeight: isSelected ? 700 : 500,
                  color: isSelected ? AppColors.blackTwo : AppColors.greyTwo,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildNotesField() {
    return CommonTextField(
      controller: _notesController,
      labelText: "Type your notes here",
      hintText: "Type your notes here",
      hintSize: 14,
      labelSize: 14,
      borderColor: AppColors.transparent,
      fillColor: AppColors.greyFive.withValues(alpha: 0.3),
      textColor: AppColors.blackTwo,
      cursorColor: AppColors.blackTwo,
      minLines: 5,
      maxLines: null,
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 24),
      child: CommonSlidingButton(
        valueListenable: _isBackSelected,
        leftLabel: "Back",
        rightLabel: "Continue",
        onLeftTap: () => Get.back(),
        onRightTap: () {
          // Handle continue
        },
        leftActiveColor: AppColors.whiteOne,
        rightActiveColor: AppColors.pinkTwo,
        leftActiveTextColor: AppColors.greyTwo,
        rightActiveTextColor: AppColors.whiteOne,
        inactiveTextColor: AppColors.greyTwo,
      ),
    );
  }
}

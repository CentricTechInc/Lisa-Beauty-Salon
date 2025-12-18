
import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CircularDaySelector extends StatelessWidget {
  final List<String> selectedDays;
  final Function(String) onDayToggle;

  const CircularDaySelector({
    required this.selectedDays,
    required this.onDayToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final days = [
      Strings.monShortText,
      Strings.tueShortText,
      Strings.wedShortText,
      Strings.thuShortText,
      Strings.friShortText,
      Strings.satShortText,
      Strings.sunShortText,
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: days.map((day) {
        final isSelected = selectedDays.contains(day);
        return GestureDetector(
          onTap: () => onDayToggle(day),
          child: Container(
            width: 45,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.pinkTwo.withOpacity(0.1) : AppColors.whiteOne,
              border: Border.all(
                color: isSelected ? AppColors.pinkTwo : AppColors.greyOne,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CommonText(
              day,
              fontSize: 12,
              fontWeight: isSelected ? 600 : 400,
              color: isSelected ? AppColors.pinkTwo : AppColors.greyTwo,
            ),
          ),
        );
      }).toList(),
    );
  }
}

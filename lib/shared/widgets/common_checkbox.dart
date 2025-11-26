import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CommonCheckbox extends StatelessWidget {
  const CommonCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.labelFontSize = 15,
    this.labelFontWeight = 400,
    this.activeColor = AppColors.secondary,
    this.inactiveColor = AppColors.neutral200,
    this.checkColor = AppColors.whiteOne,
    this.borderColor = AppColors.greyTwo,
    this.borderRadius = 6,
    this.size = 22,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.spacing = 10,
    this.enabled = true,
    this.icon,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;

  final String? label;
  final double labelFontSize;
  final double labelFontWeight;

  final Color activeColor;
  final Color inactiveColor;
  final Color checkColor;
  final Color borderColor;

  final double borderRadius;
  final double size;
  final double spacing;

  final EdgeInsetsGeometry padding;
  final bool enabled;

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: enabled ? () => onChanged(!value) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: value ? activeColor : inactiveColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: borderColor,
                  width: 1.2,
                ),
              ),
              child: value ? icon ?? Icon(
                Icons.check,
                size: size * 0.7,
                color: checkColor,
              ) : null,
            ),

            if (label != null)...[
              HorizontalSpacing(spacing)
            ],

            if (label != null)
              Flexible(
                child: CommonText(
                  label!,
                  fontSize: labelFontSize,
                  fontWeight: labelFontWeight,
                  color: AppColors.blackOne,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

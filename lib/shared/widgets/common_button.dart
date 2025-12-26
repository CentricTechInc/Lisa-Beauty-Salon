import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    this.onPressed,

    // Content
    this.text,
    this.child,

    // Dimensions
    this.height,
    this.width,
    this.padding,

    // Colors & Styles
    this.backgroundColor = AppColors.pinkTwo,
    this.textColor = AppColors.whiteOne,
    this.borderColor,
    this.borderWidth = 1.5,
    this.radius = 16.0,
    this.elevation = 0,
    this.shadowColor = AppColors.greyTwo,

    // Text Style
    this.textFontSize = 16,
    this.textFontWeight = 600,

    // Alignment
    this.alignment,
  });

  // Action
  final VoidCallback? onPressed;

  // Content
  final String? text;
  final Widget? child;

  // Dimensions
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  // Colors & border
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double borderWidth;
  final double radius;
  final double elevation;
  final Color shadowColor;

  // Text styling
  final double textFontSize;
  final double textFontWeight;

  // Alignment
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final content = child ??
        CommonText(
          text ?? '',
          color: textColor,
          fontSize: textFontSize,
          fontWeight: textFontWeight,
          textAlign: TextAlign.center,
        );

    return Align(
      alignment: alignment ?? Alignment.center,
      child: SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: elevation,
            shadowColor: shadowColor,
            padding: padding ?? const EdgeInsets.symmetric(
              vertical: 14
            ),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
                width: borderWidth,
              ),
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}

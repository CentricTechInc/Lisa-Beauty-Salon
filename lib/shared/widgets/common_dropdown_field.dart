import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CommonDropdownField<T> extends StatelessWidget {
  const CommonDropdownField({
    super.key,
    required this.items,
    required this.selectedItemBuilder,
    required this.onChanged,
    this.value,
    this.hintText = "Select",
    this.labelText = "Select",
    this.titleLabelText = '',
    this.validator,
    this.borderColor = AppColors.greyOne,
    this.enableBorder = AppColors.greyOne,
    this.disableBorder = AppColors.greyTwo,
    this.textColor = AppColors.blackTwo,
    this.hintColor = AppColors.greyTwo,
    this.labelColor = AppColors.greyTwo,
    this.titleLabelColor = AppColors.blackTwo,
    this.fontFamily = Strings.fontFamily,
    this.fontSize = 15.0,
    this.hintSize = 16.0,
    this.labelSize = 16.0,
    this.titleLabelSize = 12.0,
    this.titleLabelWeight = 400,
    this.textWeight = FontWeight.w400,
    this.hintWeight = FontWeight.w400,
    this.labelWeight = FontWeight.w400,

    this.padding = const EdgeInsets.all(0),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    this.borderRadius = 15.0,
    this.fillColor = AppColors.whiteOne,
    this.prefix,
    this.prefixPadding,
    this.isBorderEnabled = true,
  });

  final List<DropdownMenuItem<T>> items;
  final DropdownButtonBuilder? selectedItemBuilder;
  final T? value;
  final String hintText;
  final String labelText;
  final String titleLabelText;
  final Function(T?) onChanged;
  final String? Function(T?)? validator;

  final double borderRadius;
  final double fontSize;
  final double hintSize;
  final double labelSize;
  final double titleLabelSize;
  final double titleLabelWeight;
  final FontWeight textWeight;
  final FontWeight hintWeight;
  final FontWeight labelWeight;

  final Color borderColor;
  final Color enableBorder;
  final Color disableBorder;
  final Color textColor;
  final Color hintColor;
  final Color labelColor;
  final Color titleLabelColor;
  final Color? fillColor;

  final String fontFamily;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;

  final Widget? prefix;
  final EdgeInsetsGeometry? prefixPadding;

  final bool isBorderEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleLabelText.isNotEmpty)...[
            CommonText(
              titleLabelText,
              fontSize: titleLabelSize,
              fontWeight: titleLabelWeight,
              color: titleLabelColor,
            ),
            VerticalSpacing(5),
          ],
          DropdownButtonFormField<T>(
            isExpanded: true,
            initialValue: value,
            items: items,
            validator: validator,
            onChanged: onChanged,
            icon: const Icon(Icons.keyboard_arrow_down),
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSize,
              fontWeight: textWeight,
              color: textColor,
            ),
            selectedItemBuilder: selectedItemBuilder,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: fillColor,
              labelText: labelText,
              hintText: hintText,
              labelStyle: TextStyle(
                color: labelColor,
                fontFamily: fontFamily,
                fontSize: labelSize,
                fontWeight: labelWeight,
              ),
              hintStyle: TextStyle(
                color: hintColor,
                fontFamily: fontFamily,
                fontSize: hintSize,
                fontWeight: hintWeight,
              ),

              prefixIcon: prefix != null
                  ? Padding(
                padding: prefixPadding ?? EdgeInsets.zero,
                child: prefix,
              )
                  : null,

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.25,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

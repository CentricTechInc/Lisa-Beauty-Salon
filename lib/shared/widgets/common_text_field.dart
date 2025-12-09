
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.controller,
    this.isFilledColor = false,
    this.hintText = 'write here',
    this.labelText = 'write here',
    this.titleLabelText = '',
    this.suffixPadding = 7.5,
    this.prefixPadding,
    this.containerSize = 60,
    this.textWeight = FontWeight.w400,
    this.hintWeight = FontWeight.w400,
    this.labelWeight = FontWeight.w400,
    this.titleLabelWeight = 400,
    this.hintSize = 16.0,
    this.labelSize = 16.0,
    this.titleLabelSize = 12.0,
    this.fontSize = 15.0,
    this.hintColor = AppColors.greyTwo,
    this.labelColor = AppColors.greyTwo,
    this.titleLabelColor = AppColors.blackTwo,
    this.borderColor = AppColors.greyOne,
    this.readOnly = false,
    this.iconColor,
    this.fontFamily = Strings.fontFamily,
    this.minLines = 1,
    this.maxLines = 1,
    this.textOnTap,
    this.onChanged,
    this.validator,
    this.changeIcon = false,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.inputType = TextInputType.text,
    this.suffix,
    this.suffixIconOnTap,
    this.pass = false,
    this.enableBorder = AppColors.greyOne,
    this.disableBorder = AppColors.greyTwo,
    this.textColor = AppColors.blackOne,
    this.cursorColor = AppColors.secondary,
    this.padding = const EdgeInsets.all(0.0),
    this.contentPadding =
    const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    this.prefix,
    this.isBorderEnabled = true,
    this.isSuffix = true,
    this.textOverflow,
    this.focusNode,
    this.label,
    this.maxLength,
    this.labelIcon,
    this.fillColor = AppColors.whiteOne,
    this.borderRadius = 15.0,
    this.textAlign,
    this.inputFormatter,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
  });

  final double suffixPadding;
  final EdgeInsetsGeometry? prefixPadding;
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final String titleLabelText;
  final String fontFamily;
  final double fontSize;
  final double containerSize;
  final double titleLabelWeight;
  final FontWeight textWeight;
  final FontWeight hintWeight;
  final FontWeight labelWeight;
  final double hintSize;
  final double labelSize;
  final double titleLabelSize;
  final Color hintColor;
  final Color labelColor;
  final Color titleLabelColor;
  final Color borderColor;
  final Color enableBorder;
  final Color disableBorder;
  final Color textColor;
  final Color cursorColor;
  final Color? iconColor;
  final bool pass;
  final bool readOnly;
  final bool changeIcon;
  final bool isFilledColor;
  final Function()? textOnTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final int minLines;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffix;
  final VoidCallback? suffixIconOnTap;
  final Widget? prefix;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final AutovalidateMode? autoValidateMode;
  final bool isBorderEnabled;
  final bool isSuffix;
  final TextOverflow? textOverflow;
  final FocusNode? focusNode;
  final String? label;
  final String? labelIcon;
  final Color? fillColor;
  final double borderRadius;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatter;
  final FloatingLabelBehavior floatingLabelBehavior;

  @override
  Widget build(BuildContext context) {
    if (titleLabelText.isNotEmpty) {
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              titleLabelText,
              fontSize: titleLabelSize,
              fontWeight: titleLabelWeight,
              color: titleLabelColor,
            ),
            VerticalSpacing(5),
            TextFormField(
              textAlign: textAlign ?? TextAlign.start,
              focusNode: focusNode,
              controller: controller,
              cursorColor: cursorColor,
              keyboardType: inputType,
              obscureText: pass,
              readOnly: readOnly,
              minLines: minLines,
              maxLines: maxLines,
              maxLength: maxLength,
              onTap: textOnTap,
              validator: validator,
              autovalidateMode: autoValidateMode,
              inputFormatters: inputFormatter,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontFamily: fontFamily,
                fontWeight: textWeight,
                fontSize: fontSize,
                color: textColor,
                overflow: textOverflow,
              ),
              onChanged: onChanged,
              decoration: InputDecoration(
                errorMaxLines: 6,
                floatingLabelBehavior: floatingLabelBehavior,
                fillColor: fillColor,
                filled: true,
                hintText: hintText,
                labelText: labelText,
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
                contentPadding: contentPadding,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: borderColor,
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: borderColor,
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: borderColor,
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: borderColor,
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.25),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                suffixIcon: isSuffix && suffix != null
                    ? GestureDetector(
                  onTap: suffixIconOnTap,
                  child: Padding(
                    padding: EdgeInsets.only(right: suffixPadding),
                    child: suffix,
                  ),
                )
                    : null,
                prefixIcon: prefix != null
                    ? Padding(
                  padding: prefixPadding ?? EdgeInsets.zero,
                  child: prefix,
                )
                    : null,
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: padding,
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.start,
        focusNode: focusNode,
        controller: controller,
        cursorColor: cursorColor,
        keyboardType: inputType,
        obscureText: pass,
        readOnly: readOnly,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        onTap: textOnTap,
        validator: validator,
        autovalidateMode: autoValidateMode,
        inputFormatters: inputFormatter,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontFamily: fontFamily,
          fontWeight: textWeight,
          fontSize: fontSize,
          color: textColor,
          overflow: textOverflow,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          errorMaxLines: 6,
          floatingLabelBehavior: floatingLabelBehavior,
          fillColor: fillColor,
          filled: true,
          hintText: hintText,
          labelText: labelText,
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
          contentPadding: contentPadding,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: borderColor,
                width: 1
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: borderColor,
                width: 1
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: borderColor,
                width: 1
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: borderColor,
                width: 1
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.25),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          suffixIcon: isSuffix && suffix != null
              ? GestureDetector(
            onTap: suffixIconOnTap,
            child: Padding(
              padding: EdgeInsets.only(right: suffixPadding),
              child: suffix,
            ),
          )
              : null,
          prefixIcon: prefix != null
              ? Padding(
            padding: prefixPadding ?? EdgeInsets.zero,
            child: prefix,
          )
              : null,
        ),
      ),
    );
  }
}

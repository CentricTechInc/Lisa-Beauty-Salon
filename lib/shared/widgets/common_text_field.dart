import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/app/mixins/validations.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/sizer.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';


class CommonTextfield extends StatelessWidget with FieldsValidation {
  const CommonTextfield(
      this.controller, {
        super.key,
        this.textLabel = "",
        this.required = false,
        this.obscure = false,
        this.hintText = "",
        this.suffix,
        this.suffixIcon,
        this.fillColor,
        this.suffixConst = const BoxConstraints(minWidth: 24, minHeight: 24),
        this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        this.radius = 15,
      });

  final String textLabel;
  final bool required;
  final String hintText;
  final TextEditingController controller;
  final bool obscure;
  final Widget? suffix, suffixIcon;
  final BoxConstraints? suffixConst;
  final Color? fillColor;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (textLabel.isNotEmpty) ...[
          CommonText(
            textLabel + (required ? " *" : ""),
            fontSize: 12,
            letterSpacing: 0.2,
          ),
          SizedBox(height: 4),
        ],
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hint: CommonText(
              hintText,
              color: AppColors.secondary,
              fontSize: AppSizer.getFontSize(16),
            ),
            suffix: suffix,
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixConst,
            fillColor: fillColor,
            filled: fillColor != null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding: padding,
          ),
        ),
      ],
    );
  }
}
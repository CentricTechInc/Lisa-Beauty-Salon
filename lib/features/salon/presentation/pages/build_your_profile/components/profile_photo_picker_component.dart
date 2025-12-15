import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class PhotoPickerComponent extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onTap;
  final double outerHeight;
  final double innerHeight;

  const PhotoPickerComponent({
    super.key,
    required this.onTap,
    this.imagePath,
    this.outerHeight = 200,
    this.innerHeight = 130,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width * 0.88,
        height: outerHeight,
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(16),
          border: DashedBorder.fromBorderSide(
            strokeCap: StrokeCap.round,
            dashLength: 8,
            side: BorderSide(
              color: AppColors.greyOne,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Container(
            width: context.width * 0.4,
            height: innerHeight,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.greyFour,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imagePath == null
                  ? Center(
                child: SvgPicture.asset(
                  Assets.placeholderSvgIcon,
                  width: 45,
                  height: 45,
                ),
              ) : Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

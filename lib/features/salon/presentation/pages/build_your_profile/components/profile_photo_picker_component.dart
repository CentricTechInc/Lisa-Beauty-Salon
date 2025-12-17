import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class PhotoPickerComponent extends StatelessWidget {
  const PhotoPickerComponent({
    super.key,
    required this.onTap,
    this.imagePath,
    this.outerHeight = 200,
    this.innerHeight = 130,
    this.isUserInProfileCreateScreen = true,
  });

  final String? imagePath;
  final VoidCallback onTap;
  final double outerHeight;
  final double innerHeight;
  final bool isUserInProfileCreateScreen;

  @override
  Widget build(BuildContext context) {
    final width = context.width * 0.88;
    return isUserInProfileCreateScreen
        ? _DashedPhotoPickerCard(
            onTap: onTap,
            imagePath: imagePath,
            outerHeight: outerHeight,
            innerHeight: innerHeight,
            width: width,
          )
        : _PlainPhotoPickerCard(
            onTap: onTap,
            imagePath: imagePath,
            outerHeight: outerHeight,
            innerHeight: innerHeight,
            width: width,
          );
  }
}

class _ImageWithEditOverlay extends StatelessWidget {
  const _ImageWithEditOverlay({
    required this.imagePath,
    required this.borderRadius,
  });
  final String? imagePath;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: imagePath == null
                ? Center(
                    child: SvgPicture.asset(
                      Assets.placeholderSvgIcon,
                      width: 45,
                      height: 45,
                    ),
                  )
                : Image.file(File(imagePath!), fit: BoxFit.cover),
          ),
        ),
        if (imagePath != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SvgPicture.asset(
                Assets.profileEditIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.whiteOne,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DashedPhotoPickerCard extends StatelessWidget {
  const _DashedPhotoPickerCard({
    required this.onTap,
    required this.imagePath,
    required this.outerHeight,
    required this.innerHeight,
    required this.width,
  });

  final String? imagePath;
  final VoidCallback onTap;
  final double outerHeight;
  final double innerHeight;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: outerHeight,
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(16),
          border: DashedBorder.fromBorderSide(
            strokeCap: StrokeCap.round,
            dashLength: 8,
            side: BorderSide(color: AppColors.greyOne, width: 2),
          ),
        ),
        child: Center(
          child: Container(
            width: width * 0.45,
            height: innerHeight,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.greyFour,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _ImageWithEditOverlay(
              imagePath: imagePath,
              borderRadius: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class _PlainPhotoPickerCard extends StatelessWidget {
  const _PlainPhotoPickerCard({
    required this.onTap,
    required this.imagePath,
    required this.outerHeight,
    required this.innerHeight,
    required this.width,
  });

  final String? imagePath;
  final VoidCallback onTap;
  final double outerHeight;
  final double innerHeight;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: width * 0.45,
          height: innerHeight,
          decoration: BoxDecoration(
            color: AppColors.greyFour,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _ImageWithEditOverlay(imagePath: imagePath, borderRadius: 12),
        ),
      ),
    );
  }
}

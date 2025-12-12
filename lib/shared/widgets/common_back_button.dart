
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({
    super.key,
    this.iconColor,
    this.child,
  });

  final Color? iconColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: iconColor ?? AppColors.blackOne,
          ),
        ),
        if (child != null)
        Spacer(),
        if (child != null) child ?? SizedBox.shrink(),
      ],
    );
  }
}

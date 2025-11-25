import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:lisa_beauty_salon/core/constants/app_constants.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';

class CommonScaffoldWidget extends StatelessWidget {
  const CommonScaffoldWidget({
    super.key,
    required this.child,
    this.footerButton,
    this.image,
    this.bottomNavigationBar,
    this.padding,
    this.fit,
    this.imageAlignment,
    this.top = true,
    this.resizeToAvoidBottomInset = true,
    this.bgColor,
    this.drawerKey,
    this.drawer,
    this.systemOverlayStyle, // New Parameter
  });

  final Widget child;
  final List<Widget>? footerButton;
  final String? image;
  final BoxFit? fit;
  final AlignmentGeometry? imageAlignment;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry? padding;
  final bool top;
  final bool resizeToAvoidBottomInset;
  final Color? bgColor;
  final Key? drawerKey;
  final Widget? drawer;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Widget build(BuildContext context) {

    final defaultStyle = SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppColors.transparent,
    );

    final effectiveStyle = systemOverlayStyle ?? (top ? defaultStyle : null);

    final scaffold = Scaffold(
      key: drawerKey,
      backgroundColor: bgColor ?? AppColors.white,
      bottomNavigationBar: bottomNavigationBar,
      persistentFooterButtons: footerButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      drawer: drawer,

      appBar: top ? null : PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.primary,
        ),
      ),

      body: SafeArea(
        top: image != null ? false : top,
        bottom: Platform.isIOS ? false : true,
        child: image != null ? Container(
          height: context.height,
          padding: padding ?? AppConstants.kScreenPadding,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                image ?? '',
              ),
              fit: fit ?? BoxFit.cover,
            ),
          ),
            child: child
        ) : Padding(
          padding: padding ?? AppConstants.kScreenPadding,
          child: child,
        ),
      ),
    );

    if (effectiveStyle != null) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: effectiveStyle,
        child: scaffold,
      );
    }

    return scaffold;
  }
}
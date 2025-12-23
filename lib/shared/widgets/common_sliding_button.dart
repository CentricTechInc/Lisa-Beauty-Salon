import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CommonSlidingButton extends StatelessWidget {
  final ValueNotifier<bool> valueListenable;
  final String leftLabel;
  final String rightLabel;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;
  final double height;
  final Color? leftActiveColor;
  final Color? rightActiveColor;
  final Color? leftActiveTextColor;
  final Color? rightActiveTextColor;
  final Color? inactiveTextColor;

  const CommonSlidingButton({
    super.key,
    required this.valueListenable,
    required this.leftLabel,
    required this.rightLabel,
    this.onLeftTap,
    this.onRightTap,
    this.height = 56,
    this.leftActiveColor,
    this.rightActiveColor,
    this.leftActiveTextColor,
    this.rightActiveTextColor,
    this.inactiveTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        border: Border.all(
          color: AppColors.greyOne.withValues(alpha: 0.5),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / 2;

          return ValueListenableBuilder<bool>(
            valueListenable: valueListenable,
            builder: (context, selected, _) {
              final activeColor = selected
                  ? (leftActiveColor ?? AppColors.pinkTwo)
                  : (rightActiveColor ?? AppColors.pinkTwo);

              return Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    alignment: selected
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: segmentWidth,
                      height: height,
                      decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            valueListenable.value = true;
                            onLeftTap?.call();
                          },
                          child: Center(
                            child: CommonText(
                              leftLabel,
                              fontSize: 17,
                              fontWeight: 700,
                              color: selected
                                  ? (leftActiveTextColor ?? AppColors.whiteTwo)
                                  : (inactiveTextColor ?? AppColors.greyTwo),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            valueListenable.value = false;
                            onRightTap?.call();
                          },
                          child: Center(
                            child: CommonText(
                              rightLabel,
                              fontSize: 17,
                              fontWeight: 700,
                              color: !selected
                                  ? (rightActiveTextColor ?? AppColors.whiteTwo)
                                  : (inactiveTextColor ?? AppColors.greyTwo),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

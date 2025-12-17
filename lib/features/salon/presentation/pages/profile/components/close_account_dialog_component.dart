import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CloseAccountDialogComponent extends StatelessWidget {
  CloseAccountDialogComponent({super.key});

  final ValueNotifier<bool> isYesSelected = ValueNotifier(false);

  void _onSelect(bool value) {
    isYesSelected.value = value;
    Get.back(result: value);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.pinkTwo.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.all(8.0),
                child: Icon(
                  Icons.close,
                  color: AppColors.pinkTwo,
                  size: 30,
                ),
              ),
            ),
            VerticalSpacing(24),

            // Title
            CommonText(
              Strings.closeAccountQuestionText,
              fontSize: 24,
              fontWeight: 700,
              color: AppColors.blackTwo,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.visible,
              maxLines: null,
            ),
            VerticalSpacing(12),

            // Description
            CommonText(
              Strings.closeAccountDescriptionText,
              fontSize: 16,
              fontWeight: 400,
              color: AppColors.blackTwo,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.visible,
              maxLines: null,
            ),
            VerticalSpacing(32),

            /// 🔥 ValueNotifier-based Sliding Toggle
            Container(
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.greyOne,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final segmentWidth = constraints.maxWidth / 2;

                  return ValueListenableBuilder<bool>(
                    valueListenable: isYesSelected,
                    builder: (context, selected, _) {
                      return Stack(
                        children: [
                          // Sliding background
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            alignment: selected ? Alignment.centerLeft
                              : Alignment.centerRight,
                            child: Container(
                              width: segmentWidth,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.pinkTwo,
                                borderRadius: BorderRadius.circular(14.5),
                              ),
                            ),
                          ),

                          // Tap areas
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => _onSelect(true),
                                  child: Center(
                                    child: CommonText(
                                      Strings.yesText,
                                      fontSize: 18,
                                      fontWeight: 600,
                                      color: selected
                                          ? AppColors.whiteTwo
                                          : AppColors.greyTwo,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => _onSelect(false),
                                  child: Center(
                                    child: CommonText(
                                      Strings.noText,
                                      fontSize: 18,
                                      fontWeight: 600,
                                      color: !selected
                                          ? AppColors.whiteTwo
                                          : AppColors.greyTwo,
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
            ),
          ],
        ),
      ),
    );
  }
}

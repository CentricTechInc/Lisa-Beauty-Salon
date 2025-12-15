import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class EnableLocationDialogComponent extends StatelessWidget {
  const EnableLocationDialogComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: context.mediaQueryPadding.top + 20,
            bottom: 30,
            left: 20,
            right: 20
          ),
          decoration: BoxDecoration(
            color: AppColors.whiteOne,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30)
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonText(
                "Enable Location",
                fontSize: 24,
                fontWeight: 700,
                color: AppColors.blackTwo,
                textAlign: TextAlign.center,
              ),
              VerticalSpacing(20),

              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.locationImage
                    ),
                    fit: BoxFit.cover
                  )
                ),
              ),
              VerticalSpacing(20),
              CommonText(
                "We need to know your location in order to suggest nearby services.",
                fontSize: 16,
                fontWeight: 400,
                color: AppColors.greyTwo,
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.visible,
              ),
              VerticalSpacing(30),
              CommonButton(
                onPressed: () {
                  Get.back(
                    result: true
                  );
                },
                text: "Enable",
                backgroundColor: AppColors.pinkTwo,
                textColor: AppColors.whiteOne,
                width: 150,
                height: 50,
                radius: 12
              )
            ],
          ),
        ),
      ),
    );
  }
}

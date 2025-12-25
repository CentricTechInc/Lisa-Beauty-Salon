import 'package:flutter/material.dart ';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/helpers.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_tabbar_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/appointment/components/appointment_list_component.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        children: [
          VerticalSpacing(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: CommonText(
                  "Your Appointments",
                  fontSize: 24,
                  color: AppColors.blackTwo,
                  fontWeight: 600,
                  textOverflow: TextOverflow.visible,
                  maxLines: null,
                ),
              ),
              HorizontalSpacing(8),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          showFeatureUnderDevelopment();
                        },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.whiteOne,
                          borderRadius: BorderRadius.circular(
                            16
                          ),
                          border: Border.all(
                            color: AppColors.greyOne
                          )
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.filterIcon,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ),
                    HorizontalSpacing(10),
                    GestureDetector(
                        onTap: () {
                          showFeatureUnderDevelopment();
                        },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.whiteOne,
                          borderRadius: BorderRadius.circular(
                            16
                          ),
                          border: Border.all(
                            color: AppColors.greyOne
                          )
                        ),
                        child: Center(
                          child: Icon(
                            Icons.tune,
                            color: AppColors.blackTwo,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          VerticalSpacing(40),
          CommonTabBarWidgetTwo(
            tabs: [
              Strings.upcomingText,
              Strings.previousText,
              Strings.cancelledText
            ],
            tabViews: [
              UpcomingAppointmentListComponent(),
              PreviousAppointmentListComponent(),
              CancelledAppointmentListComponent(),
            ],
          ),
          VerticalSpacing(20),
        ],
      ),
    );
  }
}
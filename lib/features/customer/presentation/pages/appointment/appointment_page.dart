import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/helpers.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/appointment/components/previous_appointment_list_component.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/appointment/components/upcoming_appointment_list_component.dart';

import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_tabbar_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacing(40),
          _buildHeader(),
          const VerticalSpacing(40),
          CommonTabBarWidgetTwo(
            tabPadding: EdgeInsets.zero,
            indicatorColor: AppColors.blackOne,
            selectedLabelColor: AppColors.whiteOne,
            unselectedLabelColor: AppColors.greyTwo,
            indicatorRadius: 12,

            containerDecoration: BoxDecoration(
              color: AppColors.greyFour,
              borderRadius: BorderRadius.circular(16),
            ),

            tabs: const [
              Strings.upcomingText,
              Strings.previousText,
            ],
            tabViews: [
              UpcomingAppointmentListComponent(),
              const PreviousAppointmentListComponent(),
            ],
          ),
          const VerticalSpacing(70),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: const CommonText(
            Strings.yourAppointmentsText,
            fontSize: 24,
            fontWeight: 600,
            color: AppColors.blackTwo,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () => showFeatureUnderDevelopment(),
              child: _buildHeaderIcon(CupertinoIcons.map)
            ),
            const HorizontalSpacing(12),
            GestureDetector(
              onTap: () => showFeatureUnderDevelopment(),
              child: _buildHeaderIcon(Icons.tune)
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.greyOne
        ),
      ),
      child: Icon(
        icon,
        color: AppColors.blackTwo,
        size: 20
      ),
    );
  }

}





import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/home/components/enable_location_dialog_component.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/helpers.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

import 'components/monthly_statistics_graph.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> monthItems = [];
  final ValueNotifier<String?> selectedMonthNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLocationDialog();
    });
    _generateMonths();
  }

  @override
  void dispose() {
    selectedMonthNotifier.dispose();
    super.dispose();
  }

  Future<void> _checkLocationDialog() async {
    const storage = FlutterSecureStorage();
    final hasShown = await storage.read(key: 'hasShownLocationDialog');

    if (hasShown != 'true') {
      Get.generalDialog(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const EnableLocationDialogComponent();
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        barrierDismissible: false,
        barrierLabel: 'Dismiss',
        barrierColor: AppColors.blackOne.withValues(
          alpha: 0.5
        ),
        transitionDuration: const Duration(milliseconds: 400),
      ).then((value) {
        if (value == true) {
          storage.write(key: 'hasShownLocationDialog', value: 'true');
        }
      });
    }
  }

  void _generateMonths() {
    final now = DateTime.now();
    
    // Actually request is "from current month year to the previous year months name"
    // So we iterate backwards from now until we hit Jan of previous year.
    DateTime internalDate = now;
    // Calculate the target end date: January 1st of the previous year
    DateTime endDate = DateTime(now.year - 1, 1, 1);

    while (internalDate.isAfter(endDate) || internalDate.isAtSameMomentAs(endDate)) {
        monthItems.add(DateFormat('MMMM yyyy').format(internalDate));
        // Move to previous month
        internalDate = DateTime(internalDate.year, internalDate.month - 1, 1);
    }

    if (monthItems.isNotEmpty) {
      selectedMonthNotifier.value = monthItems.first;
    }
  }


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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    "Welcome, Eleanor",
                    fontSize: 24,
                    color: AppColors.blackTwo,
                    fontWeight: 600,
                  ),
                  CommonText(
                    "Let's do some self care",
                    fontSize: 16,
                    color: AppColors.greyTwo,
                    fontWeight: 400,
                  ),
                ],
              ),
              Row(
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
                        child: Icon(
                          Icons.notifications_none_outlined,
                          color: AppColors.blackTwo,
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
                          Icons.search,
                          color: AppColors.blackTwo,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          VerticalSpacing(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                Strings.appointmentText,
                fontSize: 20,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
              CommonText(
                Strings.todayOrMorningText,
                fontSize: 12,
                fontWeight: 400,
                color: AppColors.greyTwo,
              ),
            ],
          ),
          VerticalSpacing(20),
          Container(
            width: context.width - 40,
            height: 66,
            decoration: BoxDecoration(
              color: AppColors.pinkTwo,
              borderRadius: BorderRadius.circular(15)
            ),
            padding: EdgeInsets.only(
              left: 10,
              right: 5,
              top: 10,
              bottom: 10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.bottomBarIconTwo,
                        width: 20,
                        height: 20,
                      ),
                      HorizontalSpacing(8),
                      Expanded(
                        child: CommonText(
                          Strings.bloomAndBladeText,
                          fontSize: 18,
                          fontWeight: 600,
                          color: AppColors.whiteOne,
                          textOverflow: TextOverflow.visible,
                          maxLines: null,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        Strings.nineAmText,
                        fontSize: 12,
                        fontWeight: 400,
                        color: AppColors.whiteOne,
                      ),
                      CommonText(
                        Strings.todayOrMorningText,
                        fontSize: 12,
                        fontWeight: 400,
                        color: AppColors.whiteOne,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          VerticalSpacing(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                Strings.weekRevenueText,
                fontSize: 20,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonText(
                    Strings.weekRevenuePriceText,
                    fontSize: 30,
                    fontWeight: 700,
                    color: AppColors.pinkTwo,
                  ),
                  CommonText(
                    Strings.earnedText,
                    fontSize: 12,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                  ),
                ],
              )
            ],
          ),
          VerticalSpacing(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: CommonText(
                  Strings.appointmentStatisticsText,
                  fontSize: 20,
                  fontWeight: 700,
                  color: AppColors.blackTwo,
                  textOverflow: TextOverflow.visible,
                  maxLines: null,
                ),
              ),
              SizedBox(
                width: context.width * 0.45,
                child: ValueListenableBuilder<String?>(
                  valueListenable: selectedMonthNotifier,
                  builder: (context, value, child) {
                    return CommonDropdownField<String>(
                      items: monthItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CommonText(
                            value,
                            fontSize: 12,
                            fontWeight: 400,
                            color: AppColors.greyTwo,
                          ),
                        );
                      }).toList(),
                      selectedItemBuilder: (BuildContext context) {
                        return monthItems.map<Widget>((String value) {
                          return CommonText(
                            value,
                            fontSize: 12,
                            fontWeight: 400,
                            color: AppColors.greyTwo,
                            textOverflow: TextOverflow.ellipsis,
                          );
                        }).toList();
                      },
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          selectedMonthNotifier.value = newValue;
                        }
                      },
                      value: value,
                      hintText: "Select Month",
                      fillColor: AppColors.transparent,
                      iconColor: AppColors.greyTwo,
                      borderColor: AppColors.transparent,
                      borderRadius: 10,
                      padding: EdgeInsets.zero,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                    );
                  }
                ),
              )
            ],
          ),
          VerticalSpacing(20),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15, 
              horizontal: 10
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteOne,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: AppColors.greyOne,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonText(
                          Strings.totalText,
                          fontSize: 14,
                          fontWeight: 400,
                          color: AppColors.greyTwo,
                        ),
                        CommonText(
                          "80", // TODO: Replace with dynamic data
                          fontSize: 24,
                          fontWeight: 700,
                          color: AppColors.blackTwo,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: AppColors.greyOne,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonText(
                          Strings.completedText,
                          fontSize: 14,
                          fontWeight: 400,
                          color: AppColors.greyTwo,
                        ),
                        CommonText(
                          "65", // TODO: Replace with dynamic data
                          fontSize: 24,
                          fontWeight: 700,
                          color: AppColors.blackTwo,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonText(
                        Strings.cancelledText,
                        fontSize: 14,
                        fontWeight: 400,
                        color: AppColors.greyTwo,
                      ),
                      CommonText(
                        "15", // TODO: Replace with dynamic data
                        fontSize: 24,
                        fontWeight: 700,
                        color: AppColors.blackTwo,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          VerticalSpacing(20),
          MonthlyStatisticsGraph(),
          VerticalSpacing(90),
        ],
      ),
    );
  }
}

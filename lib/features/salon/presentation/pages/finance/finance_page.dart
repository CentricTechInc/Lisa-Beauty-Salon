import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/helpers.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/finance/components/earning_history_card_component.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/finance/components/finance_chart_component.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/finance/components/payout_history_card_component.dart';
import 'package:lisa_beauty_salon/features/salon/presentation/pages/finance/components/withdraw_bottom_sheet_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_tabbar_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';


class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  final ValueNotifier<int> _currentTabIndex = ValueNotifier(0);

  @override
  void dispose() {
    _currentTabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacing(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    Strings.financeText,
                    fontSize: 24,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                  CommonButton(
                    width: 48,
                    height: 48,
                    radius: 16,
                    backgroundColor: AppColors.whiteOne,
                    borderColor: AppColors.greyOne,
                    child: SvgPicture.asset(
                      Assets.notificationIcon,
                      width: 25,
                      height: 25,
                    ),
                    onPressed: () {
                      showFeatureUnderDevelopment();
                    },
                 ),
                ],
              ),
              VerticalSpacing(32),
              Center(
                child: CommonText(
                  Strings.availableForPayoutsText,
                  fontSize: 20,
                  fontWeight: 700,
                  color: AppColors.blackTwo,
                ),
              ),
              Center(
                child: CommonText(
                  Strings.payoutPlaceholderText,
                  fontSize: 48,
                  fontWeight: 700,
                  color: AppColors.greenOne,
                ),
              ),
              VerticalSpacing(10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.blackThree,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.totalEarningIcon
                              ),
                              HorizontalSpacing(2),
                              CommonText(
                                Strings.totalEarningsText,
                                fontSize: 16,
                                color: AppColors.whiteOne,
                              ),
                            ],
                          ),
                          VerticalSpacing(12),
                          CommonText(
                            Strings.totalEarningPlaceholderText,
                            fontSize: 24,
                            fontWeight: 600,
                            color: AppColors.pinkOne,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.totalPayoutIcon
                              ),
                              HorizontalSpacing(2),
                              const CommonText(
                                Strings.totalPayoutsText,
                                fontSize: 16,
                                color: AppColors.whiteOne,
                              ),
                            ],
                          ),
                          VerticalSpacing(12),
                          CommonText(
                            Strings.totalPayoutsPlaceholderText,
                              fontSize: 24,
                              fontWeight: 600,
                              color: AppColors.pinkOne,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              VerticalSpacing(32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CommonText(
                    Strings.commissionBreakdownText,
                    fontSize: 20,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                ),
              ),
              VerticalSpacing(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonText(
                  Strings.commissionBreakdownDescriptionText,
                  fontSize: 14,
                  fontWeight: 400,
                  color: AppColors.greyTwo,
                  lineHeight: 1.5,
                  textOverflow: TextOverflow.visible,
                ),
              ),
              VerticalSpacing(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildBreakdownRow(
                  Strings.totalAppointmentCompletedText,
                  Strings.totalAppointmentCompletedPlaceholderText,
                ),
              ),
              VerticalSpacing(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildBreakdownRow(
                  Strings.platformFeeText,
                  Strings.platformFeePlaceholderText,
                ),
              ),
              VerticalSpacing(32),
              CommonTabBarWidgetTwo(
                indicatorColor: AppColors.pinkOne,
                selectedLabelColor: AppColors.whiteOne,
                unselectedLabelColor: AppColors.greyTwo,
                tabs: const [
                  Strings.earningsButtonText,
                  Strings.payoutsButtonText,
                ],
                onTabChange: (index) {
                  _currentTabIndex.value = index;
                },
                tabViews: [_buildEarningsTab(), _buildPayoutsTab()],
              ),
              VerticalSpacing(32),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Center(
            child: CommonButton(
              width: 140,
              height: 50,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const WithdrawBottomSheetComponent(),
                );
              },
              text: Strings.withdrawText,
              textFontSize: 18,
              textFontWeight: 600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEarningsTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          FinanceChartComponent(
            title: Strings.earningStatisticsText,
            data: earningsData,
          ),
          VerticalSpacing(32),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              Strings.earningHistoryText,
              fontSize: 20,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
          ),
          VerticalSpacing(16),
          Column(
            children: [
              for (var i = 0; i < earningHistoryList.length; i++) ...[
                if (i > 0) VerticalSpacing(16),
                EarningHistoryCardComponent(
                  date: earningHistoryList[i]['date'],
                  time: earningHistoryList[i]['time'],
                  professionalName: earningHistoryList[i]['professionalName'],
                  services: earningHistoryList[i]['services'],
                  earnAmount: earningHistoryList[i]['earnAmount'],
                  imagePath: earningHistoryList[i]['imagePath'],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayoutsTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          FinanceChartComponent(
            title: Strings.payoutStatisticsText,
            data: payoutsData,
          ),
          VerticalSpacing(32),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              Strings.payoutHistoryText,
              fontSize: 20,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
          ),
          VerticalSpacing(16),
          Column(
            children: [
              for (var i = 0; i < payoutHistoryList.length; i++) ...[
                if (i > 0) VerticalSpacing(16),
                PayoutHistoryCardComponent(
                  date: payoutHistoryList[i]['date'],
                  time: payoutHistoryList[i]['time'],
                  bankName: payoutHistoryList[i]['bankName'],
                  accountNumberMasked:
                      payoutHistoryList[i]['accountNumberMasked'],
                  withdrawAmount: payoutHistoryList[i]['withdrawAmount'],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          label,
          fontSize: 16,
          fontWeight: 600,
          color: AppColors.blackTwo,
        ),
        CommonText(
          value,
          fontSize: 20,
          fontWeight: 600,
          color: AppColors.pinkOne,
        ),
      ],
    );
  }

  // Dummy Chart Data
  List<ChartData> get earningsData => [
    ChartData(Strings.januaryText, 500),
    ChartData(Strings.februaryText, 1000),
    ChartData(Strings.marchText, 1200),
    ChartData(Strings.aprilText, 800),
    ChartData(Strings.mayText, 700),
    ChartData(Strings.juneText, 900),
    ChartData(Strings.julyText, 1500),
    ChartData(Strings.augustText, 2000),
    ChartData(Strings.septemberText, 2100),
    ChartData(Strings.octoberText, 2200),
    ChartData(Strings.novemberText, 2150),
    ChartData(Strings.decemberText, 2000),
  ];

  List<ChartData> get payoutsData => [
    ChartData(Strings.januaryText, 500),
    ChartData(Strings.februaryText, 900),
    ChartData(Strings.marchText, 1100),
    ChartData(Strings.aprilText, 800),
    ChartData(Strings.mayText, 600),
    ChartData(Strings.juneText, 800),
    ChartData(Strings.julyText, 1200),
    ChartData(Strings.augustText, 1600),
    ChartData(Strings.septemberText, 2000),
    ChartData(Strings.octoberText, 2100),
    ChartData(Strings.novemberText, 2200),
    ChartData(Strings.decemberText, 2100),
  ];

  List<Map<String, dynamic>> get earningHistoryList => [
    {
      "date": "12 November 2025",
      "time": "08:00 PM",
      "professionalName": "Blossom Steele",
      "services": "Nail, Facial, Eyebrows",
      "earnAmount": "R 28.05",
      "imagePath": Assets.welcomeOne,
    },
    {
      "date": "16 November 2025",
      "time": "05:30 PM",
      "professionalName": "Gina Apple",
      "services": "Regular Haircut, Body Glowing",
      "earnAmount": "R 54.99",
      "imagePath": Assets.welcomeOne,
    },
  ];

  List<Map<String, dynamic>> get payoutHistoryList => [
    {
      "date": "12 November 2025",
      "time": "08:00 PM",
      "bankName": "Bank Account",
      "accountNumberMasked": "**** **** 2345",
      "withdrawAmount": "R 28.05",
    },
    {
      "date": "12 November 2025",
      "time": "08:00 PM",
      "bankName": "Bank Account",
      "accountNumberMasked": "**** **** 2345",
      "withdrawAmount": "R 8.12",
    },
  ];
}

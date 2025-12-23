import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/salon/data/dto/earning_dto.dart';
import 'package:lisa_beauty_salon/features/salon/data/dto/payout_dto.dart';
import 'package:lisa_beauty_salon/features/salon/data/dto/service_item_dto.dart';
import 'package:lisa_beauty_salon/features/salon/domain/entities/earning_model.dart';
import 'package:lisa_beauty_salon/features/salon/domain/entities/payout_model.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_bottom_sheet_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_tabbar_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

import 'components/earning_details_component.dart';
import 'components/earning_item_component.dart';
import 'components/payout_details_component.dart';
import 'components/payout_item_component.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> selectedFilterNotifier = ValueNotifier<String>(Strings.thisWeekText);
    final List<String> filters = [
      Strings.thisWeekText,
      Strings.thisMonthText,
      Strings.thisYearText
    ];

    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.whiteOne,
                        border: Border.all(color: AppColors.greyOne, width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(CupertinoIcons.back, color: AppColors.blackTwo),
                    ),
                  ),
                  const HorizontalSpacing(10),
                  const CommonText(
                    Strings.paymentHistoryText,
                    fontSize: 20,
                    fontWeight: 600.0,
                    color: AppColors.blackTwo,
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<String>(
              valueListenable: selectedFilterNotifier,
              builder: (context, selectedFilter, child) {
                return Column(
                  children: [
                    CommonTabBarWidgetTwo(
                      tabPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      indicatorColor: AppColors.pinkTwo,
                      selectedLabelColor: AppColors.whiteOne,
                      unselectedLabelColor: AppColors.greyTwo,
                      tabs: const [Strings.earningsButtonText, Strings.payoutsButtonText],
                      tabViews: [
                        _buildEarningsTab(context, selectedFilter, filters, selectedFilterNotifier),
                        _buildPayoutsTab(context, selectedFilter, filters, selectedFilterNotifier),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsTab(BuildContext context, String selectedFilter, List<String> filters, ValueNotifier<String> notifier) {
    return Column(
      children: [
        _buildFilterDropdown(context, selectedFilter, filters, notifier),
        _buildEarningList(selectedFilter),
      ],
    );
  }

  Widget _buildPayoutsTab(BuildContext context, String selectedFilter, List<String> filters, ValueNotifier<String> notifier) {
    return Column(
      children: [
        _buildFilterDropdown(context, selectedFilter, filters, notifier),
        _buildPayoutList(selectedFilter),
      ],
    );
  }

  Widget _buildFilterDropdown(BuildContext context, String selectedFilter, List<String> filters, ValueNotifier<String> notifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: context.width * 0.34,
            child: CommonDropdownField<String>(
              value: selectedFilter,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              borderRadius: 12,
              items: filters.map((filter) {
                return DropdownMenuItem<String>(
                  value: filter,
                  child: CommonText(filter, fontSize: 13, color: AppColors.blackTwo),
                );
              }).toList(),
              selectedItemBuilder: (context) {
                return filters.map((filter) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(filter, fontSize: 13, color: AppColors.blackTwo),
                  );
                }).toList();
              },
              onChanged: (value) {
                if (value != null) {
                  notifier.value = value;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningList(String selectedFilter) {
    final earnings = _getMockEarnings(selectedFilter);
    if (selectedFilter == Strings.thisYearText) {
      final groupedEarnings = _groupEarningsByMonth(earnings);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedEarnings.entries.map((entry) {
          final month = entry.key;
          final items = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: CommonText(
                  month,
                  fontSize: 16,
                  fontWeight: 700.0,
                  color: AppColors.blackTwo,
                ),
              ),
              ...items.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: EarningItemComponent(
                      earning: e,
                      onTap: () => _showEarningDetails(Get.context!, e),
                    ),
                  )),
            ],
          );
        }).toList(),
      );
    }

    return Column(
      children: earnings
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: EarningItemComponent(
                  earning: e,
                  onTap: () => _showEarningDetails(Get.context!, e),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildPayoutList(String selectedFilter) {
    final payouts = _getMockPayouts();
    if (selectedFilter == Strings.thisYearText) {
      final groupedPayouts = _groupPayoutsByMonth(payouts);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedPayouts.entries.map((entry) {
          final month = entry.key;
          final items = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: CommonText(
                  month,
                  fontSize: 16,
                  fontWeight: 700.0,
                  color: AppColors.blackTwo,
                ),
              ),
              ...items.map((p) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PayoutItemComponent(
                      payout: p,
                      onTap: () => _showPayoutDetails(Get.context!, p),
                    ),
                  )),
            ],
          );
        }).toList(),
      );
    }

    return Column(
      children: payouts
          .map((p) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PayoutItemComponent(
                  payout: p,
                  onTap: () => _showPayoutDetails(Get.context!, p),
                ),
              ))
          .toList(),
    );
  }

  void _showEarningDetails(BuildContext context, EarningModel earning) {
    CommonBottomSheet.show(
      context,
      title: "",
      initialChildSize: 0.6,
      maxChildSize: 0.8,
      content: EarningDetailsComponent(earning: earning),
    );
  }

  void _showPayoutDetails(BuildContext context, PayoutModel payout) {
    CommonBottomSheet.show(
      context,
      title: "",
      initialChildSize: 0.6,
      maxChildSize: 0.8,
      content: PayoutDetailsComponent(payout: payout),
    );
  }

  List<EarningDto> _getMockEarnings(String selectedFilter) {
    return [
      EarningDto(
        dateTime: DateTime(2025, 11, 12, 20, 0),
        clientName: "Blossom Steele",
        clientImage: "assets/images/welcome_one.png",
        services: const ["Nail", "Facial", "Eyebrows"],
        serviceItems: const [
          ServiceItemDto(name: "Nail", price: 8.00),
          ServiceItemDto(name: "Facial", price: 24.99),
        ],
        subTotal: 32.99,
        platformFee: 4.94,
        totalAmount: 28.05,
      ),
      ...List.generate(
        3,
        (index) => EarningDto(
          dateTime: DateTime(2025, 11, 12, 20, 0),
          clientName: "Blossom Steele",
          clientImage: "assets/images/welcome_one.png",
          services: const ["Nail", "Facial", "Eyebrows"],
          serviceItems: const [
            ServiceItemDto(name: "Nail", price: 8.00),
            ServiceItemDto(name: "Facial", price: 24.99),
          ],
          subTotal: 32.99,
          platformFee: 4.94,
          totalAmount: 28.05,
        ),
      ),
      EarningDto(
        dateTime: DateTime(2025, 11, 16, 17, 30),
        clientName: "Gina Apple",
        clientImage: "assets/images/welcome_two.png",
        services: const ["Regular Haircut", "Body Glowing"],
        serviceItems: const [
          ServiceItemDto(name: "Regular Haircut", price: 35.00),
          ServiceItemDto(name: "Body Glowing", price: 32.99),
        ],
        subTotal: 67.99,
        platformFee: 13.00,
        totalAmount: 54.99,
      ),
      if (selectedFilter == Strings.thisYearText) ...[
        EarningDto(
          dateTime: DateTime(2025, 10, 05, 10, 30),
          clientName: "John Doe",
          clientImage: "assets/images/welcome_three.png",
          services: const ["Hair Cut"],
          serviceItems: const [ServiceItemDto(name: "Hair Cut", price: 20.00)],
          subTotal: 20.00,
          platformFee: 3.00,
          totalAmount: 17.00,
        ),
      ]
    ];
  }

  List<PayoutDto> _getMockPayouts() {
    return [
      PayoutDto(
        dateTime: DateTime(2025, 11, 12, 20, 0),
        accountNumber: "******* 2345",
        amount: 740.00,
      ),
      PayoutDto(
        dateTime: DateTime(2025, 11, 12, 20, 0),
        accountNumber: "******* 2345",
        amount: 105.50,
      ),
    ];
  }

  Map<String, List<EarningModel>> _groupEarningsByMonth(List<EarningModel> earnings) {
    Map<String, List<EarningModel>> groups = {};
    for (var earning in earnings) {
      String month = DateFormat('MMMM yyyy').format(earning.dateTime);
      if (!groups.containsKey(month)) {
        groups[month] = [];
      }
      groups[month]!.add(earning);
    }
    return groups;
  }

  Map<String, List<PayoutModel>> _groupPayoutsByMonth(List<PayoutModel> payouts) {
    Map<String, List<PayoutModel>> groups = {};
    for (var payout in payouts) {
      String month = DateFormat('MMMM yyyy').format(payout.dateTime);
      if (!groups.containsKey(month)) {
        groups[month] = [];
      }
      groups[month]!.add(payout);
    }
    return groups;
  }
}

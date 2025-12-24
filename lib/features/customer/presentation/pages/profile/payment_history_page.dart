import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

import 'package:intl/intl.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/customer/domain/entities/payment_history_model.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_dropdown_field.dart';

class CustomerPaymentHistoryPage extends StatelessWidget {
  const CustomerPaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> selectedFilterNotifier =
        ValueNotifier<String>(Strings.thisWeekText);
    final List<String> filters = [
      Strings.thisWeekText,
      Strings.thisMonthText,
      Strings.thisYearText
    ];

    final List<PaymentHistoryModel> paymentHistory = [
      PaymentHistoryModel(
        dateTime: DateTime(2025, 12, 24, 20, 0),
        date: "24 December 2025 - 08:00 PM",
        salonName: "Bloom & Blade",
        category: "Salon",
        address: "6391 Elgin St. Celina, Delaware...",
        services: "Nail, Facial, Eyebrows",
        amount: r"$28.05",
        image: "assets/images/salon_one.png",
        serviceList: [
          ServiceItemModel(name: "Nail", price: 8.00),
          ServiceItemModel(name: "Facial", price: 24.99),
        ],
      ),
      PaymentHistoryModel(
        dateTime: DateTime(2025, 12, 22, 17, 30),
        date: "22 December 2025 - 05:30 PM",
        salonName: "Raven & Rose",
        category: "Individual Service Provider",
        address: "4820 Maple Ave. Celina, Delaware...",
        services: "Regular Haircut, Body Glowing",
        amount: r"$54.99",
        image: "assets/images/salon_two.png",
        serviceList: [
          ServiceItemModel(name: "Regular Haircut", price: 35.00),
          ServiceItemModel(name: "Body Glowing", price: 19.99),
        ],
      ),
      // Mock data for "This Month" (December)
      PaymentHistoryModel(
        dateTime: DateTime(2025, 12, 10, 10, 00),
        date: "10 December 2025 - 10:00 AM",
        salonName: "Glow Parlor",
        category: "Salon",
        address: "123 Main St. Springfield...",
        services: "Skin Care",
        amount: r"$40.00",
        image: "assets/images/salon_three.png",
        serviceList: [
          ServiceItemModel(name: "Skin Care", price: 40.00),
        ],
      ),
      // Mock data for "This Year" (November)
      PaymentHistoryModel(
        dateTime: DateTime(2025, 11, 15, 14, 00),
        date: "15 November 2025 - 02:00 PM",
        salonName: "Style Studio",
        category: "Salon",
        address: "456 Oak Rd. Metropolis...",
        services: "Hair Cut",
        amount: r"$30.00",
        image: "assets/images/salon_one.png",
        serviceList: [
          ServiceItemModel(name: "Hair Cut", price: 30.00),
        ],
      ),
      // Mock data for "This Year" (October)
      PaymentHistoryModel(
        dateTime: DateTime(2025, 10, 05, 09, 00),
        date: "05 October 2025 - 09:00 AM",
        salonName: "Eco Salon",
        category: "Salon",
        address: "789 Pine Ln. Gotham...",
        services: "Mani-Pedi",
        amount: r"$60.00",
        image: "assets/images/salon_two.png",
        serviceList: [
          ServiceItemModel(name: "Mani-Pedi", price: 60.00),
        ],
      ),
    ];

    return CommonScaffoldWidget(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      bgColor: AppColors.whiteTwo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacing(20),
          _buildHeader(),
          const VerticalSpacing(10),
          ValueListenableBuilder<String>(
            valueListenable: selectedFilterNotifier,
            builder: (context, selectedFilter, child) {
              final filteredHistory =
                  _getFilteredHistory(selectedFilter, paymentHistory);

              return Expanded(
                child: Column(
                  children: [
                    _buildFilterDropdown(
                        context, selectedFilter, filters, selectedFilterNotifier),
                    const VerticalSpacing(10),
                    Expanded(
                      child: _buildHistoryList(context, selectedFilter, filteredHistory),
                    ),
                  ],
                ),
              );
            },
          ),
          const VerticalSpacing(20),
        ],
      ),
    );
  }

  List<PaymentHistoryModel> _getFilteredHistory(
      String filter, List<PaymentHistoryModel> allHistory) {
    final now = DateTime.now();
    if (filter == Strings.thisWeekText) {
      final startOfWeek = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: now.weekday - 1));
      return allHistory
          .where((item) =>
              item.dateTime.isAfter(startOfWeek) ||
              item.dateTime.isAtSameMomentAs(startOfWeek))
          .toList();
    } else if (filter == Strings.thisMonthText) {
      return allHistory
          .where((item) =>
              item.dateTime.year == now.year && item.dateTime.month == now.month)
          .toList();
    } else if (filter == Strings.thisYearText) {
      return allHistory.where((item) => item.dateTime.year == now.year).toList();
    }
    return allHistory;
  }

  Map<String, List<PaymentHistoryModel>> _groupHistoryByMonth(
      List<PaymentHistoryModel> history) {
    Map<String, List<PaymentHistoryModel>> groups = {};
    for (var item in history) {
      String month = DateFormat('MMMM yyyy').format(item.dateTime);
      if (!groups.containsKey(month)) {
        groups[month] = [];
      }
      groups[month]!.add(item);
    }
    return groups;
  }

  Widget _buildHistoryList(BuildContext context, String selectedFilter,
      List<PaymentHistoryModel> history) {
    if (selectedFilter == Strings.thisYearText) {
      final groupedHistory = _groupHistoryByMonth(history);
      return ListView(
        physics: const BouncingScrollPhysics(),
        children: groupedHistory.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CommonText(
                  entry.key,
                  fontSize: 16,
                  fontWeight: 700.0,
                  color: AppColors.blackTwo,
                ),
              ),
              ...entry.value.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _buildHistoryItem(context, item),
                  )),
            ],
          );
        }).toList(),
      );
    }

    return ListView.separated(
      itemCount: history.length,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => const VerticalSpacing(20),
      itemBuilder: (context, index) {
        final item = history[index];
        return _buildHistoryItem(context, item);
      },
    );
  }

  Widget _buildFilterDropdown(BuildContext context, String selectedFilter,
      List<String> filters, ValueNotifier<String> notifier) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: context.width * 0.34,
        child: CommonDropdownField<String>(
          value: selectedFilter,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                child:
                    CommonText(filter, fontSize: 13, color: AppColors.blackTwo),
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
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: AppColors.whiteOne,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.greyOne)),
            child: const Center(
              child: Icon(
                CupertinoIcons.chevron_back,
                color: AppColors.blackTwo,
              ),
            ),
          ),
        ),
        const HorizontalSpacing(15),
        const CommonText(
          "Payment History",
          fontSize: 24,
          fontWeight: 600,
          color: AppColors.blackTwo,
        ),
      ],
    );
  }

  Widget _buildHistoryItem(BuildContext context, PaymentHistoryModel item) {
    return GestureDetector(
      onTap: () => _showPaymentDetails(context, item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.whiteOne,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.greyOne),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  item.date,
                  fontSize: 16,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                ),
                const VerticalSpacing(12),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        item.image,
                        width: 90,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 70,
                          height: 70,
                          color: AppColors.greyOne,
                          child: const Icon(Icons.image, color: AppColors.greyTwo),
                        ),
                      ),
                    ),
                    const HorizontalSpacing(16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            item.category,
                            fontSize: 12,
                            fontWeight: 400,
                            color: AppColors.pinkTwo,
                          ),
                          const VerticalSpacing(20),
                          CommonText(
                            item.salonName,
                            fontSize: 18,
                            fontWeight: 600,
                            color: AppColors.blackTwo,
                          ),
                          const VerticalSpacing(10),
                          CommonText(
                            item.address,
                            fontSize: 12,
                            fontWeight: 400,
                            color: AppColors.greyTwo,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          const VerticalSpacing(8),
                        ],
                      ),
                    ),
                  ],
                ),
                VerticalSpacing(10),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Services: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackTwo,
                          fontFamily: Strings.fontFamily
                        ),
                      ),
                      TextSpan(
                        text: item.services,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.pinkTwo,
                          fontFamily: Strings.fontFamily
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpacing(10),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Paid: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackTwo,
                          fontFamily: Strings.fontFamily
                        ),
                      ),
                      TextSpan(
                        text: item.amount,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.pinkTwo,
                          fontFamily: Strings.fontFamily
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentDetails(BuildContext context, PaymentHistoryModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.greyOne,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const VerticalSpacing(24),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80,
                    height: 80,
                    color: AppColors.greyOne,
                    child: const Icon(Icons.image, color: AppColors.greyTwo),
                  ),
                ),
              ),
              const VerticalSpacing(16),
              CommonText(
                item.salonName,
                fontSize: 18,
                fontWeight: 600,
                color: AppColors.blackTwo,
              ),
              const VerticalSpacing(4),
              CommonText(
                item.address,
                fontSize: 12,
                fontWeight: 400,
                color: AppColors.greyTwo,
                textAlign: TextAlign.center,
              ),
              const VerticalSpacing(24),
              _buildDetailRow("Date & Time", item.date.split(' - ').first,
                  valueColor: AppColors.pinkTwo),
              const VerticalSpacing(24),
              const Align(
                alignment: Alignment.centerLeft,
                child: CommonText(
                  "Services",
                  fontSize: 16,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                ),
              ),
              const VerticalSpacing(12),
              ...item.serviceList
                  .map((s) => Column(
                        children: [
                          _buildDetailRow(s.name, "\$${s.price.toStringAsFixed(2)}",
                              labelColor: AppColors.greyTwo,
                              valueColor: AppColors.pinkTwo),
                          const VerticalSpacing(12),
                        ],
                      )),
              const Divider(color: AppColors.greyOne),
              const VerticalSpacing(12),
              _buildDetailRow("Total", item.amount,
                  fontSize: 22,
                  fontWeight: 700,
                  labelColor: AppColors.blackTwo,
                  valueColor: AppColors.pinkTwo),
              const VerticalSpacing(20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value,
      {Color? labelColor,
      Color? valueColor,
      double fontSize = 14,
      double fontWeight = 500}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          label,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: labelColor ?? AppColors.blackTwo,
        ),
        CommonText(
          value,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: valueColor ?? AppColors.blackTwo,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_bottom_sheet_component.dart';

import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class UpcomingAppointmentListComponent extends StatelessWidget {
  const UpcomingAppointmentListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appointments = [
      {
        "date": "12 November 2025",
        "time": "09:00 AM",
        "professionalName": "Blossom Steele",
        "services": "Nail, Facial",
        "imagePath": Assets.welcomeOne,
        "reminder": ValueNotifier(true),
        "serviceDetails": [
          {"name": "Nail", "price": "8.00"},
          {"name": "Facial", "price": "24.99"},
        ],
        "subTotal": "32.99",
        "platformFee": "4.95",
        "grandTotal": "28.05",
      },
      {
        "date": "16 November 2025",
        "time": "05:30 PM",
        "professionalName": "Gina Apple",
        "services": "Regular Haircut, Body Glowing",
        "imagePath": Assets.welcomeOne,
        "reminder": ValueNotifier(false),
        "serviceDetails": [
          {"name": "Regular Haircut", "price": "15.00"},
          {"name": "Body Glowing", "price": "35.00"},
        ],
        "subTotal": "50.00",
        "platformFee": "4.99",
        "grandTotal": "54.99",
      },
    ];
    return ListView.separated(
      itemCount: appointments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const VerticalSpacing(15),
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return _UpcomingAppointmentCardComponent(
          date: appointment['date'],
          time: appointment['time'],
          professionalName: appointment['professionalName'],
          services: appointment['services'],
          imagePath: appointment['imagePath'],
          isReminderEnabled: appointment['reminder'],
          appointmentData: appointment,
        );
      },
    );
  }
}

class _UpcomingAppointmentCardComponent extends StatelessWidget {
  final String date;
  final String time;
  final String professionalName;
  final String services;
  final String imagePath;
  final ValueNotifier<bool> isReminderEnabled;
  final Function(bool)? onReminderChanged;
  final Map<String, dynamic> appointmentData;

  const _UpcomingAppointmentCardComponent({
    required this.date,
    required this.time,
    required this.professionalName,
    required this.services,
    this.imagePath = Assets.welcomeOne,
    this.onReminderChanged,
    required this.isReminderEnabled,
    required this.appointmentData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CommonBottomSheet.show(
          context,
          title: '',
          maxChildSize: 0.9,
          initialChildSize: 0.85,
          minChildSize: 0.5,
          content: _UpcomingAppointmentDetailsSheet(
            appointmentData: appointmentData,
             // Pass the notifier to keep state sync if needed, or handle separately
            isReminderEnabled: isReminderEnabled,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.greyOne, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              "$date - $time",
              fontSize: 16,
              fontWeight: 600,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                HorizontalSpacing(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        professionalName,
                        fontSize: 18,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                      ),
                      VerticalSpacing(8),
                      RichText(
                        text: TextSpan(
                          text: "Services: ",
                          style: const TextStyle(
                            fontFamily: Strings.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackTwo,
                          ),
                          children: [
                            TextSpan(
                              text: services,
                              style: const TextStyle(
                                fontFamily: Strings.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.pinkTwo,
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
            VerticalSpacing(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isReminderEnabled,
                    builder: (context, value, child) {
                      return Switch(
                        value: value,
                        onChanged: (newValue) {
                          isReminderEnabled.value = newValue;
                          onReminderChanged?.call(newValue);
                        },
                        activeThumbColor: AppColors.whiteOne,
                        activeTrackColor: AppColors.pinkTwo,
                        inactiveThumbColor: AppColors.whiteOne,
                        inactiveTrackColor: AppColors.greyOne,
                        trackOutlineColor: WidgetStateProperty.all(
                          AppColors.transparent,
                        ),
                      );
                    },
                  ),
                ),
                HorizontalSpacing(5),
                CommonText(
                  "30 min before",
                  fontSize: 12,
                  fontWeight: 400,
                  color: AppColors.greyTwo,
                ),
                HorizontalSpacing(5),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: AppColors.blackTwo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UpcomingAppointmentDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> appointmentData;
  final ValueNotifier<bool> isReminderEnabled;

  const _UpcomingAppointmentDetailsSheet({
    required this.appointmentData,
    required this.isReminderEnabled,
  });

  @override
  Widget build(BuildContext context) {
    // Extracting data safely
    final String imagePath = appointmentData['imagePath'] ?? Assets.welcomeOne;
    final String professionalName = appointmentData['professionalName'] ?? 'Unknown';
    final String date = appointmentData['date'] ?? '';
    final String time = appointmentData['time'] ?? '';
    final List<Map<String, String>> serviceDetails = 
        (appointmentData['serviceDetails'] as List?)?.map((e) => Map<String, String>.from(e)).toList() ?? [];
    final String subTotal = appointmentData['subTotal'] ?? '0.00';
    final String platformFee = appointmentData['platformFee'] ?? '0.00';
    final String grandTotal = appointmentData['grandTotal'] ?? '0.00';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        VerticalSpacing(15),
        CommonText(
          professionalName,
          fontSize: 20,
          fontWeight: 700,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(20),
        Container(
          height: 50,
          width: 140,
          decoration: BoxDecoration(
            color: AppColors.blackThree, 
            borderRadius: BorderRadius.circular(16)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Icons.chat_bubble_outline, color: AppColors.whiteOne, size: 20),
               HorizontalSpacing(8),
               CommonText(
                 "Chat",
                 color: AppColors.whiteOne,
                 fontSize: 16,
                 fontWeight: 500,
               )
            ],
          ),
        ),
        VerticalSpacing(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              "Date & Time",
              fontSize: 16,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            CommonText(
              "$date, $time",
              fontSize: 16,
              fontWeight: 600,
              color: AppColors.pinkTwo, 
            ),
          ],
        ),
        VerticalSpacing(20),
        Align(
          alignment: Alignment.centerLeft,
          child: CommonText(
            "Services",
            fontSize: 16,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
        ),
        VerticalSpacing(10),
        ...serviceDetails.map((service) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                service['name'] ?? '',
                fontSize: 16,
                fontWeight: 400,
                color: AppColors.blackTwo,
              ),
              CommonText(
                "\$${service['price']}", // Assuming $ based on image, user prompt showed R in others but image shows $
                fontSize: 16,
                fontWeight: 600,
                color: AppColors.pinkTwo,
              ),
            ],
          ),
        )),
        Divider(color: AppColors.greyOne),
        VerticalSpacing(10),
        _buildPriceRow("Sub Total", "\$$subTotal"),
        VerticalSpacing(10),
        _buildPriceRow("Platform Fee (15%)", "\$$platformFee"),
        VerticalSpacing(10),
        Divider(color: AppColors.greyOne),
        VerticalSpacing(10),
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                "Grand Total",
                fontSize: 20,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
              CommonText(
                "\$$grandTotal",
                fontSize: 24,
                fontWeight: 700,
                color: AppColors.pinkTwo,
              ),
            ],
        ),
        VerticalSpacing(20),
        Align(
          alignment: Alignment.centerLeft,
          child: CommonText(
            "Notes",
            fontSize: 16,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
        ),
        VerticalSpacing(10),
        CommonText(
          "Lorem ipsum dolor sit amet consectetur. Cras tincidunt purus sed scelerisque.",
          fontSize: 14,
          fontWeight: 400,
          color: AppColors.blackTwo,
          textAlign: TextAlign.start,
          textOverflow: TextOverflow.visible,
          maxLines: 3,
        ),
        VerticalSpacing(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
               children: [
                  Transform.scale(
                    scale: 0.8,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: isReminderEnabled,
                      builder: (context, value, child) {
                        return Switch(
                          value: value,
                          onChanged: (newValue) {
                            isReminderEnabled.value = newValue;
                          },
                          activeThumbColor: AppColors.whiteOne,
                          activeTrackColor: AppColors.pinkTwo,
                          inactiveThumbColor: AppColors.whiteOne,
                          inactiveTrackColor: AppColors.greyOne,
                          trackOutlineColor: WidgetStateProperty.all(
                            AppColors.transparent,
                          ),
                        );
                      },
                    ),
                  ),
                  HorizontalSpacing(5),
                   CommonText(
                    "30 min before",
                    fontSize: 14,
                    fontWeight: 400,
                    color: AppColors.blackTwo,
                  ),
                   HorizontalSpacing(5),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: AppColors.blackTwo,
                  ),
               ],
             ),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(color: AppColors.greyTwo)
               ),
               child: CommonText(
                 "Service Completed",
                 fontSize: 14,
                 fontWeight: 500,
                 color: AppColors.blackTwo,
               ),
             )
          ],
        ),
         VerticalSpacing(30),
      ],
    );
  }

  Widget _buildPriceRow(String label, String price) {
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
          price,
          fontSize: 16,
          fontWeight: 600,
          color: AppColors.pinkTwo,
        ),
      ],
    );
  }
}

class PreviousAppointmentListComponent extends StatelessWidget {
  const PreviousAppointmentListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String,dynamic>> appointments = [
      {
        "date": "12 November 2025",
        "time": "09:00 AM",
        "professionalName": "Blossom Steele",
        "services": "Nail, Facial",
        "review": 5,
        "earn": "R28.05",
        "imagePath": Assets.welcomeOne,
        "serviceDetails": [
          {"name": "Nail", "price": "8.00"},
          {"name": "Facial", "price": "24.99"},
        ],
        "subTotal": "32.99",
        "platformFee": "4.95",
        "grandTotal": "28.05",
        "notes": "Lorem ipsum dolor sit amet consectetur. Cras tincidunt purus sed scelerisque.",
        "reviewText": "The place was clean, great serivce, stall are friendly. I will certainly recommend to my friends and visit again! ;)",
      },
      {
        "date": "16 November 2025",
        "time": "05:30 PM",
        "professionalName": "Gina Apple",
        "services": "Regular Haircut, Body Glowing",
        "review": 5,
        "earn": "R54.99",
        "imagePath": Assets.welcomeOne,
        "serviceDetails": [
          {"name": "Regular Haircut", "price": "15.00"},
          {"name": "Body Glowing", "price": "35.00"},
        ],
        "subTotal": "50.00",
        "platformFee": "4.99",
        "grandTotal": "54.99",
        "notes": "Great service!",
        "reviewText": "Absolutely loved it!",
      },
    ];
    return ListView.separated(
      itemCount: appointments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const VerticalSpacing(15),
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return _PreviousAppointmentCardComponent(
          date: appointment['date'],
          time: appointment['time'],
          professionalName: appointment['professionalName'],
          services: appointment['services'],
          review: appointment['review'],
          earning: appointment['earn'],
          imagePath: appointment['imagePath'],
          appointmentData: appointment,
        );
      },
    );
  }
}

class _PreviousAppointmentCardComponent extends StatelessWidget {
  const _PreviousAppointmentCardComponent({
    required this.date,
    required this.time,
    required this.professionalName,
    required this.services,
    required this.review,
    required this.earning,
    this.imagePath = Assets.welcomeOne,
    required this.appointmentData,
  });

  final String date;
  final String time;
  final String professionalName;
  final String services;
  final String imagePath;
  final int review;
  final String earning;
  final Map<String, dynamic> appointmentData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CommonBottomSheet.show(
          context,
          title: '',
          maxChildSize: 0.9,
          initialChildSize: 0.85,
          minChildSize: 0.5,
          content: _PreviousAppointmentDetailsSheet(
            appointmentData: appointmentData,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.greyOne, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              "$date - $time",
              fontSize: 16,
              fontWeight: 600,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                HorizontalSpacing(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        professionalName,
                        fontSize: 18,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                      ),
                      VerticalSpacing(8),
                      RichText(
                        text: TextSpan(
                          text: "Services: ",
                          style: const TextStyle(
                            fontFamily: Strings.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackTwo,
                          ),
                          children: [
                            TextSpan(
                              text: services,
                              style: const TextStyle(
                                fontFamily: Strings.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.pinkTwo,
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalSpacing(8),
                      Row(
                        children: [
                          const CommonText(
                            "Review: ",
                            fontSize: 16,
                            fontWeight: 500,
                            color: AppColors.blackTwo,
                          ),
                          const HorizontalSpacing(5),
                          ...List.generate(review, (index) => const Icon(
                            Icons.star,
                            size: 18,
                            color: AppColors.yellowOne,
                          )),
                        ],
                      ),
                      VerticalSpacing(8),
                      RichText(
                        text: TextSpan(
                          text: "Earn: ",
                          style: const TextStyle(
                            fontFamily: Strings.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackTwo,
                          ),
                          children: [
                            TextSpan(
                              text: earning,
                              style: const TextStyle(
                                fontFamily: Strings.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.pinkTwo,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            VerticalSpacing(10),
          ],
        ),
      ),
    );
  }
}

class _PreviousAppointmentDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> appointmentData;

  const _PreviousAppointmentDetailsSheet({
    required this.appointmentData,
  });

  @override
  Widget build(BuildContext context) {
    // Extracting data safely
    final String imagePath = appointmentData['imagePath'] ?? Assets.welcomeOne;
    final String professionalName = appointmentData['professionalName'] ?? 'Unknown';
    final String date = appointmentData['date'] ?? '';
    final String time = appointmentData['time'] ?? '';
    final List<Map<String, String>> serviceDetails =
        (appointmentData['serviceDetails'] as List?)?.map((e) => Map<String, String>.from(e)).toList() ?? [];
    final String subTotal = appointmentData['subTotal'] ?? '0.00';
    final String platformFee = appointmentData['platformFee'] ?? '0.00';
    final String grandTotal = appointmentData['grandTotal'] ?? '0.00';
    final String notes = appointmentData['notes'] ?? '';
    final int review = appointmentData['review'] ?? 5;
    final String reviewText = appointmentData['reviewText'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        VerticalSpacing(15),
        CommonText(
          professionalName,
          fontSize: 20,
          fontWeight: 700,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              "Date & Time",
              fontSize: 16,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            CommonText(
              "$date, $time", // Assuming formatting matches design requirement
              fontSize: 16,
              fontWeight: 600,
              color: AppColors.pinkTwo,
            ),
          ],
        ),
        VerticalSpacing(20),
        Align(
          alignment: Alignment.centerLeft,
          child: CommonText(
            "Services",
            fontSize: 16,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
        ),
        VerticalSpacing(10),
        ...serviceDetails.map((service) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                service['name'] ?? '',
                fontSize: 16,
                fontWeight: 400,
                color: AppColors.blackTwo,
              ),
              CommonText(
                "\$${service['price']}",
                fontSize: 16,
                fontWeight: 600,
                color: AppColors.pinkTwo,
              ),
            ],
          ),
        )),
        Divider(color: AppColors.greyOne),
        VerticalSpacing(10),
        _buildPriceRow("Sub Total", "\$$subTotal"),
        VerticalSpacing(10),
        _buildPriceRow("Platform Fee (15%)", "\$$platformFee"),
        VerticalSpacing(10),
        Divider(color: AppColors.greyOne),
        VerticalSpacing(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              "Grand Total",
              fontSize: 20,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            CommonText(
              "\$$grandTotal",
              fontSize: 24,
              fontWeight: 700,
              color: AppColors.pinkTwo,
            ),
          ],
        ),
        VerticalSpacing(20),
        Align(
          alignment: Alignment.centerLeft,
          child: CommonText(
            "Notes",
            fontSize: 16,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
        ),
        VerticalSpacing(10),
        CommonText(
          notes,
          fontSize: 14,
          fontWeight: 400,
          color: AppColors.blackTwo,
          textAlign: TextAlign.start,
          textOverflow: TextOverflow.visible,
          maxLines: 3,
        ),
        VerticalSpacing(20),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              CommonText(
                "Review",
                fontSize: 16,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
              HorizontalSpacing(10),
              ...List.generate(review, (index) => const Icon(
                Icons.star,
                size: 18,
                color: AppColors.yellowOne,
              )),
            ],
          ),
        ),
        VerticalSpacing(10),
        CommonText(
          reviewText,
          fontSize: 14,
          fontWeight: 400,
          color: AppColors.greyTwo,
          textAlign: TextAlign.start,
          textOverflow: TextOverflow.visible,
          maxLines: 4,
        ),
        VerticalSpacing(30),
      ],
    );
  }

  Widget _buildPriceRow(String label, String price) {
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
          price,
          fontSize: 16,
          fontWeight: 600,
          color: AppColors.pinkTwo,
        ),
      ],
    );
  }
}

class CancelledAppointmentListComponent extends StatelessWidget {
  const CancelledAppointmentListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appointments = [
      {
        "date": "12 November 2025",
        "time": "09:00 AM",
        "professionalName": "Blossom Steele",
        "services": "Nail, Facial",
        "imagePath": Assets.welcomeOne,
        "serviceDetails": [
          {"name": "Nail", "price": "5.00"},
          {"name": "Facial", "price": "3.12"},
        ],
        "notes": "Lorem ipsum dolor sit amet consectetur. Cras tincidunt purus sed scelerisque.",
      },
      {
        "date": "16 November 2025",
        "time": "05:30 PM",
        "professionalName": "Gina Apple",
        "services": "Regular Haircut, Body Glowing",
        "imagePath": Assets.welcomeOne,
        "serviceDetails": [
          {"name": "Regular Haircut", "price": "15.00"},
          {"name": "Body Glowing", "price": "35.00"},
        ],
        "notes": "Cancelled by user.",
      },
    ];
    return ListView.separated(
      itemCount: appointments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const VerticalSpacing(15),
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return _CancelledAppointmentCardComponent(
          date: appointment['date'],
          time: appointment['time'],
          professionalName: appointment['professionalName'],
          services: appointment['services'],
          imagePath: appointment['imagePath'],
          appointmentData: appointment,
        );
      },
    );
  }
}

class _CancelledAppointmentCardComponent extends StatelessWidget {
  const _CancelledAppointmentCardComponent({
    required this.date,
    required this.time,
    required this.professionalName,
    required this.services,
    this.imagePath = Assets.welcomeOne,
    required this.appointmentData,
  });

  final String date;
  final String time;
  final String professionalName;
  final String services;
  final String imagePath;
  final Map<String, dynamic> appointmentData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CommonBottomSheet.show(
          context,
          title: '',
          maxChildSize: 0.8,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          content: _CancelledAppointmentDetailsSheet(
            appointmentData: appointmentData,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.greyOne, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              "$date - $time",
              fontSize: 16,
              fontWeight: 600,
              color: AppColors.blackTwo,
            ),
            VerticalSpacing(15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                HorizontalSpacing(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        professionalName,
                        fontSize: 18,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                      ),
                      VerticalSpacing(8),
                      RichText(
                        text: TextSpan(
                          text: "Services: ",
                          style: const TextStyle(
                            fontFamily: Strings.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackTwo,
                          ),
                          children: [
                            TextSpan(
                              text: services,
                              style: const TextStyle(
                                fontFamily: Strings.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.pinkTwo,
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
            VerticalSpacing(10),
          ],
        ),
      ),
    );
  }
}

class _CancelledAppointmentDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> appointmentData;

  const _CancelledAppointmentDetailsSheet({
    required this.appointmentData,
  });

  @override
  Widget build(BuildContext context) {
    // Extracting data safely
    final String imagePath = appointmentData['imagePath'] ?? Assets.welcomeOne;
    final String professionalName = appointmentData['professionalName'] ?? 'Unknown';
    final String date = appointmentData['date'] ?? '';
    final String time = appointmentData['time'] ?? '';
    final List<Map<String, String>> serviceDetails =
        (appointmentData['serviceDetails'] as List?)?.map((e) => Map<String, String>.from(e)).toList() ?? [];
    final String notes = appointmentData['notes'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        VerticalSpacing(15),
        CommonText(
          professionalName,
          fontSize: 20,
          fontWeight: 700,
          color: AppColors.blackTwo,
        ),
        VerticalSpacing(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              "Date & Time",
              fontSize: 16,
              fontWeight: 700,
              color: AppColors.blackTwo,
            ),
            CommonText(
              "$date, $time",
              fontSize: 16,
              fontWeight: 600,
              color: AppColors.pinkTwo,
            ),
          ],
        ),
        VerticalSpacing(20),
        Align(
          alignment: Alignment.centerLeft,
          child: CommonText(
            "Services",
            fontSize: 16,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
        ),
        VerticalSpacing(10),
        ...serviceDetails.map((service) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                service['name'] ?? '',
                fontSize: 16,
                fontWeight: 400,
                color: AppColors.blackTwo,
              ),
              CommonText(
                "\$${service['price']}",
                fontSize: 16,
                fontWeight: 600,
                color: AppColors.pinkTwo,
              ),
            ],
          ),
        )),
        VerticalSpacing(20),
        Align(
          alignment: Alignment.centerLeft,
          child: CommonText(
            "Notes",
            fontSize: 16,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
        ),
        VerticalSpacing(10),
        CommonText(
          notes,
          fontSize: 14,
          fontWeight: 400,
          color: AppColors.blackTwo,
          textAlign: TextAlign.start,
          textOverflow: TextOverflow.visible,
          maxLines: 3,
        ),
        VerticalSpacing(30),
      ],
    );
  }
}

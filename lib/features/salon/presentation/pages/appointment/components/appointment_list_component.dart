import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';


class UpcomingAppointmentListComponent extends StatelessWidget {
  const UpcomingAppointmentListComponent({super.key});


  @override
  Widget build(BuildContext context) {
    final List<Map<String,dynamic>> appointments = [
      {
        "date": "12 November 2025",
        "time": "09:00 AM",
        "professionalName": "Blossom Steele",
        "services": "Nail, Facial",
        "imagePath": Assets.welcomeOne,
        "reminder": ValueNotifier(true),
      },
      {
        "date": "16 November 2025",
        "time": "05:30 PM",
        "professionalName": "Gina Apple",
        "services": "Regular Haircut, Body Glowing",
        "imagePath": Assets.welcomeOne,
        "reminder": ValueNotifier(false),
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

  const _UpcomingAppointmentCardComponent({
    required this.date,
    required this.time,
    required this.professionalName,
    required this.services,
    this.imagePath = Assets.welcomeOne,
    this.onReminderChanged,
    required this.isReminderEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(
          24
        ),
        border: Border.all(
          color: AppColors.greyOne, 
          width: 1,
        ),
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
              )
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
                        AppColors.transparent
                      ),
                    );
                  }
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
                color: AppColors.blackTwo
              )
            ],
          )
        ],
      ),
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
      },
      {
        "date": "16 November 2025",
        "time": "05:30 PM",
        "professionalName": "Gina Apple",
        "services": "Regular Haircut, Body Glowing",
        "review": 5,
        "earn": "R54.99",
        "imagePath": Assets.welcomeOne,
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

  });

  final String date;
  final String time;
  final String professionalName;
  final String services;
  final String imagePath;
  final int review;
  final String earning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(
            24
        ),
        border: Border.all(
          color: AppColors.greyOne,
          width: 1,
        ),
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
                    VerticalSpacing(20),
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
                    VerticalSpacing(2),
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
    );
  }
}

class CancelledAppointmentListComponent extends StatelessWidget {
  const CancelledAppointmentListComponent({super.key});


  @override
  Widget build(BuildContext context) {
    final List<Map<String,dynamic>> appointments = [
      {
        "date": "12 November 2025",
        "time": "09:00 AM",
        "professionalName": "Blossom Steele",
        "services": "Nail, Facial",
        "imagePath": Assets.welcomeOne,
      },
      {
        "date": "16 November 2025",
        "time": "05:30 PM",
        "professionalName": "Gina Apple",
        "services": "Regular Haircut, Body Glowing",
        "imagePath": Assets.welcomeOne,
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

  });

  final String date;
  final String time;
  final String professionalName;
  final String services;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(
          24
        ),
        border: Border.all(
          color: AppColors.greyOne,
          width: 1,
        ),
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
              )
            ],
          ),
          VerticalSpacing(10),
        ],
      ),
    );
  }
}
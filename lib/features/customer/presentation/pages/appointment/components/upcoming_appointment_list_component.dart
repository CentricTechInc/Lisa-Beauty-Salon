import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/appointment/components/upcoming_appointment_card.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/appointment/components/upcoming_appointment_detail_bottom_sheet.dart';

class UpcomingAppointmentListComponent extends StatelessWidget {

  const UpcomingAppointmentListComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        6,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: UpcomingAppointmentCard(
            salonName: "Bloom & Blade",
            date: "12 November 2025 - 09:00 AM",
            image: Assets.salonOne,
          ),
        ),
      ),
    );
  }
}

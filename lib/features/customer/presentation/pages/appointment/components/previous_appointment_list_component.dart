import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/appointment/components/previous_appointment_card.dart';

class PreviousAppointmentListComponent extends StatelessWidget {
  const PreviousAppointmentListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        6,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PreviousAppointmentCard(
            salonName: index == 0 ? "Bloom & Blade" : "Green Apple",
            date: index == 0
                ? "12 November 2025 - 08:00 PM"
                : "16 November 2025 - 05:30 PM",
            image: index == 0 ? Assets.salonOne : Assets.salonTwo,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package_card.dart';

class PackageTab extends StatelessWidget {
  const PackageTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> packages = [
      {
        'name': 'Bridal Beauty Makeup',
        'description': 'Complete Package Offer',
        'price': '\$120.00',
        'image': Assets.salonOne,
        'about': 'Our Bridal Beauty Makeup package is designed to make you look stunning on your special day. It includes a consultation, trial makeup session, and the final look on your wedding day using high-quality products that last all through the night.',
        'services': [
          'Full Face Makeup',
          'Lash Application',
          'Hair Styling',
          'Bridal Consultation',
          'Long-wear Foundation',
          'Traditional/Airbrush'
        ],
      },
      {
        'name': 'Hair Style & Blow-dry',
        'description': 'Monthly Package Offer',
        'price': '\$80.00',
        'image': Assets.salonTwo,
        'about': 'Get the perfect hair every time with our monthly Hair Style & Blow-dry package. Whether it\'s for work, an event, or just because you deserve it, our stylists will ensure you leave feeling like a star.',
        'services': [
          'Hair Wash',
          'Scalp Massage',
          'Deep Conditioning',
          'Professional Blow-dry',
          'Heated Styling',
          'Finishing Products'
        ],
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          ...packages.map((package) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PackageCard(package: package),
              )),
        ],
      ),
    );
  }
}

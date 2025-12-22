import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'gallery_image.dart';

class GalleryTab extends StatelessWidget {
  const GalleryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> galleryImages = [
      {'image': Assets.welcomeOne, 'height': 200.0},
      {'image': Assets.welcomeTwo, 'height': 240.0},
      {'image': Assets.welcomeThree, 'height': 160.0},
      {'image': Assets.salonOne, 'height': 280.0},
      {'image': Assets.salonTwo, 'height': 220.0},
      {'image': Assets.welcomeOne, 'height': 180.0},
      {'image': Assets.welcomeTwo, 'height': 260.0},
      {'image': Assets.salonOne, 'height': 150.0},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            child: Column(
              children: [
                GalleryImage(image: galleryImages[0]['image'] as String, height: 200),
                VerticalSpacing(2),
                GalleryImage(image: galleryImages[2]['image'] as String, height: 160),
                VerticalSpacing(2),
                GalleryImage(image: galleryImages[4]['image'] as String, height: 220),
                VerticalSpacing(2),
                GalleryImage(image: galleryImages[6]['image'] as String, height: 260),
              ],
            ),
          ),
          HorizontalSpacing(2),
          // Right Column
          Expanded(
            child: Column(
              children: [
                GalleryImage(image: galleryImages[1]['image'] as String, height: 240),
                VerticalSpacing(2),
                GalleryImage(image: galleryImages[3]['image'] as String, height: 280),
                VerticalSpacing(2),
                GalleryImage(image: galleryImages[5]['image'] as String, height: 180),
                VerticalSpacing(2),
                GalleryImage(image: galleryImages[7]['image'] as String, height: 140),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';

class SalonHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String imagePath;
  final double expandedHeight;

  SalonHeaderDelegate({required this.imagePath, this.expandedHeight = 280});

  @override
  double get minExtent => 120;

  @override
  double get maxExtent => expandedHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(imagePath, fit: BoxFit.cover),

        Container(color: Colors.black.withValues(alpha: 0.25)),

        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.whiteOne,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chevron_left, 
                      color: AppColors.blackTwo
                    ),
                  ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.whiteOne,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.sync, color: AppColors.blackTwo),
                ),
              ),
            ],
          ),
        ),

        // bottom rounded edge
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 20,
            decoration: const BoxDecoration(
              color: AppColors.whiteOne,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SalonHeaderDelegate oldDelegate) {
    return oldDelegate.imagePath != imagePath;
  }
}

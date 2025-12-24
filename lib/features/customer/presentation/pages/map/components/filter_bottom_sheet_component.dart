

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/custom_slider_thumb_circle.dart';

import '../../../../../../core/themes/theme.dart';

class FilterBottomSheetComponent extends StatefulWidget {
  const FilterBottomSheetComponent();

  @override
  State<FilterBottomSheetComponent> createState() => _FilterBottomSheetComponentState();
}

class _FilterBottomSheetComponentState extends State<FilterBottomSheetComponent> {
  int selectedServiceIndex = 1;
  int selectedCategoryIndex = 1; // 0: Individual, 1: Salons
  int selectedRating = 4;
  String selectedServiceFor = "For All";
  double distance = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.greyOne.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const VerticalSpacing(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: const CommonText(
                  "Cancel",
                  fontSize: 16,
                  fontWeight: 500,
                  color: AppColors.greyTwo,
                ),
              ),
              const CommonText(
                "Filter",
                fontSize: 24,
                fontWeight: 600,
                color: AppColors.blackTwo,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedServiceIndex = 0;
                    selectedCategoryIndex = 1;
                    selectedRating = 0;
                    selectedServiceFor = "For All";
                    distance = 20;
                  });
                },
                child: const CommonText(
                  "Reset",
                  fontSize: 16,
                  fontWeight: 500,
                  color: AppColors.pinkTwo,
                ),
              ),
            ],
          ),
          const VerticalSpacing(20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    "Services:",
                    fontSize: 16,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(12),
                  _buildServiceList(),
                  const VerticalSpacing(24),
                  const CommonText(
                    "Select Category",
                    fontSize: 16,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(16),
                  _buildCategorySelection(),
                  const VerticalSpacing(24),
                  const CommonText(
                    "Rating:",
                    fontSize: 16,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(12),
                  _buildRatingSelector(),
                  const VerticalSpacing(24),
                  const CommonText(
                    "Service For:",
                    fontSize: 16,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(12),
                  _buildServiceForSelector(),
                  const VerticalSpacing(24),
                  const CommonText(
                    "Distance:",
                    fontSize: 16,
                    fontWeight: 700,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(30),
                  _buildDistanceSlider(),
                ],
              ),
            ),
          ),
          const VerticalSpacing(20),
          CommonButton(
            onPressed: () => Get.back(),
            text: "Apply Filters",
            radius: 16,
            height: 56,
            textFontWeight: 700,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceList() {
    final services = ["All", "Haircuts", "Makeup", "Manicure", "Skin Care"];
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        separatorBuilder: (_, __) => const HorizontalSpacing(05),
        itemBuilder: (context, index) {
          final isSelected = selectedServiceIndex == index;
          return GestureDetector(
            onTap: () => setState(() => selectedServiceIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.pinkTwo : AppColors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: CommonText(
                services[index],
                fontSize: 14,
                fontWeight: isSelected ? 600 : 500,
                color: isSelected ? AppColors.whiteTwo : AppColors.greyTwo,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategorySelection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => selectedCategoryIndex = 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                "Individual Service Providers",
                fontSize: 16,
                fontWeight: 500,
                color: AppColors.blackTwo,
              ),
              Icon(
                selectedCategoryIndex == 0
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: selectedCategoryIndex == 0
                    ? AppColors.pinkTwo
                    : AppColors.greyOne,
              ),
            ],
          ),
        ),
        const VerticalSpacing(16),
        GestureDetector(
          onTap: () => setState(() => selectedCategoryIndex = 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                "Salons",
                fontSize: 16,
                color: AppColors.blackTwo,
              ),
              Icon(
                selectedCategoryIndex == 1
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: selectedCategoryIndex == 1
                    ? AppColors.pinkTwo
                    : AppColors.greyOne,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSelector() {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return GestureDetector(
            onTap: () => setState(() => selectedRating = index + 1),
            child: Icon(
              index < selectedRating ? Icons.star : Icons.star_border,
              color: index < selectedRating
                  ? AppColors.yellowOne
                  : AppColors.greyOne,
              size: 28,
            ),
          );
        }),
        const HorizontalSpacing(12),
        CommonText(
          "${selectedRating.toDouble()} Stars",
          fontSize: 16,
          fontWeight: 500,
          color: AppColors.blackTwo,
        ),
      ],
    );
  }

  Widget _buildServiceForSelector() {
    final options = ["For All", "Man", "Woman", "Kids"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: options.map((opt) {
        final isSelected = selectedServiceFor == opt;
        return GestureDetector(
          onTap: () => setState(() => selectedServiceFor = opt),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.pinkTwo : AppColors.whiteOne,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CommonText(
              opt,
              fontSize: 14,
              fontWeight: isSelected ? 600 : 500,
              color: isSelected ? AppColors.whiteOne : AppColors.greyTwo,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDistanceSlider() {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            thumbShape: const CustomSliderThumbCircle(
              thumbRadius: 15,
              min: 0,
              max: 100,
            ),
            activeTrackColor: AppColors.pinkTwo,
            inactiveTrackColor: AppColors.greyFour,
            overlayColor: AppColors.pinkTwo.withOpacity(0.1),
            trackHeight: 6,
          ),
          child: Slider(
            value: distance,
            min: 0,
            max: 100,
            onChanged: (val) {
              setState(() {
                distance = val;
              });
            },
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class SubServicesPage extends StatefulWidget {
  const SubServicesPage({super.key});

  @override
  State<SubServicesPage> createState() => _SubServicesPageState();
}

class _SubServicesPageState extends State<SubServicesPage> {
  final List<Map<String, dynamic>> subServices = [
    {
      "audience": "Woman",
      "title": "Hair Wash & Blow-Dry/Styling",
      "price": "\$3.12",
      "description":
          "Revitalize your look with a refreshing wash and blow-dry. Enjoy sleek, styled hair that shines and turns heads!",
      "isSelected": true,
    },
    {
      "audience": "Man",
      "title": "Haircut",
      "price": "\$25.00",
      "description":
          "Get a sharp haircut and a precise beard trim for a polished, fresh appearance.",
      "isSelected": false,
    },
    {
      "audience": "Man",
      "title": "Beard Trim",
      "price": "\$15.00",
      "description":
          "Get a sharp haircut and a precise beard trim for a polished, fresh appearance.",
      "isSelected": false,
    },
    {
      "audience": "Kids",
      "title": "Kids' Haircut",
      "price": "\$15.00",
      "description":
          "Fun and friendly haircut experience for kids, ensuring they leave with a smile and a stylish new look.",
      "isSelected": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      useSafeArea: true,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 20, 
                vertical: 20
              ),
              itemCount: subServices.length,
              separatorBuilder: (context, index) => VerticalSpacing(16),
              itemBuilder: (context, index) {
                final service = subServices[index];
                return _SubServiceCard(
                  audience: service['audience'] as String,
                  title: service['title'] as String,
                  price: service['price'] as String,
                  description: service['description'] as String,
                  isSelected: service['isSelected'] as bool,
                  onChanged: (val) {
                    setState(() {
                      subServices[index]['isSelected'] = val;
                    });
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteOne,
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackOne.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: CommonButton(
              onPressed: () => Get.back(),
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CommonText(
                    "Continue",
                    fontSize: 16,
                    fontWeight: 600,
                    color: AppColors.whiteOne,
                  ),
                  const CommonText(
                    "\$8.12",
                    fontSize: 16,
                    fontWeight: 600,
                    color: AppColors.whiteOne,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20, 
        vertical: 10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.greyOne
                ),
                borderRadius: BorderRadius.circular(
                  12
                ),
              ),
              child: const Icon(
                Icons.chevron_left_rounded, 
                color: AppColors.blackTwo,
                size: 40,
              ),
            ),
          ),
          HorizontalSpacing(20),
          const CommonText(
            "Sub Services",
            fontSize: 24,
            fontWeight: 600,
            color: AppColors.blackTwo,
          ),
        ],
      ),
    );
  }
}

class _SubServiceCard extends StatelessWidget {
  const _SubServiceCard({
    required this.audience,
    required this.title,
    required this.price,
    required this.description,
    required this.isSelected,
    required this.onChanged,
  });

  final String audience;
  final String title;
  final String price;
  final String description;
  final bool isSelected;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.greyOne,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage(
                      Assets.discountImage
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              HorizontalSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          audience,
                          fontSize: 14,
                          fontWeight: 400,
                          color: AppColors.greyTwo,
                        ),
                        _buildCheckbox(),
                      ],
                    ),
                    VerticalSpacing(4),
                    CommonText(
                      title,
                      fontSize: 18,
                      fontWeight: 600,
                      color: AppColors.blackTwo,
                      maxLines: 2,
                    ),
                    VerticalSpacing(8),
                    CommonText(
                      price,
                      fontSize: 16,
                      fontWeight: 600,
                      color: AppColors.pinkTwo,
                    ),
                  ],
                ),
              ),
            ],
          ),
          VerticalSpacing(12),
          //use textSpan for description
          RichText(
            text: TextSpan(
              text: "Description: ",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.blackTwo,
                fontFamily: Strings.fontFamily,
              ),
              children: [
                TextSpan(
                  text: description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greyTwo,
                    fontFamily: Strings.fontFamily,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox() {
    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.pinkTwo : AppColors.whiteOne,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? AppColors.pinkTwo : AppColors.greyTwo,
          ),
        ),
        child: isSelected ? const Icon(
          Icons.check, 
          color: AppColors.whiteOne, 
          size: 14
        ) : null,
      ),
    );
  }
}

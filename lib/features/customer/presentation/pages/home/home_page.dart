import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';


class HomePage extends StatelessWidget {
   HomePage({super.key});

  final searchController = TextEditingController();

  void showFeatureInDevelopment() {
    MessageUtils.showInfoSnackBar(
      Strings.featureUnderDevelopment
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "name" : "Hair",
        "image": Assets.hairIcon,
      },
      {
        "name" : "Makeup",
        "image": Assets.makeupIcon,
      },
      {
        "name" : "Manicure",
        "image": Assets.manicureIcon,
      },
      {
        "name" : "Skincare",
        "image": Assets.skincareIcon,
      },
    ];
    final List<Map<String, dynamic>> nearestSalons = [
      {
        'name': 'Bloom & Blade',
        'address': '201 Main St, Dayton, OH 45402',
        'type': 'Full Service Salon',
        'rating': 4.5,
        'distance': 5.0,
        'image': 'assets/images/salon_one.png', // Placeholder
      },
      {
        'name': 'Raven & Rose',
        'address': '4820 Maple Ave, Celina, Delaware...',
        'type': 'Individual Service Provider',
        'rating': 4.0,
        'distance': 4.7,
        'image': 'assets/images/salon_two.png', // Placeholder
      },
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    "Welcome, Eleanor",
                    fontSize: 24,
                    color: AppColors.blackTwo,
                    fontWeight: 600,
                  ),
                  CommonText(
                    "Let's do some self care",
                    fontSize: 16,
                    color: AppColors.greyTwo,
                    fontWeight: 400,
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showFeatureInDevelopment();
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: AppColors.whiteOne,
                          borderRadius: BorderRadius.circular(
                              16
                          ),
                          border: Border.all(
                              color: AppColors.greyOne
                          )
                      ),
                      child: Center(
                        child: Icon(
                          Icons.notifications_none_outlined,
                          color: AppColors.blackTwo,
                        ),
                      ),
                    ),
                  ),
                  HorizontalSpacing(10),
                  GestureDetector(
                    onTap: () {
                      showFeatureInDevelopment();
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: AppColors.whiteOne,
                          borderRadius: BorderRadius.circular(
                              16
                          ),
                          border: Border.all(
                              color: AppColors.greyOne
                          )
                      ),
                      child: Center(
                        child: Icon(
                          Icons.search,
                          color: AppColors.blackTwo,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          VerticalSpacing(40),
          SizedBox(
            height: 55,
            child: CommonTextField(
              controller: searchController,
              fillColor: AppColors.whiteOne,
              prefix: Icon(
                CupertinoIcons.search,
                color: AppColors.greyTwo,
              ),
              suffix: GestureDetector(
                onTap: () {
                  showFeatureInDevelopment();
                },
                child: Icon(
                  Icons.tune,
                  color: AppColors.blackTwo,
                ),
              ),
              labelText: Strings.searchText,
              hintText: Strings.searchText,
              labelColor: AppColors.greyTwo,
              hintColor: AppColors.greyTwo,
              textColor: AppColors.blackTwo,
              cursorColor: AppColors.blackTwo,
              labelSize: 16,
              hintSize: 16,
              labelWeight: FontWeight.w400,
              hintWeight: FontWeight.w400,
            ),
          ),
          VerticalSpacing(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                Strings.appointmentText,
                fontSize: 20,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
              CommonText(
                Strings.todayOrMorningText,
                fontSize: 12,
                fontWeight: 400,
                color: AppColors.greyTwo,
              ),
            ],
          ),
          VerticalSpacing(20),
          Container(
            width: context.width - 40,
            height: 56,
            decoration: BoxDecoration(
                color: AppColors.pinkTwo,
                borderRadius: BorderRadius.circular(15)
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.bottomBarIconTwo,
                      width: 24,
                      height: 24,
                    ),
                    HorizontalSpacing(10),
                    CommonText(
                      Strings.bloomAndBladeText,
                      fontSize: 18,
                      fontWeight: 600,
                      color: AppColors.whiteOne,
                    )
                  ],
                ),
                CommonText(
                  Strings.nineAmText,
                  fontSize: 12,
                  fontWeight: 400,
                  color: AppColors.whiteOne,
                )
              ],
            ),
          ),
          VerticalSpacing(20),
          SizedBox(
            height: context.height * 0.3 ,
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    showFeatureInDevelopment();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 110,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  24
                              ),
                              image: DecorationImage(
                                  image: AssetImage(
                                      item['image'] ?? ''
                                  ),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        VerticalSpacing(5),
                        CommonText(
                          item['name'] ?? '',
                          fontSize: 16,
                          fontWeight: 400,
                          color: AppColors.blackTwo,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Promotional Card Section
          // GestureDetector(
          //   onTap: () {
          //     showFeatureInDevelopment();
          //   },
          //   child: Container(
          //     width: context.width - 40,
          //     height: 200,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage(
          //           Assets.discountImage
          //         ),
          //         fit: BoxFit.cover
          //       )
          //     ),
          //   ),
          // ),
          VerticalSpacing(20),
          // New Promotional Card Section
          Container(
            width: context.width - 40,
            decoration: BoxDecoration(
              color: AppColors.greyFive.withValues(
                  alpha: 0.3
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20,
                        top: 15,
                        bottom: 15
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "30%",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blackTwo,
                                  fontFamily: Strings.fontFamily,
                                ),
                              ),
                              TextSpan(
                                text: " Discount",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blackTwo,
                                  fontFamily: Strings.fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalSpacing(5),
                        CommonText(
                          "Skin care just for you",
                          fontSize: 12,
                          color: AppColors.greyTwo,
                          fontWeight: 400,
                        ),
                        VerticalSpacing(10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Promo: ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackTwo,
                                  fontFamily: Strings.fontFamily,
                                ),
                              ),
                              TextSpan(
                                text: "L30d",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.pinkTwo,
                                  fontFamily: Strings.fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalSpacing(10),
                        CommonButton(
                          width: 70,
                          height: 30,
                          radius: 10,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          onPressed: () {
                            showFeatureInDevelopment();
                          },
                          text: "Book Now",
                          textFontSize: 10,
                        )
                      ],
                    ),
                  ),
                ),
                HorizontalSpacing(10),
                SizedBox(
                  width: context.width / 2.4,
                  height: 140,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -40,
                        child: Container(
                          width: context.width / 2.4,
                          height: 205,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage(
                                      Assets.discountImage
                                  ),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          VerticalSpacing(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                Strings.nearestSalonText,
                fontSize: 20,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
              GestureDetector(
                onTap: () {
                  showFeatureInDevelopment();
                },
                child: CommonText(
                  Strings.viewAllText,
                  fontSize: 12,
                  fontWeight: 400,
                  color: AppColors.greyTwo,
                ),
              ),
            ],
          ),
          VerticalSpacing(20),
          ...nearestSalons.map((salon) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _SalonCard(
              name: salon['name'],
              address: salon['address'],
              type: salon['type'],
              rating: salon['rating'],
              distance: salon['distance'],
              imagePath: salon['image'],
              onTap: () {
                showFeatureInDevelopment();
              },
            ),
          )),
          VerticalSpacing(20),

        ],
      ),
    );
  }
}

class _SalonCard extends StatelessWidget {
  const _SalonCard({
    required this.name,
    required this.address,
    required this.type,
    required this.rating,
    required this.distance,
    required this.imagePath,
    required this.onTap
  });

  final String name;
  final String address;
  final String type;
  final double rating;
  final double distance;
  final String imagePath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Color typeColor = AppColors.pinkOne;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width - 40,
        padding: EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 5,
            right: 5
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.greyOne.withValues(
              alpha: 0.3
            )
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Left Side: Image
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            HorizontalSpacing(15), // Spacing between image and text

            // 2. Right Side: Text Details and Rating
            // Use Flexible with no flex or a small fixed width instead of Expanded
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Salon Name
                  CommonText(
                    name,
                    fontSize: 18,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                  VerticalSpacing(4),
                  // Address (Grey, smaller font)
                  CommonText(
                    address,
                    fontSize: 12,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  VerticalSpacing(6),
                  // Service Type (Highlighted color)
                  CommonText(
                    type,
                    fontSize: 14,
                    fontWeight: 500,
                    color: typeColor,
                  ),
                  VerticalSpacing(10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Rating Stars
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating.floor() ? Icons.star_rate_rounded : Icons.star_border_rounded,
                            color: AppColors.yellowOne,
                            size: 24,
                          );
                        }),
                      ),

                      // Distance Indicator
                      Row(
                        children: [
                          Icon(
                              Icons.location_on_outlined,
                              color: AppColors.blackTwo,
                              size: 20
                          ),
                          HorizontalSpacing(4),
                          CommonText(
                            '$distance km',
                            fontSize: 12,
                            fontWeight: 600,
                            color: AppColors.blackTwo,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


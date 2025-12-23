import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_tabbar_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'components/salon_header_delegate.dart';
import 'components/about_tab.dart';
import 'components/services_tab.dart';
import 'components/package_tab.dart';
import 'components/gallery_tab.dart';
import 'components/review_tab.dart';

class SalonDetailPage extends StatelessWidget {
  const SalonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve salon data from navigation arguments
    final Map<String, dynamic> salonData =
        (Get.arguments ?? {}) as Map<String, dynamic>;

    final String name = salonData['name'] ?? '';
    final String address = salonData['address'] ?? '';
    final double rating = salonData['rating'] ?? 0.0;
    final String imagePath = salonData['image'] ?? '';

    return CommonScaffoldWidget(
      bgColor: AppColors.whiteOne,
      useSafeArea: false,
      padding: EdgeInsets.zero,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              pinned: true,
              delegate: SalonHeaderDelegate(imagePath: imagePath),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.whiteOne,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CommonText(
                            name,
                            fontSize: 22,
                            fontWeight: 600,
                            color: AppColors.blackTwo,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00D161),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const CommonText(
                            Strings.openText,
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.whiteOne,
                          ),
                        ),
                      ],
                    ),
                    VerticalSpacing(6),
                    CommonText(
                      address,
                      fontSize: 14,
                      fontWeight: 400,
                      color: AppColors.greyTwo,
                    ),
                    VerticalSpacing(12),
                    Row(
                      children: [
                        const CommonText(
                          "Salon",
                          fontSize: 13,
                          fontWeight: 500,
                          color: Color(0xFFFF5E76),
                        ),
                        const Spacer(),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < 4
                                  ? Icons.star
                                  : (index < 5 ? Icons.star_half : Icons.star),
                              color: index < 4
                                  ? AppColors.yellowOne
                                  : (index < 5
                                         ? AppColors.yellowOne
                                         : AppColors.greyOne),
                              size: 14,
                            );
                          }),
                        ),
                        HorizontalSpacing(6),
                        CommonText(
                          "(76 ${Strings.reviewsText})",
                          fontSize: 13,
                          fontWeight: 400,
                          color: AppColors.greyTwo,
                        ),
                      ],
                    ),
                    VerticalSpacing(10),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: CommonTabBarWidgetTwo(
            indicatorColor: AppColors.pinkTwo,
            selectedLabelColor: AppColors.whiteOne,
            unselectedLabelColor: AppColors.greyTwo,
            indicatorRadius: 12,
            labelFontSize: 12,
            labelFontWeight: FontWeight.w600,
            tabAlignment: TabAlignment.start,
            labelPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            tabPadding: const EdgeInsets.symmetric(horizontal: 20),
            containerDecoration: const BoxDecoration(
              color: AppColors.transparent,
            ),
            isScrollable: true,
            tabs: const [
              Strings.aboutSalonText,
              Strings.salonServicesText,
              Strings.packageText,
              Strings.galleryText,
              Strings.reviewsText,
            ],
            tabViews: [
              const AboutTab(),
              const ServicesTab(),
              const PackageTab(),
              const GalleryTab(),
              ReviewTab(rating: rating),
            ],
          ),
        ),
      ),
    );
  }
}

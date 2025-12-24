import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/map/components/filter_bottom_sheet_component.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/map/components/recent_search_item_component.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/map/components/search_field_header_component.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/map/components/search_tag_component.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/map/components/suggestion_card_component.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class MapSearchPage extends StatelessWidget {
  const MapSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.whiteTwo,
      body: SafeArea(
        child: Column(
          children: [
            SearchFieldHeaderComponent(
              controller: searchController,
              onBackTap: () => Get.back(),
              onFilterTap: () {
                FocusScope.of(context).unfocus();
                _showFilterBottomSheet(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRecentsSection(),
                    const VerticalSpacing(24),
                    _buildPopularSearchSection(),
                    const VerticalSpacing(24),
                    _buildSuggestionsSection(),
                    const VerticalSpacing(24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentsSection() {
    final recentSearches = ["Hair service", "Nail", "Wax"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                "Recents",
                fontSize: 16,
                fontWeight: 700,
                color: AppColors.blackTwo,
              ),
              TextButton(
                onPressed: () {},
                child: const CommonText(
                  "Clear all",
                  fontSize: 16,
                  fontWeight: 500,
                  color: AppColors.pinkTwo,
                ),
              ),
            ],
          ),
          const VerticalSpacing(3),
          ...recentSearches.map((search) => RecentSearchItemComponent(
                text: search,
                onTap: () {},
                onDelete: () {},
              )),
        ],
      ),
    );
  }

  Widget _buildPopularSearchSection() {
    final popularTags = ["Hair", "Nails", "Coloring", "Facials", "Massage"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CommonText(
            "Popular Search",
            fontSize: 16,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
        ),
        const VerticalSpacing(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: popularTags
                .map((tag) => SearchTagComponent(
                      label: tag,
                      onTap: () {},
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CommonText(
            "Suggestion For You",
            fontSize: 16,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
        ),
        const VerticalSpacing(16),
        SuggestionCardComponent(
          name: "Bloom & Blade",
          category: "Hair",
          address: "6391 Elgin St. Celina, Delaware...",
          providerType: "Salon",
          rating: 5.0,
          image: "assets/images/salon_one.png",
          onTap: () {},
        ),
        const VerticalSpacing(16),
        SuggestionCardComponent(
          name: "Raven & Rose",
          category: "Hair",
          address: "4820 Maple Ave, Celina, Delaware...",
          providerType: "Individual Service Provider",
          rating: 4.7,
          image: "assets/images/salon_two.png",
          onTap: () {},
        ),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheetComponent(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';
import 'package:lisa_beauty_salon/shared/widgets/custom_slider_thumb_circle.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int?> selectedSalonIndex = ValueNotifier<int?>(null);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Stack(
        children: [
          // Map Background
          Positioned.fill(
            child: Image.asset(
              "assets/images/map_background.png",
              fit: BoxFit.cover,
            ),
          ),

          // Route Line
          ValueListenableBuilder<int?>(
            valueListenable: selectedSalonIndex,
            builder: (context, selectedIndex, child) {
              if (selectedIndex == null) return const SizedBox.shrink();
              return Positioned.fill(
                child: CustomPaint(
                  painter: _RoutePainter(index: selectedIndex),
                ),
              );
            },
          ),

          // Floating Overlays (Top)
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: _buildSearchBar(context),
          ),

          // Markers
          ValueListenableBuilder<int?>(
            valueListenable: selectedSalonIndex,
            builder: (context, selectedIndex, child) {
              return Stack(
                children: [
                  _buildMarker(
                    top: 250,
                    left: 100,
                    isSelected: selectedIndex == 0,
                    onTap: () => selectedSalonIndex.value = 0,
                  ),
                  _buildMarker(
                    top: 350,
                    left: 220,
                    isSelected: selectedIndex == 1,
                    hasPulse: selectedIndex == 1,
                    onTap: () => selectedSalonIndex.value = 1,
                  ),
                  _buildMarker(
                    top: 450,
                    left: 80,
                    isSelected: selectedIndex == 2,
                    onTap: () => selectedSalonIndex.value = 2,
                  ),
                  _buildMarker(top: 300, left: 300, isSelected: false),
                  _buildMarker(top: 550, left: 250, isSelected: false),
                ],
              );
            },
          ),

          // Floating Overlays (Bottom)
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [_buildSalonCarousel(selectedSalonIndex)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteTwo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.blackTwo,
                size: 20,
              ),
              const HorizontalSpacing(8),
              const Expanded(
                child: CommonText(
                  "6391 Elgin St. Celina, Delaware 10299",
                  fontSize: 16,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const VerticalSpacing(12),
          CommonTextField(
            controller: TextEditingController(),
            hintText: Strings.searchText,
            label: Strings.searchText,
            fillColor: AppColors.whiteOne,
            borderColor: AppColors.transparent,
            prefix: Icon(
              CupertinoIcons.search,
              color: AppColors.greyTwo,
              size: 20,
            ),
            suffix: Icon(
              Icons.filter_alt_outlined,
              color: AppColors.greyTwo,
              size: 20,
            ),
            suffixIconOnTap: () {
              FocusScope.of(context).unfocus();
              _showFilterBottomSheet(context);
            },
            borderRadius: 16,
            textColor: AppColors.blackTwo,
            cursorColor: AppColors.blackTwo,
            contentPadding: EdgeInsets.symmetric(vertical: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker({
    required double top,
    required double left,
    bool isSelected = false,
    bool hasPulse = false,
    VoidCallback? onTap,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (hasPulse) ...[
              _buildPulseCircle(60, AppColors.pinkTwo.withOpacity(0.1)),
              _buildPulseCircle(40, AppColors.pinkTwo.withOpacity(0.2)),
            ],
            Container(
              width: isSelected ? 24 : 18,
              height: isSelected ? 24 : 18,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.pinkTwo : AppColors.blackTwo,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.whiteOne,
                  width: isSelected ? 3 : 2.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.pinkTwo.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPulseCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildSalonCarousel(ValueNotifier<int?> selectedIndex) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const HorizontalSpacing(12),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              selectedIndex.value = index;
            },
            child: _buildSalonCard(
              index,
              onStartTap: () {
                Get.toNamed(RouteNames.mapNavigation, arguments: index);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSalonCard(int index, {VoidCallback? onStartTap}) {
    return GestureDetector(
      onTap: onStartTap,
      child: Container(
        width: Get.width * 0.8,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/salon_one.png",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const HorizontalSpacing(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CommonText(
                    "Bloom & Blade",
                    fontSize: 18,
                    fontWeight: 600,
                    color: AppColors.blackTwo,
                  ),
                  const VerticalSpacing(4),
                  const CommonText(
                    "6391 Elgin St. Celina, Delaware...",
                    fontSize: 12,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const VerticalSpacing(4),
                  Row(
                    children: [
                      const CommonText(
                        "Salon",
                        fontSize: 14,
                        color: AppColors.pinkTwo,
                        fontWeight: 500,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.star,
                        color: AppColors.yellowOne,
                        size: 14,
                      ),
                      const HorizontalSpacing(2),
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.blackTwo,
                        size: 14,
                      ),
                      const HorizontalSpacing(2),
                      const CommonText(
                        "5.0 km",
                        fontSize: 12,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
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

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _FilterBottomSheet(),
    );
  }
}

class _RoutePainter extends CustomPainter {
  final int index;
  _RoutePainter({required this.index});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blackTwo
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final startOffset = const Offset(220 + 12, 350 + 12);

    Offset endOffset;
    if (index == 0) {
      endOffset = const Offset(100 + 12, 250 + 12);
    } else if (index == 2) {
      endOffset = const Offset(80 + 12, 450 + 12);
    } else {
      return;
    }

    path.moveTo(startOffset.dx, startOffset.dy);
    final midX = (startOffset.dx + endOffset.dx) / 2;
    final midY = (startOffset.dy + endOffset.dy) / 2;
    path.lineTo(midX - 20, midY - 10);
    path.lineTo(midX + 10, midY + 15);
    path.lineTo(endOffset.dx, endOffset.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FilterBottomSheet extends StatefulWidget {
  const _FilterBottomSheet();

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
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

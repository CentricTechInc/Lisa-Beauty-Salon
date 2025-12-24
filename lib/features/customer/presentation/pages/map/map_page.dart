import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/features/customer/presentation/pages/map/components/filter_bottom_sheet_component.dart';
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
            readOnly: true,
            textOnTap: () {
              Get.toNamed(RouteNames.mapSearch);
            },
            prefix: Icon(
              CupertinoIcons.search,
              color: AppColors.greyTwo,
              size: 20,
            ),
            suffix: Icon(
              Icons.tune,
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
      builder: (context) => const FilterBottomSheetComponent(),
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

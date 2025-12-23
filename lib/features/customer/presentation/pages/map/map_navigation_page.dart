import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';

class MapNavigationPage extends StatelessWidget {
  final int selectedIndex;
  const MapNavigationPage({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      useSafeArea: false,
      padding: EdgeInsets.zero,
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
          Positioned.fill(
            child: CustomPaint(
              painter: _RoutePainter(index: selectedIndex),
            ),
          ),

          // Back Button (Top)
          Positioned(
            top: context.mediaQueryPadding.top + 10,
            left: 20,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.whiteOne,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.greyOne,
                  )
                ),
                child: const Icon(
                  CupertinoIcons.back, 
                  color: AppColors.blackTwo, 
                  size: 24
                ),
              ),
            ),
          ),

          // Markers
          _buildMarkerStatic(top: 250, left: 550), // Top right area
          _buildMarkerStatic(top: 400, left: 780), // Middle right area
          _buildMarkerStatic(top: 550, left: 120), // Bottom left area
          _buildMarkerStatic(top: 650, left: 650), // Bottom near nav info
          
          _buildMarker(selectedIndex),

          // Floating Overlays (Bottom)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSalonPreviewCard(),
                const VerticalSpacing(16),
                _buildNavigationInfoCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkerStatic({required double top, required double left}) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: AppColors.blackTwo,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.whiteOne, width: 2.5),
        ),
      ),
    );
  }

  Widget _buildSalonPreviewCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackFour.withValues(
                alpha: 0.25
              ),
              blurRadius: 30,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/salon_one.png",
                width: 96,
                height: 96,
                fit: BoxFit.cover,
              ),
            ),
            const HorizontalSpacing(16),
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
                  const VerticalSpacing(6),
                  const CommonText(
                    "Salon",
                    fontSize: 14,
                    fontWeight: 500,
                    color: AppColors.pinkTwo,
                  ),
                  const VerticalSpacing(4),
                  Row(
                    children: [
                      ...List.generate(4, (index) => const Icon(
                        Icons.star, 
                        color: AppColors.yellowOne, 
                        size: 16
                      )),
                      const Icon(
                        Icons.star_half, 
                        color: AppColors.yellowOne, 
                        size: 16
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

  Widget _buildMarker(int index) {
    final positions = [
      const Offset(250, 100), // top, left
      const Offset(350, 220),
      const Offset(450, 80),
    ];
    
    final pos = positions[index];

    return Positioned(
      top: pos.dx,
      left: pos.dy,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildPulseCircle(60, AppColors.pinkTwo.withOpacity(0.1)),
          _buildPulseCircle(40, AppColors.pinkTwo.withOpacity(0.2)),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.pinkTwo,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.whiteOne, width: 4),
              boxShadow: [
                BoxShadow(
                  color: AppColors.pinkTwo.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.whiteOne,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulseCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildNavigationInfoCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(
          horizontal: 24, 
          vertical: 16
        ),
        decoration: BoxDecoration(
          color: AppColors.blackOne,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackOne.withValues(
                alpha: 0.2
              ),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CommonText(
                    "25 min",
                    fontSize: 24,
                    fontWeight: 700,
                    color: AppColors.whiteOne,
                  ),
                  const VerticalSpacing(4),
                  Row(
                    children: [
                      CommonText(
                        "2:34 PM",
                        fontSize: 16,
                        color: AppColors.whiteOne,
                        fontWeight: 400,
                      ),
                      const HorizontalSpacing(12),
                      CommonText(
                        "5.0 KM",
                        fontSize: 16,
                        color: AppColors.whiteOne,
                        fontWeight: 400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CommonButton(
              onPressed: () {},
              width: 140,
              height: 64,
              radius: 32,
              backgroundColor: AppColors.pinkTwo,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.route_outlined, 
                    color: AppColors.whiteOne, 
                    size: 24,
                  ),
                  const HorizontalSpacing(10),
                  const CommonText(
                    "Start",
                    fontSize: 18,
                    fontWeight: 600,
                    color: AppColors.whiteOne,
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

    // Adding more segments to look like city grid
    path.lineTo(startOffset.dx - 10, startOffset.dy - 30);
    path.lineTo(midX - 30, startOffset.dy - 35);
    path.lineTo(midX - 35, midY + 10);
    path.lineTo(endOffset.dx, endOffset.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

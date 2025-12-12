import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint whiteCirclePaint = Paint()
      ..color = AppColors.whiteOne
      ..style = PaintingStyle.fill;

    final Paint pinkBorderPaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final Paint shadowPaint = Paint()
      ..color = AppColors.blackOne.withValues(
        alpha: 0.1
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawCircle(center + const Offset(0, 2), thumbRadius, shadowPaint);

    canvas.drawCircle(center, thumbRadius, whiteCirclePaint);

    canvas.drawCircle(center, thumbRadius, pinkBorderPaint);

    // canvas.drawCircle(center, thumbRadius / 2, pinkInnerCirclePaint);
  }
}

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
      ..color = AppColors.blackOne.withValues(alpha: 0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // Draw Shadow
    canvas.drawCircle(center + const Offset(0, 2), thumbRadius, shadowPaint);

    // Draw Thumb Circle
    canvas.drawCircle(center, thumbRadius, whiteCirclePaint);
    canvas.drawCircle(center, thumbRadius, pinkBorderPaint);

    // Draw Value Bubble
    final double actualValue = min + (max - min) * value;
    final String valueText = "${actualValue.toInt()}KM";

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: valueText,
        style: const TextStyle(
          color: AppColors.whiteOne,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final double bubbleWidth = tp.width + 12;
    final double bubbleHeight = tp.height + 6;

    // Design shows a red bubble with white text
    final Rect bubbleRect = Rect.fromCenter(
      center: center + const Offset(0, 20), // Below the thumb
      width: bubbleWidth,
      height: bubbleHeight,
    );

    final Paint bubblePaint = Paint()..color = AppColors.pinkTwo;
    canvas.drawRRect(
      RRect.fromRectAndRadius(bubbleRect, const Radius.circular(6)),
      bubblePaint,
    );

    tp.paint(canvas, bubbleRect.topLeft + const Offset(6, 3));
  }
}

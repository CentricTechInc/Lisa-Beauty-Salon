import 'package:flutter/widgets.dart';
import 'package:lisa_beauty_saloon/core/themes/theme.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      this.text, {
        super.key,
        this.fontSize = 16,
        this.color = AppColors.neutral50,
        this.fontWeight = 400,
        this.fontFamily = 'Onest',
        this.textOverflow = TextOverflow.ellipsis,
        this.textAlign = TextAlign.start,
        this.lineHeight = 1.5,
        this.letterSpacing = 0.5,
        this.maxLines,
        this.decoration,
        this.shadows,
      });

  final String text;
  final double fontSize;
  final Color color;
  final double fontWeight;
  final String fontFamily;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  final double lineHeight;
  final double letterSpacing;
  final int? maxLines;
  final TextDecoration? decoration;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      softWrap: true,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: color,
        height: lineHeight,
        letterSpacing: letterSpacing,
        shadows: shadows,
        fontVariations: [FontVariation.weight(fontWeight)],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.iconColor,
    required this.arrowIconColor,
    required this.iconBackgroundColor,
    required this.backgroundColor,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;
  final Color arrowIconColor;
  final Color iconBackgroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SvgPicture.asset(
                  icon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    iconColor,
                    BlendMode.srcIn,
                  ) 
                ),
              ),
            ),
            const HorizontalSpacing(16),
            
            // Title
            Expanded(
              child: CommonText(
                title,
                fontSize: 16,
                fontWeight: 500,
                color: AppColors.blackTwo,
              ),
            ),
            
            // Chevron
             Icon(
              CupertinoIcons.chevron_right,
              color: arrowIconColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

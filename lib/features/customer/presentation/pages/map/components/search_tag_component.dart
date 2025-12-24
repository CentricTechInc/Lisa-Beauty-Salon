import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class SearchTagComponent extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const SearchTagComponent({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.greyFour,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.transparent),
        ),
        child: CommonText(
          label,
          fontSize: 14,
          fontWeight: 500,
          color: AppColors.blackTwo,
        ),
      ),
    );
  }
}

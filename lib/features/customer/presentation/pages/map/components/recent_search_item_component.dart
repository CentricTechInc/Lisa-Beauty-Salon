import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class RecentSearchItemComponent extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const RecentSearchItemComponent({
    super.key,
    required this.text,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text,
                  fontSize: 16,
                  fontWeight: 400,
                  color: AppColors.blackTwo,
                ),
                GestureDetector(
                  onTap: onDelete,
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: AppColors.greyOne,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: AppColors.greyFour,
          height: 1,
        ),
      ],
    );
  }
}

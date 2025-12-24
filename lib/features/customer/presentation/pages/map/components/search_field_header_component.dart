import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class SearchFieldHeaderComponent extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onBackTap;
  final VoidCallback onFilterTap;

  const SearchFieldHeaderComponent({
    super.key,
    required this.controller,
    required this.onBackTap,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          _buildBackButton(),
          const HorizontalSpacing(12),
          Expanded(
            child: CommonTextField(
              controller: controller,
              hintText: Strings.searchText,
              label: Strings.searchText,
              fillColor: AppColors.whiteOne,
              borderColor: AppColors.greyOne,
              prefix: const Icon(
                CupertinoIcons.search,
                color: AppColors.greyTwo,
                size: 20,
              ),
              suffix: const Icon(
                Icons.tune,
                color: AppColors.blackTwo,
                size: 20,
              ),
              suffixIconOnTap: onFilterTap,
              borderRadius: 20,
              textColor: AppColors.blackTwo,
              cursorColor: AppColors.blackTwo,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: onBackTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.whiteOne,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.greyOne),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.blackTwo,
          size: 18,
        ),
      ),
    );
  }
}

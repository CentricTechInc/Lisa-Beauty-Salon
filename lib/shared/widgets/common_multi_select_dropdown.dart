import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CommonMultiSelectDropdown<T> extends StatelessWidget {
  const CommonMultiSelectDropdown({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    required this.itemLabelBuilder,
    this.hintText = "Select",
    this.titleLabelText = '',
    this.borderRadius = 12.0,
    this.fillColor = AppColors.whiteOne,
    this.borderColor = AppColors.greyOne,
    this.textColor = AppColors.blackTwo,
    this.hintColor = AppColors.greyTwo,
    this.iconColor = AppColors.blackTwo,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final List<T> items;
  final List<T> selectedItems;
  final Function(List<T>) onChanged;
  final String Function(T) itemLabelBuilder;
  final String hintText;
  final String titleLabelText;
  final double borderRadius;
  final Color? fillColor;
  final Color borderColor;
  final Color textColor;
  final Color hintColor;
  final Color iconColor;
  final EdgeInsetsGeometry contentPadding;
  final String? Function(List<T>?)? validator;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExpandedNotifier = ValueNotifier<bool>(false);

    return FormField<List<T>>(
      initialValue: selectedItems,
      validator: validator,
      autovalidateMode: autovalidateMode,
      builder: (FormFieldState<List<T>> state) {
        final hasError = state.hasError;
        return ValueListenableBuilder<bool>(
          valueListenable: isExpandedNotifier,
          builder: (context, isExpanded, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (titleLabelText.isNotEmpty) ...[
                  CommonText(
                    titleLabelText,
                    fontSize: 14,
                    fontWeight: 700,
                    color: textColor,
                  ),
                  const VerticalSpacing(8),
                ],
                GestureDetector(
                  onTap: () => isExpandedNotifier.value = !isExpandedNotifier.value,
                  child: Container(
                    padding: contentPadding,
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(
                        color: hasError ? Colors.red : borderColor,
                        width: hasError ? 1.25 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CommonText(
                            selectedItems.isEmpty
                                ? hintText
                                : "${selectedItems.length} ${Strings.selectedText}",
                            fontSize: 15,
                            color: selectedItems.isEmpty ? hintColor : textColor,
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: hasError ? Colors.red : iconColor,
                        ),
                      ],
                    ),
                  ),
                ),
                if (hasError) ...[
                  const VerticalSpacing(8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CommonText(
                      state.errorText ?? '',
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ],
                if (isExpanded) ...[
                  const VerticalSpacing(8),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    decoration: BoxDecoration(
                      color: AppColors.whiteOne,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.greyOne),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: 0.05
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.greyFour),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isSelected = selectedItems.contains(item);
                        return InkWell(
                          onTap: () {
                            final newSelected = List<T>.from(selectedItems);
                            if (isSelected) {
                              newSelected.remove(item);
                            } else {
                              newSelected.add(item);
                            }
                            state.didChange(newSelected);
                            onChanged(newSelected);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.success : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? AppColors.success : AppColors.greyTwo,
                                    ),
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                                      : null,
                                ),
                                const HorizontalSpacing(12),
                                Expanded(
                                  child: CommonText(
                                    itemLabelBuilder(item),
                                    fontSize: 14,
                                    color: AppColors.blackTwo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                if (selectedItems.isNotEmpty) ...[
                  const VerticalSpacing(12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedItems.map((item) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.pinkTwo.withValues(
                            alpha: 0.1
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.pinkTwo.withValues(
                              alpha: 0.3
                            )
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonText(
                              itemLabelBuilder(item),
                              fontSize: 12,
                              fontWeight: 500,
                              color: AppColors.pinkTwo,
                            ),
                            const HorizontalSpacing(4),
                            GestureDetector(
                              onTap: () {
                                final newSelected = List<T>.from(selectedItems);
                                newSelected.remove(item);
                                state.didChange(newSelected);
                                onChanged(newSelected);
                              },
                              child: const Icon(Icons.close, size: 14, color: AppColors.pinkTwo),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class CommonBottomSheet extends StatelessWidget {
  const CommonBottomSheet({
    super.key,
    required this.title,
    required this.content,
    this.footer,
  });

  final String title;
  final Widget content;
  final Widget? footer;

  static Future<void> show(
    BuildContext context, {
      required String title,
      required Widget content,
      Widget? footer,
      bool isDismissible = true,
      minChildSize = 0.3,
      maxChildSize = 0.5,
      initialChildSize = 0.4,
    }
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: AppColors.whiteOne,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        builder: (_, controller) => Padding(
          padding: const EdgeInsets.all(16),
          child: CommonBottomSheet(
              title: title,
              content: content,
              footer: footer,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.greyOne,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        VerticalSpacing(15),
        if (title.isNotEmpty)...[
          CommonText(
            title,
            fontSize: 18,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
          VerticalSpacing(10),
        ],
        Expanded(
          child: SingleChildScrollView(
            child: content,
          ),
        ),
        if (footer != null)...[
          VerticalSpacing(16),
          footer!,
        ],
      ],
    );
  }
}

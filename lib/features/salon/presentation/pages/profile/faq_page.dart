import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final ValueNotifier<int?> expandedIndex = ValueNotifier(null);

  final List<Map<String, String>> faqs = [
    {
      "question": "What is this app about?",
      "answer": "This app allows you to find and book the best beauty services near you, manage your professional profile, and track your revenue.",
    },
    {
      "question": "How does it work?",
      "answer": "It operates by processing data through a series of algorithms, allowing for efficient task execution. Essentially, it transforms input into meaningful output.",
    },
    {
      "question": "Who can benefit from it?",
      "answer": "Both clients looking for services and beauty professionals/salons looking to manage their business.",
    },
    {
      "question": "What are the key features?",
      "answer": "Service management, availability scheduling, booking tracking, earnings statistics, and direct communication between clients and professionals.",
    },
  ];

  @override
  void dispose() {
    expandedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      padding: EdgeInsets.zero,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.whiteTwo,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      bgColor: AppColors.whiteTwo,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.whiteOne,
                      border: Border.all(
                        color: AppColors.greyOne,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(CupertinoIcons.back, color: AppColors.blackTwo),
                  ),
                ),
                const HorizontalSpacing(10),
                CommonText(
                  Strings.faqsText,
                  fontSize: 24,
                  fontWeight: 600,
                  color: AppColors.blackOne,
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<int?>(
              valueListenable: expandedIndex,
              builder: (context, currentExpandedIndex, child) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: faqs.length,
                  separatorBuilder: (context, index) => const VerticalSpacing(10),
                  itemBuilder: (context, index) {
                    final bool isExpanded = currentExpandedIndex == index;
                    return _buildFaqItem(index, isExpanded);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(int index, bool isExpanded) {
    final faq = faqs[index];
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            expandedIndex.value = isExpanded ? null : index;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            color: AppColors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CommonText(
                        faq['question']!,
                        fontSize: 16,
                        fontWeight: 600,
                        color: AppColors.blackTwo,
                        textOverflow: TextOverflow.visible,
                      ),
                    ),
                    Icon(
                      isExpanded ? CupertinoIcons.minus : CupertinoIcons.add,
                      color: AppColors.blackTwo,
                      size: 20,
                    ),
                  ],
                ),
                if (isExpanded) ...[
                  const VerticalSpacing(15),
                  CommonText(
                    faq['answer']!,
                    fontSize: 14,
                    fontWeight: 400,
                    color: AppColors.greyTwo,
                    textOverflow: TextOverflow.visible,
                  ),
                ],
              ],
            ),
          ),
        ),
        const Divider(
          color: AppColors.greyOne,
          height: 1,
        ),
      ],
    );
  }
}

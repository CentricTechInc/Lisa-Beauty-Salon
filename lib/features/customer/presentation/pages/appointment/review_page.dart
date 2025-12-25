import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/constants/route_constants.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_checkbox.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_scaffold_widget.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text_field.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _reviewController = TextEditingController();
  final ValueNotifier<bool> _recommendYes = ValueNotifier(true);
  final ValueNotifier<bool> _recommendNo = ValueNotifier(false);
  final ValueNotifier<double> _rating = ValueNotifier(0.0);

  @override
  void dispose() {
    _reviewController.dispose();
    _recommendYes.dispose();
    _recommendNo.dispose();
    _rating.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWidget(
      useSafeArea: true,
      child: Column(
        children: [
          const VerticalSpacing(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.whiteOne,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.greyOne
                    )
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.chevron_back,
                      color: AppColors.blackTwo,
                    ),
                  ),
                ),
              ),
              HorizontalSpacing(15),
              CommonText(
                "Review",
                fontSize: 24,
                fontWeight: 600,
                color: AppColors.blackTwo,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(20),
                  _buildSalonInfoCard(),
                  const VerticalSpacing(32),
                  const CommonText(
                    "How was your experience?",
                    fontSize: 24,
                    fontWeight: 700,
                    color: AppColors.blackThree,
                    textOverflow: TextOverflow.visible,
                  ),
                  const VerticalSpacing(08),
                  _buildReviewInputField(),
                  const VerticalSpacing(32),
                  const CommonText(
                    "Would you recommend to your Friends?",
                    fontSize: 16,
                    fontWeight: 500,
                    color: AppColors.blackTwo,
                    textOverflow: TextOverflow.visible,
                  ),
                  const VerticalSpacing(16),
                  Row(
                    children: [
                      _buildRecommendationOption("Yes", _recommendYes, (val) {
                        if (val == true) {
                          _recommendYes.value = true;
                          _recommendNo.value = false;
                        }
                      }),
                      const HorizontalSpacing(24),
                      _buildRecommendationOption("No", _recommendNo, (val) {
                        if (val == true) {
                          _recommendNo.value = true;
                          _recommendYes.value = false;
                        }
                      }),
                    ],
                  ),
                  const VerticalSpacing(40),
                  _buildStarRatingSelector(),
                  const VerticalSpacing(60),
                  CommonButton(
                    onPressed: _submitReview,
                    text: "Submit Review",
                    backgroundColor: AppColors.pinkTwo,
                    height: 56,
                    radius: 15,
                    textFontSize: 18,
                    textFontWeight: 600,
                  ),
                  const VerticalSpacing(24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalonInfoCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.greyOne,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              Assets.welcomeOne,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const HorizontalSpacing(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  "Bloom & Blade",
                  fontSize: 18,
                  fontWeight: 600,
                  color: AppColors.blackTwo,
                ),
                const VerticalSpacing(4),
                const CommonText(
                  "6391 Elgin St. Celina, Delaware...",
                  fontSize: 12,
                  fontWeight: 400,
                  color: AppColors.greyTwo,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const VerticalSpacing(6),
                const CommonText(
                  "Salon",
                  fontSize: 14,
                  fontWeight: 500,
                  color: AppColors.pinkTwo,
                ),
                const VerticalSpacing(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < 4 ? Icons.star : Icons.star_half,
                            color: index < 4.5 ? AppColors.yellowOne : AppColors.greyOne,
                            size: 14,
                          );
                        }),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.blackTwo,
                        ),
                        const HorizontalSpacing(4),
                        const CommonText(
                          "5.0 km",
                          fontSize: 12,
                          fontWeight: 600,
                          color: AppColors.blackTwo,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewInputField() {
    return CommonTextField(
      controller: _reviewController,
      labelText: 'Write review...',
      hintText: 'Write review...',
      hintSize: 14,
      labelSize: 14,
      borderColor: AppColors.transparent,
      fillColor: AppColors.greyFive.withValues(alpha: 0.3),
      textColor: AppColors.blackTwo,
      cursorColor: AppColors.blackTwo,
      minLines: 5,
      maxLines: null,
    );
  }

  Widget _buildRecommendationOption(String label, ValueNotifier<bool> notifier, Function(bool?) onChanged) {
    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Row(
          children: [
            CommonCheckbox(
              value: value,
              onChanged: onChanged,
              borderColor: value ? AppColors.pinkTwo : AppColors.greyOne,
              activeColor: AppColors.pinkTwo,
            ),
            const HorizontalSpacing(12),
            CommonText(
              label,
              fontSize: 16,
              fontWeight: 500,
              color: AppColors.greyTwo,
            ),
          ],
        );
      },
    );
  }

  void _submitReview() async {
    // Show loader
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(
          color: AppColors.pinkTwo,
        ),
      ),
      barrierDismissible: false,
    );

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Close loader
    Get.back();

    // Navigate to Home Shell
    Get.offAllNamed(RouteNames.mainCustomer);
  }

  Widget _buildStarRatingSelector() {
    return ValueListenableBuilder<double>(
      valueListenable: _rating,
      builder: (context, rating, child) {
        return Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragUpdate: (details) => _handleRatingGesture(details.localPosition.dx),
            onTapDown: (details) => _handleRatingGesture(details.localPosition.dx),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                IconData icon;
                if (rating >= index + 1) {
                  icon = Icons.star_rate_rounded;
                } else if (rating > index) {
                  icon = Icons.star_half_rounded;
                } else {
                  icon = Icons.star_outline_rounded;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    icon,
                    color: AppColors.yellowOne,
                    size: 48,
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  void _handleRatingGesture(double xPosition) {
    const double totalStars = 5;
    const double starWidth = 56.0; // 48 icon size + 4 padding on each side
    
    // Calculate raw rating
    double rawRating = xPosition / starWidth;
    
    // Snap to 0.5 increments
    double snappedRating = (rawRating * 2).ceil() / 2.0;
    
    // Clamp between 0.5 and 5.0
    double newRating = snappedRating.clamp(0.5, totalStars);
    
    if (_rating.value != newRating) {
      _rating.value = newRating;
    }
  }
}

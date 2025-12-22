import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'review_card.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        "name": "Jennie Whang",
        "rating": 4,
        "comment":
            "The team is great service, staff are friendly. I will certainly recommend to my friends and visit again!",
        "date": "2 days ago",
      },
      {
        "name": "Nathalie",
        "rating": 4,
        "comment":
            "Very nice service from the specialist. I always going here for my treatment.",
        "date": "1 week ago",
      },
      {
        "name": "Julia Martha",
        "rating": 5,
        "comment":
            "This is my favourite place to treat my hair. I really love the result! ❤️",
        "date": "2 weeks ago",
      },
      {
        "name": "Sarah Connor",
        "rating": 5,
        "comment":
            "Modern equipment and very clean environment. Highly recommended!",
        "date": "3 weeks ago",
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review Summary
          CommonText(
            "${Strings.allReviewsCountText} (${(rating * 50).toInt()})",
            fontSize: 18,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),

          VerticalSpacing(15),

          // Reviews List
          ...reviews.map((review) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ReviewCard(
                  name: review['name'] as String,
                  rating: review['rating'] as int,
                  comment: review['comment'] as String,
                  date: review['date'] as String,
                ),
              )),

          VerticalSpacing(20),
        ],
      ),
    );
  }
}

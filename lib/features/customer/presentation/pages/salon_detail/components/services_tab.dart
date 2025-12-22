import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'category_card.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "name": Strings.hairCategoryText,
        "description": "Haircut, blow-dry, coloring, and more.",
        "price": "from \$20",
      },
      {
        "name": Strings.makeupCategoryText,
        "description": "Professional makeup for all occasions.",
        "price": "from \$45",
      },
      {
        "name": Strings.nailsCategoryText,
        "description": "Manicure, pedicure, and nail art.",
        "price": "from \$15",
      },
      {
        "name": Strings.skinCareCategoryText,
        "description": "Facials, peels, and skincare treatments.",
        "price": "from \$60",
      },
      {
        "name": "Massage & Spa",
        "description": "Relaxing massages and full-body spa.",
        "price": "from \$80",
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: categories.map((cat) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CategoryCard(
              name: cat['name'] as String,
              description: cat['description'] as String,
              price: cat['price'] as String,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class PromotionModel {
  PromotionModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.priceText,
    required this.imagePath,
    required this.services,
    this.category = '',
    this.subCategory = '',
  });

  final String title;
  final String subtitle;
  final String description;
  final String priceText;
  final String imagePath;
  final List<String> services;
  final String category;
  final String subCategory;
}

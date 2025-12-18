import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/promotions/domain/entities/promotion_model.dart';

class PromotionDto extends PromotionModel {
  PromotionDto({
    required super.title,
    required super.subtitle,
    required super.description,
    required super.priceText,
    required super.imagePath,
    required super.services,
    super.category = '',
    super.subCategory = '',
  });

  factory PromotionDto.fromJson(DataMap json) {
    return PromotionDto(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      description: json['description'] as String? ?? '',
      priceText: json['priceText'] as String? ?? '',
      imagePath: json['imagePath'] as String? ?? '',
      services: (json['services'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
      category: json['category'] as String? ?? '',
      subCategory: json['subCategory'] as String? ?? '',
    );
  }

  DataMap toJson() {
    return {
      "title": title,
      "subtitle": subtitle,
      "description": description,
      "priceText": priceText,
      "imagePath": imagePath,
      "services": services,
      "category": category,
      "subCategory": subCategory,
    };
  }
}

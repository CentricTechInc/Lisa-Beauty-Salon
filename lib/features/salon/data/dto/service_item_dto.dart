import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/salon/domain/entities/service_item_model.dart';

class ServiceItemDto extends ServiceItemModel {
  const ServiceItemDto({
    required super.name,
    required super.price,
  });

  factory ServiceItemDto.fromMap(DataMap map) {
    return ServiceItemDto(
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
    );
  }

  DataMap toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}

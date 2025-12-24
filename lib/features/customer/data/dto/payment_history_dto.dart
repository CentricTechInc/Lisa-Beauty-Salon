import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/customer/domain/entities/payment_history_model.dart';

class PaymentHistoryDto extends PaymentHistoryModel {
  const PaymentHistoryDto({
    required super.dateTime,
    required super.date,
    required super.salonName,
    required super.category,
    required super.address,
    required super.services,
    required super.amount,
    required super.image,
    required super.serviceList,
  });

  factory PaymentHistoryDto.fromMap(DataMap map) {
    return PaymentHistoryDto(
      dateTime: DateTime.parse(map['dateTime'] as String),
      date: map['date'] as String,
      salonName: map['salonName'] as String,
      category: map['category'] as String,
      address: map['address'] as String,
      services: map['services'] as String,
      amount: map['amount'] as String,
      image: map['image'] as String,
      serviceList: (map['serviceList'] as List<dynamic>)
          .map((e) => ServiceItemDto.fromMap(e as DataMap))
          .toList(),
    );
  }

  DataMap toMap() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'date': date,
      'salonName': salonName,
      'category': category,
      'address': address,
      'services': services,
      'amount': amount,
      'image': image,
      'serviceList': serviceList
          .map((e) => (e as ServiceItemDto).toMap())
          .toList(),
    };
  }
}

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

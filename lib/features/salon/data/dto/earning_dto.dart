import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/salon/data/dto/service_item_dto.dart';
import 'package:lisa_beauty_salon/features/salon/domain/entities/earning_model.dart';

class EarningDto extends EarningModel {
  const EarningDto({
    required super.dateTime,
    required super.clientName,
    required super.clientImage,
    required super.services,
    required super.serviceItems,
    required super.subTotal,
    required super.platformFee,
    required super.totalAmount,
  });

  factory EarningDto.fromMap(DataMap map) {
    return EarningDto(
      dateTime: DateTime.parse(map['dateTime'] as String),
      clientName: map['clientName'] as String,
      clientImage: map['clientImage'] as String,
      services: List<String>.from(map['services'] as List),
      serviceItems: (map['serviceItems'] as List)
          .map((item) => ServiceItemDto.fromMap(item as DataMap))
          .toList(),
      subTotal: (map['subTotal'] as num).toDouble(),
      platformFee: (map['platformFee'] as num).toDouble(),
      totalAmount: (map['totalAmount'] as num).toDouble(),
    );
  }

  DataMap toMap() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'clientName': clientName,
      'clientImage': clientImage,
      'services': services,
      'serviceItems': serviceItems.map((item) => (item as ServiceItemDto).toMap()).toList(),
      'subTotal': subTotal,
      'platformFee': platformFee,
      'totalAmount': totalAmount,
    };
  }
}

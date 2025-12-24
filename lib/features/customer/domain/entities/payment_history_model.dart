import 'package:equatable/equatable.dart';

class PaymentHistoryModel extends Equatable {
  const PaymentHistoryModel({
    required this.dateTime,
    required this.date,
    required this.salonName,
    required this.category,
    required this.address,
    required this.services,
    required this.amount,
    required this.image,
    required this.serviceList,
  });

  final DateTime dateTime;
  final String date;
  final String salonName;
  final String category;
  final String address;
  final String services;
  final String amount;
  final String image;
  final List<ServiceItemModel> serviceList;

  @override
  List<Object?> get props => [
        dateTime,
        date,
        salonName,
        category,
        address,
        services,
        amount,
        image,
        serviceList,
      ];
}

class ServiceItemModel extends Equatable {
  const ServiceItemModel({
    required this.name,
    required this.price,
  });

  final String name;
  final double price;

  @override
  List<Object?> get props => [name, price];
}

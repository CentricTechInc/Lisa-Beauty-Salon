import 'package:equatable/equatable.dart';
import 'service_item_model.dart';

class EarningModel extends Equatable {
  const EarningModel({
    required this.dateTime,
    required this.clientName,
    required this.clientImage,
    required this.services,
    required this.serviceItems,
    required this.subTotal,
    required this.platformFee,
    required this.totalAmount,
  });

  final DateTime dateTime;
  final String clientName;
  final String clientImage;
  final List<String> services;
  final List<ServiceItemModel> serviceItems;
  final double subTotal;
  final double platformFee;
  final double totalAmount;

  @override
  List<Object?> get props => [
        dateTime,
        clientName,
        clientImage,
        services,
        serviceItems,
        subTotal,
        platformFee,
        totalAmount,
      ];
}

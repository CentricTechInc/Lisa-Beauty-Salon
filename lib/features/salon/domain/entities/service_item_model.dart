import 'package:equatable/equatable.dart';

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

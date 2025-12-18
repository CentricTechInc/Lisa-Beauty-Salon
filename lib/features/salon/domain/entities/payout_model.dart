import 'package:equatable/equatable.dart';

class PayoutModel extends Equatable {
  const PayoutModel({
    required this.dateTime,
    required this.accountNumber,
    required this.amount,
  });

  final DateTime dateTime;
  final String accountNumber;
  final double amount;

  @override
  List<Object?> get props => [dateTime, accountNumber, amount];
}

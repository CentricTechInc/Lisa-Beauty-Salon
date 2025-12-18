import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/salon/domain/entities/payout_model.dart';

class PayoutDto extends PayoutModel {
  const PayoutDto({
    required super.dateTime,
    required super.accountNumber,
    required super.amount,
  });

  factory PayoutDto.fromMap(DataMap map) {
    return PayoutDto(
      dateTime: DateTime.parse(map['dateTime'] as String),
      accountNumber: map['accountNumber'] as String,
      amount: (map['amount'] as num).toDouble(),
    );
  }

  DataMap toMap() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'accountNumber': accountNumber,
      'amount': amount,
    };
  }
}

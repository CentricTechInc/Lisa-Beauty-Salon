import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/auth/domain/entities/user_model.dart';

class UserDto extends UserModel {
  const UserDto({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserDto.fromMap(DataMap map) {
    return UserDto(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
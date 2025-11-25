import 'package:lisa_beauty_saloon/core/utils/typedef.dart';
import 'package:lisa_beauty_saloon/features/auth/data/dto/user_dto.dart';

abstract class AuthRepository {
  ResultFuture<UserDto> login({
    required String email,
    required String password,
  });

  ResultFuture<void> logout();
}
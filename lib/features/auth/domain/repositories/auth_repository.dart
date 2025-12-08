import 'package:country_state_city_dropdown/country_state_city_dropdown.dart';
import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/user_dto.dart';

abstract class AuthRepository {
  ResultFuture<UserDto> login({
    required String email,
    required String password,
  });

  ResultFuture<void> logout();

  ResultFuture<List<Country>?> loadCountries();
}
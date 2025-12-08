import 'package:country_state_city_dropdown/country_state_city_dropdown.dart';
import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/user_dto.dart';
import 'package:lisa_beauty_salon/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  const AuthUseCase(this._repository);

  final AuthRepository _repository;

  ResultFuture<UserDto> call(LoginUserParams params) async {
    return _repository.login(
      email: params.email,
      password: params.password,
    );
  }

  ResultFuture<List<Country>?> loadCountries() async {
    return _repository.loadCountries();
  }
}

class LoginUserParams {
  const LoginUserParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
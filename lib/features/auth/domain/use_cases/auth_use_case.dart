import 'package:lisa_beauty_saloon/core/utils/typedef.dart';
import 'package:lisa_beauty_saloon/features/auth/data/dto/user_dto.dart';
import 'package:lisa_beauty_saloon/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  const AuthUseCase(this._repository);

  final AuthRepository _repository;

  ResultFuture<UserDto> call(LoginUserParams params) async {
    return _repository.login(
      email: params.email,
      password: params.password,
    );
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
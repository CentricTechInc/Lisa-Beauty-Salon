import 'package:dartz/dartz.dart';
import 'package:lisa_beauty_salon/core/errors/exceptions.dart';
import 'package:lisa_beauty_salon/core/errors/failures.dart';
import 'package:lisa_beauty_salon/core/utils/typedef.dart';
import 'package:lisa_beauty_salon/features/auth/data/data_sources/auth_data_source.dart';
import 'package:lisa_beauty_salon/features/auth/data/dto/user_dto.dart';
import 'package:lisa_beauty_salon/features/auth/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authDataSource);

  final AuthDataSource _authDataSource;

  @override
  ResultFuture<UserDto> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authDataSource.login(
        email: email,
        password: password,
      );
      return Right(user);
    } on APIException catch (e) {
      return Left(APIFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultVoid logout() async {
    try {
      // Implement logout logic
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }
}
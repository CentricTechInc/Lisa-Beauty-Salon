import 'package:dio/dio.dart';
import 'package:lisa_beauty_saloon/core/errors/exceptions.dart';
import 'package:lisa_beauty_saloon/core/networks/api_service.dart';
import 'package:lisa_beauty_saloon/features/auth/data/dto/user_dto.dart';

abstract class AuthDataSource {
  Future<UserDto> login({
    required String email,
    required String password,
  });
}
class AuthDataSourceImpl implements AuthDataSource {
  const AuthDataSourceImpl();

  @override
  Future<UserDto> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await APIService.dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return UserDto.fromMap(response.data['user']);
    } on DioException catch (e) {
      throw APIException(
        message: e.response?.data['message'] ?? e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
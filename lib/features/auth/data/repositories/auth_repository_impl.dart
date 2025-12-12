import 'dart:convert';

import 'package:country_state_city_dropdown/country_state_city_dropdown.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:lisa_beauty_salon/core/errors/exceptions.dart';
import 'package:lisa_beauty_salon/core/errors/failures.dart';
import 'package:lisa_beauty_salon/core/services/logger_service.dart';
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

  @override
  ResultFuture<List<Country>?> loadCountries() async {
    try {
      final jsonString = await rootBundle.loadString(
        'packages/country_state_city_dropdown/assets/data/country_state_city.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      final countries = jsonList.map(
        (country) => Country.fromJson(country)
      ).toList();

      return Right(countries);
    } catch (e) {
      return Left(
        APIFailure(
          message: e.toString(),
          statusCode: 400
        )
      );
    }
  }
}
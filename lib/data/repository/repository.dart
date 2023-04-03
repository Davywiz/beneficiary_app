import 'dart:io';

import 'package:beneficiary_app/data/data_source/remote_data_source.dart';
import 'package:beneficiary_app/data/network/error_handler.dart';
import 'package:beneficiary_app/data/network/failure.dart';
import 'package:beneficiary_app/data/requests/requests.dart';
import 'package:beneficiary_app/data/responses/responses.dart';
import 'package:dartz/dartz.dart';

class Repository {
  final _remoteDataSource = RemoteDataSource();

  Future<Either<Failure, LoginResponse>> login(String userId) async {
    final loginData = LoginRequest(userId: userId);
    try {
      final result = await _remoteDataSource.login(loginData);
      final data = LoginResponse.fromMap(result.data);

      if (data.success == 1) {
        return Right(data);
      } else {
        return Left(Failure(data.status, data.message));
      }
    } catch (error) {
      print(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, LoginResponse>> sendAnswerData(
      SendFormData formData) async {
    try {
      final result = await _remoteDataSource.sendForm(formData);

      final data = LoginResponse.fromMap(result.data);

      if (data.success == 1) {
        return Right(data);
      } else {
        return Left(Failure(data.status, data.message));
      }
    } catch (error) {
      print(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}

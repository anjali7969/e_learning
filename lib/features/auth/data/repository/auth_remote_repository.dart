import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDatasource;

  AuthRemoteRepository(this._authRemoteDatasource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      return Right(await _authRemoteDatasource.getCurrentUser());
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authRemoteDatasource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    try {
      final student = await _authRemoteDatasource.loginUser(email, password);
      return Right(student);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadprofilePicture(File file) async {
    try {
      final imageName = await _authRemoteDatasource.uploadprofilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

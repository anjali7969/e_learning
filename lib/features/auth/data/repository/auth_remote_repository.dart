import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/core/network/internet_checker.dart';
import 'package:e_learning/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDatasource;
  final InternetChecker _internetChecker;

  AuthRemoteRepository(this._authRemoteDatasource, this._internetChecker);

  /// **🔹 Get Current User**
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    if (!await _internetChecker.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      final user = await _authRemoteDatasource.getCurrentUser();
      return Right(user); // ✅ Return Success
    } catch (e) {
      return Left(ApiFailure(
        // ✅ Positional argument
        message: e.toString(),
      ));
    }
  }

  /// **🔹 Register User**
  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    if (!await _internetChecker.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      await _authRemoteDatasource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(
        // ✅ Positional argument
        message: e.toString(),
      ));
    }
  }

  /// **🔹 Login User**
  @override
  Future<Either<Failure, AuthResponse>> loginUser(
      String userName, String password) async {
    try {
      final authResponse =
          await _authRemoteDatasource.loginUser(userName, password);
      return Right(authResponse);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// **🔹 Upload Profile Picture**
  @override
  Future<Either<Failure, String>> uploadprofilePicture(File file) async {
    if (!await _internetChecker.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      final imageName = await _authRemoteDatasource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(
        // ✅ Positional argument
        message: e.toString(),
      ));
    }
  }
}

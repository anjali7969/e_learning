import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, AuthResponse>> loginUser(
      String email, String password);

  Future<Either<Failure, AuthEntity>> getCurrentUser();

  Future<Either<Failure, String>> uploadprofilePicture(File file);
}

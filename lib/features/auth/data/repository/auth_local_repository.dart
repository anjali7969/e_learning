// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
// import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
// import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
// import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';

// class AuthLocalRepository implements IAuthRepository {
//   final AuthLocalDataSource _authLocalDataSource;

//   AuthLocalRepository(this._authLocalDataSource);
// //jhgsdzuc
//   @override
//   Future<Either<Failure, AuthEntity>> getCurrentUser() async {
//     try {
//       final currentUser = await _authLocalDataSource.getCurrentUser();
//       return Right(currentUser);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, AuthResponse>> loginUser(
//     String email,
//     String password,
//   ) async {
//     try {
//       final authResponse =
//           await _authLocalDataSource.loginUser(email, password);
//       return Right(AuthResponse(
//           token: authResponse.token,
//           userId: authResponse.userId,
//           name: authResponse.name,
//           email: authResponse.email,
//           role: authResponse.role));
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> registerUser(AuthEntity user) async {
//     try {
//       return Right(_authLocalDataSource.registerUser(user));
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> uploadprofilePicture(File file) async {
//     // TODO: implement uploadProfilePicture
//     throw UnimplementedError();
//   }
// }

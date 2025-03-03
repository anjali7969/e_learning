import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
import 'package:e_learning/app/usecase/usecase.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

/// **📌 Login Parameters**
class LoginStudentParams extends Equatable {
  final String email;
  final String password;

  const LoginStudentParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

/// **📌 Login UseCase**
class LoginStudentUsecase
    implements UsecaseWithParams<String, LoginStudentParams> {
  final IAuthRepository authRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final Dio dio;

  LoginStudentUsecase({
    required this.authRepository,
    required this.tokenSharedPrefs,
    required this.dio,
  });

  @override
  Future<Either<Failure, String>> call(LoginStudentParams params) async {
    return authRepository.loginUser(params.email, params.password).then(
          (value) => value.fold(
            (failure) => Left(failure), // ❌ Return failure if login fails
            (token) async {
              await tokenSharedPrefs.saveToken(token);
              dio.options.headers['Authorization'] = 'Bearer $token';

              print("✅ Token saved successfully: $token");
              return Right(token);
            },
          ),
        );
  }
}

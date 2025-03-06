import 'package:dartz/dartz.dart';
import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
import 'package:e_learning/app/shared_prefs/user_shared_prefs.dart';
import 'package:e_learning/app/usecase/usecase.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class LoginUserParams extends Equatable {
  final String email;
  final String password;

  const LoginUserParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class AuthResponse extends Equatable {
  final String token;
  final String userId;
  final String name;
  final String email;
  final String role;

  const AuthResponse({
    required this.token,
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  List<Object?> get props => [token, userId, name, email, role];
}

class LoginUseCase implements UsecaseWithParams<void, LoginUserParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;
  final UserSharedPrefs userSharedPrefs;

  LoginUseCase({
    required this.repository,
    required this.tokenSharedPrefs,
    required this.userSharedPrefs,
  });

  @override
  Future<Either<Failure, AuthResponse>> call(LoginUserParams params) async {
    final result = await repository.loginUser(params.email, params.password);

    return result.fold(
      (failure) => Left(failure),
      (authResponse) async {
        print(
            "Raw Response: ${authResponse.token} - ${authResponse.userId}"); // Debugging output

        // Extract user details
        final String token = authResponse.token;
        final String userId = authResponse.userId;
        final String name = authResponse.name;
        final String email = authResponse.email;
        final String role = authResponse.role;

        // Save token & user details
        await tokenSharedPrefs.saveToken(token);
        await userSharedPrefs.saveUserData(userId, name, email, role);

        print("User Data Stored: ID=$userId, Name=$name, Role=$role");

        return Right(authResponse);
      },
    );
  }
}

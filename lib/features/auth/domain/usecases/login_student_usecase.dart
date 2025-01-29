import 'package:dartz/dartz.dart';
import 'package:e_learning/app/usecase/usecase.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

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

class LoginStudentUsecase
    implements UsecaseWithParams<void, LoginStudentParams> {
  final IAuthRepository authRepository;

  const LoginStudentUsecase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(LoginStudentParams params) async {
    return await authRepository.loginUser(params.email, params.password);
  }
}

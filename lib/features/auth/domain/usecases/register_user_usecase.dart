import 'package:dartz/dartz.dart';
import 'package:e_learning/app/usecase/usecase.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/auth/domain/entity/auth_entity.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String? userId;
  final String email;
  final String fname;
  final String lname;
  final String password;

  const RegisterUserParams({
    this.userId,
    required this.email,
    required this.fname,
    required this.lname,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
    this.userId,
    required this.email,
    required this.fname,
    required this.lname,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, email, fname, lname, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      userId: params.userId,
      email: params.email,
      fname: params.fname,
      lname: params.lname,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}
